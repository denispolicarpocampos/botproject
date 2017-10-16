require_relative './../../spec_helper.rb'

describe LinkModule::RemoveLink do
  before do
    @company = create(:company)
  end

  describe "#call" do
    it "With valid ID, remove Link" do
      link = create(:link, company: @company)
      @removeService = LinkModule::RemoveLink.new({ "id" => link.id })
      response = @removeService.call()
      expect(response).to match("Link deletado com sucesso!")
    end

    it "With valid ID, remove Link" do
      faq =  create(:faq, company:@company)
      link = create(:link, company: @company)
      create(:faq_link, link: link, faq: faq)
      @removeService = LinkModule::RemoveLink.new({ "id" => link.id })
      response = @removeService.call()
      expect(response).to match("O link está associado a um FAQ, para remove-lo você deve deletar o FAQ!")
    end

    it "Without valid ID" do
      link = create(:link, company: @company)
      @removeService = LinkModule::RemoveLink.new({ "id" => rand(1..9999) })
      response = @removeService.call()
      expect(response).to match("Link inválido, verifique o Id")
    end


    it "Remove from database" do
      link = create(:link, company: @company)
      @removeService = LinkModule::RemoveLink.new({ "id" => link.id })
      expect(Link.all.count).to eq(1)
      response = @removeService.call()
      expect(Link.all.count).to eq(0)
    end
  end
end
