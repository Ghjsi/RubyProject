module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        define_method(name) { instance_variable_get("@#{name}") }

        define_method("#{name}=") do |value|
          instance_variable_set("@#{name}", value)
          send "#{name}_history=", value
        end

        define_method("#{name}_history") do
          instance_variable_get("@#{name}_history") || []
        end

        define_method("#{name}_history=") do |v|
          history = instance_variable_get("@#{name}_history") || []
          history << v
          instance_variable_set("@#{name}_history", history)
        end
      end
    end

    def strong_attr_accessor(name, klass)
      define_method(name) { instance_variable_get("@#{name}") }

      define_method("#{name}=") do |value|
        unless value.is_a?(klass)
          raise "Тип значения #{value.class} не соответствует типу атрибута #{klass}"
        end
        instance_variable_set("@#{name}", value)
      end
    end
  end
end
