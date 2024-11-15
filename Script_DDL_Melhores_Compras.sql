-- Gerado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   em:        2024-09-11 21:26:47 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



DROP TABLE mc_bairro CASCADE CONSTRAINTS;

DROP TABLE mc_categoria_prod CASCADE CONSTRAINTS;

DROP TABLE mc_cidade CASCADE CONSTRAINTS;

DROP TABLE mc_cli_fisica CASCADE CONSTRAINTS;

DROP TABLE mc_cli_juridica CASCADE CONSTRAINTS;

DROP TABLE mc_cliente CASCADE CONSTRAINTS;

DROP TABLE mc_depto CASCADE CONSTRAINTS;

DROP TABLE mc_end_cli CASCADE CONSTRAINTS;

DROP TABLE mc_end_func CASCADE CONSTRAINTS;

DROP TABLE mc_estado CASCADE CONSTRAINTS;

DROP TABLE mc_funcionario CASCADE CONSTRAINTS;

DROP TABLE mc_logradouro CASCADE CONSTRAINTS;

DROP TABLE mc_produto CASCADE CONSTRAINTS;

DROP TABLE mc_sgv_sac CASCADE CONSTRAINTS;

DROP TABLE mc_sgv_tipo_video CASCADE CONSTRAINTS;

DROP TABLE mc_sgv_video_produto CASCADE CONSTRAINTS;

DROP TABLE mc_sgv_visualizacao CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE mc_bairro (
    cd_bairro      NUMBER(8) NOT NULL,
    cd_cidade      NUMBER(8) NOT NULL,
    nm_bairro      VARCHAR2(45) NOT NULL,
    nm_zona_bairro VARCHAR2(20)
)
LOGGING;

COMMENT ON COLUMN mc_bairro.cd_bairro IS
    'Esta coluna ir� receber o codigo do bairro e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_bairro.nm_bairro IS
    'Esta coluna ira receber o nome do Bairro. Esse conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_bairro.nm_zona_bairro IS
    'Esta coluna ir� receber a localiza��o da zona onde se encontra o bairro. Alguns exemplos: Zona Norte, Zona Sul, Zona Leste, Zona Oeste, Centro.'
    ;

ALTER TABLE mc_bairro ADD CONSTRAINT pk_mc_bairro PRIMARY KEY ( cd_bairro );

CREATE TABLE mc_categoria_prod (
    cd_categoria NUMBER GENERATED ALWAYS AS IDENTITY,
    ds_categoria VARCHAR2(500) NOT NULL,
    tp_categoria CHAR(1) NOT NULL,
    dt_inicio    DATE NOT NULL,
    dt_termino   DATE,
    st_categoria CHAR(1) NOT NULL
)
LOGGING;

COMMENT ON COLUMN mc_categoria_prod.cd_categoria IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de categoria de produtos da Melhorees Compras. Cada categoria nova cadastrada  ser� acionada a Sequence  SQ_MC_CATEGORIA que se encarregar� de gerar o pr�ximo n�mero �nico da categoria..'
    ;

COMMENT ON COLUMN mc_categoria_prod.ds_categoria IS
    'Essa coluna ir� armazenar descri��o da categoria de produtos da Melhorees Compras. Cada categoria tem uma  descri��o �nica e serve para organizar os produtos em categorias simliares, melhorando a tomada de decis�o.'
    ;

COMMENT ON COLUMN mc_categoria_prod.tp_categoria IS
    'Nessa  coluna  ser�  armazenada o tipo de categoria que poder�  ser (V)�deo ou (P)rodudto. Seu conte�do deve ser obrigat�rio.';

COMMENT ON COLUMN mc_categoria_prod.dt_inicio IS
    'Essa coluna ir� receber  a data de in�cio da categoria. Seu formato � dd/mm/yyyy e seu conte�do deve ser sempre  obrigat�rio.';

COMMENT ON COLUMN mc_categoria_prod.dt_termino IS
    'Essa coluna ir� receber  a data de encerramento  da categoria. Seu formato � dd/mm/yyyy e seu conte�do deve ser sempre  opcional. Conte�do obrigat�rio significa que a categoria foi encerrada a partir da data t�rmino. J� o conte�do opcional indica que a categoria est� ativa e operante.'
    ;

COMMENT ON COLUMN mc_categoria_prod.st_categoria IS
    'Essa coluna ir� armazenar o stauts da categoria da Melhorees Compras. Os valores permitidos aqui s�o: A(tivo) e I(nativo).';

ALTER TABLE mc_categoria_prod
    ADD CONSTRAINT ck_mc_categoria_prod_status CHECK ( st_categoria IN ( 'A', 'I' ) );

ALTER TABLE mc_categoria_prod
    ADD CONSTRAINT ck_mc_categoria_prod_tipo CHECK ( tp_categoria IN ( 'V', 'P' ) );

ALTER TABLE mc_categoria_prod ADD CONSTRAINT pk_mc_categoria_prod PRIMARY KEY ( cd_categoria );

ALTER TABLE mc_categoria_prod ADD CONSTRAINT un_mc_categoria_prod_descricao UNIQUE ( ds_categoria );

CREATE TABLE mc_cidade (
    cd_cidade NUMBER(8) NOT NULL,
    sg_estado CHAR(2) NOT NULL,
    nm_cidade VARCHAR2(60) NOT NULL,
    cd_ibge   NUMBER(8),
    nr_ddd    NUMBER(3)
)
LOGGING;

COMMENT ON COLUMN mc_cidade.cd_cidade IS
    'Esta coluna ir� receber o codigo da cidade e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_cidade.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_cidade.nm_cidade IS
    'Esta coluna ira receber o nome da Cidade. Esse conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_cidade.cd_ibge IS
    'Esta coluna ir� receber o c�digo do IBGE que fornece informa��es para gera��o da NFe.';

COMMENT ON COLUMN mc_cidade.nr_ddd IS
    'Esta coluna ir� receber o n�mero do DDD da cidade para ser utilizado no contato telef�nico. Seu conteudo � opcional.';

ALTER TABLE mc_cidade ADD CONSTRAINT pk_mc_cidade PRIMARY KEY ( cd_cidade );

CREATE TABLE mc_cli_fisica (
    nr_cliente        NUMBER(10) NOT NULL,
    dt_nascimento     DATE NOT NULL,
    fl_sexo_biologico CHAR(1) NOT NULL,
    nr_cpf            VARCHAR2(14) NOT NULL,
    ds_genero         VARCHAR2(100) NOT NULL,
    tp_cliente        CHAR(1) NOT NULL
)
LOGGING;

COMMENT ON COLUMN mc_cli_fisica.dt_nascimento IS
    'Essa coluna ir� armazenar a data de nascimento do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio. '
    ;

COMMENT ON COLUMN mc_cli_fisica.fl_sexo_biologico IS
    'Essa coluna ir� armazenar o sexo biol�gico do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio.. '
    ;

COMMENT ON COLUMN mc_cli_fisica.nr_cpf IS
    'Essa coluna ir� armazenar o n�mero do CPF do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio. '
    ;

COMMENT ON COLUMN mc_cli_fisica.ds_genero IS
    'Genero do sexo do Cliente. Seu conte�do deve ser obrigat�rio.';

ALTER TABLE mc_cli_fisica ADD CONSTRAINT ck_mc_cli_fisica_tipo CHECK ( tp_cliente = 'F' );

ALTER TABLE mc_cli_fisica ADD CONSTRAINT pk_mc_cli_fisica PRIMARY KEY ( nr_cliente );

CREATE TABLE mc_cli_juridica (
    nr_cliente   NUMBER(10) NOT NULL,
    dt_fundacao  DATE NOT NULL,
    nr_cnpj      VARCHAR2(20) NOT NULL,
    nr_inscr_est VARCHAR2(15),
    tp_cliente   CHAR(1) NOT NULL
)
LOGGING;

COMMENT ON COLUMN mc_cli_juridica.dt_fundacao IS
    'Essa coluna ir� armazenar data  de funda��o do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio.'
    ;

COMMENT ON COLUMN mc_cli_juridica.nr_cnpj IS
    'Essa coluna ir� armazenar o  numero do CNPJ do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio.'
    ;

COMMENT ON COLUMN mc_cli_juridica.nr_inscr_est IS
    'Essa coluna ir� armazenar o  numero da Inscri��o Estadual  do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser opcional'
    ;

ALTER TABLE mc_cli_juridica ADD CONSTRAINT ck_mc_cli_juridica_tipo CHECK ( tp_cliente = 'J' );

ALTER TABLE mc_cli_juridica ADD CONSTRAINT pk_mc_cli_juridica PRIMARY KEY ( nr_cliente );

CREATE TABLE mc_cliente (
    nr_cliente      NUMBER(10) NOT NULL,
    tp_cliente      CHAR(1) NOT NULL,
    nm_cliente      VARCHAR2(160) NOT NULL,
    qt_estrelas     NUMBER(1) NOT NULL,
    vl_medio_compra NUMBER(10, 2) NOT NULL,
    st_cliente      CHAR(1) NOT NULL,
    ds_email        VARCHAR2(100),
    nr_telefone     VARCHAR2(20),
    nm_login        VARCHAR2(50) NOT NULL,
    ds_senha        VARCHAR2(50) NOT NULL
)
LOGGING;

ALTER TABLE mc_cliente
    ADD CONSTRAINT fk_arco_cli_fisica_juridica_lov CHECK ( tp_cliente IN ( 'F', 'J' ) );

COMMENT ON COLUMN mc_cliente.nr_cliente IS
    'Essa coluna ir� armazenar o c�digo �nico do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio, �nico e preenhcido a  parrtir da chamada de sequence  SQ_MC_CLIENTE, a qual ter� sempre o n�mero disponivel para uso.'
    ;

COMMENT ON COLUMN mc_cliente.tp_cliente IS
    'Cliente (F)�sico e Cliente (J)ur�dica';

COMMENT ON COLUMN mc_cliente.nm_cliente IS
    'Essa coluna ir� armazenar o nome do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio.';

COMMENT ON COLUMN mc_cliente.qt_estrelas IS
    'Essa coluna ir� armazenar a quantiade de estrelas do cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio e ser poss�vel de estar entre 1 e 5 estrelas.'
    ;

COMMENT ON COLUMN mc_cliente.vl_medio_compra IS
    'Essa coluna ir� armazenar o valor  m�dio de gastos f eito pelo cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio e deve ser calculado diariamente.'
    ;

COMMENT ON COLUMN mc_cliente.st_cliente IS
    'Essa coluna ir� armazenar o stauts do cliente da Melhorees Compras. Os valores permitidos aqui s�o: A(tivo) e I(nativo).';

COMMENT ON COLUMN mc_cliente.ds_email IS
    'Essa coluna ir� armazenar o email  do cliente da Melhorees Compras. No minimo � esperado um email contendo o caractere (@) em seu conte�do.'
    ;

COMMENT ON COLUMN mc_cliente.nr_telefone IS
    'Essa coluna ir� armazenar o n�mero do cliente da Melhorees Compras. A mascara de armazenamento deve ser: (<nr_ddd>) 99999-9999 e  deve ser utilizada pr� definida.'
    ;

COMMENT ON COLUMN mc_cliente.nm_login IS
    'Essa coluna ir� armazenar o login de cada cliente na plataforma ecommerce da Melhores Compras. Seu conte�do deve ser obrigat�rio e  �nico para cada cliente.'
    ;

COMMENT ON COLUMN mc_cliente.ds_senha IS
    'Essa coluna ir� armazenar a senha de cada cliente na plataforma ecommerce da Melhores Compras.Seu conte�do deve ser obrigat�rio.'
    ;

ALTER TABLE mc_cliente
    ADD CONSTRAINT ck_mc_cliente_estrelas CHECK ( qt_estrelas BETWEEN 1 AND 5 );

ALTER TABLE mc_cliente
    ADD CONSTRAINT ck_mc_cliente_status CHECK ( st_cliente IN ( 'A', 'I' ) );

ALTER TABLE mc_cliente
    ADD CONSTRAINT ck_mc_cliente_tipo CHECK ( tp_cliente IN ( 'J', 'F' ) );

ALTER TABLE mc_cliente ADD CONSTRAINT pk_mc_cliente PRIMARY KEY ( nr_cliente );

ALTER TABLE mc_cliente ADD CONSTRAINT un_mc_cliente_nome UNIQUE ( nm_cliente );

ALTER TABLE mc_cliente ADD CONSTRAINT un_mc_cliente_login UNIQUE ( nm_login );

CREATE TABLE mc_depto (
    cd_depto NUMBER(3) NOT NULL,
    nm_depto VARCHAR2(100) NOT NULL,
    st_depto CHAR(1) NOT NULL
)
LOGGING;

COMMENT ON COLUMN mc_depto.cd_depto IS
    'Esta coluna ir� receber o codigo do departamento  e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_depto.nm_depto IS
    'Esta coluna ir� receber o nome do  departamento  e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_depto.st_depto IS
    'Esta coluna ir� receber o status do  departamento  e seu conte�do � obrigat�rio. Os valores poss�veis s�o: (A)tivo e (I)nativo.'
    ;

ALTER TABLE mc_depto
    ADD CONSTRAINT ck_mc_depto_status CHECK ( st_depto IN ( 'A', 'I' ) );

ALTER TABLE mc_depto ADD CONSTRAINT pk_mc_depto PRIMARY KEY ( cd_depto );

CREATE TABLE mc_end_cli (
    nr_cliente         NUMBER(10) NOT NULL,
    cd_logradouro      NUMBER(10) NOT NULL,
    nr_end             NUMBER(8) NOT NULL,
    ds_complemento_end VARCHAR2(80),
    dt_inicio          DATE NOT NULL,
    dt_termino         DATE,
    st_end             CHAR(1) NOT NULL
)
LOGGING;

COMMENT ON COLUMN mc_end_cli.nr_end IS
    'N�mero do Endere�o do Cliente. O n�mero da Rua/Localidade onde o cliente est� associado.';

COMMENT ON COLUMN mc_end_cli.ds_complemento_end IS
    'Esta coluna ir� receber o complemento do endere�o do cliente e seu conte�do pode ser opcional.';

COMMENT ON COLUMN mc_end_cli.dt_inicio IS
    'Data de in�cio do endere�o associado ao cliente.';

COMMENT ON COLUMN mc_end_cli.dt_termino IS
    'Data de t�rmino do endere�o associado ao cliente.';

COMMENT ON COLUMN mc_end_cli.st_end IS
    'Status do endere�o. (A)itvo ou (I)nativo.';

ALTER TABLE mc_end_cli ADD CONSTRAINT pk_mc_end_cli PRIMARY KEY ( nr_cliente,
                                                                  cd_logradouro );

CREATE TABLE mc_end_func (
    cd_funcionario     NUMBER(10) NOT NULL,
    cd_logradouro      NUMBER(10) NOT NULL,
    nr_end             NUMBER(8) NOT NULL,
    ds_complemento_end VARCHAR2(80),
    dt_inicio          DATE NOT NULL,
    dt_termino         DATE,
    st_end             CHAR(1) NOT NULL
)
LOGGING;

COMMENT ON COLUMN mc_end_func.nr_end IS
    'N�mero do Endere�o do Cliente. O n�mero da Rua/Localidade onde o cliente est� associado.';

COMMENT ON COLUMN mc_end_func.dt_inicio IS
    'Data de in�cio do endere�o associado ao cliente.';

COMMENT ON COLUMN mc_end_func.dt_termino IS
    'Data de t�rmino do endere�o associado ao cliente.';

ALTER TABLE mc_end_func ADD CONSTRAINT pk_mc_end_func PRIMARY KEY ( cd_logradouro,
                                                                    cd_funcionario );

CREATE TABLE mc_estado (
    sg_estado CHAR(2) NOT NULL,
    nm_estado VARCHAR2(30) NOT NULL
)
LOGGING;

COMMENT ON COLUMN mc_estado.sg_estado IS
    'Esta coluna ira receber a siga do Estado. Esse conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_estado.nm_estado IS
    'Esta coluna ir� receber o nome do estado';

ALTER TABLE mc_estado ADD CONSTRAINT pk_mc_estado PRIMARY KEY ( sg_estado );

CREATE TABLE mc_funcionario (
    cd_funcionario    NUMBER(10) NOT NULL,
    cd_depto          NUMBER(3) NOT NULL,
    cd_gerente        NUMBER(10),
    nr_cpf            VARCHAR2(14) NOT NULL,
    nm_funcionario    VARCHAR2(160) NOT NULL,
    dt_nascimento     DATE NOT NULL,
    nr_telefone       VARCHAR2(20) NOT NULL,
    fl_sexo_biologico CHAR(1),
    ds_genero         VARCHAR2(100),
    ds_cargo          VARCHAR2(80) NOT NULL,
    vl_salario        NUMBER(10, 2),
    ds_email          VARCHAR2(80) NOT NULL,
    st_func           CHAR(1),
    dt_cadastramento  DATE,
    dt_desligamento   DATE
)
LOGGING;

COMMENT ON COLUMN mc_funcionario.cd_funcionario IS
    'Esta coluna ir� receber o codigo do funcion�rio e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_funcionario.nr_cpf IS
    'Esta coluna ir� receber o CPF do funcion�rio e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_funcionario.nm_funcionario IS
    'Esta coluna ir� receber o nome do funcion�rio e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_funcionario.dt_nascimento IS
    'Esta coluna ir� receber a data de nascimento  do funcion�rio e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_funcionario.nr_telefone IS
    'Essa coluna ir� armazenar o n�mero do funcionario da Melhorees Compras. A mascara de armazenamento deve ser: (<nr_ddd>) 99999-9999 e  deve ser utilizada pr� definida..'
    ;

COMMENT ON COLUMN mc_funcionario.fl_sexo_biologico IS
    'Esta coluna ir� receber o sexo biol�gico do funcion�rio e seu conte�do � obrigat�rio.Os valores permitidos aqui seriam: (F)eminino; (M)asculino ou (Hermafrodita)'
    ;

COMMENT ON COLUMN mc_funcionario.ds_genero IS
    'Esta coluna ir� receber o genero atribuido ao funcion�rio e seu conte�do � opcional.';

COMMENT ON COLUMN mc_funcionario.ds_cargo IS
    'Esta coluna ir� receber o cargo do funcion�rio e seu conte�do � opcional.';

COMMENT ON COLUMN mc_funcionario.vl_salario IS
    'Esta coluna ir� receber o valor do sal�rio do funcion�rio e seu conte�do � opcional.';

COMMENT ON COLUMN mc_funcionario.ds_email IS
    'Esta coluna ir� receber o email do funcion�rio e seu conte�do � opcional.';

COMMENT ON COLUMN mc_funcionario.st_func IS
    'Essa coluna ir� armazenar o stauts do funcion�rio da Melhorees Compras. Os valores permitidos aqui s�o: A(tivo) e I(nativo).';

COMMENT ON COLUMN mc_funcionario.dt_cadastramento IS
    'Data de cadastramento do Funcionario';

COMMENT ON COLUMN mc_funcionario.dt_desligamento IS
    'Data de desligamento  do Funcionario. Seu conte�do � opcional.';

ALTER TABLE mc_funcionario
    ADD CONSTRAINT ck_mc_func_sexo_biologico CHECK ( fl_sexo_biologico IN ( 'F', 'M', 'H' ) );

ALTER TABLE mc_funcionario
    ADD CONSTRAINT ck_mc_funcionario_status CHECK ( st_func IN ( 'A', 'I' ) );

ALTER TABLE mc_funcionario ADD CONSTRAINT pk_mc_funcionario PRIMARY KEY ( cd_funcionario );

ALTER TABLE mc_funcionario ADD CONSTRAINT un_mc_funcionario_cpf UNIQUE ( nr_cpf );

CREATE TABLE mc_logradouro (
    cd_logradouro NUMBER(10) NOT NULL,
    cd_bairro     NUMBER(8) NOT NULL,
    nm_logradouro VARCHAR2(160) NOT NULL,
    nr_cep        NUMBER(8) NOT NULL
)
LOGGING;

COMMENT ON COLUMN mc_logradouro.cd_logradouro IS
    'Esta coluna ir� receber o c�digo do logradouro e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_logradouro.nm_logradouro IS
    'Esta coluna ir� receber o nome do logradouro e seu conte�do � obrigat�rio.';

COMMENT ON COLUMN mc_logradouro.nr_cep IS
    'Esta coluna ir� receber o numero do CEP do Logradouro e seu conte�do � obrigat�rio.';

ALTER TABLE mc_logradouro ADD CONSTRAINT pk_mc_logradouro PRIMARY KEY ( cd_logradouro );

CREATE TABLE mc_produto (
    cd_produto        NUMBER(10) GENERATED ALWAYS AS IDENTITY,
    cd_categoria      NUMBER NOT NULL,
    ds_produto        VARCHAR2(80) NOT NULL,
    nr_cd_barras_prod VARCHAR2(50),
    vl_unitario       NUMBER(8, 2) NOT NULL,
    tp_embalagem      VARCHAR2(15),
    st_produto        CHAR(1) NOT NULL,
    vl_perc_lucro     NUMBER(8, 2),
    ds_completa_prod  VARCHAR2(4000) NOT NULL
)
LOGGING;

COMMENT ON COLUMN mc_produto.cd_produto IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de produtos da Melhorees Compras. A cada produto cadastrado ser� acionada a Sequence  SQ_MC_PRODUTO que se encarregar� de gerar o pr�ximo n�mero �nico do produto.'
    ;

COMMENT ON COLUMN mc_produto.ds_produto IS
    'Essa coluna ir� armazenar a descri��o principal do produto. Seu conte�do deve ser  obrigatorio.';

COMMENT ON COLUMN mc_produto.nr_cd_barras_prod IS
    'Essa coluna ir� armazenar o n�mero do codigo de barras  do produto. Seu conte�do deve ser opcional.';

COMMENT ON COLUMN mc_produto.vl_unitario IS
    'Essa coluna ir� armazenar o valor unit�rio do produto. Seu conte�do deve ser > 0 ';

COMMENT ON COLUMN mc_produto.tp_embalagem IS
    'Essa coluna ir� armazenar o tipo de embalagem do produto. Seu conte�do pode ser opcional.';

COMMENT ON COLUMN mc_produto.st_produto IS
    'Essa coluna ir� armazenar o stauts do produto da Melhorees Compras. Os valores permitidos aqui s�o: A(tivo) e I(nativo).';

COMMENT ON COLUMN mc_produto.vl_perc_lucro IS
    'Essa coluna ir� armazenar o percentual  do lucro m�dio para cada produto. Seu conte�do deve ser opcional.';

COMMENT ON COLUMN mc_produto.ds_completa_prod IS
    'Essa coluna ir� armazenar a descri��o completa do produto. Seu conte�do deve ser  obrigatorio.';

ALTER TABLE mc_produto
    ADD CONSTRAINT ck_mc_produto_status CHECK ( st_produto IN ( 'A', 'I' ) );

ALTER TABLE mc_produto ADD CONSTRAINT ck_mc_produto_valor CHECK ( vl_unitario > 0 );

ALTER TABLE mc_produto ADD CONSTRAINT pk_mc_produto PRIMARY KEY ( cd_produto );

ALTER TABLE mc_produto ADD CONSTRAINT un_mc_produto_descricao UNIQUE ( ds_produto );

CREATE TABLE mc_sgv_sac (
    nr_sac                   NUMBER(10) GENERATED ALWAYS AS IDENTITY,
    nr_cliente               NUMBER(10) NOT NULL,
    cd_produto               NUMBER(10) NOT NULL,
    cd_funcionario           NUMBER(10) NOT NULL,
    ds_detalhada_sac         CLOB NOT NULL,
    dt_abertura_sac          DATE NOT NULL,
    hr_abertura_sac          NUMBER(2) NOT NULL,
    dt_atendimento_sac       DATE,
    hr_atendimento_sac       NUMBER(2),
    nr_tempo_total_sac       NUMBER(10),
    ds_detalhada_retorno_sac CLOB,
    tp_sac                   CHAR(1) NOT NULL,
    st_sac                   CHAR(1) NOT NULL,
    nr_indice_satisfacao     NUMBER(2),
    tx_cliente               VARCHAR2(4000) NOT NULL
)
LOGGING;

COMMENT ON COLUMN mc_sgv_sac.nr_sac IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de SAC de v�deo  da Melhorees Compras. A cada SAC cadastrado pelo cliente ser� acionada a Sequence  SQ_MC_SGV_SAC que se encarregar� de gerar o pr�ximo n�mero �nico do chamado SAC feito pelo Cliente.'
    ;

COMMENT ON COLUMN mc_sgv_sac.ds_detalhada_sac IS
    'Essa coluna  ir�  receber a descri��o completa do SAC aberto pelo cliente. Seu conteudo deve ser obrigat�rio.';

COMMENT ON COLUMN mc_sgv_sac.dt_abertura_sac IS
    'Essa coluna  ir�  receber a data e hor�rio do SAC aberto pelo cliente. Seu conteudo deve ser obrigat�rio.';

COMMENT ON COLUMN mc_sgv_sac.hr_abertura_sac IS
    'Essa coluna  ir�  receber a hora do SAC aberto pelo cliente. Seu conteudo deve ser obrigat�rio.';

COMMENT ON COLUMN mc_sgv_sac.dt_atendimento_sac IS
    'Essa coluna  ir�  receber a data e hor�rio do atendmiento SAC feita pelo funcion�rio da Melhores Compras. Seu conteudo deve ser opcional..'
    ;

COMMENT ON COLUMN mc_sgv_sac.hr_atendimento_sac IS
    'Essa coluna  ir�  receber a hora do SAC do atendimento  feito  pelo funcionario da Melhores Compras. Seu conteudo deve ser opcional.'
    ;

COMMENT ON COLUMN mc_sgv_sac.nr_tempo_total_sac IS
    'Essa coluna  ir�  receber o tempo total em horas  (HH24) computado desde a abertura at� a conclus�o dele. A unidade de medida � horas, ou seja, em quantas horas o chamado foi conclu�do desde a sua abertura.'
    ;

COMMENT ON COLUMN mc_sgv_sac.ds_detalhada_retorno_sac IS
    'Essa coluna  ir�  receber a descri��o detalhada do retorno feito pelo funcion�rio a partir da solicita��o do cliente. Seu conte�do deve ser opcional e preenchido pelo funcion�rio.'
    ;

COMMENT ON COLUMN mc_sgv_sac.tp_sac IS
    'Essa coluna  ir�  receber o TIPO  do chamado SAC aberto pelo cliente.  Seu conte�do deve ser  obrigat�rio e os poss�veis valores s�o: (S)ugest�o; (D)�vida ou  (E)logio.'
    ;

COMMENT ON COLUMN mc_sgv_sac.st_sac IS
    'Essa coluna  ir�  receber o STATUS  do chamado SAC aberto pelo cliente.  Seu conte�do deve ser  obrigat�rio e os poss�veis valores s�o:(A)berto;  (E)m Atendimento; (C)ancelado; (F)echado ou (X)Fechado com Insatisfa��o do cliente.'
    ;

COMMENT ON COLUMN mc_sgv_sac.nr_indice_satisfacao IS
    'Essa coluna  ir�  receber o �ndice de satisfa��o, , computado como um valor simples de 1 a 10, onde 1 refere-se ao cliente menos satisfeito e 10 o cliente mais satisfeito. Esse �ndice de satisfa��o � opcional e informado pelo cliente ao final do atendimento.'
    ;

COMMENT ON COLUMN mc_sgv_sac.tx_cliente IS
    'texto escrito pelo cliente';

ALTER TABLE mc_sgv_sac
    ADD CONSTRAINT ck_mc_sgv_sac_satisfacao CHECK ( nr_indice_satisfacao BETWEEN 1 AND 10 );

ALTER TABLE mc_sgv_sac
    ADD CONSTRAINT ck_mc_sgv_sac_status CHECK ( st_sac IN ( 'A', 'E', 'C', 'F', 'X' ) );

ALTER TABLE mc_sgv_sac
    ADD CONSTRAINT ck_mc_sgv_sac_tipo CHECK ( tp_sac IN ( 'S', 'D', 'E' ) );

ALTER TABLE mc_sgv_sac ADD CONSTRAINT pk_mc_sgv_sac PRIMARY KEY ( nr_sac );

CREATE TABLE mc_sgv_tipo_video (
    cd_tipo NUMBER(3) NOT NULL,
    ds_tipo VARCHAR2(150) NOT NULL
)
LOGGING;

COMMENT ON COLUMN mc_sgv_tipo_video.cd_tipo IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de video da Melhorees Compras.';

COMMENT ON COLUMN mc_sgv_tipo_video.ds_tipo IS
    'Essa coluna ir� armazenar descri��o do tipo de video da Melhorees Compras. ';

ALTER TABLE mc_sgv_tipo_video ADD CONSTRAINT pk_mc_sgv_tipo_video PRIMARY KEY ( cd_tipo );

CREATE TABLE mc_sgv_video_produto (
    cd_video    NUMBER(10) NOT NULL,
    cd_produto  NUMBER(10) NOT NULL,
    cd_tipo     NUMBER(3) NOT NULL,
    st_video    CHAR(1) NOT NULL,
    dt_cadastro DATE NOT NULL
)
LOGGING;

COMMENT ON COLUMN mc_sgv_video_produto.cd_video IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de video da Melhorees Compras.';

COMMENT ON COLUMN mc_sgv_video_produto.st_video IS
    'Essa coluna ir� armazenar o stauts do video da Melhorees Compras. Os valores permitidos aqui s�o: A(tivo) e I(nativo).';

COMMENT ON COLUMN mc_sgv_video_produto.dt_cadastro IS
    'Essa coluna  ir�  receber a data de cadastro do video da Melhores Compras. Seu conteudo deve ser obrigatorio.';

ALTER TABLE mc_sgv_video_produto
    ADD CONSTRAINT ck_mc_sgv_video_produto_status CHECK ( st_video IN ( 'A', 'I' ) );

ALTER TABLE mc_sgv_video_produto ADD CONSTRAINT pk_mc_sgv_video_produto PRIMARY KEY ( cd_video );

CREATE TABLE mc_sgv_visualizacao (
    cd_visualizacao NUMBER(10) NOT NULL,
    cd_video        NUMBER(10) NOT NULL,
    nr_cliente      NUMBER(10),
    dt_visualizacao DATE NOT NULL
)
LOGGING;

COMMENT ON COLUMN mc_sgv_visualizacao.cd_visualizacao IS
    'Essa coluna ir� armazenar a chave prim�ria da tabela de visualiza��o dos videos da Melhorees Compras.';

COMMENT ON COLUMN mc_sgv_visualizacao.dt_visualizacao IS
    'Essa coluna  ir�  receber a data e hor�rio de cada visualiza��o do video. Seu conteudo deve ser obrigat�rio.';

ALTER TABLE mc_sgv_visualizacao ADD CONSTRAINT pk_mc_sgv_visualizacao PRIMARY KEY ( cd_visualizacao );

ALTER TABLE mc_bairro
    ADD CONSTRAINT fk_mc_bairro_cidade FOREIGN KEY ( cd_cidade )
        REFERENCES mc_cidade ( cd_cidade )
    NOT DEFERRABLE;

ALTER TABLE mc_cidade
    ADD CONSTRAINT fk_mc_cidade_estado FOREIGN KEY ( sg_estado )
        REFERENCES mc_estado ( sg_estado )
    NOT DEFERRABLE;

ALTER TABLE mc_end_cli
    ADD CONSTRAINT fk_mc_cliente_end FOREIGN KEY ( nr_cliente )
        REFERENCES mc_cliente ( nr_cliente )
    NOT DEFERRABLE;

ALTER TABLE mc_cli_fisica
    ADD CONSTRAINT fk_mc_cliente_fisica FOREIGN KEY ( nr_cliente )
        REFERENCES mc_cliente ( nr_cliente )
    NOT DEFERRABLE;

ALTER TABLE mc_cli_juridica
    ADD CONSTRAINT fk_mc_cliente_juridica FOREIGN KEY ( nr_cliente )
        REFERENCES mc_cliente ( nr_cliente )
    NOT DEFERRABLE;

ALTER TABLE mc_funcionario
    ADD CONSTRAINT fk_mc_depto_func FOREIGN KEY ( cd_depto )
        REFERENCES mc_depto ( cd_depto )
    NOT DEFERRABLE;

ALTER TABLE mc_end_func
    ADD CONSTRAINT fk_mc_end_func FOREIGN KEY ( cd_funcionario )
        REFERENCES mc_funcionario ( cd_funcionario )
    NOT DEFERRABLE;

ALTER TABLE mc_end_func
    ADD CONSTRAINT fk_mc_end_func_logradouro FOREIGN KEY ( cd_logradouro )
        REFERENCES mc_logradouro ( cd_logradouro )
    NOT DEFERRABLE;

ALTER TABLE mc_funcionario
    ADD CONSTRAINT fk_mc_func_superior FOREIGN KEY ( cd_gerente )
        REFERENCES mc_funcionario ( cd_funcionario )
    NOT DEFERRABLE;

ALTER TABLE mc_logradouro
    ADD CONSTRAINT fk_mc_logradouro_bairro FOREIGN KEY ( cd_bairro )
        REFERENCES mc_bairro ( cd_bairro )
    NOT DEFERRABLE;

ALTER TABLE mc_end_cli
    ADD CONSTRAINT fk_mc_logradouro_end FOREIGN KEY ( cd_logradouro )
        REFERENCES mc_logradouro ( cd_logradouro )
    NOT DEFERRABLE;

ALTER TABLE mc_sgv_video_produto
    ADD CONSTRAINT fk_mc_prod_video_prod FOREIGN KEY ( cd_produto )
        REFERENCES mc_produto ( cd_produto )
    NOT DEFERRABLE;

ALTER TABLE mc_sgv_video_produto
    ADD CONSTRAINT fk_mc_prod_video_tipo_video FOREIGN KEY ( cd_tipo )
        REFERENCES mc_sgv_tipo_video ( cd_tipo )
    NOT DEFERRABLE;

ALTER TABLE mc_sgv_sac
    ADD CONSTRAINT fk_mc_sgv_sac_cliente FOREIGN KEY ( nr_cliente )
        REFERENCES mc_cliente ( nr_cliente )
    NOT DEFERRABLE;

ALTER TABLE mc_sgv_sac
    ADD CONSTRAINT fk_mc_sgv_sac_func FOREIGN KEY ( cd_funcionario )
        REFERENCES mc_funcionario ( cd_funcionario )
    NOT DEFERRABLE;

ALTER TABLE mc_sgv_sac
    ADD CONSTRAINT fk_mc_sgv_sac_prod FOREIGN KEY ( cd_produto )
        REFERENCES mc_produto ( cd_produto )
    NOT DEFERRABLE;

ALTER TABLE mc_sgv_visualizacao
    ADD CONSTRAINT fk_mc_sgv_visual_cliente FOREIGN KEY ( nr_cliente )
        REFERENCES mc_cliente ( nr_cliente )
    NOT DEFERRABLE;

ALTER TABLE mc_sgv_visualizacao
    ADD CONSTRAINT fk_mc_sgv_visual_video_prod FOREIGN KEY ( cd_video )
        REFERENCES mc_sgv_video_produto ( cd_video )
    NOT DEFERRABLE;

ALTER TABLE mc_produto
    ADD CONSTRAINT fk_mc_sub_categoria_prod FOREIGN KEY ( cd_categoria )
        REFERENCES mc_categoria_prod ( cd_categoria )
    NOT DEFERRABLE;

CREATE OR REPLACE TRIGGER arc_fk_arco_cli__mc_cli_fisica BEFORE
    INSERT OR UPDATE OF nr_cliente ON mc_cli_fisica
    FOR EACH ROW
DECLARE
    d CHAR(1);
BEGIN
    SELECT
        a.tp_cliente
    INTO d
    FROM
        mc_cliente a
    WHERE
        a.nr_cliente = :new.nr_cliente;

    IF ( d IS NULL OR d <> 'F' ) THEN
        raise_application_error(-20223, 'FK FK_MC_CLIENTE_FISICA in Table MC_CLI_FISICA violates Arc constraint on Table MC_CLIENTE - discriminator column TP_CLIENTE doesn''t have value ''F'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fk_arco_cl_mc_cli_juridica BEFORE
    INSERT OR UPDATE OF nr_cliente ON mc_cli_juridica
    FOR EACH ROW
DECLARE
    d CHAR(1);
BEGIN
    SELECT
        a.tp_cliente
    INTO d
    FROM
        mc_cliente a
    WHERE
        a.nr_cliente = :new.nr_cliente;

    IF ( d IS NULL OR d <> 'J' ) THEN
        raise_application_error(-20223, 'FK FK_MC_CLIENTE_JURIDICA in Table MC_CLI_JURIDICA violates Arc constraint on Table MC_CLIENTE - discriminator column TP_CLIENTE doesn''t have value ''J'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/



-- Relat�rio do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            17
-- CREATE INDEX                             0
-- ALTER TABLE                             58
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           2
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
