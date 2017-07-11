class RabbitMQSpec::DSL::Builder::Base
  # class methods
  def self.define_dsl_attribute(attribute_name)
    @allowed_dsl_attributes ||= []
    @allowed_dsl_attributes << attribute_name.to_sym
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
    @builded_options = {}.merge(default_entity_values)
  end

  def method_missing(method_name, *args, &block)
    if self.class.has_dsl_attribute?(method_name)
      @builded_options[method_name.to_sym] = if block_given?
        build_hash_from_block(&block)
      else
        args[0]
      end
    else
      raise "Configuration '#{method_name}' is not allowed for #{self.to_s}"
    end
  end

  private
  def build_entity
    raise 'Implement on child class'
  end

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