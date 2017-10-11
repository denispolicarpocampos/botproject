class HelpService
  def self.call
    response  = "*O que eu sei fazer :raised_hands:* \n\n"
    response += "*help*\n"
    response += ">Lista de comandos que eu conheço\n\n"
    response += "*Adicione ao Faq*\n"
    response += ">Adiciona uma nova questão ao Faq\n\n"
    response += "*Remova ID*\n"
    response += ">Remove uma questão baseada no ID dela\n\n"
    response += "*Adiciona link\n\n"
    response += ">Adiciona link a lista de links\n\n"
    response += "*Remove link\n\n"
    response += ">Remove link da lista de links baseado no ID dele\n\n"
    response += "*O que você sabe sobre X*\n"
    response += ">Pesquisa por palavra na lista de perguntas e respostas\n\n"
    response += "*Pesquise a hashtag X*\n"
    response += ">Lista as perguntas e respostas com aquela hashtag\n\n"
    response += "*Lista de links\n\n"
    response += ">Lista de link com aquele hashtag\n\n"
    response += "*Perguntas e Respostas*\n"
    response += ">Mostra a lista de perguntas e respostas\n\n"
  end
end
