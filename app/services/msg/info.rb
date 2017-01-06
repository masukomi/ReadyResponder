class Msg::Info < Msg::TemplatedBase

  def respond
    codename = get_event_codename
    target = Event.find_by_code(codename)
    return target if target.is_a? Error::Base

    @templated_locals[:event] = target



  end
end

