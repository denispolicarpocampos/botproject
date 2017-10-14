require_relative './../../spec_helper.rb'

describe FaqModule::CreateService do
  before do
    @company = create(:company)

    @question = FFaker::Lorem.sentence
    @answer = FFaker::Lorem.sentence
    @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
    @link = FFaker::Internet.http_url
  end

  describe '#call' do
    it "Without hashtag params, will receive a error" do
      @createService = FaqModule::CreateService.new({"question-original" => @question, "answer-original" => @answer, "link-original" => @link})

      response = @createService.call()
      expect(response).to match("Hashtag Obrigatória")
    end

    it "With valid params, receive success message" do
      @createService = FaqModule::CreateService.new({"question-original" => @question, "answer-original" => @answer, "hashtags-original" => @hashtags, "link-original" => @link})

      response = @createService.call()
      expect(response).to match("Criado com sucesso")
    end

    it "With valid params, receive success message" do
      link = 'Não'
      @createService = FaqModule::CreateService.new({"question-original" => @question, "answer-original" => @answer, "hashtags-original" => @hashtags, "link-original" => link})

      response = @createService.call()
      expect(response).to match("Criado com sucesso")
    end

    it "With valid params, receive success message, link any string" do
      link = FFaker::Name.name
      @createService = FaqModule::CreateService.new({"question-original" => @question, "answer-original" => @answer, "hashtags-original" => @hashtags, "link-original" => link})

      response = @createService.call()
      expect(response).to match("Não foi possível criar pois o link é invalido")
    end

    it "With valid params, find question and anwser in database" do
      @createService = FaqModule::CreateService.new({"question-original" => @question, "answer-original" => @answer, "hashtags-original" => @hashtags, "link-original" => @link})

      response = @createService.call()
      expect(Faq.last.question).to match(@question)
      expect(Faq.last.answer).to match(@answer)
      expect(Link.last.link).to match(@link)
    end

    it "With valid params, hashtags are created" do
      @createService = FaqModule::CreateService.new({"question-original" => @question, "answer-original" => @answer, "hashtags-original" => @hashtags, "link-original" => @link})

      response = @createService.call()
      expect(@hashtags.split(/[\s,]+/).first).to match(Hashtag.first.name)
      expect(@hashtags.split(/[\s,]+/).last).to match(Hashtag.last.name)
    end
  end
end
