# Projeto Melhores Compras Varejo

Este repositório contém o projeto de desenvolvimento de um sistema de gerenciamento de vídeos para a plataforma de e-commerce da empresa Melhores Compras LTDA. O objetivo é melhorar a experiência do usuário ao disponibilizar vídeos explicativos e informativos sobre produtos, além de implementar funcionalidades para acompanhamento de visualizações, suporte a dúvidas e sugestões de clientes.

## Descrição do Projeto

A plataforma visa oferecer uma experiência rica, proporcionando aos clientes a possibilidade de acessar vídeos sobre produtos, visualizações em tempo real e interagir com a empresa por meio de um sistema de atendimento ao cliente (SAC). A solução utiliza modelagem de dados relacional, integrações e uma camada de apresentação voltada para o usuário final.

## Estrutura do Projeto

- **Modelo Lógico e Físico de Dados**
  - Arquivo `Melhores_Compras_MER_Logico.pdf`: Contém o modelo lógico de dados usando notação da Engenharia da Informação.
  - Arquivo `Melhores_Compras_MER_Fisico.pdf`: Contém o modelo físico (relacional) de dados para implementação no sistema de banco de dados.

- **Scripts de Banco de Dados**
  - Arquivo `Script_DDL_Melhores_Compras.sql`: Contém os comandos DDL para criação das tabelas e estruturas de armazenamento, além de comandos de exclusão (`DROP`) para limpeza do banco de dados.

- **Implementação em Python**
  - Arquivo `Codigo_Nivel_Atendimento_SAC_Melhores_Compras.py`: Algoritmo que classifica o nível de satisfação do atendimento com base na nota de satisfação do cliente (0-100).
  - Arquivo `Evidencia_Teste_Nivel_Atendimento_SAC_Melhores_Compras.pdf`: Captura de tela do código e execução do algoritmo de classificação.

## Requisitos

Para executar o projeto, é necessário:
- Banco de dados compatível com SQL (preferencialmente Oracle SQL Developer ou Oracle Live SQL).
- Python 3 para execução do script de classificação de satisfação.

## Estrutura de Dados

As principais entidades e suas respectivas informações são:
- **Cliente**: Dados de pessoas físicas e jurídicas cadastradas.
- **Produto**: Produtos com informações detalhadas e status.
- **Vídeo**: Arquivos de vídeo associados aos produtos, incluindo status e data de cadastro.
- **Visualização do Vídeo**: Armazena informações de cada visualização do vídeo, incluindo data/hora e usuário (logado ou anônimo).
- **SAC**: Serviço de Atendimento ao Cliente para dúvidas e sugestões.

## Regras de Negócio

1. Cada produto pode ter múltiplos vídeos, mas apenas vídeos com status ativo podem ser exibidos.
2. Produtos e categorias possuem identificadores únicos e sequenciais.
3. A visualização de vídeos é registrada com data, hora e usuário (quando logado).
4. Chamados de atendimento devem conter detalhes do cliente, produto e feedback de satisfação.

## Como Executar

1. **Banco de Dados**:
   - Execute o script `Script_DDL_Melhores_Compras.sql` no ambiente SQL para criar a estrutura do banco.
   
2. **Classificação de Satisfação em Python**:
   - Utilize uma IDE ou terminal com Python 3.
   - Execute `Codigo_Nivel_Atendimento_SAC_Melhores_Compras.py` para realizar a classificação de acordo com a nota de satisfação.

## Contribuição

Sinta-se à vontade para abrir Issues para sugestões, melhorias ou correções. Pull requests são bem-vindas!
