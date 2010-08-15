rebay
========
Docs coming soon.


Configuration
-------------
Create and require a config.rb, or with rails create an initializer (rebay.rb perhaps) and place the following code into it:

		Rebay::Api.configure do |rebay|
  		rebay.app_id = 'YOUR APPLICATION ID HERE'
		end