email = ENV['admin_email']
password = ENV['admin_password']
first_name = ENV['admin_first_name']
last_name = ENV['admin_last_name']

puts "Hi, #{email}!"

puts 'I am creating you as an admin user...'

admin_user = SupportAgent.find_or_create_by(email: email) do |user|
  user.password = password
  user.first_name = first_name
  user.last_name = last_name
  user.admin = true
end

if admin_user.save
  puts "You have been created as an admin user, #{admin_user.first_name} #{admin_user.last_name}"
else
  puts 'error saving admin'
end
