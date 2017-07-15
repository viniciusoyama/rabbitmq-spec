# Base class for each builder.
# A Builder is a class where the DSL evaluator will run
# the DSL files. It is where we define our DSL syntax.
# For more info to know how to use it,
# see the specs related to the builders.
class RabbitMQSpec::DSL::Builder::Base
  # class methods

  # @private
  # Helper method to inhereted classes.
  # We declare witch methods will be allowed to be called
  # inside a builder instance in order to store the value
  # passed to the method
  def self.define_dsl_attribute(attribute_name)
    @allowed_dsl_attributes ||= []
    @allowed_dsl_attributes << attribute_name.to_sym
  end

  # @private
  # Helper method to inhereted classes.
  # The child class must call this method
  # Passing and entity to be builded after
  # all the the attributes was filled
  def self.define_entity_class(entity_class)
    @entity_class = entity_class
  end

  # @private
  def self.get_entity_class
    @entity_class
  end

  # @private
  def self.has_dsl_attribute?(attribute_name)
    @allowed_dsl_attributes.include?(attribute_name.to_sym)
  end

  # @public
  # This method evaluates the given blog inside
  # a new instance of the Builder class
  # and asks for the class to build the correlated entity
  def self.build(default_entity_values = {}, &block)
    builder = new(default_entity_values)
    builder.instance_eval(&block)
    builder.build_entity
  end

  # instance methods
  def initialize(default_entity_values = {})
    @builded_attributes = {}.merge(default_entity_values)
  end

  # For each method called we verify if it's
  # an defined attribute for the builder.
  # If it is then we store the argument as value of the attribute
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

  # Helper class to evaluate blocks that are passe
  # to the defined attributes for the inhereted classes
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
