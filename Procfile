web: bundle exec puma -C config/puma.rb
js: yarn build:js
release: bundle exec rails db:migrate
worker: bundle exec sidekiq -q default