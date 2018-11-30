# QUESTÃO 15

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