# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Yelper.create!(name: "Jessica L.", location: "Boston, MA",
               number_of_reviews: 87,
               image_url:
               "https://s3-media4.fl.yelpcdn.com/photo/rdVNLyslZU3",
               uid: "nmmlJN3bVjH-P0WB6-PyMw")

Yelper.create!(name: "Miles H.", location: "Cambridge, MA",
               number_of_reviews: 97,
               image_url:
               "https://s3-media3.fl.yelpcdn.com/photo/k7iL-XnHUGo",
               uid: "ixtEB7AH49Z5u_giDFG0DA")

Yelper.create!(name: "Kelly H.",
               location: "Orlando, FL", number_of_reviews: 243,
               image_url:
               "https://s3-media1.fl.yelpcdn.com/photo/6Km87skugnz",
               uid: "DgZa1AWNuwdnXGCQ-__o_w")

Yelper.create!(name: "Chris J.", location: "Providence, RI",
               number_of_reviews: 220,
               image_url:
               "https://s3-media2.fl.yelpcdn.com/photo/L3L2WliATom",
               uid: "yrqzt5IeOGQ3xa98vZQ0xw")
