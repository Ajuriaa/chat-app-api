module SimpleAction
  class Base
    extend AcceptsParams
    extend Transactable
    include ActiveModel::Conversion
    extend ActiveModel::Naming
    include DelegatesToParams

    class << self
      def run(params = {})
        instance = new(params)
        instance.mark_as_ran
        result = transaction do
          if instance.valid?
            outcome = instance.execute
            instance.errors.empty? ? outcome : nil
          end
        end
        instance.set_result(result)
        instance
      end

      def run!(params = {})
        response = run(params)
        if response.valid?
          response.result
        else
          raise ExecutionError, response.errors.to_s
        end
      end
    end

    def initialize(params = {})
      @raw_params = params
      @params = self.class.params_class.new(params)
      @initial_params_valid = nil
      @result = nil
      @has_run = false
    end

    attr_reader :params, :result

    def valid?
      initial_params_valid? && errors.empty?
    end

    def errors
      @params.errors
    end

    def execute
      raise ImplementationError, "subclasses must implement 'execute' method."
    end

    def persisted?
      false
    end

    def success?
      valid? && @has_run
    end
    alias value result

    def set_result(result = nil)
      @result = result
    end

    def mark_as_ran
      @has_run = true
    end

    private

    def initial_params_valid?
      if @initial_params_valid.nil?
        @initial_params_valid = @params.valid?
      else
        @initial_params_valid
      end
    end
  end
end
