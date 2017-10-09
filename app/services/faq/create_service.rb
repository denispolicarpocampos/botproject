module FaqModule
  class CreateService
    def initialize(params)
      # TODO: identify origin and set company
      @company = Company.last
      @question = params["question"]
      @answer = params["answer"]
      @hashtags = params["hashtags"]
    end

    def call
      return 'Hashtag Obrigatória' if @hashtags == nil
      Faq.transaction do
        faq = Faq.create(question: @question, answer: @answer, company: @company)
        @hashtags.split(/[\s,]+/).each do |hashtag|
          faq.hashtags << Hashtag.create(name: hashtag)
        end
      end
      "Criado com sucesso"
    end
  end
end
