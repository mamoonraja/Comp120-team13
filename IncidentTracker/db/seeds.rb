# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

departments = Department.create([
  { name: 'Dining' },
  { name: 'Energy & Facilities' },
  { name: 'Environmental Health & Safety' },
  { name: 'Housing' },
  { name: 'Mail & Print' },
])

categories = Category.create([
  { name: 'Fire' },
  { name: 'Flooding' },
  { name: 'Vandalism' },
  { name: 'Theft' },
])
