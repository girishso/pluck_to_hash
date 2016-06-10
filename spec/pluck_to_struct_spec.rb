require_relative './spec_helper'
require 'values'

describe 'PluckToStruct' do
  before { TestModel.delete_all }

  context '.pluck_to_struct' do
    before do
      TestModel.create!(id: 1, test_attribute: "test1")
      TestModel.create!(id: 2, test_attribute: "test2")
      TestModel.create!(id: 3, test_attribute: "test3")
    end

    it 'plucks the ids, test_attributes of the objects to a struct correctly' do
      TestModel.all.pluck_to_struct(:test_attribute, :id).each_with_index do |model, ix|
        id = ix + 1
        expect(model).to be_a(Struct)
        expect(model.test_attribute).to eq("test#{id}")
        expect(model.id).to eq(id)
      end
    end

    context 'alias pluck_s' do
      it 'works correctly' do
        struct = TestModel.where(id: 1).pluck_s(:test_attribute).first
        expect(struct.test_attribute).to eq("test1")
      end
    end

    context 'the model does not have the attribute specified' do
      it 'raises an error' do
        expect do
          TestModel.all.pluck_s(:foo)
        end.to raise_error(ActiveRecord::StatementInvalid)
      end
    end

    context 'no models exist for the given criteria' do
      it 'returns an empty relation' do
        result = TestModel.where(id: -1).pluck_s(:id)
        expect(result).to be_empty
      end
    end

    context 'when a different struct type is specified' do
      it 'returns an object with all attributes' do
        TestModel.all.pluck_to_struct(:test_attribute, :id, struct_type: Value).each do |model|
          expect(model).to respond_to(:id, :test_attribute)
        end
      end
    end

  end


  context 'when serialize attributes used' do
    describe '.pluck_to_struct' do
      before do
        TestModel.create!(id: 1, serialized_attribute: [])
        TestModel.create!(id: 2, serialized_attribute: ['Zygohistomorpic', 'Prepromorphism'])
        TestModel.create!(id: 3, serialized_attribute: ['Comonad'])
      end
      
      it 'plucks to struct correctly' do
        result = TestModel.pluck_to_struct(:serialized_attribute)

        expect(result[0].serialized_attribute).to eq([])
        expect(result[1].serialized_attribute).to eq(['Zygohistomorpic', 'Prepromorphism'])
        expect(result[2].serialized_attribute).to eq(['Comonad'])
      end

      it 'plucks to struct with multiple attributes' do
        result = TestModel.pluck_to_struct(:id, :serialized_attribute)

        expect(result[0].serialized_attribute).to eq([])
        expect(result[0].id).to eq(1)

        expect(result[1].serialized_attribute).to eq(['Zygohistomorpic', 'Prepromorphism'])
        expect(result[1].id).to eq(2)

        expect(result[2].serialized_attribute).to eq(['Comonad'])
        expect(result[2].id).to eq(3)
      end
    end
  end

end
