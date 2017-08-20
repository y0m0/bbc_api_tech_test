ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'

module LayoutConfigurator
  class Api < Sinatra::Base

    helpers ApiHelpers

    before do
      content_type :json
    end

    get '/pages' do
      format_response(LayoutConfig.all)
    end

    get '/pages/:id' do
      config = LayoutConfig.get(params[:id])
      config ? format_response(config) : format_response('Not Found', 404)
    end

    post '/pages/?' do
      create_resource(params)
    end

    put '/pages/:id' do
      config = LayoutConfig.get(params[:id])
      if config
        config.update(value: params[:value])
        format_response(config)
      else
        create_resource(params)
      end
    end

    delete '/pages/:id' do
      config = LayoutConfig.get(params[:id])
      if config
        config.destroy
        status 204
      else
        format_response('Not Found', 404)
      end
    end
  end
end
