class JoinController < ApplicationController
  def join
  end
  def result
    @name = '名前: ' + params['last_name'] + params['first_name']
    @mail_address = 'メールアドレス: ' + params['mail_1'] + '@' + params['mail_2']
    @pass = 'パスワード: ' + params['Password']
    @univ = '大学: ' + params['univ'] + '大学' + params['Undergraduate'] + '学部' + params['Department'] + '学科' + params['Grade']
    @nickname = 'あだ名: ' + params['nickname']
    @experience = '経験: ' + params['experience']
    @position = '役職: ' + params['Position']
    @program = 'やりたいプログラム: ' + params['program']
    @birthday = '誕生日: ' + params['month'] + params['day']
    @like_food = '好きな食べ物: '  + params['like_food']
    @dislike_food = '嫌いな食べ物: ' +  params['dislike_food']
  end
end
