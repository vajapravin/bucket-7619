# frozen_string_literal: true
#
class ApiResponse
  attr_accessor :success, :invocation_id, :errors, :error, :message, :error_type, :response_url, :logs

  def initialize(success)
    @success = success
  end

  def self.good(contents)
    response = new(true)
    response.message = contents
    response
  end

  def self.bad(contents)
    response = new(false)
    response.error = contents
    response.error_type = I18n.t('error_type.generic')
    response
  end
end