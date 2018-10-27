class EventsController < ApplicationController
  require 'securerandom'
  # サークルの年度計画を立てる (1/1に実行される)
  def seed
    year = 2018

    day = Time.zone.local(year, 4, 1)
    while day < Time.zone.local(year + 1, 4, 1)
      # 1年間の計画を立てるここから

      if day.wday == 4 # 毎週木曜日であるならば活動日として登録
        Event.create({
                         event_id: SecureRandom.base58(10),
                         title: '通常活動',
                         start_at: Time.zone.local(day.year, day.mon, day.mday, 16, 30),
                         end_at: Time.zone.local(day.year, day.mon, day.mday, 22, 30),
                         place: 'ディスカバリースクエア',
                         description: 'もくもく会',
                         need_attendance: true,
                         done_attendance: false
                     })
      elsif day.wday == 6 && day.strftime('%V').to_i % 2 == 1 # 隔週土曜日であるならば活動日として登録
        Event.create({
                         event_id: SecureRandom.base58(10),
                         title: '通常活動',
                         start_at: Time.zone.local(day.year, day.mon, day.mday, 10, 30),
                         end_at: Time.zone.local(day.year, day.mon, day.mday, 22, 30),
                         place: 'ディスカバリースクエア',
                         description: 'もくもく会',
                         need_attendance: true,
                         done_attendance: false
                     })
      end

      # 1年間の計画を立てるここまで
      day = day.next_day
    end

    render json: Event.all
  end

  # イベント一覧
  def index
    @events = Event.all.order(:start_at)
  end

  # イベントの個別ページ
  def show
    @event = Event.find_by(event_id: params[:event_id])
  end

end
