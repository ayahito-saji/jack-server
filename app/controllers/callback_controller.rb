class CallbackController < ApplicationController
  protect_from_forgery :except => [:slack]
  require 'pp'
  require 'json'
  def slack
    if params['command']
      @body = params
      case params['command']
        when '/jack_atd'
          jack_atd
      end
      render plain: ""
    else
      @body = JSON.parse(params['payload'])
      case @body['type']
        when 'url_verification'
          render json: @body
        when 'interactive_message'
          case @body['callback_id']
            when 'attendance_check'
              attendance_check()
          end
          render plain: ""
      end
    end
  end
  private
  def attendance_check

    member = Member.find_by(slack_id: @body['user']['id'])
    event = Event.find_by(event_id: @body['original_message']['attachments'][0]['fallback'])

    # 出欠の確認を行います．
    member_event = MemberEvent.find_by(member: member, event: event)
    if member_event # すでに出欠確認を行なっていれば更新する
      member_event.update_attributes(
          {
              attendance: @body['actions'][0]['value'].to_i
          }
      )
    else # まだ出欠確認をしていなかった場合新たに作成する
      member_event = MemberEvent.create(
          {
              member: member,
              event: event,
              attendance: @body['actions'][0]['value'].to_i
          }
      )
    end

    data = @body['original_message']
    data['channel'] = @body['channel']['id']
    data['ts'] = @body['message_ts']
    data['attachments'][0]['text'] = "#{@body['actions'][0]['name']} https://50f94ac6.ngrok.io/events/#{event.event_id}"
    data['attachments'][0]['color'] = ["#5cb85c", "#808080", "#d9534f"][@body['actions'][0]['value'].to_i]
    data['attachments'] = data['attachments'].to_json.to_s

    slack = Slack::Slack.new
    res = slack.update(data)
  end

  # 出席者一覧を表示するコマンド
  def jack_atd

    data = {
        channel: @body['user_id'],
        as_user: true,
        text: ' */jack_atd*',
        attachments: [
            {
                title: "出席する (#{Member.count})",
                text: "",
                color: "#5cb85c"
            },
            {
                title: "途中から出席 (0)",
                text: "",
                color: "#808080"
            },
            {
                title: "欠席する (0)",
                text: "",
                color: "#d9534f"
            },

        ].to_json.to_s
    }

    slack = Slack::Slack.new
    res = slack.postMessage(data)
  end

end
