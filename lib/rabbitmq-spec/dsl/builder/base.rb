# frozen_string_literal: true

class RabbitMQSpec::DSL::Builder::Base
  # class methods
  def self.define_dsl_attribute(attribute_name)
    @allowed_dsl_attributes ||= []
    @allowed_dsl_attributes << attribute_name.to_sym
  end

  def self.define_entity_class(entity_class)
    @entity_class = entity_class
  end

  def self.get_entity_class
    @entity_class
  end

  def self.has_dsl_attribute?(attribute_name)
    @allowed_dsl_attributes.include?(attribute_name.to_sym)
  end

  def self.build(default_entity_values = {}, &block)
    builder = new(default_entity_values)
    builder.instance_eval(&block)
    builder.build_entity
  end

  # instance methods
  def initialize(default_entity_values = {})
    @builded_attributes = {}.merge(default_entity_values)
  end

  def method_missing(method_name, *args, &block)
    if self.class.has_dsl_attribute?(method_name.to_sym)
      @builded_attributes[method_name.to_sym] = if block_given?
                                                  build_hash_from_block(&block)
                                                else
                                                  args[0]
      end
    else
      raise "Configuration '#{method_name}' is not allowed for #{self}"
    end
  end

  def build_entity
    raise "Entity class is not defined for #{self.class}" if self.class.get_entity_class.nil?
    entity = self.class.get_entity_class.new
    @builded_attributes.each_pair do |k, v|
      entity.send("#{k}=", v)
    end
    entity
  end

  private

  class HashBuilder
    def initialize
      @hash = {}
    end

    def build
      @hash
    end

    def method_missing(method_name, *args, &block)
      @hash[method_name.to_sym] = if block_given?
                                    builder = HashBuilder.new
                                    builder.instance_eval(&block)
                                    builder.build
                                  else
                                    args[0]
      end
    end
  end

  def build_hash_from_block(&block)
    builder = HashBuilder.new
    builder.instance_eval(&block)
    builder.build
  end
end
