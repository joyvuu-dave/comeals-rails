# Testing Production Mode Locally
* create <app name>_production database
  * easiest thing is to rename development database
* comment out `config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?`
* rails s -e production
