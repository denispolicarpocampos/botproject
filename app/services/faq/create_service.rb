module FaqModule
  class CreateService

    require 'uri'

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
        if @link =~ /\A#{URI::regexp}\z/
          link = Link.create(link: @link, company: @company)
          faq.links << link
          @hashtags.split(/[\s,]+/).each do |hashtag|
            faq.hashtags << Hashtag.create(name: hashtag)
            link.hashtags << Hashtag.create(name: hashtag)
          end
          return "Criado com sucesso"
        elsif @link == 'Não' || 'não'
          @hashtags.split(/[\s,]+/).each do |hashtag|
            faq.hashtags << Hashtag.create(name: hashtag)
          end
          return "Criado com sucesso"
        end
      end
    end
  end
end
