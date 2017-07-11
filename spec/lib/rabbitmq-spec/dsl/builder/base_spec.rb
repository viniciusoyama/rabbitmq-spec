require 'spec_helper'

describe RabbitMQSpec::DSL::Builder::Base do
  context 'using provided dsl' do
    specify 'I can define values using scalar values' do
      options = Class.new(RabbitMQSpec::DSL::Builder::Base) do
        define_dsl_attribute :attr1
        define_dsl_attribute :attr2
        define_dsl_attribute :attr3

        def build_entity
          @builded_options
        end
      end.build(default_attribute: 'myvalue') do
        attr1 'at1'
        attr3 4
      end

      expect(options[:attr1]).to eq('at1')
      expect(options[:attr2]).to be_nil
      expect(options[:attr3]).to be(4)
      expect(options[:default_attribute]).to eq('myvalue')
    end

    specify 'I can define hash values using a block' do
      options = Class.new(RabbitMQSpec::DSL::Builder::Base) do
        define_dsl_attribute :attr1

        def build_entity
          @builded_options
        end
      end.build(default_attribute: 'myvalue') do
        attr1 do
          option1 'test1'
          option2 do
            option21 21
            option22 22
          end
          option3 'test3'
        end
      end

      expect(options[:default_attribute]).to eq('myvalue')
      expect(options[:attr1][:option1]).to eq('test1')
      expect(options[:attr1][:option2][:option21]).to eq(21)
      expect(options[:attr1][:option2][:option22]).to eq(22)
      expect(options[:attr1][:option3]).to eq('test3')
    end

    it 'raises an error if I try to set a non declared attribute' do
      expect {
        options = Class.new(RabbitMQSpec::DSL::Builder::Base) do
          define_dsl_attribute :attr1
          define_dsl_attribute :attr2

          def build_entity
            @builded_options
          end

          def to_s
            'test_builder'
          end
        end.build(default_attribute: 'myvalue') do
          attr5 'at1'
        end
      }.to raise_error("Configuration 'attr5' is not allowed for test_builder")
    end
  end
end