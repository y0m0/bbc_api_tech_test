module ApiHelpers
  def format_response(data, code = 200)
    status code
    data.to_json
  end

  def create_resource(params)
    config = LayoutConfig.new(id: params[:id], value: params[:value])
    if config.save
      headers 'Location' => "/pages/#{config.id}"
      format_response(config, 201)
    else
      format_response({ errors: config.errors.full_messages }, 400)
    end
  end
end
