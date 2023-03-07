class ApplicationApiController < ApplicationController
  before_action :set_default_format
  private

    def set_default_format
      request.format = :json
    end

    def render(options={})
      options[:json] = serializer.new(options[:json])
      super(options)
    end
end
