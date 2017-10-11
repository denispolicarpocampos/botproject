module LinkModule
  class ListLink
    def initialize(params, action)
      # TODO: identify origin and set company
      @company = Company.last
      @action = action
      @query = params["query"]
    end

    def call
      if @action == "list_link"
        links = @company.links
      else @action == "search_link_by_hashtag"
        links = []
        @company.links.each do |link|
          link.hashtags.each do |hashtag|
            links << link if hashtag.name == @query
          end
        end
      end

      response = "*Links* \n\n"
      links.each do |f|
        response += "*#{f.id}* - "
        response += "*#{f.link}* - "
        f.hashtags.each do |h|
          response += "_##{h.name}_ "
        end
        response += "\n\n"
      end
      (links.count > 0)? response : "Nenhum link encontrado!"
    end
  end
end
