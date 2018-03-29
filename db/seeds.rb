# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.find_or_initialize_by(email: 'admin@philtrick.com', username: 'admin1', company_name: 'Philtrick',
                                    name: 'Admin', country: 'ES', profit_share: 100.0, admin: true)
admin.password = 'admin1'
admin.password_confirmation = 'admin1'
admin.confirmed_at = DateTime.now
admin.save!
