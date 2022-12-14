# Intro R - Julio Pedrassoli - Geoprocessamento Aplicado - 2020

# ESTE TUTORIAL TEM COMO OBJETIVO UMA INTRODUCAO RAPIDA AO FUNCIONAMENTO E A ESTRUTURA DE TRABALHO NO R

# Vamos dividir este tutorial em 4 licoes

# (1) Carregamento de arquivos no R
# O R ? ? voltado para computaa??o cient?fica e an?lise estatica e, por isso, se da muito bem como bases de dados (xls, dbf, csv, etc.)
# O R base tem diversas funcoes de carregamento de arquivos, bastante simples. Vamos carregar neste exemplo alguns dados do censo 
# demografico de 2010 para Salvador:

# A estrutura ? simples:
# "1" <- "2("3"), onde 1 ? o nome do objeto que sera criado dentro do R, e neste caso como carregaremos uma tabela ser? um dataframe,
# 2 ? a funcao que usaremos para criar este dataframe e 3 ? o arquivo, e os possiveis argumentos de definicao dele, ao qual
# aplicaremos a funcao para a importacao, e o simbolo <- indica que o objeto a esquerda recebera o resultado da funcao:

# como acessaremos um arquivo externo ? recomemd?vel que o primeiro passo seja setar a pasta de origem e destino dos arquivos gerados 
# nesta sess?o de trabalho: v? no menu Session -> set working directory -> choose directory, e entao escolha a pasta que ira trabalhar
# e lembre-se que o arquivo .csv que usaremos neste exercicio devera estar dentro desta pasta

df <- read.csv("intr_r_censo2010.csv")

# Apos digitar a linha de comando clique em "run" no canto superior direito desta janela ou com o cursor sobre a linha pressione ao
# mesmo tempo CTRL+Enter

# Observe que a cada comando executado uma resposta aparece no console, janela logo abaixo desta, assim como, eventuais erros,
# tambem aparecerao. Na janela superior direita aparecera, na aba Environment, o objeto que acabamos de criar, e ja e 
# possivel observar que se trata de uma tabela com 3592 linhas (setores censitarios de Salvador) e 7 variaveis (colunas), neste caso
# Vamos olhar a tabela

View(df)

# Observe que uma nova aba com o nome "df" se abriu acima nesta mesma janela, e voce pode acessa-la para ver a tabela gerada pelo R
# O mesmo efeito ocorre se simplesmente clicarmos sobre o objeto na janela superior direita.
# As variaveis disponiveis para este exercicio introdutorio sao: "pop masculina com mais de 60 anos", "pop feminina com mais de
# 60 anos", "populacao total", "renda media em salarios minimos", "domicilios com mais de 10 moradores"e "numero de domicilios com
# abastecimento de agua e coleta de esgoto"

# Vamos analisar a estrutura deste banco:

str(df)

# (2) Manipulacao do banco de dados

# Observe que na janela abaixo "console" apareceram as caracteristicas de cada uma das variaveis, renda do tipo numerica (pois tem
# valores quebrados) e todas as outras do tipo numero inteiro. Observe tambem que o simbolo $ e usado na sintaxe do R para acessar
# campos de um dataframe individualmente.
# Desta forma, podemos manipular os tipos de variaveis, se quisermos, por exemplo, tranformar o campo "masc_60" em um campo 
# numerico com decimais:

df$masc_60. <- as.numeric(df$masc_60.)

str(df)

# Observe que, apos aplicar a transformacao do tipo de variavel, pedindo novamente para ver a estrutura do banco, o campo
# "masc_60." passou a constar como sendo do tipo "num".

# (3) uso de funcoes basicas do R

# Bom, mas o R gosta mesmo e de estatistica, pois ? uma liguagem de programacao e, por assim dizer, uma grande calculadora sem
# muitos limites...
# Vamos calcular uma matriz de correlacao (https://en.wikipedia.org/wiki/Correlation_and_dependence#Correlation_matrices)
# entre todos os dados do nosso banco:

matriz_correlacao <- cor(df)

View(matriz_correlacao)

# Observe que a matriz gerada veio com varias celulas nulas. Isso se da porque por default, esta funcao ignora qualquer campo 
# que tenha celulas vazias, e assim, esse foi nosso resultado. Desta forma, e um bom momento para acrescentar mais argumentos
# em uma funcao, e neste caso, vamos dizer pro R calcular a matriz olhando par a par, e nao ignorando os nulos:

matriz_correlacao <- cor(df, use="pairwise")

View(matriz_correlacao)

# Veja que o resultado mudou e ja e possivel observar as correlacoes de pearson entre todas as variaveis
# Para entender todos os argumentos de uma funcao, a melhor opcao e sempre consultar a documentacao do proprio R. Neste caso,
# para a funcao "cor": https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/cor, no proprio R, voce pode
# consultar usarndo "help", e vendo o resultado na aba help, da caixa inferior a direita:

help("cor")

# (4) Instalacao e uso de pacotes no R

# Mas o R e conhecido por ter uma infinidade de "pacotes", que sao novas funcoes adicionadas a ele para os mais diversos fins
# e que empliam enormemente o seu potencial de uso.
# Por exemplo, vamos visualizar as correlacoes de uma maneira visual mais eficiente, e para isso vamos usar um pacote chamado
# "corrplot":

# Instalamos o Pacote:

install.packages("corrplot")

# Carregamos o pacote

library(corrplot)

# Geramos um grafico de correlacoes usando a matriz que calculamos:

corrplot(matriz_correlacao)

# Observe que na janela inferior a direita, na aba "Plots" um novo grafico foi gerado. Por default ele apresenta o tamanho do
# circulo como a intensidade da correlacao entre as variaveis e a cor e tom, indicam a direcao da relacao (azul = positiva e
# vermelho = negativa)
# Novamente, com alguns argumentos podemos ajustar este resultado visual. Percebe-se que o grafico ? simetrico, como toda 
# matriz de correlacao, entao vamos simplificar, dando uma olhada na documentacao do "corrplot":

help(corrplot)

# Vamos recortar esse grafico no meio, na diagonal:

corrplot(matriz_correlacao, method="color", type="upper")

# Nesse grafico, podemos infererir, visualmente, a direcao e a intensidade das correlacoes. E possivel verificar que existe correlacao
# entre populacao total e populacao de 60 anos, entao onde ha mais populacao ha mais populacao com idade igual ou superior a 60 anos. 
# Por outro lado, onde ha 10 ou mais moradores por domicilio, a renda decresce, por isso existe uma correlacao inversa entre essas 
# variaveis.
