require_relative './../../spec_helper.rb'

describe LinkModule::ListLink do
  before do
    @company = create(:company)
  end

  describe "#call" do
    it "with list command: With zero link, return don't find message" do
      @list = LinkModule::ListLink.new({}, 'list_link')
      response = @list.call()
      expect(response).to match("Nenhum link encontrado!")
    end

    it "With two links, find name of links in response" do
      @list = LinkModule::ListLink.new({}, 'list_link')
      link1 = create(:link, company: @company)
      link2 = create(:link, company: @company)
      response = @list.call()
      expect(response).to match(link1.link)
      expect(response).to match(link2.link)
    end

    it "with search_by_hashtag command: With invalid hashtag, return don't find message" do
      @list = LinkModule::ListLink.new({"query" => ''}, 'search_link_by_hashtag')
      response = @list.call()
      expect(response).to match("Nenhum link encontrado!")
    end

    it "with search_by_hashtag command: With valid hashtag, find name of link and hashtags in response" do
      hashtag = create(:hashtag, company: @company)
      link = create(:link, company: @company)
      create(:link_hashtag, link: link, hashtag: hashtag)

      @list = LinkModule::ListLink.new({'query' => hashtag.name}, 'search_link_by_hashtag')

      response = @list.call()
      expect(response).to match(link.link)

    end
  end
end
