# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

slack = Slack::Slack.new

members = slack.getActiveMembersList
members.each do |member|
  puts "#{member['id']} #{member['profile']['real_name']}(#{member['profile']['display_name']}) #{member['profile']['email'].split('@')[0]}"

  # 表示名
  if member['profile']['display_name'] != ""
    nickname = member['profile']['display_name']
  else
    nickname = member['profile']['real_name']
  end

  # 本名
  if match = member['profile']['real_name'].match(/([a-z|A-Z]+)\p{blank}+([a-z|A-Z]+)/)
    first_name = match[1].to_s
    last_name = match[2].to_s
    puts "#{first_name} #{last_name}"
  elsif match = member['profile']['real_name'].match(/(\p{Hiragana}|\p{Katakana}|[一-龠々]+)\p{blank}+(\p{Hiragana}|\p{Katakana}|[一-龠々]+)/)
    first_name = match[2].to_s
    last_name = match[1].to_s
    puts "#{first_name} #{last_name}"
  elsif match = member['profile']['real_name'].match(/(\p{Hiragana}|\p{Katakana}|[一-龠々]+)/)
    first_name = match.to_s[2..-1]
    last_name = match.to_s[0..1]
    puts "#{first_name} #{last_name}"
  else
    first_name = member['profile']['real_name']
    last_name = ""
    puts "#{first_name} #{last_name}"
  end
  member = Member.new(
      {
          username: member['profile']['email'].split('@')[0],
          slack_id: member['id'],
          nickname: nickname,
          first_name: first_name,
          last_name: last_name,
          email: member['profile']['email'],
          password: 'jacknagoya20151103',
          enroll_date: Date.new(2017, 4, 1),
          admin: false,
          icon_url: member['profile']['image_192'],
          is_graduate: false
      }
  )
  member.skip_confirmation!
  member.save!
end