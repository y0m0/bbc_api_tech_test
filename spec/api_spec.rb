describe 'Api' do

  describe 'GET /pages' do

    it 'responds with status 200' do
      get '/pages'
      expect(last_response.status).to eq 200
    end

    context 'when there is no config in the db' do
      it 'returns and empty json' do
        get '/pages'
        expect(last_response.body).to eq([].to_json)
      end
    end

    context 'when there is some config in the db' do

      it 'returns a json with all the configs' do
        config = [{ 'id' => 'foo', 'value' => 'foo config' }]
        allow(LayoutConfig).to receive(:all) { config }
        get '/pages'
        expect(last_response.body).to eq config.to_json
      end
    end
  end
end
