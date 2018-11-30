# Biblioteca com funções disponibizadas pelos responsáveis da disciplina 
setwd("~/Documents/Estudos/UnB/Data Science 4 All/Projeto Final - Grupo 12/Projeto_R_Studio_Pos_Educacao_fisica")
source("elattes.ls2df.R")
# Bibliotecas utilizadas no script abaixo
library(jsonlite)
library(tidyverse)

# Ciências de Reabilitação  - 250
json.perfil.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.profile.json"
json.advise.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.advise.json"
json.graph.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.graph.json"
json.list.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.list.json"
json.publication.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.publication.json"

unb.perfil.ciencias_de_reabilitacao <- fromJSON(json.perfil.ciencias_de_reabilitacao)
unb.producao.ciencias_de_reabilitacao <- fromJSON(json.publication.ciencias_de_reabilitacao)


areas_atuacao.df <- extrai.areas.atuacao(unb.perfil.ciencias_de_reabilitacao)
perfils.df <- extrai.perfis(unb.perfil.ciencias_de_reabilitacao)
producoes.df <- extrai.producoes(unb.perfil.ciencias_de_reabilitacao)
orientacoes.df <- extrai.orientacoes(unb.perfil.ciencias_de_reabilitacao)

print ("Grande Área")
table(unlist(sapply(unb.perfil.ciencias_de_reabilitacao, function(x) (x$areas_de_atuacao$grande_area))))
print ("Área")
table(unlist(sapply(unb.perfil.ciencias_de_reabilitacao, function(x) (x$areas_de_atuacao$area))))
print ("Sub Área")
table(unlist(sapply(unb.perfil.ciencias_de_reabilitacao, function(x) (x$areas_de_atuacao$sub_area))))
print ("Especialidade")
table(unlist(sapply(unb.perfil.ciencias_de_reabilitacao, function(x) (x$areas_de_atuacao$especialidade))))


total.df <- merge(producoes.df, perfils.df,by="idLattes")

producoes.df %>%
  filter(pais_de_publicacao %in% c("Brasil", "Estados Unidos", "Holanda",
                                   "Grã-Bretanha", "Alemanha", "Suiça")) %>%
  group_by(ano,pais_de_publicacao) %>%
  ggplot(aes(x=ano,y=pais_de_publicacao, color= pais_de_publicacao)) +
  xlab("Ano") + ylab("Pais") + geom_point() + geom_jitter()
 
producoes.df %>%
  group_by(ano,tipo_producao) %>%
  ggplot(aes(x=ano,y=..count.., color= tipo_producao)) +
  xlab("Ano") + ylab("Tipo") + geom_point() + geom_jitter()


qplot(ano, data=producoes.df, geom="density", fill=tipo_producao, alpha=I(.9), 
      facets=tipo_producao~.,
      main="Produções da Pós em Ciências de Reabilitação", xlab="Ano", 
      ylab="Densidade" )

# Apresente / cole abaixo um script para análise e visualização de dados de perfil / orientações. 
# A visualização deve levar em consideração as especialidades dos professores como atributo e o fato 
# de ter ou não participado de congressos internacionais nos últimos anos. O gráfico não pode ser no 
#  formato Histograma.
perfil.orientacoes.df <- merge(orientacoes.df, perfils.df)
perfil.orientacoes.df <- merge(perfil.orientacoes.df, areas_atuacao.df)
producoes.df <- producoes.df[-1]
perfil.orientacoes.df <- merge(perfil.orientacoes.df, producoes.df)

plot(especialidade, data=perfil.orientacoes.df, geom="point", fill=tipo_producao, alpha=I(.3), 
      facets=tipo_producao~.,
      main="Produções da Pós em Ciências de Reabilitação", xlab="Ano", 
      ylab="Densidade" )

perfil.orientacoes.df %>%
  filter(pais_de_publicacao != "Brasil") %>%
  group_by(ano,especialidade) %>%
  ggplot(aes(x=ano,y=especialidade, color= pais_de_publicacao)) +
  xlab("Ano") + ylab("Pais") + geom_point() + geom_jitter()

  
### QUESTÃO 12
list <- c()
for (member in perfils.df) {
  areas_de_atuacao <- filter(areas_atuacao.df, idLattes==member['idLattes'][,1])
  publicacoes <- filter(producoes.df, idLattes==member['idLattes'][,1])
  result <- c("Nome"= member['nome'], "Areas de Atuacao"= areas_de_atuacao, "Publicacoes"=publicacoes)
  append(list, result)
}

areas_atuacao.df <- extrai.areas.atuacao(unb.perfil.ciencias_de_reabilitacao)
perfils.df <- extrai.perfis(unb.perfil.ciencias_de_reabilitacao)
producoes.df <- extrai.producoes(unb.perfil.ciencias_de_reabilitacao)
perfil.area_atuacao.df <- merge(perfils.df, areas_atuacao.df)


