module Slack
  class Slack
    require 'net/http'
    require 'uri'
    require 'json'

    # 出欠確認
    def attendanceCheck
      ['@saji.ayahito'].each do |member|
        data = {
            channel: member,
            as_user: true,
            attachments: [
                fallback: 'fallback string',
                title: '11月12日(12:30〜)',
                callback_id: 0,
                attachment_type: 'default',
                actions: [
                    {
                        name: 'attendance',
                        text: '出席する',
                        type: 'button',
                        style: 'primary',
                        value: 'btn1Value'
                    },
                    {
                        name: 'midway_attendance',
                        text: '途中から参加',
                        type: 'button',
                        style: 'default',
                        value: 'btn2Value'
                    },
                    {
                        name: 'absence',
                        text: '欠席する',
                        type: 'button',
                        style: 'danger',
                        value: 'btn3Value'
                    }
                ]
            ].to_json.to_s
        }
        postMessage(data)
      end
    end

    # activeなメンバーリストを取得
    def getActiveMembersList
      return getMembersListWithoutBot.select{|member| (!member['deleted'])}
    end

    # bot以外のメンバーリストを取得
    def getMembersListWithoutBot
      return getMembersList.select{|member| (!member['is_bot']) && (member['id'] != 'USLACKBOT')}
    end

    # メンバーリストを取得
    def getMembersList
      url = 'https://slack.com/api/users.list'
      data = {}
      data['token'] = ENV['SLACK_BOT_TOKEN']

      res = JSON.parse(post(url, data))
      return res['members']
    end

    # メッセージを投げる
    def postMessage(data)
      url = 'https://slack.com/api/chat.postMessage'
      data['token'] = ENV['SLACK_BOT_TOKEN']

      JSON.parse(post(url, data))
    end

    private
    def post(url, data)
      escaped_url=URI.escape(url)
      uri = URI.parse(escaped_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri)

      req.set_form_data(data)

      res = http.request(req)
      return res.body
    end
  end
end