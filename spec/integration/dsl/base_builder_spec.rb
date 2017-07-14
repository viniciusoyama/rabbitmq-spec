require 'spec_helper'

describe 'Using RabbitMQSpec::DSL::Builder::Base' do
  specify 'I can use the base builder to create a new one providing an entity' do
    entity = Class.new do
      attr_accessor :attribute1
      attr_accessor :attribute2
      attr_accessor :hash_attribute
    end

    test_builder = Class.new(RabbitMQSpec::DSL::Builder::Base) do
      define_entity_class entity

      define_dsl_attribute :attribute1
      define_dsl_attribute :attribute2
      define_dsl_attribute :hash_attribute
    end

    entity = test_builder.build do
      attribute1 'value1'
      attribute2 'value2'

      hash_attribute do
        option1 1
        option2 2
        hash_nested do
          option3 3
        end
      end
    end

    expect(entity.attribute1).to eq('value1')
    expect(entity.attribute2).to eq('value2')
    expect(entity.hash_attribute).to eq({ option1: 1, option2: 2, hash_nested: { option3: 3 } })
  end

  specify 'It warns when an attribute is not allowed to be called on build' do
    entity = Class.new do
      attr_accessor :attribute1
    end

    test_builder = Class.new(RabbitMQSpec::DSL::Builder::Base) do
      define_entity_class entity

      define_dsl_attribute :attribute1
    end

    expect {
      test_builder.build do
        no_attribute
      end
    }.to raise_error
  end
end
