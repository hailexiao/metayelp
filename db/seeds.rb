# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


yelpers = File.read('db/seeds.json')
data = JSON.parse(yelpers)

data["collection1"].each do |row|
  yelper = CrawlYelp.new(row["property1"]["href"]).add_yelper
  yelper.save
  sleep(5)
end
