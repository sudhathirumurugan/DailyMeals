# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# IMPORTANT: Create admin users manually in production through secure admin panel
# or use Rails console with proper environment variable configuration.
# DO NOT hardcode credentials in seed files.
#
# To create an admin user in development:
# rails console
# Admin.create!(email: "admin@example.com", password: "secure_password", password_confirmation: "secure_password", type: "Admin")



