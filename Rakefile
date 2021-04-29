require "./setup/rake"
namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    Sequel.extension :migration
    
    config = YAML.load_file("config/database.yml")
    db = Sequel.connect(config["development"]["url"])
    migration_path = "./db/migrations"

    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, migration_path, target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, migration_path)
    end
  end


  task :seed  do |t, args|
    Sequel.extension :seed
    Sequel::Seed.setup :development
    
    config = YAML.load_file("config/database.yml")
    db = Sequel.connect(config["development"]["url"])

    Dir['./app/models/**/*.rb'].each { |file| require file }
    migration_path = "./db/seeds"

    puts "Seeding"
    Sequel::Seeder.apply(db, migration_path)
  end
end