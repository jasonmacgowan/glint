# frozen_string_literal: true

require 'json'
require 'sinatra/base'
require 'sinatra/contrib'

# Glint
class Glint < ::Sinatra::Base
  post '/echo' do
    json headers: extract_headers(request), body: request.body.read
  end

  get '/sleep/:seconds' do
    seconds = params[:seconds].to_i
    sleep(seconds)
    json seconds: seconds
  end

  get '/health' do
    json status: 'ok'
  end

  private

  # Return all HTTP headers normalized to title case
  def extract_headers(request)
    request.env.select { |k, _v| k.start_with?('HTTP_') }.map do |k, v|
      [k.sub(/^HTTP_/, '').split('_').map(&:capitalize).join('-'), v]
    end.to_h
  end
end
