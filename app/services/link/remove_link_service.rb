module LinkModule
  class RemoveLink
    def initialize(params)
      # TODO: identify origin and set company
      @company = Company.last
      @id = params["id"]
    end

    def call
      begin
        link = @company.links.find(@id)
      rescue
        return "Link inválido, verifique o Id"
      end

      Link.transaction do
        faqlink = FaqLink.find_by link_id: @id

        if FaqLink.exists?(link_id: @id) == false
          link.hashtags.each do |h|
            if h.links.count <= 1
              h.delete
            end
          end
          link.delete
          "Link deletado com sucesso!"
        else
          "O link está associado a um FAQ, para remove-lo você deve deletar o FAQ!"
        end
      end
    end
  end
end
