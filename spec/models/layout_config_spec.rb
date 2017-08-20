require_relative '../../lib/layout_configurator/models/layout_config'

describe LayoutConfig do

  it 'value cannot be empty' do
    layout = LayoutConfig.new(id: 'test', value: '')

    expect(layout.save).not_to be
  end

  it 'converts id to downcase before storing the entry' do
    layout = LayoutConfig.create(id: 'TeSt', value: 'some config')

    expect(layout.id).to eq 'test'
  end

  context 'it validates id' do
    it 'must start with a letter' do
      layout = LayoutConfig.new(id: '1a', value: 'some config')

      expect(layout.save).not_to be
    end

    it 'can contatin "-" between letters' do
      layout = LayoutConfig.new(id: 'a-a', value: 'some config')

      expect(layout.save).to be
    end

    it 'can contain numbers when preceded by letters and "-"' do
      layout = LayoutConfig.new(id: 'a-100', value: 'some config')

      expect(layout.save).to be
    end

    it 'must not include any other contain special character' do
      layout = LayoutConfig.new(id: 'a??', value: 'some config')

      expect(layout.save).not_to be
    end
  end
end


