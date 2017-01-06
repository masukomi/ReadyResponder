class Msg::TemplatedBase < Msg::Base
  attr_reader :template_locals

  def initialize(args)
    super(args)
    @template_locals = {}
  end

  def has_template?
    true
  end

end
