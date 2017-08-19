ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'

module LayoutConfigurator
  class Api < Sinatra::Base


    get '/pages' do
      content_type :json
      LayoutConfig.all.to_json
    end

    get '/pages/:id' do
      LayoutConfig.get(params[:id]).to_json
    end

  end
end
