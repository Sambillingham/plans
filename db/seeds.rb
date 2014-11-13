# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Plan.create([
    {
        role: "architect",
        funding: false,
        resources: false,
        space: true,
        partnerships: nil
    },
    {
        role: "resident",
        funding: false,
        resources: true,
        space: true,
        partnerships: "architect"
        }
    ])