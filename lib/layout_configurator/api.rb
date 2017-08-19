ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'

module LayoutConfigurator
  class Api < Sinatra::Base


    get '/pages' do
      content_type :json
      LayoutConfig.all.to_json
    end

    get '/pages/:id' do
      config = LayoutConfig.get(params[:id])
      if config
        config.to_json
      else
        status 404
      end
    end

  end
end
