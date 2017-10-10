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
        link.hashtags.each do |h|
          if h.links.count <= 1
            h.delete
          end
        end
        link.delete
        "Link deletado com sucesso!"
      end
    end
  end
end
