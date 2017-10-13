require_relative './../../spec_helper.rb'

describe FaqModule::RemoveService do
  before do
    @company = create(:company)
  end

  describe '#call' do
    it "With valid ID, remove Faq" do
      faq = create(:faq, company: @company)
      @removeService = FaqModule::RemoveService.new({"id" => faq.id})
      response = @removeService.call()

      expect(response).to match("Deletado com sucesso")
    end

    it "With invalid ID, receive error message" do
      @removeService = FaqModule::RemoveService.new({"id" => rand(1..9999)})
      response = @removeService.call()

      expect(response).to match("Questão inválida, verifique o Id")
    end

    it "With valid ID, remove Faq and hashtag from database" do
      faq = create(:faq, company: @company)
      hashtag = create(:hashtag, company: @company)
      create(:faq_hashtag, faq: faq, hashtag: hashtag)

      @removeService = FaqModule::RemoveService.new({"id" => faq.id})

      expect(Faq.all.count).to eq(1)
      expect(faq.hashtags.count).to eq(1)

      response = @removeService.call()
      expect(Faq.all.count).to eq(0)
      expect(faq.hashtags.count).to eq(0)

    end

    it "With valid ID, remove Faq, hashtag and link from database" do
      faq = create(:faq, company: @company)
      hashtag = create(:hashtag, company: @company)
      link = create(:link, company: @company)
      create(:faq_hashtag, faq: faq, hashtag: hashtag)
      create(:faq_link, faq: faq, link: link)

      @removeService = FaqModule::RemoveService.new({"id" => faq.id})

      expect(Faq.all.count).to eq(1)
      expect(faq.hashtags.count).to eq(1)
      expect(faq.links.count).to eq(1)

      response = @removeService.call()
      expect(Faq.all.count).to eq(0)
      expect(faq.hashtags.count).to eq(0)
      expect(faq.links.count).to eq(0)
    end
  end
end
