require_relative './../../spec_helper.rb'

describe LinkModule::CreateLink do
  before do
    @company = create(:company)
    @link = FFaker::Internet.http_url
    @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
  end

  describe "#call" do

    it "without hashtag" do
      @createlink = LinkModule::CreateLink.new({"link-original" => @link})
      response = @createlink.call()
      expect(response).to match("Hashtag Obrigatória")
    end

    it "with hashtag and link" do
      @createlink = LinkModule::CreateLink.new({"link-original" => @link, "hashtags-original" => @hashtags})
      response = @createlink.call()
      expect(response).to match("Link criado com sucesso!")
    end

    it "with valid params to find in database" do
      @createlink = LinkModule::CreateLink.new({"link-original" => @link, "hashtags-original" => @hashtags})
      response = @createlink.call()
      expect(Link.last.link).to match(@link)
    end

    it "with valid params hashtags are created" do
      @createlink = LinkModule::CreateLink.new({"link-original" => @link, "hashtags-original" => @hashtags})
      response = @createlink.call()
      expect(@hashtags.split(/[\s,]+/).first).to match(Hashtag.first.name)
      expect(@hashtags.split(/[\s,]+/).last).to match(Hashtag.last.name)
    end
  end
end
