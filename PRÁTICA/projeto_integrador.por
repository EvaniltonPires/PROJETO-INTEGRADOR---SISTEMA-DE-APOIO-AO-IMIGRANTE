programa{

	inclua biblioteca Arquivos --> arq
	inclua biblioteca Texto --> txt
	inclua biblioteca Tipos --> tp
	
	// funcão inicial do projeto para inicialiar o programa
	funcao inicio(){
		//inicializando o menu principal
		MenuPrincipal()
	}

	/***************************************************************************************************************************************/
	/* Parte do programa com o metodo para construir o menu com as opcoes principais do imigrante									*/
	/***************************************************************************************************************************************/
	funcao MenuPrincipal(){
		
		// iniciando o laco de repeticao do menu principal
		inteiro vMenu
		cadeia vQualquer
		faca
		{
			limpa()
			escreva("Escolha uma opção\n\n")
			
			escreva("  1. Imigrante \n")
			escreva("  2. Servicos de apoio\n")
			escreva("  9. Sair\n")
			
			escreva("Digite sua opção: ")
			
			leia(vMenu)

			escolha (vMenu)
			{
				caso 9:
					escreva("\n\nObrigado por utilizar!\n")
					pare
				
				caso 1: 
					limpa()
			 		MenuImigrante()			 		
			 		pare
			 	
			 	caso 2: 
			 		limpa()
			 		MenuServicoApoio()
			 		pare
			 	
			 	caso contrario:
			 		escreva("\n\nOpção invalida!\n")
			}			 
		}
		enquanto(vMenu != 9)
		
	}



/***************************************************************************************************************************************************************/
/* Imigrante 																													    */
/***************************************************************************************************************************************************************/

	/***************************************************************************************************************************************/
	/* Parte do programa com o metodo para construir o menu com as opcoes principais do imigrante									*/
	/***************************************************************************************************************************************/
	funcao MenuImigrante(){
		
		// iniciando o laco de repeticao do menu principal
		inteiro vMenu
		cadeia vQualquer
		inteiro vIdImigrante
		faca
		{
			limpa()
			escreva("Escolha uma opção\n\n")
			
			escreva("  1. Cadastrar Imigrante \n")
			escreva("  2. Listar Imigrante \n")
			escreva("  3. Editar Imigrante \n")
			escreva("  4. Excluir Imigrante \n")
			escreva("  9. Voltar ao menu principal \n")
			
			escreva("Digite sua opção: ")
			
			leia(vMenu)

			escolha (vMenu)
			{
				caso 9:
					pare
				
				caso 1: 
					limpa()
			 		imigranteSalvar()			 		
			 		escreva("\n\nPressione qualquer tecla para continuar!")
			 		leia(vQualquer)
			 		pare
			 	
			 	caso 2: 
			 		limpa()
			 		imigranteListar()
			 		escreva("\n\nPressione qualquer tecla para continuar!")
			 		leia(vQualquer)
			 		pare
			 	
			 	caso 3: 
			 		limpa()
			 		imigranteListar()
			 		escreva("\n\nEscolha um imigrante e informe o identificador:")
			 		leia(vIdImigrante)
			 		imigranteAlterar(vIdImigrante)
			 		pare
			 	
			 	caso 4: 
			 		limpa()
			 		imigranteListar()
			 		escreva("\n\nEscolha um imigrante e informe o identificador:")
			 		leia(vIdImigrante)
			 		imigranteExcluir(vIdImigrante)
			 		pare
			 	
			 	caso contrario:
			 		escreva("\n\nOpção invalida!\n")
			}			 
		}
		enquanto(vMenu != 9)
		
	}

	/***************************************************************************************************************************************/
	/* Parte do programa com os metodos para salvar o imigrante															     */
	/***************************************************************************************************************************************/
	funcao imigranteSalvar(){
		// declarando variaveis
		cadeia vNome
		cadeia vNacionalidade
		cadeia vDtNascimento
		cadeia vDocumento
		
		inteiro vArquivo
		inteiro vIdImigrante = 0
		cadeia vLinha

		// Limpando a tela para solicitar valores
		escreva("\n\n **********************************************************************")
		escreva("   Cadastro de imigrante ")
		escreva("**********************************************************************\n\n")
		
		// solicitando os dados
		escreva("Informe o Nome:")
		leia(vNome)
		escreva("Informe o Nacionalidade:")
		leia(vNacionalidade)
		escreva("Informe o Data de Nascimento:")
		leia(vDtNascimento)
		escreva("Informe o Documento de indentificação:")
		leia(vDocumento)

		// verificando se o arquivo exists
		se(arq.arquivo_existe("imigrante.txt")){
			// obtendo o identificador do arquivo fisico
			vArquivo = arq.abrir_arquivo("imigrante.txt", arq.MODO_LEITURA)	
				
			//lendo o arquivo linha a linha	
			vLinha = arq.ler_linha(vArquivo)
			enquanto(nao arq.fim_arquivo(vArquivo)){
				//lendo a linha e extraindo o id do imigrante
				vIdImigrante = tp.cadeia_para_inteiro(obterCampo_imigrante(vLinha, 0), 10)
				// lendo a arq linha
				vLinha = arq.ler_linha(vArquivo)
			}			
			//fechando o arquivo
			arq.fechar_arquivo(vArquivo)

			// abrindo o arquivo de dados e armazenando o id do arquivo
			vArquivo = arq.abrir_arquivo("imigrante.txt", arq.MODO_ACRESCENTAR)
			vIdImigrante = vIdImigrante + 1			
		}			
		senao{
			// abrindo o arquivo de dados e armazenando o id do arquivo
			vArquivo = arq.abrir_arquivo("imigrante.txt", arq.MODO_ESCRITA)
			vIdImigrante = 1
		}
			
		// gravando os dados separado por ; 
		arq.escrever_linha(vIdImigrante + ";" + vNome + ";" + vNacionalidade + ";" +vDtNascimento + ";" + vDocumento, vArquivo)
		
		// fechando o arquivo para salvar as alterações
		arq.fechar_arquivo(vArquivo)

		escreva("Imigrante salvo com sucesso!")		
	}
	
	/***************************************************************************************************************************************/
	/* Parte do programa com os metodo para listar todos os imigrantes														*/
	/***************************************************************************************************************************************/
	funcao imigranteListar(){
		inteiro id_arquivo
		inteiro vIdImigrante = 0
		cadeia vLinha

		// Limpando a tela para solicitar valores
		escreva("\n\n **********************************************************************")
		escreva("   Lista de imigrante ")
		escreva("**********************************************************************\n\n")

		se(arq.arquivo_existe("imigrante.txt")){
			// localizando o ultimo id para criar um novo
			id_arquivo = arq.abrir_arquivo("imigrante.txt", arq.MODO_LEITURA)		
			
			//montando titulo da tabela de resultaqdo
			escreva(completarEspacos("ID", 5) + " | ")
			escreva(completarEspacos("Nome", 50) + " | ")
			escreva(completarEspacos("NACIONALIDADE", 30) + " | ")
			escreva(completarEspacos("DT. NASCIMENTO", 15) + " | ")
			escreva(completarEspacos("DOCUMENTO", 15) + "\n")
			
			//lendo o arquivo linha a linha	
			vLinha = arq.ler_linha(id_arquivo)
			enquanto(nao arq.fim_arquivo(id_arquivo)){
				escreva(completarEspacos(obterCampo_imigrante(vLinha, 0),  5) + " | ")
				escreva(completarEspacos(obterCampo_imigrante(vLinha, 1), 50) + " | ")
				escreva(completarEspacos(obterCampo_imigrante(vLinha, 2), 30) + " | ")
				escreva(completarEspacos(obterCampo_imigrante(vLinha, 3), 15) + " | ")
				escreva(completarEspacos(obterCampo_imigrante(vLinha, 4), 15) + " \n")
				
				vLinha = arq.ler_linha(id_arquivo)
			}			
			arq.fechar_arquivo(id_arquivo)

		}			
		senao{
			escreva("Não existe dados de imigrante")
		}
			
	}
	
	/***************************************************************************************************************************************/
	/* Metodo que obtem dados de um imigrante selecionado			       													*/
	/***************************************************************************************************************************************/
	funcao logico imigranteDetalhe(inteiro pIdImigrante){
		inteiro id_arquivo
		cadeia vLinha
		logico vLocalizado = falso

		inteiro vIdImigrante = 0
		cadeia vNome
		cadeia vNacionalidade
		cadeia vDtNascimento
		cadeia vDocumento

		// Limpando a tela para solicitar valores
		escreva("\n\n **********************************************************************")
		escreva("   Detalhe do imigrante ")
		escreva("**********************************************************************\n\n")

		se(arq.arquivo_existe("imigrante.txt")){
			// localizando o ultimo id para criar um novo
			id_arquivo = arq.abrir_arquivo("imigrante.txt", arq.MODO_LEITURA)		
			
			//lendo o arquivo linha a linha	
			vLinha = arq.ler_linha(id_arquivo)
			enquanto(nao arq.fim_arquivo(id_arquivo)){
				se (obterCampo_imigrante(vLinha, 0) == tp.inteiro_para_cadeia(pIdImigrante, 10)){
					
					vIdImigrante = tp.cadeia_para_inteiro(obterCampo_imigrante(vLinha, 0), 10)
					vNome = obterCampo_imigrante(vLinha, 1)
					vNacionalidade = obterCampo_imigrante(vLinha, 2)
					vDtNascimento = obterCampo_imigrante(vLinha, 3)
					vDocumento = obterCampo_imigrante(vLinha, 4)
					
					vLocalizado = verdadeiro
					
					escreva(" ID: " + tp.inteiro_para_cadeia(vIdImigrante, 10))
					escreva(" Nome: " + vNome)
					escreva(" NACIONALIDADE: " + vNacionalidade)
					escreva(" DT. NASCIMENTO: " + vDtNascimento)
					escreva(" DOCUMENTO: " + vDocumento)
					 
				}
				
				vLinha = arq.ler_linha(id_arquivo)
			}			
			arq.fechar_arquivo(id_arquivo)

		}			
		senao{
			escreva("Não existe dados de imigrante")
		}

		retorne vLocalizado
			
	}

	/***************************************************************************************************************************************/
	/* Metodo que obtem novos dados e altera o imigrante selecionado       													*/
	/***************************************************************************************************************************************/
	funcao imigranteAlterar(inteiro pIdImigrante){
		
		inteiro id_arquivo
		cadeia vLinha
		logico vLocalizado = falso

		cadeia vAntigoRegistro = ""
		cadeia vNovoRegistro = ""

		inteiro vIdImigrante = 0
		cadeia vNome
		cadeia vNacionalidade
		cadeia vDtNascimento
		cadeia vDocumento

		// Limpando a tela para solicitar valores
		escreva("\n\n **********************************************************************")
		escreva("   Alteração do imigrante ")
		escreva("**********************************************************************\n\n")

		se(arq.arquivo_existe("imigrante.txt")){
			// localizando o ultimo id para criar um novo
			id_arquivo = arq.abrir_arquivo("imigrante.txt", arq.MODO_LEITURA)
			
			//lendo o arquivo linha a linha	
			vLinha = arq.ler_linha(id_arquivo)
			enquanto(nao arq.fim_arquivo(id_arquivo)){
				se (obterCampo_imigrante(vLinha, 0) == tp.inteiro_para_cadeia(pIdImigrante, 10)){

					vAntigoRegistro = vLinha
					
					vIdImigrante = tp.cadeia_para_inteiro(obterCampo_imigrante(vLinha, 0), 10)
					vNome = obterCampo_imigrante(vLinha, 1)
					vNacionalidade = obterCampo_imigrante(vLinha, 2)
					vDtNascimento = obterCampo_imigrante(vLinha, 3)
					vDocumento = obterCampo_imigrante(vLinha, 4)
					
					vLocalizado = verdadeiro
					
					escreva(" ID: " + tp.inteiro_para_cadeia(vIdImigrante, 10))
					escreva(" Nome: " + vNome)
					escreva(" NACIONALIDADE: " + vNacionalidade)
					escreva(" DT. NASCIMENTO: " + vDtNascimento)
					escreva(" DOCUMENTO: " + vDocumento)
					 
				}
				
				vLinha = arq.ler_linha(id_arquivo)
			}			
			arq.fechar_arquivo(id_arquivo)

			se(vLocalizado) {
	
				escreva("\n\n Informe os novos dados \n\n")
	
				// solicitando os dados
				escreva("Informe o Nome:")
				leia(vNome)
				escreva("Informe o Nacionalidade:")
				leia(vNacionalidade)
				escreva("Informe o Data de Nascimento:")
				leia(vDtNascimento)
				escreva("Informe o Documento de indentificação:")
				leia(vDocumento)
	
				vNovoRegistro = (vIdImigrante + ";" + vNome + ";" + vNacionalidade + ";" +vDtNascimento + ";" + vDocumento)
	
				arq.substituir_texto("imigrante.txt", vAntigoRegistro, vNovoRegistro, verdadeiro)
				escreva("\n\n Imigrante atualizado dom sucesso \n\n")
			}
		}			
		senao{
			escreva("Não existe dados de imigrante")
		}
		
	}

	/***************************************************************************************************************************************/
	/* Metodo que obtem novos dados e altera o imigrante selecionado       													*/
	/***************************************************************************************************************************************/
	funcao imigranteExcluir(inteiro pIdImigrante){
		
		inteiro id_arquivo
		cadeia vLinha
		logico vLocalizado = falso

		cadeia vRegistro = ""

		inteiro vExcluir = 0

		// Limpando a tela para solicitar valores
		escreva("\n\n **********************************************************************")
		escreva("   Excluir do imigrante ")
		escreva("**********************************************************************\n\n")

		se(arq.arquivo_existe("imigrante.txt")){
			// localizando o ultimo id para criar um novo
			id_arquivo = arq.abrir_arquivo("imigrante.txt", arq.MODO_LEITURA)		
			
			//lendo o arquivo linha a linha	
			vLinha = arq.ler_linha(id_arquivo)
			enquanto(nao arq.fim_arquivo(id_arquivo)){
				se (obterCampo_imigrante(vLinha, 0) == tp.inteiro_para_cadeia(pIdImigrante, 10)){

					vRegistro = vLinha					
					vLocalizado = verdadeiro
					
					escreva(" ID: " + obterCampo_imigrante(vLinha, 0))
					escreva(" Nome: " + obterCampo_imigrante(vLinha, 1))
					escreva(" Nacionalidade: " + obterCampo_imigrante(vLinha, 2))
					escreva(" Dt. nascimento: " + obterCampo_imigrante(vLinha, 3))
					escreva(" Documento: " + obterCampo_imigrante(vLinha, 4))
					 
				}
				
				vLinha = arq.ler_linha(id_arquivo)
			}			
			arq.fechar_arquivo(id_arquivo)

			se(vLocalizado) {
	
				escreva("\n\n Deseja realmente excluir esse imigrante (digite 1 para confirmar): ")
				leia(vExcluir)
				se(vExcluir == 1){
					// substituindo o valor por vazio para que na funcao limpaArquivo essa linha seja ignorada
					arq.substituir_texto("imigrante.txt", vRegistro, "", verdadeiro)
					limparArquivoImigrante()
					escreva("\n\n Imigrante atualizado dom sucesso \n\n")					
				}senao{
					escreva("\n\n Operação cancelada \n\n")		
								
				}
	
			}
		}			
		senao{
			escreva("Não existe dados de imigrante")
		}
		
	}
	
	/***************************************************************************************************************************************/
	/* Metodo de suporte para separa os dados salva nos arquivos															*/
	/***************************************************************************************************************************************/
	funcao cadeia obterCampo_imigrante(cadeia pLinha, inteiro pItem){

		/* Esta função serve para pega a linha que tem os dado separa por ;
		 *  e separa os valores no vetor, sendo um campo em cada espaço do vetor
		 *  o segunda paramentro é qual item do vetor que será retornado, sendo:
		 *  0 para ID
		 *  1 para NOME
		 *  2 para NACIONALIDADE
		 *  3 para DATA DE NASCIMENTO
		 *  4 PARA DOCUMENTO
		 */

		cadeia vValores[5]
		cadeia vlinha = pLinha
		cadeia vPosicao
		cadeia vRetorno

		//localizando o campo id na linha
		vValores[0] = txt.extrair_subtexto(vlinha, 0, txt.posicao_texto(";", vlinha, 0))
		vlinha = txt.extrair_subtexto(vlinha, txt.posicao_texto(";", vlinha, 0) + 1, txt.numero_caracteres(vlinha))
		
		//localizando o campo nome
		vValores[1] = txt.extrair_subtexto(vlinha, 0, txt.posicao_texto(";", vlinha, 0))
		vlinha = txt.extrair_subtexto(vlinha, txt.posicao_texto(";", vlinha, 0) + 1, txt.numero_caracteres(vlinha))

		//Localizando o campo nacionalidade
		vValores[2] = txt.extrair_subtexto(vlinha, 0, txt.posicao_texto(";", vlinha, 0))
		vlinha = txt.extrair_subtexto(vlinha, txt.posicao_texto(";", vlinha, 0) + 1, txt.numero_caracteres(vlinha))
		
		//Localizando o campo dt nascimento
		vValores[3] = txt.extrair_subtexto(vlinha, 0, txt.posicao_texto(";", vlinha, 0))
		vlinha = txt.extrair_subtexto(vlinha, txt.posicao_texto(";", vlinha, 0) + 1, txt.numero_caracteres(vlinha))

		//Localizando o campo documento
		vValores[4] = vlinha		

		retorne vValores[pItem]
	
	}

	/***************************************************************************************************************************************/
	/* Ler o arquivo original de imigrante, ignorando as linhas em branco e salva os dados em um novo arquivo com o mesmo nome			*/
	/***************************************************************************************************************************************/
	funcao limparArquivoImigrante(){
		
		// declarando variaveis
		inteiro vArquivoOrigem
		inteiro vArquivoDestino
		cadeia vLinhas[1000]
		inteiro vPos = 0

		//inicializando os valores do vetor
		vPos = 0
		para(inteiro i=0; i < 1000; i++){
			vLinhas[i] = ""
		}			

		// verificando se o arquivo exists
		se(arq.arquivo_existe("imigrante.txt")){
			// obtendo o identificador do arquivo fisico
			vArquivoOrigem = arq.abrir_arquivo("imigrante.txt", arq.MODO_LEITURA)	
				
			//lendo o arquivo linha a linha
			faca {
				vLinhas[vPos] = arq.ler_linha(vArquivoOrigem)
				vPos = vPos + 1					
			}enquanto(nao arq.fim_arquivo(vArquivoOrigem))
			
			//fechando o arquivo
			arq.fechar_arquivo(vArquivoOrigem)

			vArquivoDestino = arq.abrir_arquivo("imigrante.txt", arq.MODO_ESCRITA)	
			vPos = 0
			para(inteiro i=0; i < 1000; i++){
				se(txt.numero_caracteres(vLinhas[i]) > 3){
					arq.escrever_linha(vLinhas[i], vArquivoDestino)
				}
			}
			arq.fechar_arquivo(vArquivoDestino)


		}			
		
	}



/***************************************************************************************************************************************************************/
/* Servico																													    */
/***************************************************************************************************************************************************************/

	/***************************************************************************************************************************************/
	/* Parte do programa com o metodo para construir o menu com as opcoes principais do imigrante									*/
	/***************************************************************************************************************************************/
	funcao MenuServicoApoio(){
		
		// iniciando o laco de repeticao do menu principal
		inteiro vMenu
		cadeia vQualquer
		inteiro vIdServico
		faca
		{
			limpa()
			escreva("Escolha uma opção\n\n")
			
			escreva("  1. Cadastrar Servicos de apoio \n")
			escreva("  2. Listar Servicos de apoio \n")
			escreva("  3. Editar Servicos de apoio \n")
			escreva("  4. Excluir Servicos de apoio \n")
			escreva("  9. Voltar ao menu principal \n")
			
			escreva("Digite sua opção: ")
			
			leia(vMenu)

			escolha (vMenu)
			{
				caso 9:
					pare
				
				caso 1: 
					limpa()
			 		servicoApoioSalvar()			 		
			 		escreva("\n\nPressione qualquer tecla para continuar!")
			 		leia(vQualquer)
			 		pare
			 	
			 	caso 2: 
			 		limpa()
			 		servicoApoioListar()
			 		escreva("\n\nPressione qualquer tecla para continuar!")
			 		leia(vQualquer)
			 		pare
			 	
			 	caso 3: 
			 		limpa()
			 		servicoApoioListar()
			 		escreva("\n\nEscolha um servico de apoio e informe o identificador:")
			 		leia(vIdServico)
			 		servicoApoioAlterar(vIdServico)
			 		pare
			 	
			 	caso 4: 
			 		limpa()
			 		servicoApoioListar()
			 		escreva("\n\nEscolha um servico de apoio e informe o identificador:")
			 		leia(vIdServico)
			 		servicoApoioExcluir(vIdServico)
			 		pare
			 	
			 	caso contrario:
			 		escreva("\n\nOpção invalida!\n")
			}			 
		}
		enquanto(vMenu != 9)
		
	}

	/***************************************************************************************************************************************/
	/* Parte do programa com os metodos para salvar o servico de apoio												     	*/
	/***************************************************************************************************************************************/
	funcao servicoApoioSalvar(){
		// declarando variaveis
		cadeia vTipo
		cadeia vNome
		cadeia vEndereco
		cadeia vTelefone
		
		inteiro vArquivo
		inteiro vIdServicoApoio = 0
		cadeia vLinha

		// Limpando a tela para solicitar valores
		escreva("\n\n **********************************************************************")
		escreva("   Cadastro de Servico de Apoio")
		escreva("**********************************************************************\n\n")
		
		// solicitando os dados
		escreva("Informe o Tipo:")
		leia(vTipo)
		escreva("Informe o Nome:")
		leia(vNome)
		escreva("Informe o Endereco:")
		leia(vEndereco)
		escreva("Informe o Telefone:")
		leia(vTelefone)

		// verificando se o arquivo exists
		se(arq.arquivo_existe("servicoApoio.txt")){
			// obtendo o identificador do arquivo fisico
			vArquivo = arq.abrir_arquivo("servicoApoio.txt", arq.MODO_LEITURA)	
				
			//lendo o arquivo linha a linha	
			vLinha = arq.ler_linha(vArquivo)
			enquanto(nao arq.fim_arquivo(vArquivo)){
				//lendo a linha e extraindo o id do imigrante
				vIdServicoApoio = tp.cadeia_para_inteiro(obterCampo_servicoApoio(vLinha, 0), 10)
				// lendo a arq linha
				vLinha = arq.ler_linha(vArquivo)
			}			
			//fechando o arquivo
			arq.fechar_arquivo(vArquivo)

			// abrindo o arquivo de dados e armazenando o id do arquivo
			vArquivo = arq.abrir_arquivo("servicoApoio.txt", arq.MODO_ACRESCENTAR)
			vIdServicoApoio = vIdServicoApoio + 1			
		}			
		senao{
			// abrindo o arquivo de dados e armazenando o id do arquivo
			vArquivo = arq.abrir_arquivo("servicoApoio.txt", arq.MODO_ESCRITA)
			vIdServicoApoio = 1
		}
			
		// gravando os dados separado por ; 
		arq.escrever_linha(vIdServicoApoio + ";" + vTipo + ";" + vNome + ";" +vEndereco + ";" + vTelefone, vArquivo)
		
		// fechando o arquivo para salvar as alterações
		arq.fechar_arquivo(vArquivo)

		escreva("Imigrante salvo com sucesso!")		
	}

	/***************************************************************************************************************************************/
	/* Parte do programa com os metodo para listar todos os imigrantes														*/
	/***************************************************************************************************************************************/
	funcao servicoApoioListar(){
		inteiro id_arquivo
		inteiro vIdServicoApoio = 0
		cadeia vLinha

		// Limpando a tela para solicitar valores
		escreva("\n\n **********************************************************************")
		escreva("   Lista de Servicos de Apoios ")
		escreva("**********************************************************************\n\n")

		se(arq.arquivo_existe("servicoApoio.txt")){
			// localizando o ultimo id para criar um novo
			id_arquivo = arq.abrir_arquivo("servicoApoio.txt", arq.MODO_LEITURA)		
			
			//montando titulo da tabela de resultaqdo
			escreva(completarEspacos("ID", 5) + " | ")
			escreva(completarEspacos("TIPO", 30) + " | ")
			escreva(completarEspacos("NOME", 50) + " | ")
			escreva(completarEspacos("ENDERECO", 50) + " | ")
			escreva(completarEspacos("TELEFONE", 15) + "\n")
			
			//lendo o arquivo linha a linha	
			vLinha = arq.ler_linha(id_arquivo)
			enquanto(nao arq.fim_arquivo(id_arquivo)){
				escreva(completarEspacos(obterCampo_servicoApoio(vLinha, 0),  5) + " | ")
				escreva(completarEspacos(obterCampo_servicoApoio(vLinha, 1), 30) + " | ")
				escreva(completarEspacos(obterCampo_servicoApoio(vLinha, 2), 50) + " | ")
				escreva(completarEspacos(obterCampo_servicoApoio(vLinha, 3), 50) + " | ")
				escreva(completarEspacos(obterCampo_servicoApoio(vLinha, 4), 15) + " \n")
				
				vLinha = arq.ler_linha(id_arquivo)
			}			
			arq.fechar_arquivo(id_arquivo)

		}			
		senao{
			escreva("Não existe dados de servicos de apoio")
		}
			
	}

	/***************************************************************************************************************************************/
	/* Metodo que obtem novos dados e altera o imigrante selecionado       													*/
	/***************************************************************************************************************************************/
	funcao servicoApoioAlterar(inteiro pIdServicoApoio){
		
		inteiro id_arquivo
		cadeia vLinha
		logico vLocalizado = falso

		cadeia vAntigoRegistro = ""
		cadeia vNovoRegistro = ""

		inteiro vIdServicoApoio = 0
		cadeia vTipo
		cadeia vNome
		cadeia vEndereco
		cadeia vTelefone

		// Limpando a tela para solicitar valores
		escreva("\n\n **********************************************************************")
		escreva("   Alteração do Servico de apoio ")
		escreva("**********************************************************************\n\n")

		se(arq.arquivo_existe("servicoApoio.txt")){
			// localizando o ultimo id para criar um novo
			id_arquivo = arq.abrir_arquivo("servicoApoio.txt", arq.MODO_LEITURA)
			
			//lendo o arquivo linha a linha	
			vLinha = arq.ler_linha(id_arquivo)
			enquanto(nao arq.fim_arquivo(id_arquivo)){
				se (obterCampo_servicoApoio(vLinha, 0) == tp.inteiro_para_cadeia(pIdServicoApoio, 10)){
					vAntigoRegistro = vLinha
					
					vIdServicoApoio = tp.cadeia_para_inteiro(obterCampo_servicoApoio(vLinha, 0), 10)
					vTipo = obterCampo_servicoApoio(vLinha, 1)
					vNome = obterCampo_servicoApoio(vLinha, 2)
					vEndereco = obterCampo_servicoApoio(vLinha, 3)
					vTelefone = obterCampo_servicoApoio(vLinha, 4)
					
					vLocalizado = verdadeiro
					
					escreva(" ID: " + tp.inteiro_para_cadeia(vIdServicoApoio, 10))
					escreva(" Tipo: " + vTipo)
					escreva(" Nome: " + vNome)
					escreva(" Endereco: " + vEndereco)
					escreva(" Telefone: " + vTelefone)
					 
				}
				
				vLinha = arq.ler_linha(id_arquivo)
			}			
			arq.fechar_arquivo(id_arquivo)

			se(vLocalizado) {
	
				escreva("\n\n Informe os novos dados \n\n")
	
				// solicitando os dados
				escreva("Informe o Tipo:")
				leia(vTipo)
				escreva("Informe o Nome:")
				leia(vNome)
				escreva("Informe o Endereco:")
				leia(vEndereco)
				escreva("Informe o Telefone:")
				leia(vTelefone)
	
				vNovoRegistro = (vIdServicoApoio + ";" + vTipo + ";" + vNome + ";" +vEndereco + ";" + vTelefone)
	
				arq.substituir_texto("servicoApoio.txt", vAntigoRegistro, vNovoRegistro, verdadeiro)
				escreva("\n\n Servico de apoio atualizado dom sucesso \n\n")
			}
		}			
		senao{
			escreva("Não existe dados do servico de apoio")
		}
		leia(vTipo)
		
	}

	/***************************************************************************************************************************************/
	/* Metodo que obtem novos dados e altera o imigrante selecionado       													*/
	/***************************************************************************************************************************************/
	funcao servicoApoioExcluir(inteiro pIdServicoApoio){
		
		inteiro id_arquivo
		cadeia vLinha
		logico vLocalizado = falso

		cadeia vRegistro = ""

		inteiro vExcluir = 0

		// Limpando a tela para solicitar valores
		escreva("\n\n **********************************************************************")
		escreva("   Excluir o Servico de apoio ")
		escreva("**********************************************************************\n\n")

		se(arq.arquivo_existe("servicoApoio.txt")){
			// localizando o ultimo id para criar um novo
			id_arquivo = arq.abrir_arquivo("servicoApoio.txt", arq.MODO_LEITURA)		
			
			//lendo o arquivo linha a linha	
			vLinha = arq.ler_linha(id_arquivo)
			enquanto(nao arq.fim_arquivo(id_arquivo)){
				se (obterCampo_servicoApoio(vLinha, 0) == tp.inteiro_para_cadeia(pIdServicoApoio, 10)){

					vRegistro = vLinha					
					vLocalizado = verdadeiro
					
					escreva(" ID: " + obterCampo_servicoApoio(vLinha, 0))
					escreva(" Tipo: " + obterCampo_servicoApoio(vLinha, 1))
					escreva(" Nome: " + obterCampo_servicoApoio(vLinha, 2))
					escreva(" Endereco: " + obterCampo_servicoApoio(vLinha, 3))
					escreva(" Telefone: " + obterCampo_servicoApoio(vLinha, 4))
					 
				}
				
				vLinha = arq.ler_linha(id_arquivo)
			}			
			arq.fechar_arquivo(id_arquivo)

			se(vLocalizado) {
	
				escreva("\n\n Deseja realmente excluir esse servico de apoio (digite 1 para confirmar): ")
				leia(vExcluir)
				se(vExcluir == 1){
					// substituindo o valor por vazio para que na funcao limpaArquivo essa linha seja ignorada
					arq.substituir_texto("servicoApoio.txt", vRegistro, "", verdadeiro)
					limparArquivoServicoApoio()
					escreva("\n\n Servico de apoio atualizado dom sucesso \n\n")					
				}senao{
					escreva("\n\n Operação cancelada \n\n")		
								
				}
	
			}
		}			
		senao{
			escreva("Não existe dados de imigrante")
		}
		
	}	
	/***************************************************************************************************************************************/
	/* Metodo de suporte para separa os dados salva nos arquivos															*/
	/***************************************************************************************************************************************/
	funcao cadeia obterCampo_servicoApoio(cadeia pLinha, inteiro pItem){

		/* Esta função serve para pega a linha que tem os dado separa por ;
		 *  e separa os valores no vetor, sendo um campo em cada espaço do vetor
		 *  o segunda paramentro é qual item do vetor que será retornado, sendo:
		 *  0 para ID
		 *  1 para TIPO
		 *  2 para NOME
		 *  3 para ENDERECO
		 *  4 PARA TELEFONE
		 */

		cadeia vValores[5]
		cadeia vlinha = pLinha
		cadeia vPosicao
		cadeia vRetorno

		//localizando o campo id na linha
		vValores[0] = txt.extrair_subtexto(vlinha, 0, txt.posicao_texto(";", vlinha, 0))
		vlinha = txt.extrair_subtexto(vlinha, txt.posicao_texto(";", vlinha, 0) + 1, txt.numero_caracteres(vlinha))
		
		//localizando o campo nome
		vValores[1] = txt.extrair_subtexto(vlinha, 0, txt.posicao_texto(";", vlinha, 0))
		vlinha = txt.extrair_subtexto(vlinha, txt.posicao_texto(";", vlinha, 0) + 1, txt.numero_caracteres(vlinha))

		//Localizando o campo nacionalidade
		vValores[2] = txt.extrair_subtexto(vlinha, 0, txt.posicao_texto(";", vlinha, 0))
		vlinha = txt.extrair_subtexto(vlinha, txt.posicao_texto(";", vlinha, 0) + 1, txt.numero_caracteres(vlinha))
		
		//Localizando o campo dt nascimento
		vValores[3] = txt.extrair_subtexto(vlinha, 0, txt.posicao_texto(";", vlinha, 0))
		vlinha = txt.extrair_subtexto(vlinha, txt.posicao_texto(";", vlinha, 0) + 1, txt.numero_caracteres(vlinha))

		//Localizando o campo documento
		vValores[4] = vlinha		

		retorne vValores[pItem]
	
	}

	/***************************************************************************************************************************************/
	/* Ler o arquivo original de imigrante, ignorando as linhas em branco e salva os dados em um novo arquivo com o mesmo nome			*/
	/***************************************************************************************************************************************/
	funcao limparArquivoServicoApoio(){
		
		// declarando variaveis
		inteiro vArquivoOrigem
		inteiro vArquivoDestino
		cadeia vLinhas[1000]
		inteiro vPos = 0

		//inicializando os valores do vetor
		vPos = 0
		para(inteiro i=0; i < 1000; i++){
			vLinhas[i] = ""
		}			

		// verificando se o arquivo exists
		se(arq.arquivo_existe("servicoApoio.txt")){
			// obtendo o identificador do arquivo fisico
			vArquivoOrigem = arq.abrir_arquivo("servicoApoio.txt", arq.MODO_LEITURA)	
				
			//lendo o arquivo linha a linha
			faca {
				vLinhas[vPos] = arq.ler_linha(vArquivoOrigem)
				vPos = vPos + 1					
			}enquanto(nao arq.fim_arquivo(vArquivoOrigem))
			
			//fechando o arquivo
			arq.fechar_arquivo(vArquivoOrigem)

			vArquivoDestino = arq.abrir_arquivo("servicoApoio.txt", arq.MODO_ESCRITA)	
			vPos = 0
			para(inteiro i=0; i < 1000; i++){
				se(txt.numero_caracteres(vLinhas[i]) > 3){
					arq.escrever_linha(vLinhas[i], vArquivoDestino)
				}
			}
			arq.fechar_arquivo(vArquivoDestino)


		}			
		
	}



/***************************************************************************************************************************************************************/
/* Outros metodos																												    */
/***************************************************************************************************************************************************************/

	/***************************************************************************************************************************************/
	/* Ler o arquivo original de imigrante, ignorando as linhas em branco e salva os dados em um novo arquivo com o mesmo nome			*/
	/***************************************************************************************************************************************/
	funcao cadeia completarEspacos(cadeia pValor, inteiro pQtde){
		
		/* Esta função serve para incluir espaço ao final de uma texto até o limite 
		 * informado, isso ajuda na construção da tabela para mostrar em tela, 
		 * ficando todas as linhas com o mesmo tamanho 
		 */
		 
		inteiro vTamanha = txt.numero_caracteres(pValor)
		cadeia vResultado = pValor
		
		enquanto (txt.numero_caracteres(vResultado) < pQtde){
			vResultado = vResultado + " "			
		}
		retorne vResultado 		
	}
	
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 32144; 
 * @DOBRAMENTO-CODIGO = [7, 15, 66, 133, 197, 241, 298, 378, 442, 485, 536, 603, 667, 711, 791, 854, 897, 948];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */