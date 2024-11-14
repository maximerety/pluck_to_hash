# frozen_string_literal: true

require_relative './spec_helper'

describe 'PluckToHash' do
  before { TestModel.delete_all }
  include_context 'making sure alias is fine'

  describe '.pluck_to_hash' do
    include_context 'essentials'
    include_context 'when using a different hash type'
  end

  context 'when serialize attributes used' do
    describe '.pluck_to_hash' do
      before do
        TestModel.create!(serialized_attribute: [])
        TestModel.create!(serialized_attribute: ['Zygohistomorpic', 'Prepromorphism'])
        TestModel.create!(serialized_attribute: ['Comonad'])
      end

      it 'plucks the hash correctly' do
        result = TestModel.pluck_to_hash(:serialized_attribute)
        expect(result).to eq [
          { serialized_attribute: [] }.with_indifferent_access,
          { serialized_attribute: ['Zygohistomorpic', 'Prepromorphism'] }.with_indifferent_access,
          { serialized_attribute: ['Comonad'] }.with_indifferent_access
        ]
      end

      it 'plucks a hash with multiple attributes' do
        result = TestModel.pluck_to_hash(:test_attribute, :serialized_attribute)
        expect(result).to eq [
          { test_attribute: nil, serialized_attribute: [] }.with_indifferent_access,
          { test_attribute: nil, serialized_attribute: ['Zygohistomorpic', 'Prepromorphism'] }.with_indifferent_access,
          { test_attribute: nil, serialized_attribute: ['Comonad'] }.with_indifferent_access
        ]
      end

      it 'plucks coalesce as correctly' do
        columns = [
          Arel.sql('COALESCE(SUM(price_1 - price_2), 0) AS difference'),
          Arel.sql('COUNT(test_models.id) AS cnt')
        ]
        TestModel.pluck_to_hash(*columns).each do |result|
          expect(result).to have_key('difference')
          expect(result).to have_key('cnt')
        end
      end
    end
  end
end
