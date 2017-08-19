module ApiHelpers
  def format_response(code, data)
    status code
    data.to_json
  end
end
