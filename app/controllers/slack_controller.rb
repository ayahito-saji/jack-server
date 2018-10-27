class SlackController < ApplicationController
  # エラー422を回避する
  protect_from_forgery :except => [:callback]
  require 'pp'
  require 'json'

  # slackからのコールバック
  def callback
    if params['command'] # slack command
      @body = params
      case params['command']
        when '/jack_cmd' # コマンドとそれの実行
          puts ('Hello World!!')
      end
      render plain: ""
    else                 # slack command以外
      @body = JSON.parse(params['payload'])
      case @body['type'] # callbackの種類
        when 'url_verification'     # url認証ならば，送られて来た値を全て返す（これで認証OK）
          render json: @body
        when 'interactive_message'  # インタラクティブコンポーネント（ボタン等）ならば，callback_idで振り分ける
          case @body['callback_id']
            when 'attendance_check'
              attendance
          end
          render plain: ""
      end
    end
  end
  private
  def attendance
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
    data['attachments'][0]['text'] = "#{@body['actions'][0]['name']} https://jack-server.herokuapp.com/events/#{event.event_id}"
    data['attachments'][0]['color'] = ["#5cb85c", "#808080", "#d9534f"][@body['actions'][0]['value'].to_i]
    data['attachments'] = data['attachments'].to_json.to_s

    res = updateMessage(data)
  end
end
