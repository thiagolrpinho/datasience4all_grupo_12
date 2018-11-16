  # Data Science 4 All Grupo 3 Educação Física

  Projeto final da matéria de Tópicos Avançados em Programação - Data Sience 4 All

  ## Membros

  Bruno Helder - 1X/00YYYYYYYY  
  Gabriel Almeida - 15/0009887  
  Thiago Luis - 15/0065205  

  ## Trello do Projeto

  [Trello](https://trello.com/b/GaaLi38O/datascience-grupo-3-educa%C3%A7%C3%A3o-f%C3%ADsica)  


  ## Etapas do Projeto

  ### 1 - Busca dos dados no e-Lattes  

  Após definidos os programas, buscar no elattes as análises disponíveis para os respectivos programas. Criar novas análises no caso do universo não ser o mesmo (mais ou menos professores que no programa atual). As análises foram feitas no semestre passado e podem ter havido alterações no programa. O número correto e nome dos professores pode ser encontrado no portal da CAPES.
  Links úteis:  
  [e-Lattes](http://unb.elattes.com.br "e-lattes")


  **Nota do Professor:**

   >No item 1 vcs devem entrar na plataforma sucupira, Clicar no Baner Coleta Capes, Preencher os campos com universidade e programa desejado, Clicar em salvar Filtro, Clicar em Docentes e na próxima página irá aparecer o nome de todos os docentes do programa segundo a ultima avaliação.

   >Com esses nomes vcs vão no e-lattes e verificam se todos estão contemplados na análise já criada para o programa. Notem que existe uma diferença entre os programas de graduação e pós. Tenham certeza que estão buscando pelo da pós. Entrem na análise e verifiquem que o número e nome dos professores é o mesmo. Se for o mesmo baixem os arquivos json e utilizem o script para fazer a análise.

   >Se o número não for o mesmo vcs terão que criar uma nova análise com todos os nomes que estão na CAPES.

   >Para criar uma nova análise vcs dão um nome, preferencialmente igual ou parecido ao da pós já existente, definam uma data para análise (2010 a 2017 para manter o padrão) façam uma descrição dizendo do que se trata a análise e que vcs que estão criando. Por ultimo faça a busca pelos nomes.

   >Na base existem cerca de 22.000 currículos. Procure por nome todos aqueles que encontraram na CAPES. Após escolher todos peçam para criar a análise.

   >Ela vai rodar por alguns minutos dependendo do tamanho e depois vai estar pronta para visualização na aba Temporário. Abra a análise e verifique que contém todos os nomes que buscaram. Depois faça o download dos arquivos json para análise.

### 3 - Descrição da Metodologia
   Nesta sessão iremos descrever e analisar o processo de exploração, pesquisa e desenvolvimento utilizados para a criação deste projeto, o **CRISP-DM**.
	**CRISP DM** é abreviação de Cross-industry standard process for data mining que é um padrão industrial aberto de processos para abordar trabalhos de data mining e análise de dados em geral. Esta metodologia basicamente se divide em seis etapas: _Business Understanding_ , _Data Understanding_, _Data preparation_ , _Modeling_ , _Evaluation_ e _Deployment_. Iremos descrever casa uma das etapas mais detalhadamente à seguir.

##### Business Understanding
A primeira etapa do processo é talvez a mais abstrata de todas, que é o conhecimento sobre o problema. O objetivo é que se avalie os custos e os impactos da solução a ser proposta. Nesta etapa também, são definidos os objetivos e metas do processo.
	Neste projeto estamos analisando os dados relativos aos Programas de Pós-Graduação da Universidade de Brasília. À partir disso desejamos realizar uma análise exploratória sobre os dados para oferecer novas perspectivas sobre estes programas. 

##### Data Understanding
_Data Understanding_, que pode ser traduzido para Entendimento dos Dados, é a etapa que consiste em avaliar os dados já disponíveis. Deve-se organizar e descrever os dados obtidos, e, avaliar se é possível atingir os objetivos determinados na etapa anterior com estes dados. Esta etapa tem um teor também exploratório, pois é necessário avaliar que tipo de análise é possível realizar com os dados disponíveis e tomar decisões baseadas nesta análise. Por exemplo, é possível determinar que é necessário realizar o processo de obtenção dos dados novamente, ou retornar para a etapa de __Business Understanding__.

Neste projeto, temos acesso tanto aos dados disponibilizados pelo professor, em diferentes arquivos em formato __JSON__, com dados sobre todos os projetos de pós-graduação da UnB, e também os dados disponíveis no E-lattes. O arquivo __profile.json__ contém informações referentes ao perfil dos docentes, identificados pelo número de matrícula e contém nome, resumo do currículo, áreas de atuação, endereço profissional, produção bibliográfica que contém os capítulos de livro, eventos, livros e artigos em periódicos publicados pelo docente. O arquivo __publication.json__ tem informações referentes as publicações da determinada área no período entre 2010 e 2017.


##### Data Preparation
	
A etapa de __Data Preparation__, ou Preparação dos dados, é uma etapa de cunho técnico que tem como objetivo realizar a limpeza dos dados para o processo de modelagem. Dependendo da maneira de como foi realizada a coletagem de dados, esta etapa pode se tornar menos ou mais relevante. Nesta etapa também é realizada a construção de características derivadas, ou seja, dados que são possíveis ser inferidos dos dados disponíveis.

Tomando em conta o projeto aqui sendo desenvolvido, esta etapa é menos relevante pois já obtemos os dados semi-filtrados, que podem ser facilmente utilizados no ambiente de desenvolvimento utilizando a linguagem R, restando apenas selecionar as caracterísitcas a serem utilizadas.

##### Modelagem
	
Nesta etapa é aplicado as técnicas de __Data Science__ e __Data Analisys__ para construir modelos adequados para o contexto da situação e consequentemente tirar conclusões ou proposições para as soluções do problema proposto na etapa de __Business Understanding__.
	
No projeto em questão, iremos ((__inserir o que vai ser feito no projeto__)).

##### Evaluation
Fase de avaliação dos resultados obtidos na etapa de modelagem e verificando se cumpre os objetivos definidos na etapa de __business understanding__.

##### __Deployment__
Fase de implantação de fato dos resultados obtidos nas análises realizadas e assim concluindo o processo de desenvolvimento.
