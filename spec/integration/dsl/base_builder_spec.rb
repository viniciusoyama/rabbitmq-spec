require 'spec_helper'

describe 'Using RabbitMQSpec::DSL::Builder::Base' do
  specify 'I can use the base builder to create a new one providing an entity' do
    entity = Class.new do
      attr_accessor :attribute1
      attr_accessor :attribute2
    end

    test_builder = Class.new(RabbitMQSpec::DSL::Builder::Base) do
      define_entity_class entity

      define_dsl_attribute :attribute1
      define_dsl_attribute :attribute2
    end

    entity = test_builder.build do
      attribute1 'value1'
      attribute2 'value2'
    end

    expect(entity.attribute1).to eq('value1')
    expect(entity.attribute2).to eq('value2')
  end
end
