module Validation
  def  self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validations
      @validations ||= []
    end

    def validate(attr_name, valid_type, option = nil)
      @validations ||= []
      @validations << { attr_name: attr_name, valid_type: valid_type, option: option }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        value = instance_variable_get("@#{validation[:attr_name]}") #
        send((validation[:valid_type]).to_s, value, *validation[:option])
      end
    end

    protected

    def presence(value)
      raise StandardError, 'Значение является пустой строкой' if value.to_s.empty?
    end

    def formate(value, option)
      raise StandardError, "Значение #{value} не соответствет формату #{option}" if value !~ option
    end

    def attr_type(value, option)
      raise StandardError, 'Тип атрибута не соответствует классу' unless value.is_a? option
    end

    public

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
