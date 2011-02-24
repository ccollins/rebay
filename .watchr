ENV["WATCHR"] = "1"
$spec_cmd = "rspec --drb --colour --format nested"

def run(cmd)
  system('clear')
  puts(cmd)
  system(cmd)
end

def run_spec(spec)
  result = run "#{$spec_cmd} #{spec}"
end

def run_all_specs
  result = run "#{$spec_cmd} spec/"
end

def related_specs(path)
  Dir['spec/**/*.rb'].select { |file| file =~ /#{File.basename(path).split(".").first}_spec.rb/ }
end

def run_suite
  run_all_specs
end

@interrupted = false

# Ctrl-C
Signal.trap 'INT' do
  if @interrupted then
    @wants_to_quit = true
    abort("\n")
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    Kernel.sleep 1.5
    # raise Interrupt, nil # let the run loop catch it
    run_suite
  end
end

watch('spec/support/.*') { run_all_specs }
watch('spec/.*_spec\.rb') { |m| run_spec m[0] }
watch('lib/.*\.rb') { |m| related_specs(m[0]).map {|tf| run_spec tf } }

# Ctrl-\
Signal.trap 'QUIT' do
  puts " --- Running all specs ---\n\n"
  run_all_specs
end
