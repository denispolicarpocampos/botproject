module FaqModule
  class CreateService
    def initialize(params)
      # TODO: identify origin and set company
      @company = Company.last
      @question = params["question-original"]
      @answer = params["answer-original"]
      @hashtags = params["hashtags-original"]
    end

    def call
      if @hashtag == nil || @hashtag == ""
        return 'Hashtag Obrigatória'
      end

      begin
        Faq.transaction do
          faq = Faq.create(question: @question, answer: @answer, company: @company)
          return "Hashtag Obrigatória" if @hashtags == nil
          @hashtags.split(/[\s,]+/).each do |hashtag|
            faq.hashtags << Hashtag.create(name: hashtag)
          end
        end
        "Criado com sucesso"
      rescue
        "Problemas na criação"           
      end
    end
  end
end
