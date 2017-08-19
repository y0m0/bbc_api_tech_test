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
        configs = [{ 'id' => 'foo', 'value' => 'foo config' }]
        allow(LayoutConfig).to receive(:all) { configs }

        get '/pages'
        expect(last_response.body).to eq configs.to_json
      end
    end
  end

  describe 'GET /pages/:id' do

    context 'when resource is available' do
      before do
        LayoutConfig.create(id: 'foo', value: 'foo config')
      end

      it 'respond with status 200' do
        get '/pages/foo'
        expect(last_response.status).to eq 200
      end

      it 'return the correct json config data' do
        get '/pages/foo'
        expect(last_response.body).to eq({ 'id' => 'foo', 'value' => 'foo config' }.to_json)
      end
    end
  end

end
