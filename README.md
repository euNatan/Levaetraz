# Levaetraz
##Desafio


Entregando mercadorias

A Companhia LevaEtraz está desenvolvendo um novo sistema de logistica e sua ajuda é muito

importante neste momento. Sua tarefa será desenvolver o novo sistema de entregas visando

sempre o menor custo. Para popular sua base de dados o sistema precisa expor um

Webservices que aceite o formato de malha logística (exemplo abaixo), nesta mesma

requisição o requisitante deverá informar um nome para este mapa. É importante que os

mapas sejam persistidos para evitar que a cada novo deploy todas as informações

desapareçam. O formato de malha logística é bastante simples, cada linha mostra uma rota:

ponto de origem, ponto de destino e distância entre os pontos em quilômetros.

A B 10

B D 15

A C 20

C D 30

B E 50

D E 30

Com os mapas carregados o requisitante irá procurar o menor valor de entrega e seu caminho,

para isso ele passará o mapa, nome do ponto de origem, nome do ponto de destino,

autonomia do caminhão (km/l) e o valor do litro do combustivel, agora sua tarefa é criar este

Webservices. Um exemplo de entrada seria, mapa SP, origem A, destino D, autonomia 10,

valor do litro 2,50; a resposta seria a rota A B D com custo de 6,25.

-------------------------------------------------------------------------------------------------------

##Instalando o projeto

- Clone o projeto com git:

 - ` git clone https://github.com/euNatan/Levaetraz.git `

- Instale as dependências com o bundle:
  - `cd Levaetraz `
  - ` bundle install `

- Crie o banco de dados ( Banco configurado é o Mysql ):
  - ` rake db:create `
  - ` rake db:migrate `

- Popule o banco de dados( Previamente seguindo os valores do desafio ):
  - ` Vá no terminal e no diretorio do projeto rode este comando: bundle exec rake create_routes:start  `

- Você pode rodar a aplicação com:
 - ` rails s ` de dentro da pasta do projeto.

### Adicionando mapas
-  Basta preencher os campos do formulario 'Crie uma nova rota' e enviar.

### Consultando rotas
-  Clique em "consultar" que fica ao lado direito.
-  Escolha o mapa e clique em buscar.
-  Escolha a origem, o destino e coloque a autonomia e o preço do combustivel e clique em enviar.


##Webservice

### Para visualizar o mapa e suas rotas
Faça uma requisição do tipo GET na url: `/api/routes.json`

### Adicionando mapas
Para adicionar uma rota faça uma requisição do tipo GET na url: `/api/route/create.json` passando os seguintes parâmetros:

  - `map` : nome do mapa, exemplo: New York
  - `origin`: Nome do ponto de origem.
  - `destination`: Nome do ponto de destino
  - `distance`: Distância entre pontos em Km.

Se tudo ocorrer de acordo, você receberá uma resposta (Criado com sucesso)

Exemplo de criação pela url com o web service rodando local:

`  http://localhost:3000/api/route/create.json?map=Sao Paulo&origin=A&destination=E&distance=35 `
