class ApplicationService
  private_class_method :new

  def self.call(params)
    new(params).call
  end

  def initialize(params)
    @params ||= params
  end

  def call; end

  private

  attr_reader :params
end
