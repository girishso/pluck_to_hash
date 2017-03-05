require_relative './spec_helper'

describe 'PluckToHash' do
  before { TestModel.delete_all }
  include_context 'making sure alias is fine'

  describe '.pluck_to_hash' do
    include_context 'essentials'

    context 'when using a different hash type' do
      it 'returns a hash of the correct type with all attributes' do
        TestModel.all.pluck_to_hash(:id, :test_attribute,hash_type: Hash).each do |hash|
          expect(hash.class).to eq(Hash)
          expect(hash).to have_key(:id)
          expect(hash).to have_key(:test_attribute)
        end
      end
    end
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
    end
  end
end
