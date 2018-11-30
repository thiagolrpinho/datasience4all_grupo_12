# Biblioteca com funções disponibizadas pelos responsáveis da disciplina 
setwd("~/Documents/Estudos/UnB/Data Science 4 All/Projeto Final - Grupo 12/Projeto_R_Studio_Pos_Educacao_fisica")
source("elattes.ls2df.R")
# Bibliotecas utilizadas no script abaixo
library(jsonlite)
library(plyr)
library(tidyverse)
library(igraph)
library(RColorBrewer)

# Ciências de Reabilitação  - 250
json.perfil.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.profile.json"
json.advise.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.advise.json"
json.graph.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.graph.json"
json.list.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.list.json"
json.publication.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.publication.json"

unb.perfil.ciencias_de_reabilitacao <- fromJSON(json.perfil.ciencias_de_reabilitacao)
unb.producao.ciencias_de_reabilitacao <- fromJSON(json.publication.ciencias_de_reabilitacao)
unb.graph.ciencias_de_reabilitacao <- fromJSON(json.graph.ciencias_de_reabilitacao)


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


# QUESTÃO 13


qplot(ano, data=producoes.df, geom="density", fill=tipo_producao, alpha=I(.9), 
      facets=tipo_producao~.,
      main="Produções da Pós em Ciências de Reabilitação", xlab="Ano", 
      ylab="Densidade" )
#Laço para corrigir o erro de produções sem ano, mas com ano do trabalho
for (row in 1:nrow(producoes.df)) {
  if ( is.na(producoes.df$ano[row]) ){
    producoes.df$ano[row] <- producoes.df$ano_do_trabalho[row]
  } 
}
producao.df <- merge(producoes.df, count(producoes.df, "idLattes"))
producao.df %>%
  group_by(idLattes) %>%
  ggplot(aes(x=ano ,y=freq, color=idLattes)) +
  xlab("Quantidade de Produção") + ylab("Ano") + ggtitle("Produção de Ciências de Reabilitação") + geom_point() + geom_jitter() + facet_grid(tipo_producao~.)


# QUESTÃO 14
# Apresente / cole abaixo um script para análise e visualização de dados de perfil / orientações. 
# A visualização deve levar em consideração as especialidades dos professores como atributo e o fato 
# de ter ou não participado de congressos internacionais nos últimos anos. O gráfico não pode ser no 
#  formato Histograma.

#Laço para corrigir o erro de produções sem ano, mas com ano do trabalho
for (row in 1:nrow(producoes.df)) {
  if ( is.na(producoes.df$ano[row]) ){
    producoes.df$ano[row] <- producoes.df$ano_do_trabalho[row]
  } 
}

# Reunindo as base de dados em um grande dataframe 
perfil.orientacoes.df <- merge(producoes.df, areas_atuacao.df)
producoes.df <- producoes.df[-1]
perfil.orientacoes.df <- merge(perfil.orientacoes.df, producoes.df)

count(producoes.df, vars="ano")


perfil.orientacoes.df %>%
  group_by(ano,especialidade, idLattes) %>%
  filter( pais_de_publicacao != "Brasil" && !is.na(pais_de_publicacao)) %>%
  ggplot(aes(x=ano,y=especialidade, color= tipo_producao)) +
  xlab("Ano") + ylab("Especialidade")+ ggtitle("Produções de Ciências de Reabilitação Internacionais") + geom_point() + geom_jitter()

perfil.orientacoes.df %>%
  group_by(ano,especialidade, idLattes) %>%
  filter( pais_de_publicacao == "Brasil" || is.na(pais_de_publicacao)) %>%
  ggplot(aes(x=ano,y=especialidade, color= tipo_producao)) +
  xlab("Ano") + ylab("Especialidade") + ggtitle("Produções de Ciências de Reabilitação Não-Internacionais") + geom_point() + geom_jitter()
  
### QUESTÃO 12
areas_atuacao.df <- extrai.areas.atuacao(unb.perfil.ciencias_de_reabilitacao)
perfils.df <- extrai.perfis(unb.perfil.ciencias_de_reabilitacao)
perfil.area_atuacao.df <- merge(perfils.df, areas_atuacao.df)
perfil.df <- merge(perfil.area_atuacao.df,count(producoes.df$idLattes), by.x = "idLattes", by.y="x")
perfil.df <- merge(perfil.df,count(orientacoes.df$idLattes), by.x = "idLattes", by.y="x")
colnames(perfil.df)[18] <- "count_orientacoes"
colnames(perfil.df)[17] <- "count_producoes"

perfil.df %>%
  group_by(idLattes, grande_area) %>%
  ggplot(aes(x=count_producoes ,y=count_orientacoes, color= grande_area)) +
  xlab("Número de Produções") + ylab("Número de Orientações") + ggtitle("Produções e Orientações de Ciências de Reabilitação") + geom_point() + geom_jitter()

perfil.df %>%
  group_by(idLattes, area) %>%
  ggplot(aes(x=count_producoes ,y=count_orientacoes, color= area)) +
  xlab("Número de Produções") + ylab("Número de Orientações") + ggtitle("Produções e Orientações de Ciências de Reabilitação") + geom_point() + geom_jitter()

perfil.df %>%
  group_by(idLattes) %>%
  ggplot(aes(x=count_producoes ,y=count_orientacoes, color= nome)) +
  xlab("Número de Produções") + ylab("Número de Orientações") + ggtitle("Produções e Orientações de Ciências de Reabilitação") + geom_point() + geom_jitter()

perfil.df %>%
  group_by(idLattes, especialidade) %>%
  ggplot(aes(x=count_producoes ,y=count_orientacoes, color= especialidade)) +
  xlab("Número de Produções") + ylab("Número de Orientações") + ggtitle("Produções e Orientações de Ciências de Reabilitação") + geom_point() + geom_jitter()


# QUESTÃO 15

grafo.df <- unb.graph.ciencias_de_reabilitacao
grafo.df$properties <- areas_atuacao.df

g3 <- graph_from_data_frame(grafo.df$links, directed=F, 
                            vertices = grafo.df$nodes )
E(g3)$weigth <- as.numeric(grafo.df$links$weigth)
V(g3)$label <- as.vector(grafo.df$nodes$properties[,1])

# Para explorar os dados, primeiro checo o nível de entrelaçamento dos nós

g3.b <- betweenness(g3, directed = TRUE)

# Depois o número de pesquisas feito pelo pesquisador
contagem <- merge(grafo.df$nodes, as.data.frame(count(grafo.df$properties$idLattes)), by.x = "id",by.y = "x") 
colors <- brewer.pal(range(contagem$freq)[2],"Greens")

# Quanto mais escuro o verde, maior o número de publicações
V(g3)$color <- colors[contagem$freq]

plot(g3, 
     vertex.label.color = "black",
     vertex.label.cex = 0.6 ,
     edge.color = "gray",
     vertex.size = g3.b+10,
     edge.width = g3$weight+3,
     main = "Rede Entrelaçamento de Pesquisas",
     layout = layout_nicely(g3))


# Questões idiotas 

#Questão 15
count( producao.df %>% filter(tipo_producao == "PERIODICO"), "periodico")

#Questão 14

library(data.table) # load package
dt <- data.table(producao.df) # transpose to data.table
dt[, list(Freq =.N), by=list(producao.df$tipo_producao,producao.df$ano)] # use list to name var directly

