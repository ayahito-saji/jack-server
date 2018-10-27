class MembersController < ApplicationController
  # メンバーをslackから取得する
  def seed
    # アクティブなメンバーのリストを取得
    members = getActiveMembersList
    # 各メンバーに対して処理を行う
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
        last_name = "?"
        puts "#{first_name} #{last_name}"
      end
      unless Member.find_by(slack_id: member['id'])
        member = Member.new(
            {
                member_id: member['profile']['email'].split('@')[0].split('.')[0],
                slack_id: member['id'],
                nickname: nickname,
                first_name: first_name,
                last_name: last_name,
                birthday: Date.new(1990, 1, 1),
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
    end
    render json: Member.all
  end
  def index
    @members = Member.all
  end
  def new
  end
  def create
  end
  def show
    @member = Member.find_by(member_id: params[:member_id])
  end
  def edit
  end
  def update
  end
  def destroy
  end
end
