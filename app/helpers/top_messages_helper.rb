module TopMessagesHelper

  def auth_xml
    render 'authentication',type: :haml
  end
end
