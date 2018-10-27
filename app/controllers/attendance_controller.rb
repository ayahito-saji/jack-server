class AttendanceController < ApplicationController
  def new
    start_day = Time.zone.now.midnight.since(1.days)
    end_day = start_day.since(7.days)

    res = ""

    Event.where(["start_at > ? and end_at < ?", start_day, end_day]).where(need_attendance: true, done_attendance: false).each do |event|
      Member.all.each do |member|
        MemberEvent.create(member: member, event: event, attendance: :null)
        data = {
            channel: member.slack_id,
            as_user: true,
            attachments: [
                fallback: event.event_id,
                title: "#{event.title} #{event.start_at.strftime("%m/%d(%a) %H:%M")}〜",
                text: "未回答 https://jack-server.herokuapp.com/events/#{event.event_id}",
                callback_id: 'attendance_check',
                attachment_type: 'default',
                actions: [
                    {
                        name: '出席する',
                        text: '出席する',
                        type: 'button',
                        style: 'primary',
                        value: '0'
                    },
                    {
                        name: '途中から参加',
                        text: '途中から参加',
                        type: 'button',
                        style: 'default',
                        value: '1'
                    },
                    {
                        name: '欠席する',
                        text: '欠席する',
                        type: 'button',
                        style: 'danger',
                        value: '2'
                    }
                ]
            ].to_json.to_s
        }
        res = postMessage(data)
      end
      event.update_attributes(done_attendance: true)
    end
    render :json => JSON.dump(res)
  end
end
