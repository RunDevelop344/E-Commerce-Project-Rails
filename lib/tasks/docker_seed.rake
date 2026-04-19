namespace :db do
  desc "Seed database for Docker/production without external API calls"
  task docker_seed: :environment do
    load Rails.root.join("db/seeds/docker_seeds.rb")
  end
end
