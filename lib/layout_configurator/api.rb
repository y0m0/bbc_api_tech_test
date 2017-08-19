ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'

module LayoutConfigurator
  class Api < Sinatra::Base

    include ApiHelpers

    before do
      content_type :json
    end

    get '/pages' do
      format_response(200, LayoutConfig.all)
    end

    get '/pages/:id' do
      config = LayoutConfig.get(params[:id])
      config ? format_response(200, config) : format_response(404, 'Not found')
    end

    put '/pages/:id' do
      config = LayoutConfig.get(params[:id])
      if config
        config.update(value: params[:value])
        format_response(200, config)
      else
        config = LayoutConfig.new(id: params[:id], value: params[:value])
        if config.save
          format_response(201, config)
        else
          format_response(500, errors: config.errors.full_messages)
        end
      end
    end

    delete '/pages/:id' do
      status 204
    end

  end
end
