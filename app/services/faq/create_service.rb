module FaqModule
  class CreateService
    def initialize(params)
      # TODO: identify origin and set company
      @company = Company.last
      @question = params["question-original"]
      @answer = params["answer-original"]
      @hashtags = params["hashtags-original"]
      @link = params["link-original"]
    end

    def call
      return 'Hashtag Obrigatória' if @hashtags == nil
      Faq.transaction do
        faq = Faq.create(question: @question, answer: @answer, company: @company)
        link = Link.create(link: @link, company: @company) if @link != nil
        @hashtags.split(/[\s,]+/).each do |hashtag|
          faq.hashtags << Hashtag.create(name: hashtag)
          link.hashtags << Hashtag.create(name: hashtag) if @link != nil
        end
      end
      "Criado com sucesso"
    end
  end
end
