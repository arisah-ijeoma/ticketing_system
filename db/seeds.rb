email = ENV['admin_email']
password = ENV['admin_password']
first_name = ENV['admin_first_name']
last_name = ENV['admin_last_name']

s_email = ENV['support_agent_email']
s_password = ENV['support_agent_password']
s_first_name = ENV['support_agent_first_name']
s_last_name = ENV['support_agent_last_name']

puts "Hi, #{email} and #{s_email}"

puts "I am creating #{email} as an admin user..."

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


support_agent = SupportAgent.find_or_create_by(email: s_email) do |user|
  user.password = s_password
  user.first_name = s_first_name
  user.last_name = s_last_name
end

if support_agent.save
  puts "You have been created as a support agent, #{support_agent.first_name} #{support_agent.last_name}"
else
  puts 'error saving admin'
end
