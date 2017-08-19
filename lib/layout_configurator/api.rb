ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'

module LayoutConfigurator
  class Api < Sinatra::Base


    get '/pages' do
      content_type :json
      LayoutConfig.all.to_json
    end

    get '/pages/:id' do
      content_type :json
      config = LayoutConfig.get(params[:id])
      if config
        config.to_json
      else
        status 404
      end
    end

    put '/pages/:id' do
      content_type :json

      config = LayoutConfig.get(params[:id])
      if config
        config.update(value: params[:value])
        status 200
        config.to_json
      else
        config = LayoutConfig.new(id: params[:id], value: params[:value])
        if config.save
          status 201
          body config.to_json
        else
          status 500
          { errors: config.errors.full_messages }.to_json
        end
      end
    end

  end
end
