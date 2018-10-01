class CallbackController < ApplicationController
  protect_from_forgery :except => [:slack]
  require 'pp'
  require 'json'
  def slack
    @body = JSON.parse(params['payload'])
    case @body['type']
      when 'url_verification'
        render json: @body
      when 'interactive_message'
        pp @body
    end
  end
end
