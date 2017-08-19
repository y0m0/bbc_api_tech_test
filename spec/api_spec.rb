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
        expect(last_response.body).to eq({ id: 'foo', value: 'foo config' }.to_json)
      end
    end

    context 'when resource is not available' do
      it 'respond with status 404' do
        get '/pages/foo'
        expect(last_response.status).to eq 404
      end
    end
  end

  describe 'PUT /pages/:id ' do

    context 'when the resource does not exists' do
      it 'creates a new resource' do
        put '/pages/bar', value: 'bar config'
        expect(LayoutConfig.get('bar')).to be
      end

      it 'respond with status 201' do
        put '/pages/bar', value: 'bar config'
        expect(last_response.status).to eq 201
      end

      it 'returns the newly created resource' do
        put '/pages/bar', value: 'bar config'
        expect(last_response.body).to eq({ id: 'bar', value: 'bar config' }.to_json)
      end
    end

    context 'when the resource alreay exists' do
      before do
        LayoutConfig.create(id: 'foo', value: 'foo config')
      end

      it 'respond with status 200' do
        put 'pages/foo', value: 'new foo config'
        expect(last_response.status).to eq 200
      end

      it 'return the updated config' do
        put 'pages/foo', value: 'new foo config'
        expect(last_response.body).to eq({ id: 'foo', value: 'new foo config' }.to_json)
      end
    end

  end

end
