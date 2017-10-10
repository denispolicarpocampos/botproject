module LinkModule
  class CreateLink
    def initialize(params)
      # TODO: identify origin and set company
      @company = params["company-original"]
      @link = params["link-original"]
      @hashtags = params["hashtags-original"]
    end

    def call
      return "Hashtag Obrigatória" if @hashtags == nil
      Link.transaction do
        link = Link.create(link: @link, company: @company)
        @hashtags.split(/[\s,]+/).each do |hashtag|
          link.hashtags << Hashtag.create(name: hashtag)
        end
      end
      "Link criado com sucesso!"
    end
  end
end
