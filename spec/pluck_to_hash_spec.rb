require_relative './spec_helper'

describe 'PluckToHash' do
  before { TestModel.delete_all }
  
  describe '.pluck_to_hash' do
    before do
      3.times.each do
        TestModel.create!
      end
    end

    it 'plucks the ids of the objects to a hash correctly' do
      TestModel.all.pluck_to_hash(:id).each do |hash|
        expect(hash.class).to eq(Hash)
        expect(hash).to have_key(:id)
      end
    end

    context 'the model does not have the attribute specified' do
      it 'raises an error' do
        expect do
          TestModel.all.pluck_to_hash(:foo)
        end.to raise_error
      end
    end

    context 'no models exist for the given criteria' do
      it 'returns an empty relation' do
        expect do
          result = TestModel.where(id: -1).pluck_to_hash(:id)
          expect(result).to be_empty
        end.to_not raise_error
      end
    end

    context 'specifying multiple attributes' do
      it 'returns a hash with both attributes' do
        TestModel.all.pluck_to_hash(:id, :test_attribute).each do |hash|
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
          { serialized_attribute: [] },
          { serialized_attribute: ['Zygohistomorpic', 'Prepromorphism'] },
          { serialized_attribute: ['Comonad'] },
        ]
      end
    end
  end

  context 'making sure alias is fine' do
    describe '.pluck_h' do
      before do
        3.times.each do
          TestModel.create!
        end
      end

      it 'plucks the ids of the objects to a hash correctly' do
        TestModel.all.pluck_h(:id).each do |hash|
          expect(hash.class).to eq(Hash)
          expect(hash).to have_key(:id)
        end
      end

      context 'the model does not have the attribute specified' do
        it 'raises an error' do
          expect do
            TestModel.all.pluck_h(:foo)
          end.to raise_error
        end
      end

      context 'no models exist for the given criteria' do
        it 'returns an empty relation' do
          expect do
            result = TestModel.where(id: -1).pluck_h(:id)
            expect(result).to be_empty
          end.to_not raise_error
        end
      end

      context 'specifying multiple attributes' do
        it 'returns a hash with both attributes' do
          TestModel.all.pluck_h(:id, :test_attribute).each do |hash|
            expect(hash.class).to eq(Hash)
            expect(hash).to have_key(:id)
            expect(hash).to have_key(:test_attribute)
          end
        end
      end
    end
  end
end
