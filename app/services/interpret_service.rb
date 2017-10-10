class InterpretService
  def self.call action, params
    case action
    when "list", "search", "search_by_hashtag"
      FaqModule::ListService.new(params, action).call()
    when "create"
      FaqModule::CreateService.new(params).call()
    when "remove"
      FaqModule::RemoveService.new(params).call()
    when "help"
      HelpService.call()
    when "list_link", "search_link_by_hashtag"
      LinkModule::ListLink.new(params, action).call()
    when "create_link"
      LinkModule::CreateLink.new(params).call()
    when "remove_link"
      LinkModule::RemoveLink.new(params).call()
    else
      "Não compreendi o seu desejo"
    end
  end
end
