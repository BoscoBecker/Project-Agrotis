## Projeto para testes(Agrotis)

## Tecnologia
Usando o IDE de desenvolvimento Embarcadero RAD Studio 10.2 Tokyo Architect 25.0.26309.314

## Componentes
* Uso do componente de conexão a banco FireDac(nativo Embarcadeiro 10.2)
* Uso Data Access, DataSet
* DbChart, para gerar gráficos.

##  Microsoft SQL Server 2017 (RTM) - 14.0.1000.169 (X64)

## Foi realizado um Bakcup da Base de dados, só restaurar, está na raiz do projeto pasta chamada de "DataBase", compactado.	 

## Informações de acesso a base de dados e conexão do sistemas.
* Para o funcionamento correto banco na aplicação, deve-se configurar o IP ou hostname onde esta a base de dados
dbAgrotis, sendo assim no Delphi, deve se configurar duas conexões, segue abaixo:

* Para a geração de gráfico
* Local: formGraficoPedido > FDConnectionGrafico(componente) "Duplo clique"

* Conexão geral do sistema
* Local: UdmConexao.pas >  connectionSSMS(componente)  "Duplo clique"

* String de conexão para ser inserida nas configurações dos 2 componentes

* Database=dbagrotis
* Server=DESKTOP-FPNQ6CD    * SEU IP OU HOSTNAME *
* OSAuthent=No
* User_Name=delphi
* Password=delphi
* DriverID=MSSQL

## Maquina usada para o desenvolvimento
* Processador: AMD 1.0 Ghz
* Memoria RAM : 6.0 GB
* OS WIndows 10 Pro 64 Bits

MAKE WITH LOVE - BOSCOBECKER