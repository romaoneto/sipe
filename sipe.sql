CREATE TABLE IF NOT EXISTS `rl_documentos_pastas` (
  `es_pasta` int(10) unsigned NOT NULL,
  `es_documento` int(10) unsigned NOT NULL,
  `es_instituicao` int(10) unsigned NOT NULL,
  `dt_cadastro` datetime NOT NULL,
  `es_usuario` int(10) unsigned NOT NULL,
  PRIMARY KEY (`es_pasta`,`es_documento`),
  KEY `es_pasta` (`es_pasta`),
  KEY `es_documento` (`es_documento`),
  KEY `es_usuario` (`es_usuario`),
  KEY `es_instituicao` (`es_instituicao`),
  CONSTRAINT `rl_documentos_pastas_ibfk_2` FOREIGN KEY (`es_pasta`) REFERENCES `tb_pastas` (`pr_pasta`),
  CONSTRAINT `rl_documentos_pastas_ibfk_3` FOREIGN KEY (`es_usuario`) REFERENCES `tb_usuarios` (`pr_usuario`),
  CONSTRAINT `rl_documentos_pastas_ibfk_4` FOREIGN KEY (`es_documento`) REFERENCES `tb_documentos` (`pr_documento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `rl_instituicoes_pastas` (
  `es_instituicao` int(10) unsigned NOT NULL,
  `es_pasta` int(10) unsigned NOT NULL,
  `dt_cadastro` date DEFAULT NULL,
  `es_cadastrador` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`es_instituicao`,`es_pasta`),
  KEY `es_cadastrador` (`es_cadastrador`),
  KEY `es_pasta` (`es_pasta`),
  CONSTRAINT `rl_instituicoes_pastas_ibfk_1` FOREIGN KEY (`es_instituicao`) REFERENCES `tb_instituicoes2` (`pr_instituicao`),
  CONSTRAINT `rl_instituicoes_pastas_ibfk_2` FOREIGN KEY (`es_pasta`) REFERENCES `tb_pastas` (`pr_pasta`),
  CONSTRAINT `rl_instituicoes_pastas_ibfk_3` FOREIGN KEY (`es_cadastrador`) REFERENCES `tb_usuarios` (`pr_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `tb_alteracoes` (
  `pr_alteracao` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `en_tipo` enum('Documento','Pasta') COLLATE utf8_bin NOT NULL,
  `tx_antes` text COLLATE utf8_bin,
  `tx_depois` text COLLATE utf8_bin,
  `tx_justificativa` text COLLATE utf8_bin,
  `dt_cadastro` datetime NOT NULL,
  `es_usuario` int(10) unsigned NOT NULL,
  PRIMARY KEY (`pr_alteracao`),
  KEY `es_usuario` (`es_usuario`) USING BTREE,
  CONSTRAINT `tb_alteracoes_ibfk_1` FOREIGN KEY (`es_usuario`) REFERENCES `tb_usuarios` (`pr_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=687 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `tb_documentos` (
  `pr_documento` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `es_processo` int(10) unsigned NOT NULL,
  `in_documento` int(7) unsigned zerofill NOT NULL,
  `in_unidade_sei` bigint(20) unsigned NOT NULL,
  `vc_documento` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `vc_link` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `vc_mime` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `bl_ativo` enum('0','1') COLLATE utf8_bin NOT NULL DEFAULT '1',
  `dt_desativacao` date DEFAULT NULL,
  `es_desativador` int(10) unsigned DEFAULT NULL,
  `dt_sei` datetime NOT NULL,
  PRIMARY KEY (`pr_documento`),
  UNIQUE KEY `in_documento` (`in_documento`),
  KEY `es_desativador` (`es_desativador`),
  KEY `es_processo` (`es_processo`) USING BTREE,
  CONSTRAINT `tb_documentos_ibfk_1` FOREIGN KEY (`es_processo`) REFERENCES `tb_processos` (`pr_processo`),
  CONSTRAINT `tb_documentos_ibfk_2` FOREIGN KEY (`es_desativador`) REFERENCES `tb_usuarios` (`pr_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=524183 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `tb_instituicoes2` (
  `pr_instituicao` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `DDNRPESSOAFISJUR` int(10) unsigned DEFAULT NULL,
  `vc_instituicao` varchar(255) COLLATE utf8_bin NOT NULL,
  `in_tipounidade` int(1) unsigned NOT NULL DEFAULT '0',
  `vc_sigla` varchar(50) COLLATE utf8_bin NOT NULL,
  `en_sexonome` enum('m','f') COLLATE utf8_bin DEFAULT NULL,
  `bl_extinto` enum('0','1') COLLATE utf8_bin NOT NULL DEFAULT '0',
  PRIMARY KEY (`pr_instituicao`),
  UNIQUE KEY `DDNRPESSOAFISJUR` (`DDNRPESSOAFISJUR`)
) ENGINE=InnoDB AUTO_INCREMENT=1260371 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `tb_pastas` (
  `pr_pasta` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `es_servidor` int(10) unsigned DEFAULT NULL,
  `in_masp` int(10) unsigned NOT NULL,
  `in_admissao` tinyint(3) unsigned NOT NULL,
  `vc_nome` varchar(100) COLLATE utf8_bin NOT NULL,
  `ch_cpf` char(11) COLLATE utf8_bin NOT NULL,
  `es_instituicao_lotacao` int(10) unsigned NOT NULL,
  `es_instituicao_exercicio` int(10) unsigned NOT NULL,
  `dt_cadastro` date DEFAULT NULL,
  `es_cadastrador` int(10) unsigned DEFAULT NULL,
  `dt_alteracao` date DEFAULT NULL,
  `es_alterador` int(10) unsigned DEFAULT NULL,
  `bl_ativo` enum('0','1') COLLATE utf8_bin NOT NULL DEFAULT '1',
  `dt_desativacao` date DEFAULT NULL,
  `es_desativador` int(10) unsigned DEFAULT NULL,
  `en_tipo` enum('servidor','estagiario','externo','serventuario','empregado_publico') COLLATE utf8_bin DEFAULT 'servidor',
  PRIMARY KEY (`pr_pasta`),
  UNIQUE KEY `es_servidor` (`es_servidor`),
  UNIQUE KEY `in_masp` (`in_masp`,`in_admissao`,`ch_cpf`,`en_tipo`) USING BTREE,
  KEY `es_instituicao_lotacao` (`es_instituicao_lotacao`),
  KEY `es_instituicao_exercicio` (`es_instituicao_exercicio`),
  CONSTRAINT `tb_pastas_ibfk_1` FOREIGN KEY (`es_instituicao_lotacao`) REFERENCES `tb_instituicoes2` (`pr_instituicao`),
  CONSTRAINT `tb_pastas_ibfk_2` FOREIGN KEY (`es_instituicao_exercicio`) REFERENCES `tb_instituicoes2` (`pr_instituicao`)
) ENGINE=InnoDB AUTO_INCREMENT=331835 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `tb_pastas_publicas` (
  `pr_pasta_publica` varchar(128) COLLATE utf8_bin NOT NULL,
  `es_pasta` int(10) unsigned NOT NULL,
  `es_usuario` int(10) unsigned NOT NULL,
  `dt_cadastro` datetime NOT NULL,
  PRIMARY KEY (`pr_pasta_publica`),
  KEY `es_pasta` (`es_pasta`) USING BTREE,
  KEY `es_usuario` (`es_usuario`) USING BTREE,
  CONSTRAINT `tb_pastas_publicas_ibfk_1` FOREIGN KEY (`es_pasta`) REFERENCES `tb_pastas` (`pr_pasta`),
  CONSTRAINT `tb_pastas_publicas_ibfk_2` FOREIGN KEY (`es_usuario`) REFERENCES `tb_usuarios` (`pr_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `tb_perfis` (
  `pr_perfil` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vc_perfil` varchar(20) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`pr_perfil`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `tb_processos` (
  `pr_processo` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ch_sei` varchar(255) COLLATE utf8_bin NOT NULL,
  `es_tipo_processo` int(10) unsigned NOT NULL,
  `in_codigo_sei` int(10) unsigned DEFAULT NULL,
  `vc_especificacao` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `vc_link_processo` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`pr_processo`),
  UNIQUE KEY `ch_sei` (`ch_sei`),
  KEY `es_tipo_processo` (`es_tipo_processo`),
  CONSTRAINT `tb_processos_ibfk_1` FOREIGN KEY (`es_tipo_processo`) REFERENCES `tb_tipos_processo` (`pr_tipo_processo`)
) ENGINE=InnoDB AUTO_INCREMENT=14763337 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `tb_remocoes` (
  `pr_remocao` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tx_justificativa` text COLLATE utf8_bin NOT NULL,
  `dt_remocao` datetime NOT NULL,
  `es_documento` int(10) unsigned NOT NULL,
  `es_pasta` int(10) unsigned NOT NULL,
  `es_usuario` int(10) unsigned NOT NULL,
  PRIMARY KEY (`pr_remocao`),
  KEY `es_documento` (`es_documento`) USING BTREE,
  KEY `es_pasta` (`es_pasta`) USING BTREE,
  KEY `es_usuario` (`es_usuario`) USING BTREE,
  CONSTRAINT `tb_remocoes_ibfk_1` FOREIGN KEY (`es_documento`) REFERENCES `tb_documentos` (`pr_documento`),
  CONSTRAINT `tb_remocoes_ibfk_2` FOREIGN KEY (`es_pasta`) REFERENCES `tb_pastas` (`pr_pasta`),
  CONSTRAINT `tb_remocoes_ibfk_3` FOREIGN KEY (`es_usuario`) REFERENCES `tb_usuarios` (`pr_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2292 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `tb_tipos_processo` (
  `pr_tipo_processo` int(10) unsigned NOT NULL,
  `vc_tipo_processo` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`pr_tipo_processo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE IF NOT EXISTS `tb_usuarios` (
  `pr_usuario` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `es_instituicao` int(10) unsigned DEFAULT NULL,
  `es_perfil` int(10) unsigned NOT NULL,
  `vc_nome` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `vc_email` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `vc_telefone` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `vc_login` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `vc_senha` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `vc_senha_temporaria` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ch_cpf` char(11) COLLATE utf8_bin NOT NULL,
  `in_unidade_sei` int(10) unsigned DEFAULT NULL,
  `dt_cadastro` date DEFAULT NULL,
  `dt_alteracao` date DEFAULT NULL,
  `dt_ultimoacesso` datetime DEFAULT NULL,
  `bl_trocasenha` enum('0','1') COLLATE utf8_bin DEFAULT '1',
  `in_erros` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `bl_removido` enum('0','1') COLLATE utf8_bin DEFAULT '0',
  PRIMARY KEY (`pr_usuario`),
  UNIQUE KEY `ch_cpf` (`ch_cpf`),
  UNIQUE KEY `vc_login` (`vc_login`),
  KEY `es_perfil` (`es_perfil`),
  KEY `es_instituicao` (`es_instituicao`),
  CONSTRAINT `tb_usuarios_ibfk_1` FOREIGN KEY (`es_instituicao`) REFERENCES `tb_instituicoes2` (`pr_instituicao`),
  CONSTRAINT `tb_usuarios_ibfk_2` FOREIGN KEY (`es_perfil`) REFERENCES `tb_perfis` (`pr_perfil`)
) ENGINE=InnoDB AUTO_INCREMENT=633 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `tb_instituicoes2` VALUES(1, NULL, 'INSTITUICAO C/ CODIGO DE UNIDADE NAO INFORMADO', 0, 'INVALIDO', 'm', '1');
INSERT INTO `tb_instituicoes2` VALUES(2, 2, 'Vice Governadoria do Estado', 2, 'VICEGOVERNADORIA', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(9, NULL, 'Caixa de Amortiza????o da D??vida', 8, 'CADIV', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(1071, 1857449, 'Gabinete Militar do Governador do Estado', 4, 'GMG', 'm', '0');
INSERT INTO `tb_instituicoes2` VALUES(1081, 1858199, 'Advocacia Geral do Estado', 4, 'AGE', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1101, 2939378, 'Ouvidoria Geral do Estado de Minas Gerais', 4, 'OGE', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1111, 1857428, 'Escrit??rio de Representa????o do Governo de Minas Gerais em Bras??lia', 4, 'ERGMG-BSB', 'm', '1');
INSERT INTO `tb_instituicoes2` VALUES(1121, 1857416, 'Secretaria do Governo', 3, 'SEGOV', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(1141, 1791028, 'Escrit??rio de Representa????o do Governo de Minas Gerais no RJ', 4, 'ERGMG-RJ', 'm', '1');
INSERT INTO `tb_instituicoes2` VALUES(1161, 1808437, 'Escrit??rio de Representa????o do Governo de Minas Gerais em SP', 4, 'ERGMG-SP', 'm', '1');
INSERT INTO `tb_instituicoes2` VALUES(1171, 1858268, 'Secretaria de Estado de Recursos Humanos e Administra????o', 3, 'SERHA', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(1191, 1858211, 'Secretaria de Estado de Fazenda', 3, 'SEF', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1201, 1858214, 'Secretaria de Estado de Planejamento e Coordena????o', 3, 'SEPLAN', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(1221, 1858203, 'Secretaria de Estado de Desenvolvimento Econ??mico', 3, 'SEDE', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1231, 1858202, 'Secretaria de Estado de Agricultura, Pecu??ria e Abastecimento', 3, 'SEAPA', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1251, 1857466, 'Pol??cia Militar do Estado de Minas Gerais', 4, 'PMMG', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1261, 1858210, 'Secretaria de Estado de Educa????o', 3, 'SEE', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1271, 1858208, 'Secretaria de Estado de Cultura e Turismo', 3, 'SECULT', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1281, 1858209, 'Secretaria de Esportes', 1, 'SEESP', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(1301, 1858216, 'Secretaria de Estado de Infraestrutura e Mobilidade', 3, 'SEINFRA', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1311, 1858205, 'Secretaria de Ind??stria', 3, 'SEI', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(1321, 1858213, 'Secretaria de Estado de Sa??de', 3, 'SES', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1341, 1857419, 'Coordenadoria de Apoio e Assist??ncia ?? Pessoa Deficiente', 4, 'CAADE', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(1371, 1857447, 'Secretaria de Estado de Meio Ambiente e Desenvolvimento Sustent??vel', 3, 'SEMAD', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1381, 1858267, 'Secretaria de Estado do Trabalho, da Assist??ncia Social, da Crian??a e do Adolescente', 3, 'SETASCAD', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(1401, 2671339, 'Corpo de Bombeiros Militar de Minas Gerais', 4, 'CBMMG', 'm', '0');
INSERT INTO `tb_instituicoes2` VALUES(1411, 2716739, 'Secretaria de Estado de Turismo', 3, 'SETUR', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1421, 1791031, 'SECRETARIA COMUNICACAO SOCIAL ', 0, 'SECS', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(1441, 2873312, 'Defensoria P??blica do Estado de Minas Gerais', 4, 'DPMG', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1451, 1858212, 'Secretaria de Estado de Justi??a e Seguran??a P??blica', 3, 'SEJUSP', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1461, 2873313, 'Secretaria de Estado de Desenvolvimento Econ??mico', 3, 'SEDE', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(1471, 1858204, 'Secretaria de Estado de Cidades e de Integra????o Regional', 3, 'SECIR', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1481, 2873309, 'Secretaria de Estado de Desenvolvimento Social', 3, 'SEDESE', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1491, 2873308, 'Secretaria de Estado de Governo', 3, 'SEGOV', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1501, 2873307, 'Secretaria de Estado de Planejamento e Gest??o', 3, 'SEPLAG', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1511, 1858215, 'Pol??cia Civil do Estado de Minas Gerais', 4, 'PCMG', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1521, 2273949, 'Controladoria Geral do Estado', 4, 'CGE', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1531, 3017980, 'Secretaria de Estado de Esportes e da Juventude', 3, 'SEEJ', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(1541, 3017981, 'Escola de Sa??de P??blica de Minas Gerais', 4, 'ESP', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1571, 3189804, 'Secretaria de Estado de Casa Civil e de Rela????es Institucionais', 3, 'SECCRI', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1581, 3189872, 'Secretaria de Estado de Trabalho e Emprego', 3, 'SETE', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(1591, 3189873, 'Secretaria de Estado de Desenvolvimento e Integra????o do Norte e Nordeste de Minas Gerais', 3, 'SEDINOR', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1601, 3190139, 'Escrit??rio de Prioridades Estrat??gicas', 3, 'EPE', 'm', '1');
INSERT INTO `tb_instituicoes2` VALUES(1631, 3200569, 'Secretaria Geral', 1, 'SG', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1641, 3347491, 'Secretaria de Estado de Desenvolvimento Agr??rio', 3, 'SEDA', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1651, 3346710, 'Secretaria de Estado de Direitos Humanos, Participa????o Social e Cidadania', 3, 'SEDPAC', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1671, 3347506, 'Secretaria de Estado de Esportes ', 3, 'SEESP', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1691, 3408097, 'Secretaria de Estado de Seguran??a P??blica', 3, 'SESP', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1692, NULL, 'INSTITUICAO C/ CODIGO DE UNIDADE NAO INFORMADO', 0, 'INVALIDO', 'm', '1');
INSERT INTO `tb_instituicoes2` VALUES(1693, NULL, 'INSTITUICAO C/ CODIGO DE UNIDADE NAO INFORMADO', 0, 'INVALIDO', 'm', '1');
INSERT INTO `tb_instituicoes2` VALUES(1701, 3414458, 'Secretaria de Estado Extraordin??ria de Desenvolvimento Integrado', 3, 'SEEDIF', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(1941, 1853802, 'ENCARGOS GERAIS PLANEJAMENTO E GESTAO', 0, 'ENCARGOS', 'm', '1');
INSERT INTO `tb_instituicoes2` VALUES(2011, 1857455, 'Instituto de Previd??ncia dos Servidores do Estado de Minas Gerais', 6, 'IPSEMG', 'm', '0');
INSERT INTO `tb_instituicoes2` VALUES(2041, 1857459, 'Loteria do Estado de Minas Gerais', 6, 'LEMG', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(2061, 1857440, 'Funda????o Jo??o Pinheiro', 5, 'FJP', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(2071, 1857430, 'Funda????o de Amparo a Pesquisa do Estado de Minas Gerais', 5, 'FAPEMIG', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(2081, 1857417, 'Funda????o Centro Tecnol??gico de Minas Gerais', 5, 'CETEC', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(2091, 2273955, 'Funda????o Estadual do Meio Ambiente', 5, 'FEAM', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(2101, 1767133, 'Instituto Estadual de Florestas', 6, 'IEF', 'm', '0');
INSERT INTO `tb_instituicoes2` VALUES(2111, 1858201, 'Funda????o Rural Mineira', 5, 'RURALMINAS', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(2121, 1857454, 'Instituto de Previd??ncia dos Servidores Militares do Estado de Minas Gerais', 6, 'IPSM', 'm', '0');
INSERT INTO `tb_instituicoes2` VALUES(2141, 1857422, 'Departamento de Obras P??blicas do Estado de Minas Gerais', 6, 'DEOP', 'm', '1');
INSERT INTO `tb_instituicoes2` VALUES(2151, 1857438, 'Funda????o Helena Antipoff', 5, 'FHA', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(2161, 1857434, 'Funda????o Educacional Caio Martins', 5, 'FUCAM', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(2171, 1857429, 'Funda????o de Arte de Ouro Preto', 5, 'FAOP', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(2181, 1857432, 'Funda????o Cl??vis Salgado', 5, 'FCS', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(2201, 1857451, 'Instituto Estadual do Patrim??nio Hist??rico e Art??stico de Minas Gerais', 5, 'IEPHA', 'm', '0');
INSERT INTO `tb_instituicoes2` VALUES(2211, 1858561, 'Funda????o TV Minas', 5, 'TVMINAS', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(2231, 1853800, 'Administra????o de Est??dios do Estado de Minas Gerais', 6, 'ADEMG', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(2241, 2273951, 'Instituto Mineiro de Gest??o das ??guas', 6, 'IGAM', 'm', '0');
INSERT INTO `tb_instituicoes2` VALUES(2251, 1857457, 'Junta Comercial do Estado de Minas Gerais', 6, 'JUCEMG', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(2261, 1857448, 'Funda????o Ezequiel Dias', 5, 'FUNED', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(2271, 1857431, 'Funda????o Hospitalar do Estado de Minas Gerais', 5, 'FHEMIG', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(2281, 1858563, 'Funda????o de Educa????o para o Trabalho de Minas Gerais', 5, 'UTRAMIG', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(2301, 1857424, 'Departamento de Edifica????es e Estradas de Rodagem do Estado de Minas Gerais', 6, 'DEER', 'm', '0');
INSERT INTO `tb_instituicoes2` VALUES(2311, 1858562, 'Universidade Estadual de Montes Claros', 6, 'UNIMONTES', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(2321, 1857439, 'Funda????o Centro de Hematologia e Hemoterapia do Estado de Minas Gerais', 5, 'HEMOMINAS', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(2331, 1857456, 'Instituto de Metrologia e Qualidade', 6, 'IPEM', 'm', '0');
INSERT INTO `tb_instituicoes2` VALUES(2351, 1806206, 'Universidade do Estado de Minas Gerais', 6, 'UEMG', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(2371, 1862379, 'Instituto Mineiro de Agropecu??ria', 6, 'IMA', 'm', '0');
INSERT INTO `tb_instituicoes2` VALUES(2381, 1857423, 'Departamento Estadual de Telecomunica????es de Minas Gerais', 6, 'DETEL', 'm', '1');
INSERT INTO `tb_instituicoes2` VALUES(2391, 1857452, 'Imprensa Oficial do Estado de Minas Gerais', 6, 'IOF', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(2401, 2426354, 'Instituto de Geoinforma????o e Tecnologia', 6, 'IGTEC', 'm', '1');
INSERT INTO `tb_instituicoes2` VALUES(2411, 2855048, 'Instituto de Terras do Estado de Minas Gerais', 6, 'ITER', 'm', '1');
INSERT INTO `tb_instituicoes2` VALUES(2421, 1857418, 'Instituto de Desenvolvimento do Norte e Nordeste de Minas Gerais', 6, 'IDENE', 'm', '0');
INSERT INTO `tb_instituicoes2` VALUES(2431, 3115953, 'Ag??ncia de Desenvolvimento da Regi??o Metropolitana de Belo Horizonte', 6, 'ARMBH', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(2441, 3133385, 'Ag??ncia Reguladora de Servi??os de Abastecimento de ??gua e de Esgotamento Sanit??rio do Estado de Minas Gerais', 6, 'ARSAE', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(2451, 3146991, 'Funda????o Centro Internacional de Educa????o Capacita????o e Pesquisa Aplicada em ??guas', 5, 'HIDROEX', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(2461, 3230042, 'Ag??ncia Metropolitana do Vale do A??o', 6, 'ARMVA', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(3001, NULL, 'Secretaria de Estado Extraordin??ria para Assuntos de Reforma Agr??ria', 3, 'SEARA', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(3041, 2426998, 'Empresa de Assist??ncia T??cnica e Extens??o Rural do Estado de Minas Gerais', 8, 'EMATER', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(3051, 2426999, 'Empresa de Pesquisa Agropecu??ria de Minas Gerais', 8, 'EPAMIG', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(3151, 1858200, 'Empresa Mineira de Comunica????o', 8, 'EMC', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(5011, 2426992, 'Companhia de Desenvolvimento Econ??mico de Minas Gerais', 8, 'CODEMIG', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(5031, NULL, 'Companhia de Desenvolvimento de Minas Gerais', 8, 'CODEMGE', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(5071, 2426982, 'Companhia de Habita????o do Estado de Minas Gerais', 8, 'COHAB', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(5080, NULL, 'Companhia de Saneamento de Minas Gerais', 8, 'COPASA', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(5121, 2426989, 'Companhia Energ??tica de Minas Gerais', 8, 'CEMIG', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(5131, 2427004, 'Instituto de Desenvolvimento Integrado de Minas Gerais', 6, 'INDI', 'm', '0');
INSERT INTO `tb_instituicoes2` VALUES(5141, 1764024, 'Companhia de Tecnologia da Informa????o do Estado de Minas Gerais', 8, 'PRODEMGE', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(5181, 2426997, 'Distribuidora de T??tulos e Valores Mobili??rios de Minas Gerais S.A.', 8, 'DIMINAS', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(5191, 2427005, 'Minas Gerais Participa????es S.A.', 8, 'MGI', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(5201, 2426925, 'Banco de Desenvolvimento de Minas Gerais S.A.', 8, 'BDMG', 'm', '0');
INSERT INTO `tb_instituicoes2` VALUES(5241, 2426990, 'Companhia Mineira de Promo????es', 8, 'PROMINAS', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(5251, NULL, 'Companhia de G??s de Minas Gerais', 8, 'GASMIG', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(5261, NULL, 'Trem Metropolitano de Belo Horizonte S.A.', 8, 'METROMINAS', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(5381, 2427008, 'Minas Gerais Administra????o e Servi??os S.A.', 8, 'MGS', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(5391, NULL, 'CEMIG Gera????o e Transmiss??o S.A.', 8, 'CEMIG GERA????O E TRANSMISS??O', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(5401, NULL, 'CEMIG DISTRIBUI????O S.A.', 8, 'CEMIG DISTRIBUIDORA', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(5511, NULL, 'COPASA - SERVI??OS DE SANEAMENTO INTEGRADO DO NORTE E NORDESTE DE MINAS GERAIS S/A', 0, 'COPANOR', 'f', '0');
INSERT INTO `tb_instituicoes2` VALUES(1260365, NULL, 'Secretaria de Estado Extraordin??ria da Copa do Mundo', 3, 'SECOPA', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(1260366, NULL, 'Secretaria de Estado Extraordin??ria de Gest??o Metropolitana', 3, 'SEEGM', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(1260367, NULL, 'Secretaria de Estado Extraordin??ria de Regulariza????o Fundi??ria', 3, 'SEERF', 'f', '1');
INSERT INTO `tb_instituicoes2` VALUES(1260368, NULL, 'Conselho Estadual de Educa????o', 8, 'CEE', 'm', '0');
INSERT INTO `tb_instituicoes2` VALUES(1260370, NULL, 'INSTITUICAO C/ CODIGO DE UNIDADE NAO INFORMADO', 0, 'INVALIDO', 'm', '1');

INSERT INTO `tb_perfis` VALUES(1, 'RH Visualizador');
INSERT INTO `tb_perfis` VALUES(2, 'Geral Visualizador');
INSERT INTO `tb_perfis` VALUES(3, 'Administrador');
INSERT INTO `tb_perfis` VALUES(4, 'Desativado');
INSERT INTO `tb_perfis` VALUES(5, 'RH Arquivo');

INSERT INTO `tb_tipos_processo` VALUES(100000101, 'RH: Abono de Perman??ncia');
INSERT INTO `tb_tipos_processo` VALUES(100000102, 'Pessoal: Adicional de F??rias (1/3 constitucional)');
INSERT INTO `tb_tipos_processo` VALUES(100000103, 'RH: Adicional de Insalubridade');
INSERT INTO `tb_tipos_processo` VALUES(100000104, 'Pessoal: Adicional de Periculosidade');
INSERT INTO `tb_tipos_processo` VALUES(100000105, 'Pessoal: Adicional Noturno');
INSERT INTO `tb_tipos_processo` VALUES(100000106, 'Pessoal: Adicional por Atividade Penosa');
INSERT INTO `tb_tipos_processo` VALUES(100000107, 'Pessoal: Adicional por Servi??o Extraordin??rio');
INSERT INTO `tb_tipos_processo` VALUES(100000108, 'Pessoal: Adicional de Desempenho (ADE)');
INSERT INTO `tb_tipos_processo` VALUES(100000109, 'Pessoal: Afastamento para Atividade Desportiva');
INSERT INTO `tb_tipos_processo` VALUES(100000110, 'Pessoal: Afastamento para Curso na Escola de Gover');
INSERT INTO `tb_tipos_processo` VALUES(100000111, 'Pessoal: Afastamento para Depor');
INSERT INTO `tb_tipos_processo` VALUES(100000112, 'Pessoal: Afastamento para Exercer Mandato Eletivo');
INSERT INTO `tb_tipos_processo` VALUES(100000113, 'Pessoal: Requisi????o para Servi??o Eleitoral (TRE)');
INSERT INTO `tb_tipos_processo` VALUES(100000114, 'Pessoal: Afastamento para Servir como Jurado');
INSERT INTO `tb_tipos_processo` VALUES(100000116, 'Pessoal: Afastamento para Estudos');
INSERT INTO `tb_tipos_processo` VALUES(100000118, 'Pessoal: Afastamento para servir em Organismo Inte');
INSERT INTO `tb_tipos_processo` VALUES(100000119, 'Pessoal: Ajuda de Custo com Mudan??a de Domic??lio');
INSERT INTO `tb_tipos_processo` VALUES(100000120, 'Pessoal: Aposentadoria Compuls??ria');
INSERT INTO `tb_tipos_processo` VALUES(100000121, 'Pessoal: Aposentadoria por Invalidez');
INSERT INTO `tb_tipos_processo` VALUES(100000122, 'Pessoal: Aposentadoria - Pens??o Vital??cia');
INSERT INTO `tb_tipos_processo` VALUES(100000123, 'Pessoal: Assentamento Funcional do Servidor');
INSERT INTO `tb_tipos_processo` VALUES(100000124, 'Pessoal: Sa??de - Solicita????o de Aux??lio-Sa??de');
INSERT INTO `tb_tipos_processo` VALUES(100000125, 'Pessoal: Sa??de - Plano de Sa??de');
INSERT INTO `tb_tipos_processo` VALUES(100000126, 'Pessoal: Sa??de - Prontu??rio M??dico');
INSERT INTO `tb_tipos_processo` VALUES(100000127, 'Pessoal: Aus??ncia em raz??o de Casamento');
INSERT INTO `tb_tipos_processo` VALUES(100000128, 'Pessoal: Aus??ncia para Alistamento Eleitoral');
INSERT INTO `tb_tipos_processo` VALUES(100000129, 'Pessoal: Aus??ncia para Doa????o de Sangue');
INSERT INTO `tb_tipos_processo` VALUES(100000130, 'Pessoal: Aus??ncia por Falecimento de Familiar');
INSERT INTO `tb_tipos_processo` VALUES(100000131, 'Pessoal: Aux??lio Acidente');
INSERT INTO `tb_tipos_processo` VALUES(100000132, 'vantagens');
INSERT INTO `tb_tipos_processo` VALUES(100000133, 'Pessoal: Aux??lio Assist??ncia Pr??-Escolar/Creche');
INSERT INTO `tb_tipos_processo` VALUES(100000134, 'Pessoal: Aux??lio Doen??a');
INSERT INTO `tb_tipos_processo` VALUES(100000135, 'Pessoal: Aux??lio Funeral');
INSERT INTO `tb_tipos_processo` VALUES(100000136, 'Pessoal: Aux??lio Moradia');
INSERT INTO `tb_tipos_processo` VALUES(100000137, 'Pessoal: Aux??lio Natalidade');
INSERT INTO `tb_tipos_processo` VALUES(100000138, 'Pessoal: Aux??lio Reclus??o');
INSERT INTO `tb_tipos_processo` VALUES(100000139, 'Pessoal: Aux??lio-Transporte');
INSERT INTO `tb_tipos_processo` VALUES(100000140, 'Pessoal: Avalia????o de Desempenho Individual');
INSERT INTO `tb_tipos_processo` VALUES(100000141, 'Pessoal: Avalia????o de Desempenho Institucional');
INSERT INTO `tb_tipos_processo` VALUES(100000142, 'Pessoal: Est??gio Probat??rio');
INSERT INTO `tb_tipos_processo` VALUES(100000143, 'Pessoal: Averba????o de Tempo de Servi??o');
INSERT INTO `tb_tipos_processo` VALUES(100000144, 'Pessoal: Bolsa de Estudo de Idioma Estrangeiro');
INSERT INTO `tb_tipos_processo` VALUES(100000145, 'Pessoal: Bolsa de P??s-Gradua????o');
INSERT INTO `tb_tipos_processo` VALUES(100000146, 'Pessoal: Cadastro de Dependente no Imposto de Rend');
INSERT INTO `tb_tipos_processo` VALUES(100000147, 'Pessoal: Apresenta????o de Certificado de Curso');
INSERT INTO `tb_tipos_processo` VALUES(100000148, 'RH: Cess??o de Servidor');
INSERT INTO `tb_tipos_processo` VALUES(100000149, 'RH: Contagem de Tempo/Averba????o : Apura????o de Tempo de Servi??o');
INSERT INTO `tb_tipos_processo` VALUES(100000150, 'Pessoal: Coleta de Imagem de Assinatura');
INSERT INTO `tb_tipos_processo` VALUES(100000151, 'RH: Aposentadoria');
INSERT INTO `tb_tipos_processo` VALUES(100000152, 'Pessoal: Concurso P??blico - Exames Admissionais');
INSERT INTO `tb_tipos_processo` VALUES(100000153, 'Pessoal: Concurso P??blico - Organiza????o');
INSERT INTO `tb_tipos_processo` VALUES(100000154, 'Pessoal: Concurso P??blico - Provas e T??tulos');
INSERT INTO `tb_tipos_processo` VALUES(100000157, 'Pessoal: Frequ??ncia');
INSERT INTO `tb_tipos_processo` VALUES(100000158, 'Pessoal: Curso no Exterior - com ??nus');
INSERT INTO `tb_tipos_processo` VALUES(100000159, 'Pessoal: Cursos Promovidos');
INSERT INTO `tb_tipos_processo` VALUES(100000160, 'Pessoal: Curso Promovido por outra Institui????o');
INSERT INTO `tb_tipos_processo` VALUES(100000161, 'Pessoal: Curso de P??s-Gradua????o');
INSERT INTO `tb_tipos_processo` VALUES(100000162, 'Pessoal: Delega????o de Compet??ncia');
INSERT INTO `tb_tipos_processo` VALUES(100000163, 'RH: Op????o de Contribui????o Previdenci??ria');
INSERT INTO `tb_tipos_processo` VALUES(100000164, 'Pessoal: Desconto de Contribui????o Associativa');
INSERT INTO `tb_tipos_processo` VALUES(100000165, 'Pessoal: Desconto de Contribui????o Sindical');
INSERT INTO `tb_tipos_processo` VALUES(100000166, 'Pessoal: Consigna????o em Folha de Pagamento');
INSERT INTO `tb_tipos_processo` VALUES(100000167, 'Pessoal: Desconto de Pens??o Aliment??cia');
INSERT INTO `tb_tipos_processo` VALUES(100000169, 'Pessoal: Desconto do IRPF Retido na Fonte');
INSERT INTO `tb_tipos_processo` VALUES(100000170, 'Pessoal: Designa????o');
INSERT INTO `tb_tipos_processo` VALUES(100000172, 'Pessoal: Emiss??o de Certid??es e Declara????es');
INSERT INTO `tb_tipos_processo` VALUES(100000173, 'Pessoal: Emiss??o de Procura????o');
INSERT INTO `tb_tipos_processo` VALUES(100000174, 'Pessoal: Encargo Patronal - Contribui????o para INSS');
INSERT INTO `tb_tipos_processo` VALUES(100000175, 'Pessoal: Est??gio - Dossi?? do Estagi??rio');
INSERT INTO `tb_tipos_processo` VALUES(100000176, 'Pessoal: Est??gio - Planejamento/Organiza????o Geral');
INSERT INTO `tb_tipos_processo` VALUES(100000177, 'Pessoal: Est??gio de Servidor no Brasil');
INSERT INTO `tb_tipos_processo` VALUES(100000178, 'Pessoal: Contrata????o de Estagi??rios');
INSERT INTO `tb_tipos_processo` VALUES(100000179, 'RH: Exonera????o de Cargo Efetivo ou Dispensa de Fun????o P??blica');
INSERT INTO `tb_tipos_processo` VALUES(100000181, 'Pessoal: Falecimento de Servidor');
INSERT INTO `tb_tipos_processo` VALUES(100000182, 'Pessoal: F??rias Regulamentares');
INSERT INTO `tb_tipos_processo` VALUES(100000183, 'Pessoal: F??rias - Interrup????o');
INSERT INTO `tb_tipos_processo` VALUES(100000184, 'Pessoal: F??rias - Solicita????o');
INSERT INTO `tb_tipos_processo` VALUES(100000185, 'Pessoal: Ficha Financeira (Contracheque)');
INSERT INTO `tb_tipos_processo` VALUES(100000186, 'RH: Folha de Pagamento');
INSERT INTO `tb_tipos_processo` VALUES(100000187, 'Pessoal: Gratifica????o de Desempenho');
INSERT INTO `tb_tipos_processo` VALUES(100000188, 'Pessoal: Gratifica????o Natalina (D??cimo Terceiro)');
INSERT INTO `tb_tipos_processo` VALUES(100000189, 'Pessoal: Gratifica????o por Encargo - Curso/Concurso');
INSERT INTO `tb_tipos_processo` VALUES(100000190, 'Pessoal: Hor??rio de Expediente - Defini????o');
INSERT INTO `tb_tipos_processo` VALUES(100000191, 'Pessoal: Hor??rio de Expediente - Escala de Plant??o');
INSERT INTO `tb_tipos_processo` VALUES(100000192, 'Pessoal: Hor??rio Especial - Familiar Deficiente');
INSERT INTO `tb_tipos_processo` VALUES(100000193, 'Pessoal: Hor??rio Especial - Instrutor de Curso');
INSERT INTO `tb_tipos_processo` VALUES(100000194, 'Pessoal: Hor??rio Especial - Servidor Deficiente');
INSERT INTO `tb_tipos_processo` VALUES(100000195, 'RH: Flexibiliza????o de Hor??rio de Trabalho');
INSERT INTO `tb_tipos_processo` VALUES(100000196, 'Pessoal: Indeniza????o de Transporte (meio pr??prio)');
INSERT INTO `tb_tipos_processo` VALUES(100000197, 'Pessoal: Sa??de - Inspe????o Peri??dica');
INSERT INTO `tb_tipos_processo` VALUES(100000198, 'RH: Licen??a Adotante');
INSERT INTO `tb_tipos_processo` VALUES(100000199, 'Pessoal: Licen??a Maternidade');
INSERT INTO `tb_tipos_processo` VALUES(100000200, 'Pessoal: Licen??a Paternidade');
INSERT INTO `tb_tipos_processo` VALUES(100000201, 'Pessoal: Licen??a para Atividade Pol??tica');
INSERT INTO `tb_tipos_processo` VALUES(100000202, 'Pessoal: Licen??a para Capacita????o');
INSERT INTO `tb_tipos_processo` VALUES(100000203, 'Pessoal: Licen??a para Mandato Classista');
INSERT INTO `tb_tipos_processo` VALUES(100000204, 'Pessoal: Licen??a para Servi??o Militar');
INSERT INTO `tb_tipos_processo` VALUES(100000205, 'Pessoal: Licen??a para Tratamento da Pr??pria Sa??de');
INSERT INTO `tb_tipos_processo` VALUES(100000206, 'Pessoal: Licen??a por Acidente em Servi??o');
INSERT INTO `tb_tipos_processo` VALUES(100000207, 'Pessoal: Licen??a por Afastamento do C??njuge');
INSERT INTO `tb_tipos_processo` VALUES(100000208, 'Pessoal: Licen??a por Doen??a em Pessoa da Fam??lia');
INSERT INTO `tb_tipos_processo` VALUES(100000209, 'Pessoal: Licen??a por Doen??a Profissional');
INSERT INTO `tb_tipos_processo` VALUES(100000210, 'Pessoal: Licen??a Pr??mio por Assiduidade');
INSERT INTO `tb_tipos_processo` VALUES(100000211, 'RH: Licen??a para Tratar de Interesses Particulares (LIP)');
INSERT INTO `tb_tipos_processo` VALUES(100000212, 'Pessoal: Licen??as por Aborto/Natimorto');
INSERT INTO `tb_tipos_processo` VALUES(100000213, 'Pessoal: Movimenta????o de Servidor');
INSERT INTO `tb_tipos_processo` VALUES(100000214, 'Pessoal: Movimento Reivindicat??rio');
INSERT INTO `tb_tipos_processo` VALUES(100000215, 'Pessoal: Negocia????o Sindical');
INSERT INTO `tb_tipos_processo` VALUES(100000217, 'Pessoal: Normatiza????o');
INSERT INTO `tb_tipos_processo` VALUES(100000218, 'Pessoal: Ocupa????o de Im??vel Funcional');
INSERT INTO `tb_tipos_processo` VALUES(100000219, 'Pessoal: Orienta????es e Diretrizes Gerais');
INSERT INTO `tb_tipos_processo` VALUES(100000220, 'Pessoal: Pagamento de Provento');
INSERT INTO `tb_tipos_processo` VALUES(100000221, 'Pessoal: Pagamento de Remunera????o');
INSERT INTO `tb_tipos_processo` VALUES(100000222, 'Pessoal: Penalidade Advert??ncia');
INSERT INTO `tb_tipos_processo` VALUES(100000223, 'Pessoal: Penalidade Cassa????o de Aposentadoria');
INSERT INTO `tb_tipos_processo` VALUES(100000224, 'Pessoal: Penalidade');
INSERT INTO `tb_tipos_processo` VALUES(100000225, 'Pessoal: Penalidade Destitui????o Cargo em Comiss??o');
INSERT INTO `tb_tipos_processo` VALUES(100000226, 'Pessoal: Penalidade Disponibilidade');
INSERT INTO `tb_tipos_processo` VALUES(100000227, 'Pessoal: Penalidade Suspens??o');
INSERT INTO `tb_tipos_processo` VALUES(100000228, 'Pessoal: Pens??o IPSEMG');
INSERT INTO `tb_tipos_processo` VALUES(100000229, 'Pessoal: Planejamento da For??a de Trabalho');
INSERT INTO `tb_tipos_processo` VALUES(100000230, 'RH: Pr??mio Inova Minas Gerais');
INSERT INTO `tb_tipos_processo` VALUES(100000231, 'Pessoal: Preven????o de Acidentes no Trabalho');
INSERT INTO `tb_tipos_processo` VALUES(100000232, 'RH: Progress??o e Promo????o');
INSERT INTO `tb_tipos_processo` VALUES(100000233, 'Pessoal: Progress??o e Promo????o (Quadro Espec??fico)');
INSERT INTO `tb_tipos_processo` VALUES(100000234, 'Pessoal: Provimento - Nomea????o para Cargo Efetivo');
INSERT INTO `tb_tipos_processo` VALUES(100000235, 'Pessoal: Provimento - Nomea????o para Cargo em Comiss??o');
INSERT INTO `tb_tipos_processo` VALUES(100000236, 'Pessoal: Provimento - por Aproveitamento');
INSERT INTO `tb_tipos_processo` VALUES(100000237, 'Pessoal: Provimento - por Readapta????o, Recondu????o ou Reintegra????o');
INSERT INTO `tb_tipos_processo` VALUES(100000238, 'Pessoal: Provimento - por Recondu????o');
INSERT INTO `tb_tipos_processo` VALUES(100000239, 'Pessoal: Provimento - por Reintegra????o');
INSERT INTO `tb_tipos_processo` VALUES(100000240, 'Pessoal: Provimento - por Revers??o');
INSERT INTO `tb_tipos_processo` VALUES(100000242, 'Pessoal: Rela????o com Conselho Profissional');
INSERT INTO `tb_tipos_processo` VALUES(100000243, 'RH: Remo????o');
INSERT INTO `tb_tipos_processo` VALUES(100000244, 'Pessoal: Remo????o a Pedido com Mudan??a de Sede');
INSERT INTO `tb_tipos_processo` VALUES(100000245, 'Pessoal: Remo????o a Pedido para Acompanhar C??njuge');
INSERT INTO `tb_tipos_processo` VALUES(100000246, 'Pessoal: Remo????o a Pedido por Motivo de Sa??de');
INSERT INTO `tb_tipos_processo` VALUES(100000247, 'Pessoal: Remo????o a Pedido sem Mudan??a de Sede');
INSERT INTO `tb_tipos_processo` VALUES(100000248, 'Pessoal: Remo????o de Of??cio com Mudan??a de Sede');
INSERT INTO `tb_tipos_processo` VALUES(100000249, 'Pessoal: Remo????o de Of??cio sem Mudan??a de Sede');
INSERT INTO `tb_tipos_processo` VALUES(100000250, 'Pessoal: Requisi????o de Servidor Externo');
INSERT INTO `tb_tipos_processo` VALUES(100000251, 'Pessoal: Requisi????o de Servidor Interno');
INSERT INTO `tb_tipos_processo` VALUES(100000252, 'Pessoal: Restrutura????o de Cargos e Fun????es');
INSERT INTO `tb_tipos_processo` VALUES(100000253, 'Pessoal: Retribui????o por Cargo em Comiss??o');
INSERT INTO `tb_tipos_processo` VALUES(100000254, 'Pessoal: Sal??rio-Fam??lia');
INSERT INTO `tb_tipos_processo` VALUES(100000255, 'Pessoal: Informa????es ?? AGE para Subs??dio ?? Defesa ');
INSERT INTO `tb_tipos_processo` VALUES(100000256, 'Arrecada????o: Cobran??a');
INSERT INTO `tb_tipos_processo` VALUES(100000261, 'Arrecada????o: Receita');
INSERT INTO `tb_tipos_processo` VALUES(100000267, 'Contabilidade: Contratos e Garantias');
INSERT INTO `tb_tipos_processo` VALUES(100000270, 'Contabilidade: Encerramento do Exerc??cio');
INSERT INTO `tb_tipos_processo` VALUES(100000271, 'Controle de Estoque');
INSERT INTO `tb_tipos_processo` VALUES(100000275, 'Presta????o de Contas Anual para o TCEMG - Administr');
INSERT INTO `tb_tipos_processo` VALUES(100000278, 'Gest??o da Informa????o: Arrecada????o');
INSERT INTO `tb_tipos_processo` VALUES(100000279, 'Or??amento: Acompanhamento de Despesa Mensal');
INSERT INTO `tb_tipos_processo` VALUES(100000282, 'Or??amento: Descentraliza????o de Cr??ditos');
INSERT INTO `tb_tipos_processo` VALUES(100000283, 'Or??amento: Manuais');
INSERT INTO `tb_tipos_processo` VALUES(100000284, 'Or??amento: Programa????o Or??ament??ria');
INSERT INTO `tb_tipos_processo` VALUES(100000285, 'Viagem a Servi??o: Sem ??nus para institui????o');
INSERT INTO `tb_tipos_processo` VALUES(100000289, 'Pessoal: Vac??ncia');
INSERT INTO `tb_tipos_processo` VALUES(100000291, 'Material: Desfazimento de Material Permanente');
INSERT INTO `tb_tipos_processo` VALUES(100000292, 'Material: Desfazimento de Material de Consumo');
INSERT INTO `tb_tipos_processo` VALUES(100000293, 'Material: Movimenta????o de Material de Consumo');
INSERT INTO `tb_tipos_processo` VALUES(100000294, 'Invent??rios: Material de Consumo');
INSERT INTO `tb_tipos_processo` VALUES(100000295, 'Invent??rios: de Material Permanente');
INSERT INTO `tb_tipos_processo` VALUES(100000296, 'Patrim??nio: Gest??o de Bens Im??veis');
INSERT INTO `tb_tipos_processo` VALUES(100000298, 'Controle de Portaria/Acesso');
INSERT INTO `tb_tipos_processo` VALUES(100000303, 'Procedimentos Administrativos Disciplinares');
INSERT INTO `tb_tipos_processo` VALUES(100000304, 'Licita????o: Plano de Aquisi????es');
INSERT INTO `tb_tipos_processo` VALUES(100000305, 'Conv??nios/Ajustes: Formaliza????o/Altera????o com Repa');
INSERT INTO `tb_tipos_processo` VALUES(100000306, 'Conv??nios/Ajustes: Formaliza????o/Altera????o sem Repasse');
INSERT INTO `tb_tipos_processo` VALUES(100000307, 'Conv??nios/Ajustes: Acompanhamento da Execu????o');
INSERT INTO `tb_tipos_processo` VALUES(100000308, 'Gest??o de Contrato: Supress??o Contratual');
INSERT INTO `tb_tipos_processo` VALUES(100000309, 'Gest??o de Contrato: Aplica????o de San????o Contratual');
INSERT INTO `tb_tipos_processo` VALUES(100000310, 'Gest??o de Contrato: Revis??o Contratual');
INSERT INTO `tb_tipos_processo` VALUES(100000311, 'Gest??o de Contrato: Execu????o de Garantia');
INSERT INTO `tb_tipos_processo` VALUES(100000312, 'Gest??o de Contrato: Processo de Pagamento');
INSERT INTO `tb_tipos_processo` VALUES(100000313, 'Gest??o de Contrato: Prorroga????o Contratual');
INSERT INTO `tb_tipos_processo` VALUES(100000314, 'Gest??o de Contrato: Reajuste ou Repactua????o Contra');
INSERT INTO `tb_tipos_processo` VALUES(100000315, 'Gest??o de Contrato: Rescis??o Contratual');
INSERT INTO `tb_tipos_processo` VALUES(100000316, 'Gest??o de Contrato: Acompanhamento da Execu????o');
INSERT INTO `tb_tipos_processo` VALUES(100000317, 'Licita????o: Preg??o');
INSERT INTO `tb_tipos_processo` VALUES(100000318, 'Licita????o: Preg??o para Registro de Pre??o');
INSERT INTO `tb_tipos_processo` VALUES(100000319, 'Licita????o: Preg??o Presencial');
INSERT INTO `tb_tipos_processo` VALUES(100000320, 'Licita????o: Concorr??ncia');
INSERT INTO `tb_tipos_processo` VALUES(100000321, 'Licita????o: Concorr??ncia-Registro de Pre??o');
INSERT INTO `tb_tipos_processo` VALUES(100000322, 'Licita????o: Tomada de Pre??os');
INSERT INTO `tb_tipos_processo` VALUES(100000323, 'Licita????o: Convite');
INSERT INTO `tb_tipos_processo` VALUES(100000324, 'Licita????o: Regime Diferenciado de Contrata????o-RDC');
INSERT INTO `tb_tipos_processo` VALUES(100000325, 'Licita????o para Contrata????o de Servi??o: Preg??o Elet');
INSERT INTO `tb_tipos_processo` VALUES(100000326, 'Licita????o: Leil??o');
INSERT INTO `tb_tipos_processo` VALUES(100000328, 'Licita????o: Ades??o a Ata de RP-Participante');
INSERT INTO `tb_tipos_processo` VALUES(100000329, 'Licita????o: Ades??o a Ata de RP-N??o Participante');
INSERT INTO `tb_tipos_processo` VALUES(100000330, 'Licita????o: Dispensa - At?? R$ 8 mil');
INSERT INTO `tb_tipos_processo` VALUES(100000331, 'Licita????o: Dispensa - Acima de R$ 8 mil');
INSERT INTO `tb_tipos_processo` VALUES(100000332, 'Licita????o: Inexigibilidade');
INSERT INTO `tb_tipos_processo` VALUES(100000333, 'Ouvidoria: Elogio ?? atua????o do ??rg??o');
INSERT INTO `tb_tipos_processo` VALUES(100000334, 'Ouvidoria: Cr??tica ?? atua????o do ??rg??o');
INSERT INTO `tb_tipos_processo` VALUES(100000335, 'Ouvidoria: Den??ncia contra a atua????o do ??rg??o');
INSERT INTO `tb_tipos_processo` VALUES(100000336, 'Ouvidoria: Reclama????o ?? atua????o do ??rg??o');
INSERT INTO `tb_tipos_processo` VALUES(100000337, 'Ouvidoria: Agradecimento ao ??rg??o');
INSERT INTO `tb_tipos_processo` VALUES(100000338, 'Ouvidoria: Pedido de Informa????o');
INSERT INTO `tb_tipos_processo` VALUES(100000339, 'Gest??o e Controle: Executar Auditoria Interna');
INSERT INTO `tb_tipos_processo` VALUES(100000341, 'Comunica????o: Pedido de Apoio Institucional');
INSERT INTO `tb_tipos_processo` VALUES(100000342, 'Comunica????o: Evento Institucional P??blico Externo');
INSERT INTO `tb_tipos_processo` VALUES(100000345, 'Comunica????o: Evento Institucional P??blico Interno');
INSERT INTO `tb_tipos_processo` VALUES(100000351, 'Demanda Externa: Senador');
INSERT INTO `tb_tipos_processo` VALUES(100000352, 'Demanda Externa: Deputado Federal');
INSERT INTO `tb_tipos_processo` VALUES(100000353, 'Demanda Externa:: Deputado Estadual');
INSERT INTO `tb_tipos_processo` VALUES(100000354, 'Demanda Externa: Vereador/C??mara Municipal');
INSERT INTO `tb_tipos_processo` VALUES(100000355, 'Demanda Externa: Org??os Governamentais Federais');
INSERT INTO `tb_tipos_processo` VALUES(100000356, 'Demanda Externa: Org??os Governamentais Estaduais');
INSERT INTO `tb_tipos_processo` VALUES(100000357, 'Demanda Externa: Org??os Governamentais Municipais');
INSERT INTO `tb_tipos_processo` VALUES(100000358, 'Demanda Externa: Outros ??rg??os P??blicos');
INSERT INTO `tb_tipos_processo` VALUES(100000361, 'Corregedoria: Investiga????o Preliminar');
INSERT INTO `tb_tipos_processo` VALUES(100000362, 'Corregedoria: Sindic??ncia Punitiva');
INSERT INTO `tb_tipos_processo` VALUES(100000363, 'Corregedoria: Processo Administrativo Disciplinar');
INSERT INTO `tb_tipos_processo` VALUES(100000365, 'Gest??o da Informa????o: Credenciamento de Seguran??a');
INSERT INTO `tb_tipos_processo` VALUES(100000366, 'Gest??o da Informa????o: Normatiza????o Interna');
INSERT INTO `tb_tipos_processo` VALUES(100000367, 'Gest??o da Informa????o: Rol Anual de Informa????es Cla');
INSERT INTO `tb_tipos_processo` VALUES(100000368, 'Gest??o da Informa????o: Avalia????o/Destina????o de Documentos');
INSERT INTO `tb_tipos_processo` VALUES(100000369, 'Gest??o da Informa????o: Reconstitui????o Documental');
INSERT INTO `tb_tipos_processo` VALUES(100000372, 'Gest??o de Projetos: Planejamento e Execu????o');
INSERT INTO `tb_tipos_processo` VALUES(100000373, 'Desenvolvimento Organizacional: Reestrutura????o e M');
INSERT INTO `tb_tipos_processo` VALUES(100000375, 'Auditoria em Demandas Pontuais');
INSERT INTO `tb_tipos_processo` VALUES(100000382, 'Demanda Externa: Cidad??o (Pessoa F??sica)');
INSERT INTO `tb_tipos_processo` VALUES(100000383, 'Gest??o de Contrato: Pagamento Direto a Terceiros');
INSERT INTO `tb_tipos_processo` VALUES(100000384, 'Gest??o de TI: CITI');
INSERT INTO `tb_tipos_processo` VALUES(100000385, 'Demanda Externa: Judici??rio');
INSERT INTO `tb_tipos_processo` VALUES(100000386, 'Demanda Externa: Minist??rio P??blico Estadual');
INSERT INTO `tb_tipos_processo` VALUES(100000387, 'Demanda Externa: Minist??rio P??blico Federal');
INSERT INTO `tb_tipos_processo` VALUES(100000388, 'Demanda Externa: Outras Entidades Privadas');
INSERT INTO `tb_tipos_processo` VALUES(100000389, 'Gest??o da Informa????o: Controle de Malote');
INSERT INTO `tb_tipos_processo` VALUES(100000390, 'Suprimento de Fundos: Solicita????o de Despesa');
INSERT INTO `tb_tipos_processo` VALUES(100000391, 'Material: Movimenta????o de Material Permanente');
INSERT INTO `tb_tipos_processo` VALUES(100000392, 'Pessoal: Sa??de - Exclus??o de Aux??lio-Sa??de');
INSERT INTO `tb_tipos_processo` VALUES(100000393, 'Pessoal: Sa??de - Pagamento de Aux??lio-Sa??de');
INSERT INTO `tb_tipos_processo` VALUES(100000394, 'Pessoal: Sa??de - Cadastro de Dependente Estudante ');
INSERT INTO `tb_tipos_processo` VALUES(100000395, 'Pessoal: Sa??de - Aux??lio-Sa??de GEAP');
INSERT INTO `tb_tipos_processo` VALUES(100000396, 'Pessoal: Sa??de - Atestado de Comparecimento');
INSERT INTO `tb_tipos_processo` VALUES(100000397, 'Pessoal: Sa??de - Ressarcimento ao Er??rio');
INSERT INTO `tb_tipos_processo` VALUES(100000398, 'Pessoal: Sa??de - Pagamento de Retroativo');
INSERT INTO `tb_tipos_processo` VALUES(100000399, 'Pessoal: Sa??de e Qualidade de Vida no Trabalho');
INSERT INTO `tb_tipos_processo` VALUES(100000400, 'Pessoal: Ressarcimento ao Er??rio');
INSERT INTO `tb_tipos_processo` VALUES(100000401, 'Gest??o de Contrato: Consulta ?? Procuradoria/Conjur');
INSERT INTO `tb_tipos_processo` VALUES(100000402, 'Gest??o de Contrato: Acr??scimo Contratual');
INSERT INTO `tb_tipos_processo` VALUES(100000403, 'Gest??o de Contrato: Altera????es Contratuais Conjunt');
INSERT INTO `tb_tipos_processo` VALUES(100000404, 'Gest??o de Contrato');
INSERT INTO `tb_tipos_processo` VALUES(100000405, 'Pessoal: Abono Perman??ncia - Revis??o');
INSERT INTO `tb_tipos_processo` VALUES(100000406, 'RH: Aposentadoria - Revis??o de Proventos');
INSERT INTO `tb_tipos_processo` VALUES(100000407, 'Pessoal: Capacita????o');
INSERT INTO `tb_tipos_processo` VALUES(100000408, 'Licita????o: Aplica????o de San????o decorrente de Proce');
INSERT INTO `tb_tipos_processo` VALUES(100000409, 'Gest??o da Informa????o: Cadastro de Usu??rio Externo ');
INSERT INTO `tb_tipos_processo` VALUES(100000410, 'Pessoal: Sa??de - Lan??amento Mensal do Aux??lio-Sa??d');
INSERT INTO `tb_tipos_processo` VALUES(100000411, 'Seguran??a da Informa????o: Organiza????o da Seguran??a da Informa????o');
INSERT INTO `tb_tipos_processo` VALUES(100000414, 'Pessoal: Curso no Exterior - ??nus limitado');
INSERT INTO `tb_tipos_processo` VALUES(100000415, 'Pessoal: Curso no Exterior - sem ??nus');
INSERT INTO `tb_tipos_processo` VALUES(100000417, 'Licita????o: Consulta');
INSERT INTO `tb_tipos_processo` VALUES(100000418, 'Infraestrutura: Apoio de Engenharia Civil');
INSERT INTO `tb_tipos_processo` VALUES(100000419, 'Produ????o e Utiliza????o de Documentos: Classifica????o e Arquivamento');
INSERT INTO `tb_tipos_processo` VALUES(100000420, 'Rela????es Internacionais: Composi????o de Delega????o -');
INSERT INTO `tb_tipos_processo` VALUES(100000501, 'Cadastramento e Credenciamento de Fornecedores');
INSERT INTO `tb_tipos_processo` VALUES(100000502, 'Regulariza????o de Im??veis');
INSERT INTO `tb_tipos_processo` VALUES(100000503, 'Acompanhamento de Portf??lio');
INSERT INTO `tb_tipos_processo` VALUES(100000504, 'Aliena????o: Doa????o');
INSERT INTO `tb_tipos_processo` VALUES(100000505, 'Aliena????o: Retrocess??o');
INSERT INTO `tb_tipos_processo` VALUES(100000506, 'Aliena????o: Revers??o');
INSERT INTO `tb_tipos_processo` VALUES(100000507, 'Aquisi????o - Adjudica????o??');
INSERT INTO `tb_tipos_processo` VALUES(100000508, 'Aquisi????o - Compra');
INSERT INTO `tb_tipos_processo` VALUES(100000509, 'Aquisi????o - Da????o em pagamento');
INSERT INTO `tb_tipos_processo` VALUES(100000510, 'Aquisi????o - Desapropria????o');
INSERT INTO `tb_tipos_processo` VALUES(100000511, 'Aquisi????o - Doa????o');
INSERT INTO `tb_tipos_processo` VALUES(100000512, 'Aquisi????o - Revers??o');
INSERT INTO `tb_tipos_processo` VALUES(100000513, 'Aquisi????o - Usucapi??o');
INSERT INTO `tb_tipos_processo` VALUES(100000514, 'Aquisi????o de Ve??culos');
INSERT INTO `tb_tipos_processo` VALUES(100000515, 'Autoriza????o de Obra em Im??veis P??blicos');
INSERT INTO `tb_tipos_processo` VALUES(100000516, 'Autoriza????o Provis??ria para Utiliza????o de Im??veis ');
INSERT INTO `tb_tipos_processo` VALUES(100000517, 'Avalia????o da Vantajosidade de Renova????o Contratual');
INSERT INTO `tb_tipos_processo` VALUES(100000518, 'Cadastro de Material e Servi??o: Classifica????o de D');
INSERT INTO `tb_tipos_processo` VALUES(100000519, 'Cadastro e Atualiza????o de Im??veis');
INSERT INTO `tb_tipos_processo` VALUES(100000520, 'Cess??o de Uso de Bens M??veis');
INSERT INTO `tb_tipos_processo` VALUES(100000521, 'Cess??o de Uso de Ve??culos');
INSERT INTO `tb_tipos_processo` VALUES(100000522, 'CNPJ Administrativo');
INSERT INTO `tb_tipos_processo` VALUES(100000523, 'Consulta Disponibilidade de Im??veis');
INSERT INTO `tb_tipos_processo` VALUES(100000524, 'Da????o em Pagamento');
INSERT INTO `tb_tipos_processo` VALUES(100000525, 'Demanda: Assessoramento ?? Defesa do Estado de Minas Gerais');
INSERT INTO `tb_tipos_processo` VALUES(100000526, 'Demanda Externa: Assessoramento Jur??dico');
INSERT INTO `tb_tipos_processo` VALUES(100000527, 'Demanda Externa: Pol??tica e Regras de Compras P??bl');
INSERT INTO `tb_tipos_processo` VALUES(100000528, 'Demanda Externa: Sistemas e Cadastros');
INSERT INTO `tb_tipos_processo` VALUES(100000529, 'Solicita????o de Doa????o de Bens M??veis');
INSERT INTO `tb_tipos_processo` VALUES(100000530, 'Solicita????o de Doa????o de Ve??culos');
INSERT INTO `tb_tipos_processo` VALUES(100000531, 'Assessoramento T??cnico-Legislativo - Decreto');
INSERT INTO `tb_tipos_processo` VALUES(100000532, 'Assessoramento T??cnico-Legislativo - Proposi????o de');
INSERT INTO `tb_tipos_processo` VALUES(100000533, 'Elabora????o de Resolu????o');
INSERT INTO `tb_tipos_processo` VALUES(100000534, 'Elabora????o de Resolu????o Conjunta');
INSERT INTO `tb_tipos_processo` VALUES(100000535, 'Empr??stimo - Autoriza????o de Uso do Im??vel');
INSERT INTO `tb_tipos_processo` VALUES(100000536, 'Empr??stimo - Cess??o de Uso do Im??vel');
INSERT INTO `tb_tipos_processo` VALUES(100000537, 'Empr??stimo - Cess??o de Uso, Permiss??o de Uso e Aut');
INSERT INTO `tb_tipos_processo` VALUES(100000538, 'Empr??stimo - Desvincula????o');
INSERT INTO `tb_tipos_processo` VALUES(100000539, 'Empr??stimo - Permiss??o de uso do Im??vel');
INSERT INTO `tb_tipos_processo` VALUES(100000540, 'Empr??stimo - Vincula????o de Im??vel');
INSERT INTO `tb_tipos_processo` VALUES(100000541, 'Gest??o de Contrato: Armazenamento de Documentos');
INSERT INTO `tb_tipos_processo` VALUES(100000542, 'Gest??o de Contrato: Abastecimento');
INSERT INTO `tb_tipos_processo` VALUES(100000543, 'Gestao de Contrato: Aluguel de Ve??culos');
INSERT INTO `tb_tipos_processo` VALUES(100000544, 'Gestao de Contrato: Contrata????o de Menor de 18 anos');
INSERT INTO `tb_tipos_processo` VALUES(100000545, 'Gest??o de Contrato: MGS - Terceirizados');
INSERT INTO `tb_tipos_processo` VALUES(100000546, 'Gest??o de Contrato: Outros Servi??os Postais');
INSERT INTO `tb_tipos_processo` VALUES(100000547, 'Serca/Malote');
INSERT INTO `tb_tipos_processo` VALUES(100000548, 'Servi??o de Encomenda Expressa (Sedex) Nacional e I');
INSERT INTO `tb_tipos_processo` VALUES(100000549, 'Gest??o de TI: Acesso a Sistemas Corporativos');
INSERT INTO `tb_tipos_processo` VALUES(100000550, 'Gest??o de TI: Interven????es em Sistemas Corporativos');
INSERT INTO `tb_tipos_processo` VALUES(100000551, 'Gest??o de TI: Solicita????o de Administrador de Seguran??a');
INSERT INTO `tb_tipos_processo` VALUES(100000552, 'Identifica????o e Regulariza????o de D??bitos de Im??vei');
INSERT INTO `tb_tipos_processo` VALUES(100000553, 'Invent??rios: Bens Im??veis, ve??culos e bens semoven');
INSERT INTO `tb_tipos_processo` VALUES(100000554, 'Licita????o de Bens M??veis: Preg??o Eletr??nico-Regist');
INSERT INTO `tb_tipos_processo` VALUES(100000555, 'Licita????o: Contrata????o de Servi??o');
INSERT INTO `tb_tipos_processo` VALUES(100000556, 'Licita????o: Acordo Judicial - Da????o em Pagamento');
INSERT INTO `tb_tipos_processo` VALUES(100000557, 'Licita????o: Compra');
INSERT INTO `tb_tipos_processo` VALUES(100000558, 'Licita????o: Dispensa');
INSERT INTO `tb_tipos_processo` VALUES(100000559, 'Licita????o: Dispensa por Valor - Cota????o Eletr??nica');
INSERT INTO `tb_tipos_processo` VALUES(100000560, 'Licita????o: Modalidades BIRD / BID');
INSERT INTO `tb_tipos_processo` VALUES(100000561, 'Licita????o: Outras Contrata????es');
INSERT INTO `tb_tipos_processo` VALUES(100000562, 'Projetos de Parcerias P??blico-Privadas (PPP)');
INSERT INTO `tb_tipos_processo` VALUES(100000563, 'Licita????o: Preg??o Presencial-Registro de Pre??o');
INSERT INTO `tb_tipos_processo` VALUES(100000564, 'Licita????o: Registro de Pre??os n??o Realizado no SIR');
INSERT INTO `tb_tipos_processo` VALUES(100000565, 'Licita????o: Registro de Pre??os Realizado no SIRP');
INSERT INTO `tb_tipos_processo` VALUES(100000566, 'Loca????o de Ve??culos');
INSERT INTO `tb_tipos_processo` VALUES(100000567, 'Manifesta????o de Projeto de Lei');
INSERT INTO `tb_tipos_processo` VALUES(100000568, 'Orienta????o aos ??rg??os e Entidades: Pol??ticas e Reg');
INSERT INTO `tb_tipos_processo` VALUES(100000569, 'Orienta????o aos ??rg??os e Entidades: Gest??o da Frota');
INSERT INTO `tb_tipos_processo` VALUES(100000570, 'Permiss??o de Uso de Bens M??veis');
INSERT INTO `tb_tipos_processo` VALUES(100000571, 'Permiss??o de Uso de Ve??culos');
INSERT INTO `tb_tipos_processo` VALUES(100000572, 'Permuta');
INSERT INTO `tb_tipos_processo` VALUES(100000573, 'Processo Oriundo de Outros Setores do CSC');
INSERT INTO `tb_tipos_processo` VALUES(100000574, 'Servi??os de Abastecimento');
INSERT INTO `tb_tipos_processo` VALUES(100000575, 'Servi??os de Engenharia: Anu??ncia de Rio');
INSERT INTO `tb_tipos_processo` VALUES(100000576, 'Servi??os de Engenharia: Avalia????o de Im??veis');
INSERT INTO `tb_tipos_processo` VALUES(100000577, 'Servi??os de Engenharia: Manifesta????o do Estado em ');
INSERT INTO `tb_tipos_processo` VALUES(100000578, 'IEF -Servi??os de Engenharia: Retifica????o de ??rea');
INSERT INTO `tb_tipos_processo` VALUES(100000579, 'Servi??os de Engenharia: Vistoria de Im??veis');
INSERT INTO `tb_tipos_processo` VALUES(100000580, 'Servi??os de Manuten????o Veicular');
INSERT INTO `tb_tipos_processo` VALUES(100000581, 'Servi??os de Transporte');
INSERT INTO `tb_tipos_processo` VALUES(100000582, 'Adjudica????o');
INSERT INTO `tb_tipos_processo` VALUES(100000583, 'Processo Administrativo Punitivo de Fornecedores');
INSERT INTO `tb_tipos_processo` VALUES(100000584, 'Pessoal: Exonera????o de Cargo de Provimento em Comiss??o ou Dispensa de Fun????o Gratificada');
INSERT INTO `tb_tipos_processo` VALUES(100000585, 'Pessoal: Nomea????o');
INSERT INTO `tb_tipos_processo` VALUES(100000586, 'Pessoal: F??rias Pr??mio - Altera????o');
INSERT INTO `tb_tipos_processo` VALUES(100000587, 'Pessoal: F??rias Pr??mio - Interrup????o');
INSERT INTO `tb_tipos_processo` VALUES(100000588, 'Pessoal: F??rias Pr??mio');
INSERT INTO `tb_tipos_processo` VALUES(100000589, 'Pessoal: Uso de Folga Compensativa');
INSERT INTO `tb_tipos_processo` VALUES(100000590, 'Consulta Jur??dica');
INSERT INTO `tb_tipos_processo` VALUES(100000591, 'Atendimento Judici??rio Socioeducativo: Atendimento');
INSERT INTO `tb_tipos_processo` VALUES(100000592, 'Apoio a Encaminhamento de Alta Complexidade');
INSERT INTO `tb_tipos_processo` VALUES(100000593, 'Gest??o de TIC: Infraestrutura de Tecnologia da Informa????o e Comunica????o');
INSERT INTO `tb_tipos_processo` VALUES(100000594, 'Obras P??blicas: Constru????o e Conserva????o de Obras P??blicas');
INSERT INTO `tb_tipos_processo` VALUES(100000595, 'Obras P??blicas: Conv??nio');
INSERT INTO `tb_tipos_processo` VALUES(100000596, 'Processo Cofin');
INSERT INTO `tb_tipos_processo` VALUES(100000598, 'Fiscaliza????o Operacional: Sede ??gua');
INSERT INTO `tb_tipos_processo` VALUES(100000599, 'Normatiza????o: Operacional');
INSERT INTO `tb_tipos_processo` VALUES(100000600, 'Pessoal: Certifica????o de Nada Consta por motivo de');
INSERT INTO `tb_tipos_processo` VALUES(100000601, 'Informe de Eventos de Seguran??a das Unidades');
INSERT INTO `tb_tipos_processo` VALUES(100000602, 'Informa????es: Solicita????es Gerais');
INSERT INTO `tb_tipos_processo` VALUES(100000603, 'Per??cia Oficial: Exames Periciais');
INSERT INTO `tb_tipos_processo` VALUES(100000604, 'Per??cia Oficial: Laudos Periciais');
INSERT INTO `tb_tipos_processo` VALUES(100000605, 'Per??cia Oficial: Procedimentos Operacionais');
INSERT INTO `tb_tipos_processo` VALUES(100000606, 'Per??cia Oficial: Assistente T??cnico');
INSERT INTO `tb_tipos_processo` VALUES(100000607, 'Per??cia Oficial: Articula????o Interinstitucional');
INSERT INTO `tb_tipos_processo` VALUES(100000608, 'Per??cia Oficial: Projetos');
INSERT INTO `tb_tipos_processo` VALUES(100000609, 'Documentos Digitalizados na Ilha Central de Digitaliza????o Cidade Administrativa');
INSERT INTO `tb_tipos_processo` VALUES(100000611, 'Manuten????o de Equipamentos');
INSERT INTO `tb_tipos_processo` VALUES(100000612, 'Preven????o ?? Criminalidade: Media????o de Conflitos');
INSERT INTO `tb_tipos_processo` VALUES(100000613, 'Preven????o ?? Criminalidade: Estudos e Pesquisas');
INSERT INTO `tb_tipos_processo` VALUES(100000614, 'Preven????o ?? Criminalidade: Supervis??o dos Gestores');
INSERT INTO `tb_tipos_processo` VALUES(100000615, 'Desenvolvimento Social: Prote????o da Mulher');
INSERT INTO `tb_tipos_processo` VALUES(100000616, 'Desenvolvimento Social: Inclus??o Social e Promo????o');
INSERT INTO `tb_tipos_processo` VALUES(100000617, 'Conselho Deliberativo de Desenvolvimento da Regi??o');
INSERT INTO `tb_tipos_processo` VALUES(100000618, 'Gest??o de TIC: Sistemas de Informa????es e Aplica????es');
INSERT INTO `tb_tipos_processo` VALUES(100000619, 'Orienta????es aos ??rg??os e Entidades Emitidas por Unidades Centrais');
INSERT INTO `tb_tipos_processo` VALUES(100000620, 'Gest??o de TIC: An??lise das Demandas de Tecnologia ');
INSERT INTO `tb_tipos_processo` VALUES(100000621, 'Gest??o Prodemge');
INSERT INTO `tb_tipos_processo` VALUES(100000622, 'CRV: Segunda Via');
INSERT INTO `tb_tipos_processo` VALUES(100000623, 'CRLV');
INSERT INTO `tb_tipos_processo` VALUES(100000624, 'CNH: Altera????o de dados');
INSERT INTO `tb_tipos_processo` VALUES(100000625, 'Ve??culos: Baixa de Gravame');
INSERT INTO `tb_tipos_processo` VALUES(100000626, 'Ve??culos: Inclus??o e Baixa de Comunica????o de Venda');
INSERT INTO `tb_tipos_processo` VALUES(100000627, 'Ve??culos: Retorno de propriedade');
INSERT INTO `tb_tipos_processo` VALUES(100000628, 'Ve??culos: Baixa Definitiva');
INSERT INTO `tb_tipos_processo` VALUES(100000629, 'Ve??culos: Destitui????o de Propriedade');
INSERT INTO `tb_tipos_processo` VALUES(100000630, 'Ve??culos: Transf??rencia de Jurisdi????o');
INSERT INTO `tb_tipos_processo` VALUES(100000631, 'CNH: Baixa e transfer??ncia de Pontua????o');
INSERT INTO `tb_tipos_processo` VALUES(100000632, 'CNH: Baixa e suspens??o de multa');
INSERT INTO `tb_tipos_processo` VALUES(100000633, 'CNH: Suspens??o do direito de dirigir-novos exames');
INSERT INTO `tb_tipos_processo` VALUES(100000634, 'CNH: PAP e PAI');
INSERT INTO `tb_tipos_processo` VALUES(100000635, 'Ve??culos: Baixa de D??bito');
INSERT INTO `tb_tipos_processo` VALUES(100000636, 'Credenciamento de F??brica de Placas');
INSERT INTO `tb_tipos_processo` VALUES(100000637, 'Credenciamento de CFC');
INSERT INTO `tb_tipos_processo` VALUES(100000638, 'Ve??culos: Bloqueio de Ve??culo');
INSERT INTO `tb_tipos_processo` VALUES(100000639, 'Ve??culos: Libera????o de Ve??culos');
INSERT INTO `tb_tipos_processo` VALUES(100000640, 'CNH: Pesquisa Condutor');
INSERT INTO `tb_tipos_processo` VALUES(100000641, 'Ve??culos: Pesquisa Ve??culo');
INSERT INTO `tb_tipos_processo` VALUES(100000642, 'Ve??culos: Averba????o');
INSERT INTO `tb_tipos_processo` VALUES(100000643, 'CNH: transferencia de CNH - Outro Estado');
INSERT INTO `tb_tipos_processo` VALUES(100000644, 'Ve??culos: Leil??o');
INSERT INTO `tb_tipos_processo` VALUES(100000645, 'Gest??o de Atas de Registro de Pre??os');
INSERT INTO `tb_tipos_processo` VALUES(100000646, 'Avalia????o de Mercado');
INSERT INTO `tb_tipos_processo` VALUES(100000647, 'Comunica????o: Interna');
INSERT INTO `tb_tipos_processo` VALUES(100000649, 'Pessoal: Acr??scimo de Efetivo');
INSERT INTO `tb_tipos_processo` VALUES(100000650, 'A????es Judiciais: Mandado de Pris??o');
INSERT INTO `tb_tipos_processo` VALUES(100000651, 'A????es Policiais: Folha de Antecedentes Criminais');
INSERT INTO `tb_tipos_processo` VALUES(100000652, 'A????es Policiais: Carta Precat??ria');
INSERT INTO `tb_tipos_processo` VALUES(100000653, 'A????es Policiais: Carteira de Identidade');
INSERT INTO `tb_tipos_processo` VALUES(100000654, 'A????es Policias: Rela????o de ??bitos');
INSERT INTO `tb_tipos_processo` VALUES(100000655, 'A????es Policiais:  Plant??o Regionalizado');
INSERT INTO `tb_tipos_processo` VALUES(100000656, 'Organiza????o e Funcionamento do ??rg??o: Normas, Regulamentos, Diretrizes ou Procedimentos');
INSERT INTO `tb_tipos_processo` VALUES(100000657, 'Administra????o Geral: Instala????o de Unidade Policia');
INSERT INTO `tb_tipos_processo` VALUES(100000658, 'Gest??o de Conv??nios - Entre unidades Governamentais e n??o Governamentais');
INSERT INTO `tb_tipos_processo` VALUES(100000659, 'Conv??nios/Ajustes: Termo de Colabora????o');
INSERT INTO `tb_tipos_processo` VALUES(100000660, 'Gest??o de Im??veis: Energia');
INSERT INTO `tb_tipos_processo` VALUES(100000661, 'Cadastramento de Usu??rios Externos');
INSERT INTO `tb_tipos_processo` VALUES(100000662, 'Licita????o: Leil??o - Credenciamento de Arrematantes');
INSERT INTO `tb_tipos_processo` VALUES(100000663, 'Indeniza????o');
INSERT INTO `tb_tipos_processo` VALUES(100000664, 'Licita????o: Leil??o - Processo Administrativo Puniti');
INSERT INTO `tb_tipos_processo` VALUES(100000665, 'Patrim??nio: Desaparecimento ou Avaria de Bens');
INSERT INTO `tb_tipos_processo` VALUES(100000666, 'Solicita????o de Doa????o de Ve??culos Usados - P??tio G');
INSERT INTO `tb_tipos_processo` VALUES(100000667, 'Solicita????o de Doa????o Bens Usados  (exceto ve??culo');
INSERT INTO `tb_tipos_processo` VALUES(100000668, 'Demanda Externa: Tribunal de Contas do Estado');
INSERT INTO `tb_tipos_processo` VALUES(100000669, 'Conselho de Administra????o de Pessoal (CAP)');
INSERT INTO `tb_tipos_processo` VALUES(100000670, 'Viagem a Servi??o: Com ??nus para a institui????o');
INSERT INTO `tb_tipos_processo` VALUES(100000671, 'Viagem: Presta????o de Contas de Adiantamento');
INSERT INTO `tb_tipos_processo` VALUES(100000672, 'Governo Aberto, Transpar??ncia e Controle Social');
INSERT INTO `tb_tipos_processo` VALUES(100000673, 'Pessoal: F??rias Pr??mio - Concess??o');
INSERT INTO `tb_tipos_processo` VALUES(100000674, 'Pessoal: Requerimento para ausentar-se do Pa??s');
INSERT INTO `tb_tipos_processo` VALUES(100000675, 'Tomada de Contas Especial');
INSERT INTO `tb_tipos_processo` VALUES(100000676, 'Per??cia Oficial: Transfer??ncia de Material');
INSERT INTO `tb_tipos_processo` VALUES(100000678, 'Informa????es: Operacionais');
INSERT INTO `tb_tipos_processo` VALUES(100000679, 'Informa????es: Econ??mico-financeiras');
INSERT INTO `tb_tipos_processo` VALUES(100000680, 'Homologa????o de Documentos: Operacional');
INSERT INTO `tb_tipos_processo` VALUES(100000681, 'Fiscaliza????o Operacional: Sede Esgoto');
INSERT INTO `tb_tipos_processo` VALUES(100000682, 'Fiscaliza????o Operacional: Distrito ??gua');
INSERT INTO `tb_tipos_processo` VALUES(100000683, 'Fiscaliza????o Operacional: Distrito Esgoto');
INSERT INTO `tb_tipos_processo` VALUES(100000684, 'SEPLAG - Celebra????o de Contratos Mais Asfalto - Mu');
INSERT INTO `tb_tipos_processo` VALUES(100000685, 'Pessoal: Pasta Funcional Digital');
INSERT INTO `tb_tipos_processo` VALUES(100000686, 'Funcionamento Escolar: Documenta????o');
INSERT INTO `tb_tipos_processo` VALUES(100000687, 'Processo Judicial');
INSERT INTO `tb_tipos_processo` VALUES(100000688, 'RH: Posicionamento / Reposicionamento');
INSERT INTO `tb_tipos_processo` VALUES(100000689, 'RH: Contrata????o para Atender a Necessidade Tempor??ria de Excepcional Interesse P??blico');
INSERT INTO `tb_tipos_processo` VALUES(100000690, 'Pessoal: Ajustamento Funcional');
INSERT INTO `tb_tipos_processo` VALUES(100000691, 'Pessoal: Agendamento de Junta M??dica');
INSERT INTO `tb_tipos_processo` VALUES(100000692, 'Pessoal: Perfil Profissiogr??fico Previdenci??rio');
INSERT INTO `tb_tipos_processo` VALUES(100000693, 'Pessoal: Acolhimento Psicol??gico ao Servidor');
INSERT INTO `tb_tipos_processo` VALUES(100000694, 'Assist??ncia M??dica IPSEMG');
INSERT INTO `tb_tipos_processo` VALUES(100000695, 'Pessoal: Altera????o de Dados Funcionais');
INSERT INTO `tb_tipos_processo` VALUES(100000696, 'Pessoal: Cadastro de Dependentes do Servidor');
INSERT INTO `tb_tipos_processo` VALUES(100000697, 'Despesas dos Exerc??cios Anteriores (DEA)');
INSERT INTO `tb_tipos_processo` VALUES(100000698, 'Gest??o de Contrato: Encerramento');
INSERT INTO `tb_tipos_processo` VALUES(100000699, 'Finan??as: Execu????o Financeira da Despesa');
INSERT INTO `tb_tipos_processo` VALUES(100000700, 'Documentos Digitalizados no Protocolo/Apoio Administrativo');
INSERT INTO `tb_tipos_processo` VALUES(100000701, 'Pessoal: Pens??o Especial (SEF)');
INSERT INTO `tb_tipos_processo` VALUES(100000702, 'Pessoal: Reenquadramento');
INSERT INTO `tb_tipos_processo` VALUES(100000703, 'Pessoal: Licen??a ?? Gestante');
INSERT INTO `tb_tipos_processo` VALUES(100000704, 'Pessoal: Jeton');
INSERT INTO `tb_tipos_processo` VALUES(100000705, 'Pessoal: Licen??a Para Acompanhar C??njuge');
INSERT INTO `tb_tipos_processo` VALUES(100000706, 'Pessoal: Licen??a Para Tratamento de Sa??de');
INSERT INTO `tb_tipos_processo` VALUES(100000707, 'Pessoal: Quinqu??nio');
INSERT INTO `tb_tipos_processo` VALUES(100000708, 'Pessoal: Ac??mulo de Cargos');
INSERT INTO `tb_tipos_processo` VALUES(100000709, 'RH: Altera????o de Carga Hor??ria');
INSERT INTO `tb_tipos_processo` VALUES(100000710, 'Pessoal: Previd??ncia Complementar');
INSERT INTO `tb_tipos_processo` VALUES(100000711, 'Pessoal: Participa????o em Evento, Treinamento, Curso ou Miss??o');
INSERT INTO `tb_tipos_processo` VALUES(100000712, 'RH: T??tulo Declarat??rio de Apostilamento');
INSERT INTO `tb_tipos_processo` VALUES(100000713, 'Pessoal: Elabora????o de Pol??ticas de Recursos Humanos');
INSERT INTO `tb_tipos_processo` VALUES(100000714, 'Pessoal: Nomea????o/Exonera????o Judicial');
INSERT INTO `tb_tipos_processo` VALUES(100000715, 'Cumprimento de Decis??o Judicial');
INSERT INTO `tb_tipos_processo` VALUES(100000716, 'Pessoal: Rescis??o de Contrato (Lei 18.185/2009)');
INSERT INTO `tb_tipos_processo` VALUES(100000717, 'Pessoal: Promo????o por Escolaridade Adicional');
INSERT INTO `tb_tipos_processo` VALUES(100000718, 'Aquisi????o: Contrata????es de Material Permanente e de Consumo (Pronto Pagamento)');
INSERT INTO `tb_tipos_processo` VALUES(100000719, 'Finan??as: Convalida????o de Documentos da Execu????o O');
INSERT INTO `tb_tipos_processo` VALUES(100000720, 'Conselho Curador');
INSERT INTO `tb_tipos_processo` VALUES(100000723, 'IDENE -  Perfura????o de Po??os Tubulares para Prefei');
INSERT INTO `tb_tipos_processo` VALUES(100000724, 'Moderniza????o Institucional: Celebra????o de Termos de Parceria');
INSERT INTO `tb_tipos_processo` VALUES(100000725, 'Hemoterapia');
INSERT INTO `tb_tipos_processo` VALUES(100000726, 'Hematologia');
INSERT INTO `tb_tipos_processo` VALUES(100000727, 'C??lulas e Tecidos Biol??gicos');
INSERT INTO `tb_tipos_processo` VALUES(100000728, 'Doa????o de Bens M??veis');
INSERT INTO `tb_tipos_processo` VALUES(100000729, 'Comiss??es Intergestores (CIB/CIRA/CIR)');
INSERT INTO `tb_tipos_processo` VALUES(100000730, 'Incentivo a Projetos Esportivos por Meio de Ren??nc');
INSERT INTO `tb_tipos_processo` VALUES(100000731, 'ICMS Esportivo');
INSERT INTO `tb_tipos_processo` VALUES(100000732, '??ndice Mineiro de Desenvolvimento Esportivo');
INSERT INTO `tb_tipos_processo` VALUES(100000733, 'Corregedoria: Processo Administrativo de Responsab');
INSERT INTO `tb_tipos_processo` VALUES(100000734, 'IEF - Servi??o de Engenharia: Anu??ncia INCRA');
INSERT INTO `tb_tipos_processo` VALUES(100000735, 'RH: Reabilita????o');
INSERT INTO `tb_tipos_processo` VALUES(100000736, 'Finan??as: Ateste de Notas Fiscais');
INSERT INTO `tb_tipos_processo` VALUES(100000737, 'Requerimento de Contribuinte');
INSERT INTO `tb_tipos_processo` VALUES(100000738, 'Pessoal: Inclus??o/Altera????o de Dados no SISAP');
INSERT INTO `tb_tipos_processo` VALUES(100000739, 'Pessoal: Afastamento Preliminar ?? Aposentadoria');
INSERT INTO `tb_tipos_processo` VALUES(100000740, 'Gest??o de Contrato: Apostilamento');
INSERT INTO `tb_tipos_processo` VALUES(100000741, 'Pedido de Informa????o');
INSERT INTO `tb_tipos_processo` VALUES(100000742, 'Seguran??a P??blica: Estat??stica e an??lise criminal');
INSERT INTO `tb_tipos_processo` VALUES(100000743, 'Seguran??a P??blica: Classifica????o e an??lise datilos');
INSERT INTO `tb_tipos_processo` VALUES(100000744, 'Seguran??a P??blica: Identifica????o Externa');
INSERT INTO `tb_tipos_processo` VALUES(100000745, 'Seguran??a P??blica: Emiss??o de Carteiras');
INSERT INTO `tb_tipos_processo` VALUES(100000746, 'Contrata????o de Terceiros para Servi??os de Assist??n');
INSERT INTO `tb_tipos_processo` VALUES(100000747, 'Seguran??a P??blica: ??bitos');
INSERT INTO `tb_tipos_processo` VALUES(100000748, 'Publica????o e Processamento de Atos Normativos e Resolu????es');
INSERT INTO `tb_tipos_processo` VALUES(100000749, 'Seguran??a P??blica: Pesquisas e confronto datilosc??');
INSERT INTO `tb_tipos_processo` VALUES(100000750, 'RH: Processo Administrativo Resolu????o - SEPLAG n?? 37/2005 (inclusive Cobran??a de d??bito)');
INSERT INTO `tb_tipos_processo` VALUES(100000751, 'Pessoal: Orienta????es sobre Direitos e Benef??cios dos Servidores');
INSERT INTO `tb_tipos_processo` VALUES(100000752, 'RH: Atribui????o ou Dispensa de Gratifica????o Tempor??ria Estrat??gica (GTED)');
INSERT INTO `tb_tipos_processo` VALUES(100000753, 'Pessoal: Atribui????o ou Dispensa de Chefia de ??rg??o, Entidade ou Unidade Administrativa');
INSERT INTO `tb_tipos_processo` VALUES(100000754, 'Solicita????o de Adiantamento em Viagens');
INSERT INTO `tb_tipos_processo` VALUES(100000755, 'RH: Licen??a p/ Afast. Remunerado de Servidor P??b. Candidato a Elei????o Municipal, Estadual e Federal');
INSERT INTO `tb_tipos_processo` VALUES(100000756, 'RH: Afastamento por Motivo de Casamento');
INSERT INTO `tb_tipos_processo` VALUES(100000757, 'SESP - Interna????o Provis??ria');
INSERT INTO `tb_tipos_processo` VALUES(100000758, 'Pessoal: Vencimentos Deixados');
INSERT INTO `tb_tipos_processo` VALUES(100000759, 'RH: Afastamento por Motivo de Luto');
INSERT INTO `tb_tipos_processo` VALUES(100000760, 'RH: Licen??a Paternidade');
INSERT INTO `tb_tipos_processo` VALUES(100000761, 'RH: Licen??a ?? Gestante');
INSERT INTO `tb_tipos_processo` VALUES(100000762, 'Pessoal: Adicional Trinten??rio');
INSERT INTO `tb_tipos_processo` VALUES(100000763, 'RH: Ordem de Pagamento Especial (OPE)');
INSERT INTO `tb_tipos_processo` VALUES(100000768, 'Patrim??nio: Loca????o (imobili??rio)');
INSERT INTO `tb_tipos_processo` VALUES(100000777, 'RH: Concurso P??blico - Homologa????o');
INSERT INTO `tb_tipos_processo` VALUES(100000778, 'RH: Concurso P??blico - Solicita????o de Realiza????o');
INSERT INTO `tb_tipos_processo` VALUES(100000779, 'RH: Concurso P??blico - Autoriza????o de Nomea????o de ');
INSERT INTO `tb_tipos_processo` VALUES(100000780, 'RH: Concurso P??blico - Autoriza????o de Realiza????o');
INSERT INTO `tb_tipos_processo` VALUES(100000781, 'RH: Nomea????o - Cargo Efetivo');
INSERT INTO `tb_tipos_processo` VALUES(100000782, 'RH: Pr??mios, Concess??es de Medalhas, Diplomas de Honra ao M??rito, Elogios');
INSERT INTO `tb_tipos_processo` VALUES(100000783, 'RH: Pasta Funcional F??sica - Migra????o de Passivo');
INSERT INTO `tb_tipos_processo` VALUES(100000784, 'RH: Processamento de Processo Administrativo Disciplinar (PAD) conclu??do');
INSERT INTO `tb_tipos_processo` VALUES(100000787, 'RH: Conv??nio n??o Oneroso para Concess??o de Benef??c');
INSERT INTO `tb_tipos_processo` VALUES(100000788, 'RH: Concess??o de F??rias Pr??mio');
INSERT INTO `tb_tipos_processo` VALUES(100000789, 'RH: Gozo de F??rias Pr??mio');
INSERT INTO `tb_tipos_processo` VALUES(100000800, 'RH: Remo????o a Pedido por Interesse Pessoal');
INSERT INTO `tb_tipos_processo` VALUES(100000801, 'RH: Remo????o a Pedido por Motivo de Sa??de');
INSERT INTO `tb_tipos_processo` VALUES(100000802, 'RH: Remo????o Ex-Officio');
INSERT INTO `tb_tipos_processo` VALUES(100000803, 'RH: Remo????o a Pedido por Permuta');
INSERT INTO `tb_tipos_processo` VALUES(100000804, 'RH: Afastamento do trabalho para estudo ou aperfei??oamento profissional');
INSERT INTO `tb_tipos_processo` VALUES(100000805, 'IDENE - Doa????o de Caixas D\'??gua Met??lica');
INSERT INTO `tb_tipos_processo` VALUES(100000806, 'RH: Reposit??rio de bases de conhecimento');
INSERT INTO `tb_tipos_processo` VALUES(100000807, 'IPEM - Credenciamento de oficina');
INSERT INTO `tb_tipos_processo` VALUES(100000808, 'Controle das Atividades Cont??beis: Relat??rio de Co');
INSERT INTO `tb_tipos_processo` VALUES(100000809, 'RH: Frequ??ncia');
INSERT INTO `tb_tipos_processo` VALUES(100000810, 'Pessoal: Gratifica????o Complementar de Produtividade (GCP)');
INSERT INTO `tb_tipos_processo` VALUES(100000811, 'Or??amento: Reestabelecimento de Restos a Pagar');
INSERT INTO `tb_tipos_processo` VALUES(100000812, 'RH: Concurso P??blico - Institui????o de comiss??o esp');
INSERT INTO `tb_tipos_processo` VALUES(100000813, 'Or??amento: Levantamento de Informa????es (PPAG-LOA)');
INSERT INTO `tb_tipos_processo` VALUES(100000814, 'RH: Requerimento altera????o de endere??o');
INSERT INTO `tb_tipos_processo` VALUES(100000816, 'RH: Reuni??o de inst??ncia colegiada');
INSERT INTO `tb_tipos_processo` VALUES(100000817, 'RH: Emiss??o de Certid??es e Declara????es');
INSERT INTO `tb_tipos_processo` VALUES(100000818, 'RH: Requerimento Altera????o de Nome');
INSERT INTO `tb_tipos_processo` VALUES(100000819, 'RH: Altera????o de conta banc??ria para pagamento do ');
INSERT INTO `tb_tipos_processo` VALUES(100000820, 'RH: Requerimento de certid??es de pag. pessoal');
INSERT INTO `tb_tipos_processo` VALUES(100000821, 'RH: Est??gio');
INSERT INTO `tb_tipos_processo` VALUES(100000822, 'RH: Estagi??rio');
INSERT INTO `tb_tipos_processo` VALUES(100000823, 'Solicita????o de Medicamento CEAF');
INSERT INTO `tb_tipos_processo` VALUES(100000824, 'RH: Posse e Exerc??cio - Cargo efetivo');
INSERT INTO `tb_tipos_processo` VALUES(100000825, 'RH: Recadastramento');
INSERT INTO `tb_tipos_processo` VALUES(100000826, 'RH: Requerimento de F??rias Regulamentares');
INSERT INTO `tb_tipos_processo` VALUES(100000827, 'RH: Req. Altera????o de F??rias Regulamentares');
INSERT INTO `tb_tipos_processo` VALUES(100000828, 'RH: Concess??o de Quinqu??nio');
INSERT INTO `tb_tipos_processo` VALUES(100000829, 'RH: Licen??a para Acompanhar C??njuge (LAC)');
INSERT INTO `tb_tipos_processo` VALUES(100000830, 'RH: Aposentadoria - Pr??via');
INSERT INTO `tb_tipos_processo` VALUES(100000831, 'RH: Concess??o de Adicional por Tempo de Servi??o');
INSERT INTO `tb_tipos_processo` VALUES(100000832, 'RH: Est??gio Curricular Obrigat??rio do Curso Superior de Administra????o P??blica da FJP');
INSERT INTO `tb_tipos_processo` VALUES(100000833, 'Licita????o: Procedimento das Estatais (Lei 13.303/2');
INSERT INTO `tb_tipos_processo` VALUES(100000834, 'Licita????o: Credenciamento');
INSERT INTO `tb_tipos_processo` VALUES(100000835, 'Licita????o: COTEP');
INSERT INTO `tb_tipos_processo` VALUES(100000836, 'Recupera????o de Cr??dito');
INSERT INTO `tb_tipos_processo` VALUES(100000837, 'SEMAD Protocolo SUPRAM - TM');
INSERT INTO `tb_tipos_processo` VALUES(100000838, 'SEMAD Protocolo SUPRAM - SUL');
INSERT INTO `tb_tipos_processo` VALUES(100000839, 'SEMAD Protocolo SUPRAM - CENTRAL');
INSERT INTO `tb_tipos_processo` VALUES(100000840, 'Assessoramento T??cnico-Legislativo - Projeto de Le');
INSERT INTO `tb_tipos_processo` VALUES(100000841, 'Assessoramento T??cnico-Legislativo - Mensagem do G');
INSERT INTO `tb_tipos_processo` VALUES(100000842, 'Seguran??a Alimentar e Apoio ?? Agricultura Familiar');
INSERT INTO `tb_tipos_processo` VALUES(100000843, 'Desenvolvimento Rural Sustent??vel: Cadeias Produti');
INSERT INTO `tb_tipos_processo` VALUES(100000844, 'Desenvolvimento Rural Sustent??vel: Cadeias Produti');
INSERT INTO `tb_tipos_processo` VALUES(100000845, 'Desenvolvimento Rural Sustent??vel: Engenharia e Lo');
INSERT INTO `tb_tipos_processo` VALUES(100000846, 'Desenvolvimento Rural Sustent??vel: Agricultura Irr');
INSERT INTO `tb_tipos_processo` VALUES(100000847, 'Pedidos, Oferecimentos e Informa????es Diversas: Deputado Estadual');
INSERT INTO `tb_tipos_processo` VALUES(100000848, 'RH: Posse - Cargo/Fun????o/Gratifica????o');
INSERT INTO `tb_tipos_processo` VALUES(100000849, 'RH: Convers??o de F??rias Pr??mio em Esp??cie');
INSERT INTO `tb_tipos_processo` VALUES(100000850, 'SETOP: Concess??o Rodovi??ria');
INSERT INTO `tb_tipos_processo` VALUES(100000851, 'Desenvolvimento do Setor Produtivo: Atra????o de Inv');
INSERT INTO `tb_tipos_processo` VALUES(100000852, 'Pedidos, Oferecimentos e Informa????es Diversas: Judici??rio');
INSERT INTO `tb_tipos_processo` VALUES(100000853, 'Pedidos, Oferecimentos e Informa????es Diversas: Cidad??o (Pessoa F??sica)');
INSERT INTO `tb_tipos_processo` VALUES(100000854, 'Pedidos, Oferecimentos e Informa????es Diversas: Entidades Privadas');
INSERT INTO `tb_tipos_processo` VALUES(100000855, 'Pedidos, Oferecimentos e Informa????es Diversas: Deputado Federal');
INSERT INTO `tb_tipos_processo` VALUES(100000856, 'Pedidos, Oferecimentos e Informa????es Diversas: Minist??rio P??blico Estadual');
INSERT INTO `tb_tipos_processo` VALUES(100000857, 'Pedidos, Oferecimentos e Informa????es Diversas: ??rg??os Governamentais Estaduais');
INSERT INTO `tb_tipos_processo` VALUES(100000858, 'Pedidos, Oferecimentos e Informa????es Diversas: ??rg??os Governamentais Federais');
INSERT INTO `tb_tipos_processo` VALUES(100000859, 'Pedidos, Oferecimentos e Informa????es Diversas: ??rg??os Governamentais Municipais');
INSERT INTO `tb_tipos_processo` VALUES(100000860, 'Pedidos, Oferecimentos e Informa????es Diversas: Sen');
INSERT INTO `tb_tipos_processo` VALUES(100000861, 'Pedidos, Oferecimentos e Informa????es Diversas: Tribunal de Contas do Estado');
INSERT INTO `tb_tipos_processo` VALUES(100000862, 'Pedidos, Oferecimentos e Informa????es Diversas:  Vereador/C??mara Municipal');
INSERT INTO `tb_tipos_processo` VALUES(100000863, 'Pedidos, Oferecimentos e Informa????es Diversas');
INSERT INTO `tb_tipos_processo` VALUES(100000864, 'Pedidos, Oferecimentos e Informa????es Diversas:  Minist??rio P??blico Federal');
INSERT INTO `tb_tipos_processo` VALUES(100000865, 'RH: Altera????o de dados IRPF');
INSERT INTO `tb_tipos_processo` VALUES(100000866, 'RH: Pens??o Libertas');
INSERT INTO `tb_tipos_processo` VALUES(100000867, 'Vigil??ncia Sanit??ria');
INSERT INTO `tb_tipos_processo` VALUES(100000868, 'RH: Cadastro de Vinculado');
INSERT INTO `tb_tipos_processo` VALUES(100000869, 'Contrata????es de Servi??os: Aquisi????o de Servi??os');
INSERT INTO `tb_tipos_processo` VALUES(100000870, 'VE??CULOS: Multas');
INSERT INTO `tb_tipos_processo` VALUES(100000871, 'RH: Efetiva????o');
INSERT INTO `tb_tipos_processo` VALUES(100000872, 'RH: Afastamento do trabalho para estudo ou aperfei??oamento profissional - PRORROGA????O');
INSERT INTO `tb_tipos_processo` VALUES(100000873, 'Licenciamento Ambiental Simplificado');
INSERT INTO `tb_tipos_processo` VALUES(100000874, 'Implementa????o de Pol??ticas de Ci??ncia e Tecnologia');
INSERT INTO `tb_tipos_processo` VALUES(100000875, 'Produ????o de Tecnologias de Correi????o: Desenvolvime');
INSERT INTO `tb_tipos_processo` VALUES(100000876, 'Produ????o de Tecnologias de Correi????o: Divulga????o');
INSERT INTO `tb_tipos_processo` VALUES(100000877, '??tica');
INSERT INTO `tb_tipos_processo` VALUES(100000878, 'Recebimento e An??lise de Den??ncia de Correi????o');
INSERT INTO `tb_tipos_processo` VALUES(100000879, 'Processamento de Dados Estat??sticos de Correi????o A');
INSERT INTO `tb_tipos_processo` VALUES(100000880, 'Cria????o e Revis??o de Manuais. T??cnicas e Rotinas d');
INSERT INTO `tb_tipos_processo` VALUES(100000881, 'Cat??logo de Materiais');
INSERT INTO `tb_tipos_processo` VALUES(100000882, 'Cadastro de Fornecedores Impedidos de Licitar e Co');
INSERT INTO `tb_tipos_processo` VALUES(100000883, 'Patrim??nio: Transfer??ncia Direta Bens M??veis (Incl');
INSERT INTO `tb_tipos_processo` VALUES(100000884, 'Reembolso de Despesas: Outros Reembolsos');
INSERT INTO `tb_tipos_processo` VALUES(100000885, 'RH: Convoca????o para Retorno de F??rias');
INSERT INTO `tb_tipos_processo` VALUES(100000886, 'Acessos de Usu??rios/Servidores nos Portais Institucionais');
INSERT INTO `tb_tipos_processo` VALUES(100000887, 'RH: Substitui????o Tempor??ria');
INSERT INTO `tb_tipos_processo` VALUES(100000888, 'RH: Afastamento Volunt??rio Incentivado (AVI)');
INSERT INTO `tb_tipos_processo` VALUES(100000889, 'RH: Exonera????o de Cargo Efetivo ou Dispensa de Fun');
INSERT INTO `tb_tipos_processo` VALUES(100000890, 'Controle das Informa????es da Intelig??ncia Prisional');
INSERT INTO `tb_tipos_processo` VALUES(100000891, 'Intelig??ncia Prisional: Investiga????o Social');
INSERT INTO `tb_tipos_processo` VALUES(100000892, 'Assist??ncia ao Preso: Documentos t??cnicos');
INSERT INTO `tb_tipos_processo` VALUES(100000893, 'Assist??ncia ao Preso: Documentos financeiros');
INSERT INTO `tb_tipos_processo` VALUES(100000894, 'Cogest??o Prisional: Documentos t??cnicos');
INSERT INTO `tb_tipos_processo` VALUES(100000895, 'Cogest??o Prisional: Documentos financeiros');
INSERT INTO `tb_tipos_processo` VALUES(100000896, 'Administra????o Prisional: Indicadores de Desempenho');
INSERT INTO `tb_tipos_processo` VALUES(100000897, 'Administra????o Prisional: Gest??o de Projetos');
INSERT INTO `tb_tipos_processo` VALUES(100000898, 'Administra????o Prisional: Comiss??o T??cnica de Classifica????o (CTC)');
INSERT INTO `tb_tipos_processo` VALUES(100000899, 'Administra????o Prisional: Supervis??o das Comiss??es T??cnicas de Classifica????o(CTC)');
INSERT INTO `tb_tipos_processo` VALUES(100000900, 'Classifica????o T??cnica do Preso');
INSERT INTO `tb_tipos_processo` VALUES(100000901, 'Projetos para Atendimento ?? Sa??de do Preso');
INSERT INTO `tb_tipos_processo` VALUES(100000902, 'Prontu??rio M??dico do Preso');
INSERT INTO `tb_tipos_processo` VALUES(100000903, 'Sa??de do Preso: Controle de Estoque. Distribui????o ');
INSERT INTO `tb_tipos_processo` VALUES(100000904, 'Sa??de do Preso: Mapa de Medicamentos');
INSERT INTO `tb_tipos_processo` VALUES(100000905, 'Sa??de do Preso: Controle de Estoque. Distribui????o ');
INSERT INTO `tb_tipos_processo` VALUES(100000906, 'Sa??de do preso: Controle Epidemiol??gico');
INSERT INTO `tb_tipos_processo` VALUES(100000907, 'Atendimento. Cadastramento de Familiares e Companh');
INSERT INTO `tb_tipos_processo` VALUES(100000908, 'Gest??o dos Estabelecimentos de Sa??de das Unidades ');
INSERT INTO `tb_tipos_processo` VALUES(100000909, 'Sa??de do preso: Cadastro das Equipes de Sa??de');
INSERT INTO `tb_tipos_processo` VALUES(100000910, 'Transfer??ncia de Preso para Tratamento de Sa??de');
INSERT INTO `tb_tipos_processo` VALUES(100000911, 'Atendimento Jur??dico. Apoio ao Preso');
INSERT INTO `tb_tipos_processo` VALUES(100000912, 'Administra????o Prisional: Relat??rio Di??rio de Ocorr');
INSERT INTO `tb_tipos_processo` VALUES(100000913, 'Administra????o Prisional: Escolta Externa de Alta P');
INSERT INTO `tb_tipos_processo` VALUES(100000914, 'Interven????es Especializadas. Escoltas de Alta Peri');
INSERT INTO `tb_tipos_processo` VALUES(100000915, 'Interven????o T??tica e/ou Administrativa na Unidade ');
INSERT INTO `tb_tipos_processo` VALUES(100000916, 'Administra????o Prisional: Escolta Externa');
INSERT INTO `tb_tipos_processo` VALUES(100000917, 'Administra????o Prisional: Preven????o de Seguran??a Ex');
INSERT INTO `tb_tipos_processo` VALUES(100000918, 'Administra????o Prisional: Interven????o de Emerg??ncia');
INSERT INTO `tb_tipos_processo` VALUES(100000919, 'Administra????o Prisional: Gest??o de Seguran??a Externa');
INSERT INTO `tb_tipos_processo` VALUES(100000920, 'Administra????o Prisional: Seguran??a Interna - Seguran??a Geral');
INSERT INTO `tb_tipos_processo` VALUES(100000921, 'Seguran??a Interna: Seguran??a Preventiva');
INSERT INTO `tb_tipos_processo` VALUES(100000922, 'Administra????o Prisional: Controle de Distribui????o. Uso de Equipamentos de Seguran??a');
INSERT INTO `tb_tipos_processo` VALUES(100000923, 'Administra????o Prisional: Distribui????o de Agentes de Seguran??a');
INSERT INTO `tb_tipos_processo` VALUES(100000924, 'Admiss??o do Preso');
INSERT INTO `tb_tipos_processo` VALUES(100000925, 'Administra????o Prisional: Revista em Servidores,Vis');
INSERT INTO `tb_tipos_processo` VALUES(100000926, 'Visita ao Preso');
INSERT INTO `tb_tipos_processo` VALUES(100000927, 'Administra????o Prisional: Vistoria em Ve??culos de P');
INSERT INTO `tb_tipos_processo` VALUES(100000928, 'Controle de Presos Foragidos da Unidade Prisional');
INSERT INTO `tb_tipos_processo` VALUES(100000929, 'Gest??o de Vagas: Matr??cula e Transfer??ncia de Presos');
INSERT INTO `tb_tipos_processo` VALUES(100000930, 'Gest??o de Vagas: Ocupa????o das Unidades Prisionais');
INSERT INTO `tb_tipos_processo` VALUES(100000931, 'Administra????o Prisional: Prontu??rio Geral Padroniz');
INSERT INTO `tb_tipos_processo` VALUES(100000932, 'Ensino e Profissionaliza????o: Frequ??ncia do Preso');
INSERT INTO `tb_tipos_processo` VALUES(100000933, 'Institui????o de Ensino na Unidade Prisional: Avalia');
INSERT INTO `tb_tipos_processo` VALUES(100000934, 'Obras Realizadas pelo ??rg??o: Documentos T??cnicos');
INSERT INTO `tb_tipos_processo` VALUES(100000935, 'Obras Realizadas pelo ??rg??o: Documentos Financeiro');
INSERT INTO `tb_tipos_processo` VALUES(100000936, 'Obras Realizadas pelo ??rg??o: Celebra????o de Conv??ni');
INSERT INTO `tb_tipos_processo` VALUES(100000937, 'Repasse de Verba e Doa????o para Execu????o de Obras: ');
INSERT INTO `tb_tipos_processo` VALUES(100000938, 'Repasse de Verba e Doa????o para Execu????o de Obras: ');
INSERT INTO `tb_tipos_processo` VALUES(100000939, 'Repasse de Verbas Federais para Execu????o de Obras:');
INSERT INTO `tb_tipos_processo` VALUES(100000940, 'Repasse de Verbas Federais para Execu????o de Obras:');
INSERT INTO `tb_tipos_processo` VALUES(100000941, 'Estudos, Programas e Projetos de Obras P??blicas: P');
INSERT INTO `tb_tipos_processo` VALUES(100000942, 'Estudos, Programas e Projetos de Obras P??blicas: P');
INSERT INTO `tb_tipos_processo` VALUES(100000943, 'Estudos e Programas de Obras P??blicas');
INSERT INTO `tb_tipos_processo` VALUES(100000944, 'Constru????o e Conserva????o de Obras P??blicas: Levant');
INSERT INTO `tb_tipos_processo` VALUES(100000945, 'RH: Carteira de Identidade Funcional e outras Identifica????es');
INSERT INTO `tb_tipos_processo` VALUES(100000946, 'RH: Certid??o Nada Consta - sem pend??ncias');
INSERT INTO `tb_tipos_processo` VALUES(100000947, 'RH: Certid??o Nada Consta - com pend??ncias');
INSERT INTO `tb_tipos_processo` VALUES(100000948, 'RH: Posse e Exerc??cio - Cargo Comissionado');
INSERT INTO `tb_tipos_processo` VALUES(100000949, 'Pol??tica Ambiental');
INSERT INTO `tb_tipos_processo` VALUES(100000950, 'RH: Posse - Prorroga????o');
INSERT INTO `tb_tipos_processo` VALUES(100000951, 'IDENE - Reservat??rios de 500 Litros - Munic??pio');
INSERT INTO `tb_tipos_processo` VALUES(100000952, 'IDENE - Reservat??rios de 500 Litros - Associa????es');
INSERT INTO `tb_tipos_processo` VALUES(100000953, 'Sindic??ncia Administrativa Investigat??ria');
INSERT INTO `tb_tipos_processo` VALUES(100000954, 'Sindic??ncia Administrativa Punitiva');
INSERT INTO `tb_tipos_processo` VALUES(100000955, 'Sindic??ncia Administrativa Patrimonial');
INSERT INTO `tb_tipos_processo` VALUES(100000956, 'Processo Administrativo Disciplinar');
INSERT INTO `tb_tipos_processo` VALUES(100000957, 'RH: Nomea????o - Cargo Comissionado');
INSERT INTO `tb_tipos_processo` VALUES(100000958, 'RH: Designa????o - Fun????o Gratificada');
INSERT INTO `tb_tipos_processo` VALUES(100000959, 'Gest??o da Qualidade: Avalia????o Interlaboratorial');
INSERT INTO `tb_tipos_processo` VALUES(100000960, 'RH: Afastamento para Exerc??cio de Mandato Eletivo');
INSERT INTO `tb_tipos_processo` VALUES(100000961, 'Estudos, Projetos e Zoneamento Ambiental: Gest??o T');
INSERT INTO `tb_tipos_processo` VALUES(100000962, 'Estudos, Projetos e Zoneamento Ambiental: ICMS Eco');
INSERT INTO `tb_tipos_processo` VALUES(100000963, 'Estudos, Projetos e Zoneamento Ambiental: Estudos ');
INSERT INTO `tb_tipos_processo` VALUES(100000964, 'FEAM - Estudos T??cnicos Ambientais: Fechamento de ');
INSERT INTO `tb_tipos_processo` VALUES(100000965, 'Gest??o de Gastos: ??gua e Esgoto');
INSERT INTO `tb_tipos_processo` VALUES(100000966, 'Gest??o de Gastos: Energia El??trica');
INSERT INTO `tb_tipos_processo` VALUES(100000967, 'RH: Transfer??ncia');
INSERT INTO `tb_tipos_processo` VALUES(100000968, 'Est??gio Remunerado - Conv??nio com Institui????o de E');
INSERT INTO `tb_tipos_processo` VALUES(100000969, 'Gest??o das Atividades Cont??beis: Normatiza????o e Or');
INSERT INTO `tb_tipos_processo` VALUES(100000970, 'Controle das Atividades Cont??beis: Certifica????o Co');
INSERT INTO `tb_tipos_processo` VALUES(100000971, 'Atendimento Judici??rio Socioeducativo: Prontu??rio ');
INSERT INTO `tb_tipos_processo` VALUES(100000973, 'Atendimento Judici??rio Socioeducativo: Plano Indiv');
INSERT INTO `tb_tipos_processo` VALUES(100000974, 'Atendimento Judici??rio Socioeducativo: Evolu????o do');
INSERT INTO `tb_tipos_processo` VALUES(100000975, 'Atendimento Judici??rio Socioeducativo: Cadastro de');
INSERT INTO `tb_tipos_processo` VALUES(100000976, 'Atendimento Judici??rio Socioeducativo: Instrumento');
INSERT INTO `tb_tipos_processo` VALUES(100000977, 'Gest??o de Vagas Socioeducativas: Solicita????o de Va');
INSERT INTO `tb_tipos_processo` VALUES(100000978, 'Gest??o de Vagas Socioeducativas: Panorama da Ocupa');
INSERT INTO `tb_tipos_processo` VALUES(100000979, 'Gest??o de Vagas Socioeducativas: Movimenta????o de A');
INSERT INTO `tb_tipos_processo` VALUES(100000980, 'Gest??o de Vagas Socioeducativas: Movimenta????o de A');
INSERT INTO `tb_tipos_processo` VALUES(100000981, 'Orienta????o Socioeducativa: Projeto Pol??tico Pedag??');
INSERT INTO `tb_tipos_processo` VALUES(100000982, 'Interc??mbio entre Policiais e Adolescentes em Cump');
INSERT INTO `tb_tipos_processo` VALUES(100000983, 'Gest??o da Informa????o e Pesquisa: Informa????es sobre');
INSERT INTO `tb_tipos_processo` VALUES(100000984, 'Gest??o de Parcerias para Atendimento Socioeducativ');
INSERT INTO `tb_tipos_processo` VALUES(100000985, 'SEMAD Protocolo SUPRAM - ASF');
INSERT INTO `tb_tipos_processo` VALUES(100000986, 'SEMAD Protocolo SUPRAM - JEQ');
INSERT INTO `tb_tipos_processo` VALUES(100000987, 'SEMAD Protocolo SUPRAM - LM');
INSERT INTO `tb_tipos_processo` VALUES(100000988, 'SEMAD Protocolo SUPRAM - NOR');
INSERT INTO `tb_tipos_processo` VALUES(100000989, 'SEMAD Protocolo SUPRAM - NM');
INSERT INTO `tb_tipos_processo` VALUES(100000990, 'SEMAD Protocolo SUPRAM - ZM');
INSERT INTO `tb_tipos_processo` VALUES(100000991, 'SEMAD Protocolo - SUPPRI');
INSERT INTO `tb_tipos_processo` VALUES(100000992, 'Avalia????o Educacional : Avalia????o da Qualidade de ');
INSERT INTO `tb_tipos_processo` VALUES(100000993, 'Pol??ticas Educacionais: Planejamento e Gest??o de P');
INSERT INTO `tb_tipos_processo` VALUES(100000994, 'Educa????o B??sica - Tem??ticas Especiais de Ensino: E');
INSERT INTO `tb_tipos_processo` VALUES(100000995, 'Educa????o B??sica - Tem??ticas Especiais de Ensino: R');
INSERT INTO `tb_tipos_processo` VALUES(100000996, 'Educa????o B??sica - Tem??ticas Especiais de Ensino: E');
INSERT INTO `tb_tipos_processo` VALUES(100000997, 'Educa????o B??sica - Tem??ticas Especiais de Ensino: E');
INSERT INTO `tb_tipos_processo` VALUES(100000998, 'Educa????o Especial: Atendimento Educacional Especia');
INSERT INTO `tb_tipos_processo` VALUES(100000999, 'Educa????o Especial: Monitoramento Social');
INSERT INTO `tb_tipos_processo` VALUES(100001000, 'Educa????o de Jovens e Adultos: Banca Permanente de ');
INSERT INTO `tb_tipos_processo` VALUES(100001001, 'Educa????o de Jovens e Adultos: Alfabetiza????o de Jov');
INSERT INTO `tb_tipos_processo` VALUES(100001002, 'Educa????o de Jovens e Adultos: Ensino Semipresencia');
INSERT INTO `tb_tipos_processo` VALUES(100001003, 'Educa????o de Jovens e Adultos: Exames Supletivos - ');
INSERT INTO `tb_tipos_processo` VALUES(100001004, 'Educa????o Profissional: Programa de Educa????o Profis');
INSERT INTO `tb_tipos_processo` VALUES(100001005, 'Ensino Fundamental: Implanta????o da Pol??tica do Ens');
INSERT INTO `tb_tipos_processo` VALUES(100001006, 'Ensino Fundamental: Implanta????o, Capacita????o e Mon');
INSERT INTO `tb_tipos_processo` VALUES(100001007, 'Ensino M??dio: Conte??do B??sico Comum (CBC)');
INSERT INTO `tb_tipos_processo` VALUES(100001008, 'Ensino M??dio: Programa do Ensino M??dio');
INSERT INTO `tb_tipos_processo` VALUES(100001009, 'Ensino M??dio: Incentivo para Conclus??o do Ensino M');
INSERT INTO `tb_tipos_processo` VALUES(100001010, 'Acompanhamento da Vida Escolar: Avalia????o e Result');
INSERT INTO `tb_tipos_processo` VALUES(100001011, 'Funcionamento Escolar: Planejamento de Curso');
INSERT INTO `tb_tipos_processo` VALUES(100001012, 'Funcionamento Escolar: Documenta????o da Escola');
INSERT INTO `tb_tipos_processo` VALUES(100001013, 'Funcionamento Escolar: Inspe????o');
INSERT INTO `tb_tipos_processo` VALUES(100001014, 'Funcionamento Escolar - Normas de escritura????o esc');
INSERT INTO `tb_tipos_processo` VALUES(100001015, 'Regulariza????o da Vida Escolar: An??lise da Vida Esc');
INSERT INTO `tb_tipos_processo` VALUES(100001016, 'Regularidade de Funcionamento da Escola: Funcionam');
INSERT INTO `tb_tipos_processo` VALUES(100001017, 'Regularidade de Funcionamento da Escola: Processos');
INSERT INTO `tb_tipos_processo` VALUES(100001018, 'Regularidade de Funcionamento da Escola: Registro');
INSERT INTO `tb_tipos_processo` VALUES(100001019, 'Regularidade de Funcionamento da Escola:??Registro,');
INSERT INTO `tb_tipos_processo` VALUES(100001021, 'Equival??ncia de Estudos:  An??lise de Documentos Es');
INSERT INTO `tb_tipos_processo` VALUES(100001022, 'Gest??o Escolar: Processo de Elei????o dos Colegiados');
INSERT INTO `tb_tipos_processo` VALUES(100001023, 'Gest??o Escolar: Processo de Indica????o de Diretor e');
INSERT INTO `tb_tipos_processo` VALUES(100001024, 'Gest??o Escolar: Avalia????o e Autoavalia????o  da Gest');
INSERT INTO `tb_tipos_processo` VALUES(100001025, 'Gest??o Escolar: Aprimoramento da Gest??o Escolar (P');
INSERT INTO `tb_tipos_processo` VALUES(100001026, 'Processo de Autoriza????o: Autoriza????o de Funcioname');
INSERT INTO `tb_tipos_processo` VALUES(100001027, 'Processo de Autoriza????o: Credenciamento da Entidad');
INSERT INTO `tb_tipos_processo` VALUES(100001028, 'Processo de Autoriza????o: Mudan??a de Denomina????o do');
INSERT INTO `tb_tipos_processo` VALUES(100001029, 'Processo de Autoriza????o: Mudan??a de Denomina????o do');
INSERT INTO `tb_tipos_processo` VALUES(100001030, 'Processo de Autoriza????o: Escolas Munic. e Part.: E');
INSERT INTO `tb_tipos_processo` VALUES(100001031, 'Processo de Autoriza????o: Mudan??a da Entidade Mante');
INSERT INTO `tb_tipos_processo` VALUES(100001032, 'Processo de Autoriza????o: Mudan??a de Pr??dio');
INSERT INTO `tb_tipos_processo` VALUES(100001033, 'Processo de Autoriza????o: Reconhecimento de Curso/N');
INSERT INTO `tb_tipos_processo` VALUES(100001034, 'Processo de Autoriza????o: Prorroga????o da Autoriza????');
INSERT INTO `tb_tipos_processo` VALUES(100001035, 'Processo de Autoriza????o: Recredenciamento da Entid');
INSERT INTO `tb_tipos_processo` VALUES(100001036, 'Processo de Autoriza????o: Turma Vinculada');
INSERT INTO `tb_tipos_processo` VALUES(100001037, 'Cadastro Escolar: Divulga????o do Cadastro Escolar');
INSERT INTO `tb_tipos_processo` VALUES(100001038, 'Plano de Atendimento Escolar: Implanta????o de Curso');
INSERT INTO `tb_tipos_processo` VALUES(100001039, 'Plano de Atendimento Escolar: Implanta????o de Educa');
INSERT INTO `tb_tipos_processo` VALUES(100001040, 'Plano de Atendimento Escolar: Extens??o dos Anos In');
INSERT INTO `tb_tipos_processo` VALUES(100001041, 'Plano de Atendimento Escolar: Implanta????o de N??vel');
INSERT INTO `tb_tipos_processo` VALUES(100001042, 'Plano de Atendimento Escolar: Proposta de Cria????o ');
INSERT INTO `tb_tipos_processo` VALUES(100001043, 'Plano de Atendimento Escolar: Implanta????o de Segun');
INSERT INTO `tb_tipos_processo` VALUES(100001044, 'Plano de Atendimento Escolar: Integra????o de Escola');
INSERT INTO `tb_tipos_processo` VALUES(100001045, 'Plano de Atendimento Escolar: Paralisa????o e Encerr');
INSERT INTO `tb_tipos_processo` VALUES(100001046, 'Suprimento Escolar: Manuten????o e Custeio da Escola');
INSERT INTO `tb_tipos_processo` VALUES(100001047, 'Suprimento Escolar: Repasse de Dinheiro Direto par');
INSERT INTO `tb_tipos_processo` VALUES(100001048, 'Suprimento Escolar: Alimenta????o Escolar (Merenda)');
INSERT INTO `tb_tipos_processo` VALUES(100001049, 'Suprimento Escolar: Transporte Escolar');
INSERT INTO `tb_tipos_processo` VALUES(100001050, 'Capacita????o e Inclus??o Social: Cursos Profissional');
INSERT INTO `tb_tipos_processo` VALUES(100001051, 'Capacita????o e Inclus??o Social: Projetos Culturais ');
INSERT INTO `tb_tipos_processo` VALUES(100001052, 'Suporte aos Munic??pios: Promo????o de Debates Juveni');
INSERT INTO `tb_tipos_processo` VALUES(100001053, 'Formula????o de Pol??ticas P??blicas: Cria????o de Conse');
INSERT INTO `tb_tipos_processo` VALUES(100001054, 'Informa????es Educacionais: Cadastro de Estabelecime');
INSERT INTO `tb_tipos_processo` VALUES(100001055, 'Informa????es Educacionais: Coleta de Dados');
INSERT INTO `tb_tipos_processo` VALUES(100001056, 'RH: Est??gio Remunerado - Divulga????o e sele????o');
INSERT INTO `tb_tipos_processo` VALUES(100001057, 'RH: Est??gio Remunerado - Solicita????o de Vaga');
INSERT INTO `tb_tipos_processo` VALUES(100001058, 'RH: Est??gio Remunerado - Encerramento de Est??gio');
INSERT INTO `tb_tipos_processo` VALUES(100001059, 'RH: Afastamento para Servi??o Militar');
INSERT INTO `tb_tipos_processo` VALUES(100001060, 'RH: Frequ??ncia Anual');
INSERT INTO `tb_tipos_processo` VALUES(100001061, 'RH: Promo????o por Escolaridade Adicional');
INSERT INTO `tb_tipos_processo` VALUES(100001062, 'Processo de Autoriza????o: Altera????o na Entidade Man');
INSERT INTO `tb_tipos_processo` VALUES(100001063, 'Processo de Autoriza????o: Rein??cio de Atividades (E');
INSERT INTO `tb_tipos_processo` VALUES(100001064, 'Processo de Autoriza????o: Encerramento (Escolas Par');
INSERT INTO `tb_tipos_processo` VALUES(100001066, 'RH: Convers??o de F??rias Pr??mio em Esp??cie p??s Exon');
INSERT INTO `tb_tipos_processo` VALUES(100001067, 'RH: Solicita????o de crach?? - Cidade Administrativa');
INSERT INTO `tb_tipos_processo` VALUES(100001068, 'RH: Contrato Administrativo - Aditivo');
INSERT INTO `tb_tipos_processo` VALUES(100001069, 'RH: Contrato Administrativo Perito - Pr?? Qualifica');
INSERT INTO `tb_tipos_processo` VALUES(100001070, 'RH: Concurso P??blico - Informa????o de candidato');
INSERT INTO `tb_tipos_processo` VALUES(100001071, 'RH: Contagem em dobro de F??rias Pr??mio para aposen');
INSERT INTO `tb_tipos_processo` VALUES(100001072, 'Intelig??ncia do Sistema Socioeducativo: Produ????o d');
INSERT INTO `tb_tipos_processo` VALUES(100001073, 'Intelig??ncia do Sistema Socioeducativo: Contados c');
INSERT INTO `tb_tipos_processo` VALUES(100001074, 'RH: Avalia????o de Desempenho dos Gestores P??blicos');
INSERT INTO `tb_tipos_processo` VALUES(100001075, 'RH: Nomea????o - Tornar sem efeito');
INSERT INTO `tb_tipos_processo` VALUES(100001076, 'SESP - Interna????o Por Prazo Indeterminado');
INSERT INTO `tb_tipos_processo` VALUES(100001077, 'SESP - Interna????o San????o');
INSERT INTO `tb_tipos_processo` VALUES(100001078, 'SESP - Semiliberdade');
INSERT INTO `tb_tipos_processo` VALUES(100001079, 'RH: Avalia????o de Desempenho');
INSERT INTO `tb_tipos_processo` VALUES(100001080, 'RH: Exerc??cio - Prorroga????o');
INSERT INTO `tb_tipos_processo` VALUES(100001081, 'RH: Altera????o de Data F??rias Pr??mio');
INSERT INTO `tb_tipos_processo` VALUES(100001082, 'RH: Op????o Remunerat??ria');
INSERT INTO `tb_tipos_processo` VALUES(100001083, 'SISEMA - Plano Individual de Fiscaliza????o - PIF');
INSERT INTO `tb_tipos_processo` VALUES(100001084, 'SISEMA - Gratifica????o pelo Desenvolvimento de Atividade de Fiscaliza????o - GDAF');
INSERT INTO `tb_tipos_processo` VALUES(100001085, 'Inscri????o do D??bito em D??vida Ativa N??o Tribut??ria');
INSERT INTO `tb_tipos_processo` VALUES(100001086, 'Inscri????o do D??bito em D??vida Ativa N??o Tribut??ria');
INSERT INTO `tb_tipos_processo` VALUES(100001087, 'Inscri????o do D??bito em D??vida Ativa N??o Tribut??ria');
INSERT INTO `tb_tipos_processo` VALUES(100001088, 'RH: Miss??o Governamental');
INSERT INTO `tb_tipos_processo` VALUES(100001089, 'Moderniza????o Institucional: Monitoramento do Desem');
INSERT INTO `tb_tipos_processo` VALUES(100001090, 'Qualifica????o como OSCIP');
INSERT INTO `tb_tipos_processo` VALUES(100001092, 'Coopera????o para o Programa de Parcerias P??blico-Pr');
INSERT INTO `tb_tipos_processo` VALUES(100001093, 'Estruturas Institucionais do Programa Parcerias P??');
INSERT INTO `tb_tipos_processo` VALUES(100001094, 'Estruturas Institucionais do Programa Parcerias P??');
INSERT INTO `tb_tipos_processo` VALUES(100001095, 'Estruturas Institucionais do Programa Parcerias P??');
INSERT INTO `tb_tipos_processo` VALUES(100001096, 'Diretrizes e Pr??ticas para Estrutura????o de Projeto');
INSERT INTO `tb_tipos_processo` VALUES(100001097, 'Implementa????o de Novos Modelos para Execu????o de Po');
INSERT INTO `tb_tipos_processo` VALUES(100001098, 'Organiza????o Administrativa: Informa????es Institucionais');
INSERT INTO `tb_tipos_processo` VALUES(100001099, 'Organiza????o Administrativa: Normas e Manuais');
INSERT INTO `tb_tipos_processo` VALUES(100001100, 'Recursos para Avalia????o de Desempenho');
INSERT INTO `tb_tipos_processo` VALUES(100001101, 'Desenvolvimento Regional e Urbano: Processo Admini');
INSERT INTO `tb_tipos_processo` VALUES(100001102, 'Patrim??nio Imobili??rio: Loca????o (Inclusive de Im??v');
INSERT INTO `tb_tipos_processo` VALUES(100001103, 'Avalia????o para Concess??o de Benef??cios e Preven????o ?? Sa??de (Prontu??rio M??dico)');
INSERT INTO `tb_tipos_processo` VALUES(100001104, 'Assist??ncia ?? Sa??de: Concess??o de Insalubridade e Periculosidade');
INSERT INTO `tb_tipos_processo` VALUES(100001105, 'Inspe????es Peri??dicas de Sa??de');
INSERT INTO `tb_tipos_processo` VALUES(100001106, 'Assist??ncia M??dica Suplementar');
INSERT INTO `tb_tipos_processo` VALUES(100001107, 'Produ????o Editorial: Coordena????o da Edi????o de Publi');
INSERT INTO `tb_tipos_processo` VALUES(100001108, 'Pol??tica Estadual de Transpar??ncia P??blica e Contr');
INSERT INTO `tb_tipos_processo` VALUES(100001109, 'Pol??tica Estadual de Transpar??ncia P??blica e Contr');
INSERT INTO `tb_tipos_processo` VALUES(100001110, 'Incremento da Transpar??ncia P??blica. Informa????o In');
INSERT INTO `tb_tipos_processo` VALUES(100001111, 'Incremento da Transpar??ncia P??blica.Informa????o Ins');
INSERT INTO `tb_tipos_processo` VALUES(100001112, 'Parcerias para a Transpar??ncia P??blica e Controle ');
INSERT INTO `tb_tipos_processo` VALUES(100001113, 'Parcerias para a Transpar??ncia P??blica e Controle ');
INSERT INTO `tb_tipos_processo` VALUES(100001114, 'Produ????o e Desenvolvimento de Tecnologias de Trans');
INSERT INTO `tb_tipos_processo` VALUES(100001115, 'Produ????o e Desenvolvimento de Tecnologias de Trans');
INSERT INTO `tb_tipos_processo` VALUES(100001116, 'Pol??tica Estadual de Preven????o e Combate ?? Corrup??');
INSERT INTO `tb_tipos_processo` VALUES(100001117, 'Pol??tica Estadual de Preven????o e Combate ?? Corrup??');
INSERT INTO `tb_tipos_processo` VALUES(100001118, 'Parcerias para a Preven????o e Combate ?? Corrup????o: ');
INSERT INTO `tb_tipos_processo` VALUES(100001119, 'Parcerias para a Preven????o e Combate ?? Corrup????o: ');
INSERT INTO `tb_tipos_processo` VALUES(100001120, 'Dissemina????o de Conte??dos Relacionados ?? Preven????o');
INSERT INTO `tb_tipos_processo` VALUES(100001121, 'Dados e Informa????es Referentes ?? Preven????o e ao Combate ?? Corrup????o');
INSERT INTO `tb_tipos_processo` VALUES(100001122, 'Produ????o e Desenvolvimento de Tecnologia de Preven');
INSERT INTO `tb_tipos_processo` VALUES(100001123, 'Produ????o e Desenvolvimento de Tecnologia de Preven');
INSERT INTO `tb_tipos_processo` VALUES(100001124, 'Gest??o Institucional: Organiza????o e Funcionamento do ??rg??o/entidade');
INSERT INTO `tb_tipos_processo` VALUES(100001125, 'Organiza????o e Funcionamento do ??rg??o/entidade: Reg');
INSERT INTO `tb_tipos_processo` VALUES(100001126, 'Organiza????o e Funcionamento do ??rg??o/entidade: Audi??ncias. Despachos. Reuni??es');
INSERT INTO `tb_tipos_processo` VALUES(100001127, 'Gest??o Institucional: Comiss??es T??cnicas. Conselhos. Grupos de Trabalho. Juntas. Comit??s. C??maras');
INSERT INTO `tb_tipos_processo` VALUES(100001128, 'Divulga????o Institucional do Governo: Campanhas Pub');
INSERT INTO `tb_tipos_processo` VALUES(100001129, 'Publica????o de Mat??rias no Di??rio Oficial do Estado de Minas Gerais');
INSERT INTO `tb_tipos_processo` VALUES(100001130, 'Divulga????o Institucional do Governo: Material Inst');
INSERT INTO `tb_tipos_processo` VALUES(100001131, 'Divulga????o Institucional do Governo: Material Inst');
INSERT INTO `tb_tipos_processo` VALUES(100001132, 'Assessoria de Imprensa');
INSERT INTO `tb_tipos_processo` VALUES(100001133, 'Relacionamento com a Imprensa: Produ????o e Veicula??');
INSERT INTO `tb_tipos_processo` VALUES(100001134, 'Acompanhamento da Vers??o On-line de Jornais Impres');
INSERT INTO `tb_tipos_processo` VALUES(100001135, 'Comunica????o Social: Divulga????o Interna');
INSERT INTO `tb_tipos_processo` VALUES(100001136, 'Produ????o Editorial: Coordena????o da Edi????o de Publi');
INSERT INTO `tb_tipos_processo` VALUES(100001137, 'Produ????o Editorial: Distribui????o, Promo????o e Divul');
INSERT INTO `tb_tipos_processo` VALUES(100001138, 'Credenciamento para Celebra????o de Conv??nios no CAG');
INSERT INTO `tb_tipos_processo` VALUES(100001139, 'Credenciamento para Celebra????o de Conv??nios no CAG');
INSERT INTO `tb_tipos_processo` VALUES(100001140, 'Credenciamento para Celebra????o de Conv??nios no CAG');
INSERT INTO `tb_tipos_processo` VALUES(100001141, 'Credenciamento para Celebra????o de Conv??nios no CAG');
INSERT INTO `tb_tipos_processo` VALUES(100001142, 'Credenciamento para Celebra????o de Conv??nios no CAG');
INSERT INTO `tb_tipos_processo` VALUES(100001143, 'Credenciamento para Celebra????o de Conv??nios no CAG');
INSERT INTO `tb_tipos_processo` VALUES(100001144, 'Credenciamento para Celebra????o de Conv??nios no CAG');
INSERT INTO `tb_tipos_processo` VALUES(100001145, 'Gest??o Institucional: Relat??rios de Atividades');
INSERT INTO `tb_tipos_processo` VALUES(100001146, 'Gest??o do Atendimento ao Cidad??o: Avalia????o e Moni');
INSERT INTO `tb_tipos_processo` VALUES(100001147, 'Gest??o do Atendimento ao Cidad??o: Estrutura????o e P');
INSERT INTO `tb_tipos_processo` VALUES(100001148, 'Gest??o do Atendimento ao Cidad??o: Atendimento e Orienta????o');
INSERT INTO `tb_tipos_processo` VALUES(100001149, 'Atendimento ao Cidad??o. Gest??o da Informa????o e Recursos de Tecnologia da Informa????o e Comunica????o');
INSERT INTO `tb_tipos_processo` VALUES(100001150, 'Outras Atividades/Transa????es Referentes a Organiza????o e Funcionamento: Informa????es sobre o ??rg??o');
INSERT INTO `tb_tipos_processo` VALUES(100001151, 'DEER - Recursos de multas de transporte coletivo i');
INSERT INTO `tb_tipos_processo` VALUES(100001152, 'Recursos de Multas de Tr??nsito');
INSERT INTO `tb_tipos_processo` VALUES(100001153, 'Assessoramento Jur??dico: Parecer');
INSERT INTO `tb_tipos_processo` VALUES(100001154, 'Assessoramento Jur??dico: Parecer sobre Processo Ad');
INSERT INTO `tb_tipos_processo` VALUES(100001155, 'Assessoramento Jur??dico: Parecer sobre Processo do');
INSERT INTO `tb_tipos_processo` VALUES(100001156, 'Assessoramento Jur??dico: Parecer Normativo');
INSERT INTO `tb_tipos_processo` VALUES(100001157, 'Assessoramento Jur??dico: Nota Jur??dica');
INSERT INTO `tb_tipos_processo` VALUES(100001158, 'Corregedoria: An??lise Preliminar');
INSERT INTO `tb_tipos_processo` VALUES(100001159, 'RH: Contrato Administrativo Perito - Pr?? Qualifica');
INSERT INTO `tb_tipos_processo` VALUES(100001160, 'RH: Contrato Administrativo - Rescis??o');
INSERT INTO `tb_tipos_processo` VALUES(100001161, 'RH: Posse e Exerc??cio - Fun????o Gratificada');
INSERT INTO `tb_tipos_processo` VALUES(100001162, 'RH: Desligamento por Morte');
INSERT INTO `tb_tipos_processo` VALUES(100001163, 'RH: Sa??de do Servidor: Per??cia Ex-Officio');
INSERT INTO `tb_tipos_processo` VALUES(100001164, 'RH: Posse - Desist??ncia');
INSERT INTO `tb_tipos_processo` VALUES(100001165, 'RH: Ac??mulo de Cargos');
INSERT INTO `tb_tipos_processo` VALUES(100001166, 'RH: Exonera????o ou Dispensa a Pedido');
INSERT INTO `tb_tipos_processo` VALUES(100001167, 'RH: Capacidade Laborativa');
INSERT INTO `tb_tipos_processo` VALUES(100001168, 'RH: Adicional de Periculosidade');
INSERT INTO `tb_tipos_processo` VALUES(100001169, 'RH: Licen??a por Motivo de Doen??a em Pessoa da Fam??');
INSERT INTO `tb_tipos_processo` VALUES(100001170, 'RH: Exonera????o ou Dispensa Ex Officio');
INSERT INTO `tb_tipos_processo` VALUES(100001171, 'Lei Estadual de Incentivo ?? Cultura: Projetos apro');
INSERT INTO `tb_tipos_processo` VALUES(100001172, 'Lei Estadual de Incentivo ?? Cultura: Projetos apro');
INSERT INTO `tb_tipos_processo` VALUES(100001173, 'Processo Recebido Externamente (a classificar)');
INSERT INTO `tb_tipos_processo` VALUES(100001174, 'Coopera????o Administrativa e T??cnica');
INSERT INTO `tb_tipos_processo` VALUES(100001175, 'RH: Ordem de Pagamento Especial (OPE): vencimentos deixados');
INSERT INTO `tb_tipos_processo` VALUES(100001176, 'Processo de Autoriza????o: Renova????o do Reconhecimen');
INSERT INTO `tb_tipos_processo` VALUES(100001177, 'Processo de Autoriza????o: Autoriza????o de Funcioname');
INSERT INTO `tb_tipos_processo` VALUES(100001178, 'Processo de Autoriza????o: Prorroga????o do Reconhecim');
INSERT INTO `tb_tipos_processo` VALUES(100001179, 'Processo de Autoriza????o: Prorroga????o da Renova????o ');
INSERT INTO `tb_tipos_processo` VALUES(100001180, 'Processo de Autoriza????o: Prorroga????o do Credenciam');
INSERT INTO `tb_tipos_processo` VALUES(100001181, 'Processo de Autoriza????o: Prorroga????o do Recredenci');
INSERT INTO `tb_tipos_processo` VALUES(100001182, 'Processo de Autoriza????o: Especializa????o t??cnica de');
INSERT INTO `tb_tipos_processo` VALUES(100001183, 'Processo de Autoriza????o: Funcionamento de P??lo de ');
INSERT INTO `tb_tipos_processo` VALUES(100001184, 'Processo de Autoriza????o: Segundo Endere??o da Escol');
INSERT INTO `tb_tipos_processo` VALUES(100001185, 'Processo de Autoriza????o: Amplia????o da Rede F??sica ');
INSERT INTO `tb_tipos_processo` VALUES(100001186, 'IDENE - Doa????o de bens de emenda parlamentar - Ass');
INSERT INTO `tb_tipos_processo` VALUES(100001187, 'IDENE - Doa????o de bens de emenda parlamentar - Mun');
INSERT INTO `tb_tipos_processo` VALUES(100001188, 'FEAM - Gest??o T??cnica de Projetos Ambientais: Decl');
INSERT INTO `tb_tipos_processo` VALUES(100001189, 'Recebimento e An??lise de Den??ncia de Correi????o: An??lise de Den??ncia');
INSERT INTO `tb_tipos_processo` VALUES(100001190, 'Recebimento e An??lise de Den??ncia de Correi????o: Ex');
INSERT INTO `tb_tipos_processo` VALUES(100001191, 'Recebimento e An??lise de Den??ncia de Correi????o: Ex');
INSERT INTO `tb_tipos_processo` VALUES(100001192, 'Recebimento e An??lise de Den??ncia de Correi????o: Ex');
INSERT INTO `tb_tipos_processo` VALUES(100001193, 'Recebimento e An??lise de Den??ncia de Correi????o: Expediente de Conduta Funcional Irregular');
INSERT INTO `tb_tipos_processo` VALUES(100001194, 'Recebimento e An??lise de Den??ncia de Correi????o: Expediente de Servidor - Abandono de Cargo');
INSERT INTO `tb_tipos_processo` VALUES(100001195, 'Recebimento e An??lise de Den??ncia de Correi????o: In');
INSERT INTO `tb_tipos_processo` VALUES(100001196, 'Recebimento e An??lise de Den??ncia de Correi????o: Po');
INSERT INTO `tb_tipos_processo` VALUES(100001197, 'Recebimento e An??lise de Den??ncia de Correi????o: Do');
INSERT INTO `tb_tipos_processo` VALUES(100001198, 'Recebimento e An??lise de Den??ncia de Correi????o: Ex');
INSERT INTO `tb_tipos_processo` VALUES(100001199, 'Recebimento e An??lise de Den??ncia de Correi????o: Ex');
INSERT INTO `tb_tipos_processo` VALUES(100001200, 'Recebimento e An??lise de Den??ncia de Correi????o: Ex');
INSERT INTO `tb_tipos_processo` VALUES(100001201, 'Recebimento e An??lise de Den??ncia de Correi????o: Ex');
INSERT INTO `tb_tipos_processo` VALUES(100001202, 'Correi????o: Procedimentos Administrativos Disciplinares');
INSERT INTO `tb_tipos_processo` VALUES(100001203, 'Higiene e Seguran??a do Trabalho');
INSERT INTO `tb_tipos_processo` VALUES(100001204, 'Preven????o de Acidentes de Trabalho. Comiss??o Inter');
INSERT INTO `tb_tipos_processo` VALUES(100001205, 'Programas Preventivos de Sa??de Laboral');
INSERT INTO `tb_tipos_processo` VALUES(100001206, 'Auditoria Assistencial');
INSERT INTO `tb_tipos_processo` VALUES(100001207, 'Cadastro de Comunica????o de Acidente de Trabalho - CAT');
INSERT INTO `tb_tipos_processo` VALUES(100001208, 'Gest??o de Desempenho dos Servidores: Normatiza????o da Avalia????o de Desempenho');
INSERT INTO `tb_tipos_processo` VALUES(100001209, 'Gest??o de Desempenho dos Servidores: Avalia????o de Desempenho do Servidor');
INSERT INTO `tb_tipos_processo` VALUES(100001210, 'Gest??o de Desempenho dos Servidores: Avalia????o de Desempenho Individual');
INSERT INTO `tb_tipos_processo` VALUES(100001211, 'Gest??o de Desempenho dos Servidores: Avalia????o de Desempenho do Gestor P??blico');
INSERT INTO `tb_tipos_processo` VALUES(100001212, 'Outras Atividades/Transa????es Referentes ?? Gest??o de Pessoas: Hor??rio de Expediente');
INSERT INTO `tb_tipos_processo` VALUES(100001213, 'Outras Atividades/Transa????es Referentes ?? Gest??o de Pessoas: Controle de Frequ??ncia');
INSERT INTO `tb_tipos_processo` VALUES(100001214, 'Miss??es Fora da Sede. Viagens a Servi??o: Sem ??nus para a Institui????o');
INSERT INTO `tb_tipos_processo` VALUES(100001215, 'Miss??es Fora da Sede. Viagens a Servi??o: Com ??nus ');
INSERT INTO `tb_tipos_processo` VALUES(100001216, 'Incentivos Funcionais: Pr??mios (Concess??es de Meda');
INSERT INTO `tb_tipos_processo` VALUES(100001217, 'Outras Atividades/Transa????es Referentes ?? Gest??o de Pessoas: Delega????es de Compet??ncia. Procura????o');
INSERT INTO `tb_tipos_processo` VALUES(100001218, 'A????es Judiciais Movidas por Servidores P??blicos (Estatut??rio e Celetista): Informa????o T??cnica');
INSERT INTO `tb_tipos_processo` VALUES(100001219, 'A????es Judiciais Movidas por Servidores P??blicos (Estatut??rio e Celetista):Cumprimento de Decis??o jud');
INSERT INTO `tb_tipos_processo` VALUES(100001220, 'Movimentos Reivindicat??rios: Greves e Paralisa????es');
INSERT INTO `tb_tipos_processo` VALUES(100001221, 'Produ????o de Tecnologias de Auditoria: Desenvolvime');
INSERT INTO `tb_tipos_processo` VALUES(100001222, 'Produ????o de Tecnologias de Auditoria: Divulga????o');
INSERT INTO `tb_tipos_processo` VALUES(100001223, 'Acompanhamento da Aplica????o de Normas e Procedimentos de Auditoria Operacional');
INSERT INTO `tb_tipos_processo` VALUES(100001224, 'Gerenciamento das Atividades de Auditoria');
INSERT INTO `tb_tipos_processo` VALUES(100001225, 'Auditoria Interna Especial por Determina????o Superi');
INSERT INTO `tb_tipos_processo` VALUES(100001226, 'Auditorias Especiais: Acolhimento e Apura????o da De');
INSERT INTO `tb_tipos_processo` VALUES(100001227, 'Presta????o Anual de Contas do Governador');
INSERT INTO `tb_tipos_processo` VALUES(100001228, 'Abertura de Vista nas Contas do Governador promovi');
INSERT INTO `tb_tipos_processo` VALUES(100001229, 'Auditoria de Contas: Auditoria do Relat??rio de Ges');
INSERT INTO `tb_tipos_processo` VALUES(100001230, 'Auditoria de Contas: Auditoria Cont??bil');
INSERT INTO `tb_tipos_processo` VALUES(100001231, 'Auditoria de Contas: Tomada de Contas Especial');
INSERT INTO `tb_tipos_processo` VALUES(100001232, 'Auditoria de Contratos de Gest??o: Auditoria de Aco');
INSERT INTO `tb_tipos_processo` VALUES(100001233, 'Avalia????o de Gest??o e Resultados de Termos de Parc');
INSERT INTO `tb_tipos_processo` VALUES(100001234, 'Avalia????o de Contratos de Parcerias P??blico Privad');
INSERT INTO `tb_tipos_processo` VALUES(100001235, 'Auditoria de Gest??o: Monitoramento das Implementa??');
INSERT INTO `tb_tipos_processo` VALUES(100001236, 'Auditoria de Gest??o: Auditoria de Avalia????o de Imp');
INSERT INTO `tb_tipos_processo` VALUES(100001237, 'Auditoria de Gest??o: Auditoria em Programas Govern');
INSERT INTO `tb_tipos_processo` VALUES(100001238, 'Auditoria de Gest??o: Auditoria em Demandas Pontuais');
INSERT INTO `tb_tipos_processo` VALUES(100001239, 'Planejamento e Or??amento: Pol??ticas Or??ament??rias');
INSERT INTO `tb_tipos_processo` VALUES(100001240, 'Planejamento e Or??amento: Or??amento Fiscal');
INSERT INTO `tb_tipos_processo` VALUES(100001241, 'Planejamento e Or??amento: Or??amento de Investiment');
INSERT INTO `tb_tipos_processo` VALUES(100001242, 'Planejamento e Or??amento: Coordena????o Geral: A????es');
INSERT INTO `tb_tipos_processo` VALUES(100001243, 'Gest??o de Projetos Estruturadores: Planejamento e ');
INSERT INTO `tb_tipos_processo` VALUES(100001244, 'Planejamento e Or??amento: Previs??o de Receita');
INSERT INTO `tb_tipos_processo` VALUES(100001245, 'Planejamento e Or??amento: Programa????o Or??ament??ria');
INSERT INTO `tb_tipos_processo` VALUES(100001246, 'Plano Plurianual de A????o Governamental - PPAG');
INSERT INTO `tb_tipos_processo` VALUES(100001247, 'Avalia????o e Monitoramento do Plano Plurianual de A');
INSERT INTO `tb_tipos_processo` VALUES(100001248, 'Lei de Diretrizes Or??ament??rias - LDO');
INSERT INTO `tb_tipos_processo` VALUES(100001249, 'Recomenda????es para Elabora????o da Lei de Diretrizes');
INSERT INTO `tb_tipos_processo` VALUES(100001250, 'Lei do Or??amento Anual - LOA');
INSERT INTO `tb_tipos_processo` VALUES(100001251, 'Mensagem Anual do Governador ?? ALMG');
INSERT INTO `tb_tipos_processo` VALUES(100001252, 'Execu????es F??sica e Or??ament??ria: Processo de Alter');
INSERT INTO `tb_tipos_processo` VALUES(100001253, 'Execu????o de Or??amento de Encargos Gerais do Estado');
INSERT INTO `tb_tipos_processo` VALUES(100001254, 'Execu????o de Or??amento de Encargos Gerais do Estado');
INSERT INTO `tb_tipos_processo` VALUES(100001255, 'Execu????es F??sica e Or??ament??ria: Descentraliza????o ');
INSERT INTO `tb_tipos_processo` VALUES(100001256, 'Execu????es F??sica e Or??ament??ria: Plano Operativo. ');
INSERT INTO `tb_tipos_processo` VALUES(100001257, 'Acompanhamento de Conv??nios de Entrada de Recursos');
INSERT INTO `tb_tipos_processo` VALUES(100001258, 'Gest??o Financeira: Elabora????o de Fluxo de Caixa');
INSERT INTO `tb_tipos_processo` VALUES(100001259, 'Controle de Encargos Gerais do Estado e das Unidad');
INSERT INTO `tb_tipos_processo` VALUES(100001260, 'Presta????o de Contas Mensal de Encargos Gerais do E');
INSERT INTO `tb_tipos_processo` VALUES(100001261, 'Presta????o de Contas Anual de Encargos Gerais do Es');
INSERT INTO `tb_tipos_processo` VALUES(100001262, 'Presta????o de Contas Mensal ??s Prefeituras Municipa');
INSERT INTO `tb_tipos_processo` VALUES(100001263, 'Encerramento do Exerc??cio da Unidade Or??ament??ria');
INSERT INTO `tb_tipos_processo` VALUES(100001264, 'Controle de Encargos Gerais do Estado e das Unidad');
INSERT INTO `tb_tipos_processo` VALUES(100001265, 'Controle de Encargos Gerais do Estado e das Unidad');
INSERT INTO `tb_tipos_processo` VALUES(100001266, 'Certifica????o Mensal de Saldos e Encargos Gerais do');
INSERT INTO `tb_tipos_processo` VALUES(100001267, 'Credenciamento de Bancos para Arrecada????o de Tribu');
INSERT INTO `tb_tipos_processo` VALUES(100001268, 'Controle Financeiro da Arrecada????o da Receita do E');
INSERT INTO `tb_tipos_processo` VALUES(100001269, 'Registro Cont??bil Di??rio das Transfer??ncias Federa');
INSERT INTO `tb_tipos_processo` VALUES(100001270, 'Caixa do Tesouro do Estado: Posi????o Di??ria do Caix');
INSERT INTO `tb_tipos_processo` VALUES(100001271, 'Caixa do Tesouro do Estado: Fechamento Di??rio do C');
INSERT INTO `tb_tipos_processo` VALUES(100001272, 'Acompanhamento Di??rio do Mercado Financeiro');
INSERT INTO `tb_tipos_processo` VALUES(100001273, 'Registro Cont??bil dos Rendimentos das Aplica????es F');
INSERT INTO `tb_tipos_processo` VALUES(100001274, 'Receita: Classifica????o da Receita Arrecadada');
INSERT INTO `tb_tipos_processo` VALUES(100001275, 'Receita: Capta????o de Recursos do Or??amento Geral d');
INSERT INTO `tb_tipos_processo` VALUES(100001276, 'Despesas: Reclassifica????o: Receitas a Restituir a ');
INSERT INTO `tb_tipos_processo` VALUES(100001277, 'Despesas: Controle e Acompanhamento de Precat??rios');
INSERT INTO `tb_tipos_processo` VALUES(100001278, 'Controles Or??ament??rio e Financeiro da Libera????o d');
INSERT INTO `tb_tipos_processo` VALUES(100001279, 'Pagamento de Taxas de Administra????o e Tarifas Banc');
INSERT INTO `tb_tipos_processo` VALUES(100001280, 'Acompanhamento de Registro no Cadastro Informativo');
INSERT INTO `tb_tipos_processo` VALUES(100001281, 'Acompanhamento de Registro no Cadastro ??nico de Co');
INSERT INTO `tb_tipos_processo` VALUES(100001282, 'Contrata????o de Empr??stimos, Financiamentos e outra');
INSERT INTO `tb_tipos_processo` VALUES(100001283, 'Contrata????o de Empr??stimos, Financiamentos e outra');
INSERT INTO `tb_tipos_processo` VALUES(100001284, 'Contrata????o de Empr??stimo e Financiamento - D??vida');
INSERT INTO `tb_tipos_processo` VALUES(100001285, 'Contrata????o de Empr??stimo e Financiamento - D??vida');
INSERT INTO `tb_tipos_processo` VALUES(100001286, 'Administra????o da D??vida P??blica Fundada do Estado:');
INSERT INTO `tb_tipos_processo` VALUES(100001287, 'Administra????o da D??vida P??blica Fundada do Estado:');
INSERT INTO `tb_tipos_processo` VALUES(100001288, 'Recebimento e Libera????o de Recursos de Empr??stimos');
INSERT INTO `tb_tipos_processo` VALUES(100001289, 'Recursos de Empr??stimos Externos: Registros de Lib');
INSERT INTO `tb_tipos_processo` VALUES(100001290, 'Pagamento da D??vida: Apura????o do Valor Dedut??vel d');
INSERT INTO `tb_tipos_processo` VALUES(100001291, 'Administra????o da D??vida P??blica Fundada do Estado:');
INSERT INTO `tb_tipos_processo` VALUES(100001292, 'Controle e Acompanhamento Mensal da D??vida P??blica');
INSERT INTO `tb_tipos_processo` VALUES(100001293, 'Controle Or??ament??rio Mensal da D??vida P??blica Fun');
INSERT INTO `tb_tipos_processo` VALUES(100001294, 'Controle e Acompanhamento da D??vida: Controle do F');
INSERT INTO `tb_tipos_processo` VALUES(100001295, 'Participa????o Acion??ria do Estado - Governan??a Corp');
INSERT INTO `tb_tipos_processo` VALUES(100001296, 'Participa????o Acion??ria do Estado - Governan??a Corp');
INSERT INTO `tb_tipos_processo` VALUES(100001297, 'Participa????o Acion??ria do Estado - Governan??a Corp');
INSERT INTO `tb_tipos_processo` VALUES(100001298, 'Participa????o Acion??ria do Estado - Governan??a Corp');
INSERT INTO `tb_tipos_processo` VALUES(100001299, 'Participa????o Acion??ria do Estado - Governan??a Corp');
INSERT INTO `tb_tipos_processo` VALUES(100001300, 'Ajuste Fiscal: Regime de Recupera????o Fiscal');
INSERT INTO `tb_tipos_processo` VALUES(100001301, 'Certifica????o Mensal de Saldos do Fundo Financeiro ');
INSERT INTO `tb_tipos_processo` VALUES(100001302, 'Registro Cont??bil das Contribui????es ao Fundo Financeiro de Previd??ncia da ALMG');
INSERT INTO `tb_tipos_processo` VALUES(100001303, 'Gest??o das Atividades Cont??beis: Normatiza????o e Or');
INSERT INTO `tb_tipos_processo` VALUES(100001304, 'Controle das Atividades Cont??beis');
INSERT INTO `tb_tipos_processo` VALUES(100001305, 'Gest??o das Atividades Cont??beis: Demonstrativos e ');
INSERT INTO `tb_tipos_processo` VALUES(100001306, 'Gest??o das Atividades Cont??beis: Responsabilidade ');
INSERT INTO `tb_tipos_processo` VALUES(100001307, 'Gest??o das Atividades Cont??beis: Coleta de Dados C');
INSERT INTO `tb_tipos_processo` VALUES(100001308, 'Balan??o Geral do Estado');
INSERT INTO `tb_tipos_processo` VALUES(100001309, 'Atendimento e Fornecimento de documenta????o da Extinta Caixa Econ??mica do Estado (MINASCAIXA)');
INSERT INTO `tb_tipos_processo` VALUES(100001310, 'Comunica????o: Servi??o Postal');
INSERT INTO `tb_tipos_processo` VALUES(100001311, 'Comunica????o: Sedex Nacional e Internacional');
INSERT INTO `tb_tipos_processo` VALUES(100001312, 'Comunica????o: Serca/Malote');
INSERT INTO `tb_tipos_processo` VALUES(100001313, 'Comunica????o: Servi??o de Transporte de Cargas');
INSERT INTO `tb_tipos_processo` VALUES(100001314, 'Comunica????o: Outros Servi??os Postais');
INSERT INTO `tb_tipos_processo` VALUES(100001315, 'Eventos: Concursos: Documentos T??cnicos');
INSERT INTO `tb_tipos_processo` VALUES(100001316, 'Eventos: Concursos: Documentos Financeiros');
INSERT INTO `tb_tipos_processo` VALUES(100001317, 'Visitas e Visitantes aos ??rg??os: Visitas T??cnicas');
INSERT INTO `tb_tipos_processo` VALUES(100001318, 'Visitas e Visitantes aos ??rg??os: Visitas Monitorad');
INSERT INTO `tb_tipos_processo` VALUES(100001319, 'Visitas e Visitantes aos ??rg??os: Visitas Monitorad');
INSERT INTO `tb_tipos_processo` VALUES(100001320, 'Outras Atividades/Transa????es de Gest??o Institucional: Cartas de Apresenta????o e Recomenda????o');
INSERT INTO `tb_tipos_processo` VALUES(100001321, 'Outras Atividades/Transa????es de Gest??o Institucional: Comunicados e Informes');
INSERT INTO `tb_tipos_processo` VALUES(100001322, 'Outras Atividades/Transa????es de Gest??o Institucional: Convites Diversos');
INSERT INTO `tb_tipos_processo` VALUES(100001323, 'Outras Atividades/Transa????es de Gest??o Institucion');
INSERT INTO `tb_tipos_processo` VALUES(100001324, 'Outras Atividades/Transa????es de Gest??o Institucion');
INSERT INTO `tb_tipos_processo` VALUES(100001325, 'Outras Atividades/Transa????es de Gest??o Institucional: Pedidos. Oferecimentos e Informa????es Diversas');
INSERT INTO `tb_tipos_processo` VALUES(100001326, 'Outras Atividades/Transa????es de Gest??o Institucion');
INSERT INTO `tb_tipos_processo` VALUES(100001327, 'Indica????o Parlamentar Sa??de - Custeio');
INSERT INTO `tb_tipos_processo` VALUES(100001328, 'Indica????o Parlamentar Sa??de - Investimento');
INSERT INTO `tb_tipos_processo` VALUES(100001329, 'Eventos: Promovidos pelo ??rg??o (Congressos. Confer??ncias, Treinamentos. Workshops...)');
INSERT INTO `tb_tipos_processo` VALUES(100001330, 'RH: Exonera????o Ex Officio - Decretos n?? 47.606 e  n?? 47.608');
INSERT INTO `tb_tipos_processo` VALUES(100001331, 'RH: Taxa????o - Decretos n?? 47.606 e n?? 47.608');
INSERT INTO `tb_tipos_processo` VALUES(100001332, 'RH: Verifica????o de Pend??ncia Cont??bil');
INSERT INTO `tb_tipos_processo` VALUES(100001333, 'Indica????o Parlamentar Sa??de - Ve??culos');
INSERT INTO `tb_tipos_processo` VALUES(100001334, 'Patrim??nio Imobili??rio: Cess??o, Permiss??o. Autoriz');
INSERT INTO `tb_tipos_processo` VALUES(100001335, 'SEAPA - Proalminas');
INSERT INTO `tb_tipos_processo` VALUES(100001336, 'Loteria _ Opera????es');
INSERT INTO `tb_tipos_processo` VALUES(100001338, 'RH: Contrato Administrativo - Nova Contrata????o');
INSERT INTO `tb_tipos_processo` VALUES(100001339, 'RH: Est??gio - Encerramento');
INSERT INTO `tb_tipos_processo` VALUES(100001340, 'Ordena????o Territorial: Legisla????o Urban??stica');
INSERT INTO `tb_tipos_processo` VALUES(100001341, 'Ordena????o Territorial: Planos Diretores');
INSERT INTO `tb_tipos_processo` VALUES(100001342, 'Ordena????o Territorial: Gest??o da Informa????o dos Pl');
INSERT INTO `tb_tipos_processo` VALUES(100001343, 'RH: Movimenta????o Interna de Servidor');
INSERT INTO `tb_tipos_processo` VALUES(100001344, 'IEF: Autoriza????o de Pesquisa Cient??fica');
INSERT INTO `tb_tipos_processo` VALUES(100001345, 'IEF: Cadastro de Aula de Campo');
INSERT INTO `tb_tipos_processo` VALUES(100001346, 'SEGOV - PADEM -  Programa de Apoio ao Desenvolvime');
INSERT INTO `tb_tipos_processo` VALUES(100001347, 'Gest??o de Contrato: Cobran??a/Notifica????o Extrajudi');
INSERT INTO `tb_tipos_processo` VALUES(100001348, 'Opera????es Financ. de Cr??dito: Acomp. de Reg. Cadas');
INSERT INTO `tb_tipos_processo` VALUES(100001349, 'Opera????es Financeiras de Cr??dito: Acompanhamento d');
INSERT INTO `tb_tipos_processo` VALUES(100001350, 'Parcelamento do Solo: Fiscaliza????o');
INSERT INTO `tb_tipos_processo` VALUES(100001351, 'Anu??ncia Pr??via: Parcelamento do Solo');
INSERT INTO `tb_tipos_processo` VALUES(100001352, 'Organiza????o Administrativa: Estudos e Propostas de Reestrutura????o Organizacional');
INSERT INTO `tb_tipos_processo` VALUES(100001353, 'Desenvolvimento das Microrregi??es: Plano Microrreg');
INSERT INTO `tb_tipos_processo` VALUES(100001354, 'Linhas de Transporte Coletivo Intermunicipal de Pa');
INSERT INTO `tb_tipos_processo` VALUES(100001355, 'Linhas de Transporte Coletivo Metropolitano de Pas');
INSERT INTO `tb_tipos_processo` VALUES(100001356, 'Permiss??o de Transporte de Passageiros por T??xi Es');
INSERT INTO `tb_tipos_processo` VALUES(100001357, 'Cadastro de Permission??rio e Cadastro do Motorista');
INSERT INTO `tb_tipos_processo` VALUES(100001358, 'Processo de Autoriza????o: Autoriza????o de Funcioname');
INSERT INTO `tb_tipos_processo` VALUES(100001359, 'Processo de Autoriza????o: Mudan??a de denomina????o de');
INSERT INTO `tb_tipos_processo` VALUES(100001360, 'Processo de Autoriza????o: Autoriza????o de Funcioname');
INSERT INTO `tb_tipos_processo` VALUES(100001361, 'RH: SEF CONTRIBUI????O PREVIDENCI??RIA');
INSERT INTO `tb_tipos_processo` VALUES(100001362, 'SEAPA - Solicita????o de Doa????o/Emenda Parlamentar');
INSERT INTO `tb_tipos_processo` VALUES(100001363, 'LEMG - Disponibilidade de Sistema');
INSERT INTO `tb_tipos_processo` VALUES(100001364, 'LEMG - Documenta????o de Habilita????o');
INSERT INTO `tb_tipos_processo` VALUES(100001365, 'LEMG - Documenta????o de Premiados');
INSERT INTO `tb_tipos_processo` VALUES(100001366, 'LEMG - Fundo de Premia????o');
INSERT INTO `tb_tipos_processo` VALUES(100001367, 'LEMG - Fundo de Marketing');
INSERT INTO `tb_tipos_processo` VALUES(100001368, 'RH: EPPGG - Movimenta????o e Exerc??cio');
INSERT INTO `tb_tipos_processo` VALUES(100001369, 'RH: Concess??o de Vale Transporte');
INSERT INTO `tb_tipos_processo` VALUES(100001370, 'Aliena????o de Material Permanente e de Consumo: Lei');
INSERT INTO `tb_tipos_processo` VALUES(100001371, 'Aliena????o de Material Permanente e de Consumo: Ces');
INSERT INTO `tb_tipos_processo` VALUES(100001372, 'Gest??o T??cnica de Projetos Ambientais: ??reas Conta');
INSERT INTO `tb_tipos_processo` VALUES(100001373, 'FEAM - Gest??o T??cnica de Projetos Ambientais: ??rea');
INSERT INTO `tb_tipos_processo` VALUES(100001374, 'Processo Judicial - Teste Psicol??gico');
INSERT INTO `tb_tipos_processo` VALUES(100001375, 'Patrim??nio Imobili??rio: Regulariza????o de Imoveis -');
INSERT INTO `tb_tipos_processo` VALUES(100001376, 'FAPEMIG - Presta????o de Contas Financeira');
INSERT INTO `tb_tipos_processo` VALUES(100001377, 'Produ????o de Medicamento');
INSERT INTO `tb_tipos_processo` VALUES(100001378, 'PRODEMGE: Prova de Conceito de Plataforma de Compu');
INSERT INTO `tb_tipos_processo` VALUES(100001379, 'Celebra????o de Contrato de Gest??o');
INSERT INTO `tb_tipos_processo` VALUES(100001380, 'Qualifica????o de Organiza????es Sociais (OS)');
INSERT INTO `tb_tipos_processo` VALUES(100001381, 'SETOP: Certificado PMQP-H');
INSERT INTO `tb_tipos_processo` VALUES(100001382, 'Incorpora????o: Mercadorias Apreendidas e Abandonada');
INSERT INTO `tb_tipos_processo` VALUES(100001383, 'SEF- PMPF  Ra????es Secas Tipo PET');
INSERT INTO `tb_tipos_processo` VALUES(100001385, 'Presta????o de Contas Anual para o TCEMG - Entidade ');
INSERT INTO `tb_tipos_processo` VALUES(100001386, 'Presta????o de Contas Anual para o TCEMG - Fundos Es');
INSERT INTO `tb_tipos_processo` VALUES(100001387, 'Presta????o de Contas Anual para o TCEMG - Empresas ');
INSERT INTO `tb_tipos_processo` VALUES(100001388, 'FAPEMIG - Presta????o de Contas T??cnica-Cient??fica');
INSERT INTO `tb_tipos_processo` VALUES(100001389, 'Gest??o de TIC: Servi??o de Transmiss??o de Dados, Vo');
INSERT INTO `tb_tipos_processo` VALUES(100001390, 'LEMG - Publicidade');
INSERT INTO `tb_tipos_processo` VALUES(100001391, 'LEMG - Plano de Jogo');
INSERT INTO `tb_tipos_processo` VALUES(100001392, 'LEMG - Teleatendimento');
INSERT INTO `tb_tipos_processo` VALUES(100001393, 'LEMG - Pr??mio Extra TOTOLOT');
INSERT INTO `tb_tipos_processo` VALUES(100001394, 'Contabilidade: Adiantamento e Empr??stimo a Servido');
INSERT INTO `tb_tipos_processo` VALUES(100001395, 'RH: Ass??dio Moral');
INSERT INTO `tb_tipos_processo` VALUES(100001396, 'LEMG - IRRF');
INSERT INTO `tb_tipos_processo` VALUES(100001397, 'LEMG - Processos Diversos');
INSERT INTO `tb_tipos_processo` VALUES(100001398, 'Previd??ncia. Assist??ncia. Seguridade Social: Pol??t');
INSERT INTO `tb_tipos_processo` VALUES(100001399, 'Previd??ncia. Assist??ncia. Seguridade Social: Benef');
INSERT INTO `tb_tipos_processo` VALUES(100001400, 'Previd??ncia. Assist??ncia. Seguridade Social: Benef');
INSERT INTO `tb_tipos_processo` VALUES(100001401, 'Previd??ncia. Assist??ncia. Seguridade Social: Benef??cios: Aposentadoria');
INSERT INTO `tb_tipos_processo` VALUES(100001402, 'Previd??ncia. Assist??ncia. Seguridade Social: Aposentadoria - Apura????o de Tempo de Servi??o');
INSERT INTO `tb_tipos_processo` VALUES(100001403, 'Previd??ncia. Assist??ncia. Seguridade Social: Aposentadoria - Pens??es');
INSERT INTO `tb_tipos_processo` VALUES(100001404, 'Previd??ncia. Assist??ncia. Seguridade Social: Apose');
INSERT INTO `tb_tipos_processo` VALUES(100001405, 'Previd??ncia. Assist??ncia. Seguridade Social: Apose');
INSERT INTO `tb_tipos_processo` VALUES(100001406, 'Moderniza????o Institucional: Estudo de Viabilidade ');
INSERT INTO `tb_tipos_processo` VALUES(100001407, 'RH: Indeniza????o do saldo de f??rias regulamentares');
INSERT INTO `tb_tipos_processo` VALUES(100001408, 'DEER - Declara????o de Ve??culo Escolar');
INSERT INTO `tb_tipos_processo` VALUES(100001409, 'DEER - Declara????o de Cadastro e Fretamento');
INSERT INTO `tb_tipos_processo` VALUES(100001410, 'RH: Substitui????o Tempor??ria (CBMMG)');
INSERT INTO `tb_tipos_processo` VALUES(100001411, 'Contabilidade: Balan??o Geral');
INSERT INTO `tb_tipos_processo` VALUES(100001412, 'Destina????o de Documentos: An??lise. Avalia????o. Sele????o');
INSERT INTO `tb_tipos_processo` VALUES(100001413, 'Previd??ncia. Assist??ncia. Seguridade Social: Assis');
INSERT INTO `tb_tipos_processo` VALUES(100001414, 'Previd??ncia. Assist??ncia. Seguridade Social: Benef');
INSERT INTO `tb_tipos_processo` VALUES(100001415, 'Funcionamento Escolar: Estudos das Normas da Educa');
INSERT INTO `tb_tipos_processo` VALUES(100001416, 'Regularidade de Funcionamento da Escola: Valida????o');
INSERT INTO `tb_tipos_processo` VALUES(100001417, 'SEPLAG - Assesoria de Rela????es Sindicais - ARS');
INSERT INTO `tb_tipos_processo` VALUES(100001418, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001419, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001420, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001421, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001422, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001423, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001424, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001425, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001427, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001428, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001429, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001430, 'DEER - Movimenta????o Cadastral Fretamento - Interior');
INSERT INTO `tb_tipos_processo` VALUES(100001431, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001432, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001433, 'Gest??o de Atas de Registro de Pre??os: Processo Adm');
INSERT INTO `tb_tipos_processo` VALUES(100001434, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001435, 'DEER - Movimenta????o Cadastral Fretamento - Regional Uberl??ndia');
INSERT INTO `tb_tipos_processo` VALUES(100001436, 'IEF: Criador Amador de Passeriformes da Fauna Silv');
INSERT INTO `tb_tipos_processo` VALUES(100001437, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001438, 'Eventos: Promovidos por outras Institui????es (Congressos. Confer??ncias, Treinamentos, Workshops...)');
INSERT INTO `tb_tipos_processo` VALUES(100001439, 'Eventos: Promovidos pelo ??rg??o (Solenidades. Comem');
INSERT INTO `tb_tipos_processo` VALUES(100001440, 'Eventos: Promovidos por outras institui????es (Solen');
INSERT INTO `tb_tipos_processo` VALUES(100001441, 'RH: Capta????o e Sele????o - HEMOMINAS');
INSERT INTO `tb_tipos_processo` VALUES(100001442, 'Doa????o');
INSERT INTO `tb_tipos_processo` VALUES(100001443, 'Aquisi????o - Doa????o Manifesta????o de Interesse');
INSERT INTO `tb_tipos_processo` VALUES(100001444, 'Aquisi????o - Doa????o Chamamento P??blico');
INSERT INTO `tb_tipos_processo` VALUES(100001445, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001446, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001447, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001448, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001449, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001450, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001451, 'DEER - Movimenta????o Cadastral Fretamento - Regiona');
INSERT INTO `tb_tipos_processo` VALUES(100001452, 'Regulariza????o e Titula????o Fundi??ria Rural');
INSERT INTO `tb_tipos_processo` VALUES(100001453, 'Gest??o de TIC: Servi??o Telef??nico');
INSERT INTO `tb_tipos_processo` VALUES(100001454, 'SEE_ Gest??o de Conv??nios - Entre entidades Governa');
INSERT INTO `tb_tipos_processo` VALUES(100001455, 'Aliena????o: Apreens??es e Abandono');
INSERT INTO `tb_tipos_processo` VALUES(100001456, 'RH: Movimenta????o Interna de Servidor - HEMOMINAS');
INSERT INTO `tb_tipos_processo` VALUES(100001457, 'IGAM - Pedido de Restitui????o de Ind??bito Tribut??ri');
INSERT INTO `tb_tipos_processo` VALUES(100001458, 'IEF - Pedido de Restitui????o de Ind??bito Tribut??rio');
INSERT INTO `tb_tipos_processo` VALUES(100001459, 'SEMAD - Pedido de Restitui????o de Ind??bito Tribut??r');
INSERT INTO `tb_tipos_processo` VALUES(100001460, 'FEAM - Pedido de Restitui????o de Ind??bito Tribut??ri');
INSERT INTO `tb_tipos_processo` VALUES(100001461, 'DEER - Infra????o de Tr??nsito');
INSERT INTO `tb_tipos_processo` VALUES(100001462, 'DEER - Infra????o de Tr??nsito: Identifica????o  do Con');
INSERT INTO `tb_tipos_processo` VALUES(100001463, 'DEER - Infra????o de Transito: Identifica????o do real');
INSERT INTO `tb_tipos_processo` VALUES(100001464, 'DEER - Infra????o de Transito: Recurso CETRAN');
INSERT INTO `tb_tipos_processo` VALUES(100001465, 'DEER - Infra????o de Transito: Defesa da Autua????o');
INSERT INTO `tb_tipos_processo` VALUES(100001466, 'DEER - Infra????o de Transito: Recurso JARI/DEER-MG');
INSERT INTO `tb_tipos_processo` VALUES(100001468, 'Previd??ncia. Assist??ncia. Seguridade Social: Avali');
INSERT INTO `tb_tipos_processo` VALUES(100001469, 'Previd??ncia. Assist??ncia. Seguridade Social: Benef');
INSERT INTO `tb_tipos_processo` VALUES(100001470, 'Contratos de Gest??o: Avalia????o de Gest??o e Resulta');
INSERT INTO `tb_tipos_processo` VALUES(100001471, 'Previd??ncia. Assist??ncia. Seguridade Social: Outro');
INSERT INTO `tb_tipos_processo` VALUES(100001472, 'Previd??ncia. Assist??ncia. Seguridade Social: Pedidos, Oferecimentos e Informa????es');
INSERT INTO `tb_tipos_processo` VALUES(100001473, 'JUCEMG: Redesim MG');
INSERT INTO `tb_tipos_processo` VALUES(100001474, 'JUCEMG: Sala Mineira do Empreendedor');
INSERT INTO `tb_tipos_processo` VALUES(100001475, 'UNIMONTES -  Acad??mico - Requerimento Gen??rico');
INSERT INTO `tb_tipos_processo` VALUES(100001476, 'Informa????es de Doadores e Pacientes');
INSERT INTO `tb_tipos_processo` VALUES(100001477, 'SES: Conv??nio com Munic??pios (Recursos Federais)');
INSERT INTO `tb_tipos_processo` VALUES(100001478, 'SES: Conv??nio com Entidade Privada Sem Fins Lucrat');
INSERT INTO `tb_tipos_processo` VALUES(100001479, 'SES: Conv??nio com Munic??pios (Recursos Estaduais)');
INSERT INTO `tb_tipos_processo` VALUES(100001480, 'SES: Conv??nio com Entidade Privada Sem Fins Lucrat');
INSERT INTO `tb_tipos_processo` VALUES(100001482, 'IGAM - Usos Isentos de Outorga');
INSERT INTO `tb_tipos_processo` VALUES(100001483, 'RH - Outros Direitos. Obriga????es. Vantagens. Concess??es: Aux??lios');
INSERT INTO `tb_tipos_processo` VALUES(100001484, 'Processo Judicial: Prontu??rio');
INSERT INTO `tb_tipos_processo` VALUES(100001485, 'Inscri????o Processo Elei????o Copam 2020/2022');
INSERT INTO `tb_tipos_processo` VALUES(100001486, 'SEINFRA: Transporte Intermunicipal - Empresa');
INSERT INTO `tb_tipos_processo` VALUES(100001487, 'SEINFRA: Transporte Intermunicipal - Linhas');
INSERT INTO `tb_tipos_processo` VALUES(100001488, 'SEINFRA: Transporte Intermunicipal - Ve??culos');
INSERT INTO `tb_tipos_processo` VALUES(100001489, 'SEINFRA: Transporte Intermunicipal - Outros Requer');
INSERT INTO `tb_tipos_processo` VALUES(100001490, 'PMMG: Emiss??o de Certid??es');
INSERT INTO `tb_tipos_processo` VALUES(100001491, 'PMMG: Pasta Funcional F??sica');
INSERT INTO `tb_tipos_processo` VALUES(100001492, 'RH: Auditoria da Folha de Pagamento: Recupera????o de Valores');
INSERT INTO `tb_tipos_processo` VALUES(100001493, 'RH: Auditoria da Folha de Pagamento: Reten????es de Pagamento');
INSERT INTO `tb_tipos_processo` VALUES(100003315, 'RH: Reop????o Semad');
INSERT INTO `tb_tipos_processo` VALUES(100003465, 'RH: Atribui????o e Revoga????o de GFPE');
INSERT INTO `tb_tipos_processo` VALUES(100003765, 'RH: Afastamento aguardando transfer??ncia para inatividade');
INSERT INTO `tb_tipos_processo` VALUES(100004815, 'RH: Monitor Individual ??? Dos??metro');
INSERT INTO `tb_tipos_processo` VALUES(100004965, 'RH: Jornada de Trabalho - IPSEMG');
INSERT INTO `tb_tipos_processo` VALUES(100005115, 'RH: Jornada de Trabalho - M??dico - IPSEMG');
INSERT INTO `tb_tipos_processo` VALUES(100005265, 'RH: Dispensa de Ponto Para Participa????o em Eventos');
INSERT INTO `tb_tipos_processo` VALUES(100005415, 'RH: Retorno Antecipado de Afastamento');
INSERT INTO `tb_tipos_processo` VALUES(100006765, 'RH: Gratifica????o de Incentivo a Produtividade (GIPPEA)');
INSERT INTO `tb_tipos_processo` VALUES(100006915, 'Tr??mite de Processo F??sico e/ou Objeto');
INSERT INTO `tb_tipos_processo` VALUES(100007815, 'RH: Atribui????o ou Dispensa de Gratifica????o Tempor??ria Estrat??gica (GTEI)');
INSERT INTO `tb_tipos_processo` VALUES(100011115, 'RH: Pens??o Alimento');
INSERT INTO `tb_tipos_processo` VALUES(100012465, 'RH: Concess??o de Jornada Estendida - UNIMONTES');
INSERT INTO `tb_tipos_processo` VALUES(100012615, 'RH: Certificado de Avalia????o de T??tulos - CAT');
INSERT INTO `tb_tipos_processo` VALUES(100013065, 'RH: Requisi????o de Teletrabalho');
INSERT INTO `tb_tipos_processo` VALUES(100015015, 'RH: Pasta Funcional - Migra????o Ponto Digital');
INSERT INTO `tb_tipos_processo` VALUES(100021166, 'RH: Afastamento COVID-19');
INSERT INTO `tb_tipos_processo` VALUES(100022366, 'RH: Licen??a por motivo de doen??a em pessoa na fam??lia');
INSERT INTO `tb_tipos_processo` VALUES(100023865, 'RH - Declara????o de Bens e Valores - IPSEMG');
INSERT INTO `tb_tipos_processo` VALUES(100024165, 'RH: Prontu??rio M??dico');
INSERT INTO `tb_tipos_processo` VALUES(100025215, 'IPSEMG - Inclus??o de Dependente ?? Assist??ncia Sa??de');
INSERT INTO `tb_tipos_processo` VALUES(100025216, 'IPSEMG - Exclus??o de Dependentes ?? Assist??ncia Sa??de');
INSERT INTO `tb_tipos_processo` VALUES(100025665, 'RH: Redu????o de Jornada de Trabalho');
INSERT INTO `tb_tipos_processo` VALUES(100025965, 'RH: Per??cia M??dica: Retifica????o de Licen??a');
INSERT INTO `tb_tipos_processo` VALUES(100025966, 'RH: Per??cia M??dica: Justificativa de aus??ncia em junta m??dica');
INSERT INTO `tb_tipos_processo` VALUES(100025967, 'RH: Per??cia M??dica: Fotoc??pia');
INSERT INTO `tb_tipos_processo` VALUES(100025968, 'RH: Per??cia M??dica: Outros');
INSERT INTO `tb_tipos_processo` VALUES(100026115, 'RH: Per??cia M??dica: Isen????o de Imposto de Renda');
INSERT INTO `tb_tipos_processo` VALUES(100026116, 'RH: Per??cia M??dica: Ajustamento Funcional');
INSERT INTO `tb_tipos_processo` VALUES(100026117, 'RH: Per??cia M??dica: Recurso');
INSERT INTO `tb_tipos_processo` VALUES(100026865, 'RH: Per??cia M??dica - BIM');
INSERT INTO `tb_tipos_processo` VALUES(100027015, 'RH: Per??cia M??dica: Informa????o de Licen??a');
INSERT INTO `tb_tipos_processo` VALUES(100027165, 'RH: Per??cia M??dica: Entrega de Documentos');
INSERT INTO `tb_tipos_processo` VALUES(100027315, 'RH: Per??cia M??dica: CAT');
INSERT INTO `tb_tipos_processo` VALUES(100027615, 'RH: Per??cia M??dica: Licen??a para Tratamento de Sa??de');
INSERT INTO `tb_tipos_processo` VALUES(100028815, 'RH - Contrato Administrativo - Celebra????o');
INSERT INTO `tb_tipos_processo` VALUES(100029265, 'RH: Pasta Funcional F??sica');
INSERT INTO `tb_tipos_processo` VALUES(100030315, 'RH: Atendimento Sociofuncional');
INSERT INTO `tb_tipos_processo` VALUES(100035715, 'RH: Servi??o eleitoral com gera????o de folga compensativa');

INSERT INTO `tb_usuarios` VALUES(1, 1501, 3, 'Carga Inicial', 'administrador@planejamento.mg.gov.br', '999999', '99999999999', '7b48a10755de57fd1e60a653c33f7d6c005d3862260b86ca179d8d278a33bae8d3af96228314bc71f9206763801a84e9f16ff5ecac76469993e4a3e8539e0256bhcxARkqQ9PQnd0V2UnjDWiqyhyoMnheirAvQRfUq/M=', NULL, '999999999', 990000999, NULL, NULL, '2021-06-18 13:29:37', '0', 0, '0');
