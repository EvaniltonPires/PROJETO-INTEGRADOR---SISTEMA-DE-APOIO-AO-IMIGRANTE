/* // ==============================================
//        SISTEMA DE CADASTRO IMIGRA+ BRASIL
// ==============================================
// Este programa simula um sistema de cadastro de usu�rios,
// com as seguintes funcionalidades principais:
//
// 1. Cadastro de at� 10 usu�rios com:
//    - Nome
//    - Nacionalidade
//    - Idioma (portugu�s ou ingl�s)
//    - E-mail (�nico)
//    - Senha
//
// 2. Login com autentica��o por e-mail e senha
//    - M�ximo de 3 tentativas
//
// 3. Recupera��o de senha por e-mail
//
// 4. Menu principal ap�s login (em portugu�s ou ingl�s):
//    - Ver perfil
//    - Alterar senha
//    - Editar informa��es do perfil
//    - Excluir conta
//    - Listar todos os usu�rios cadastrados (apenas em portugu�s)
//
// 5. Valida��es inclu�das:
//    - Idioma deve ser "portugues" ou "ingles"
//    - E-mail deve ser �nico
//
// OBS: Os dados s�o armazenados temporariamente em mem�ria (vetores).
// N�o h� persist�ncia em arquivo.
//
// Desenvolvido para fins educacionais com estrutura em pseudoc�digo.
// ==============================================

 */

programa
{
    // Constante para o n�mero m�ximo de usu�rios
    const inteiro MAX = 10

    // Vetores para armazenar os dados dos usu�rios
    cadeia nomes[MAX]
    cadeia nacionalidades[MAX]
    cadeia idiomas[MAX]
    cadeia emails[MAX]
    cadeia senhas[MAX]
    inteiro qtdUsuarios = 0 // Contador de usu�rios cadastrados

    // Fun��o principal
    funcao inicio()
    {
        // Vari�veis auxiliares para login e controle
        inteiro opcao, opcaoLogin, i, posUsuario
        cadeia emailInput, senhaInput
        logico autenticado = falso
        inteiro tentativas = 0

        escreva("=== IMIGRA+ BRASIL ===\n") // T�tulo do programa

        // In�cio do processo de cadastro de usu�rios
        enquanto (qtdUsuarios < MAX)
        {
            escreva("\nCadastro do usu�rio ", qtdUsuarios + 1, " de ", MAX, "\n")
            
            // Leitura dos dados
            escreva("Nome: ")
            leia(nomes[qtdUsuarios])
            escreva("Nacionalidade: ")
            leia(nacionalidades[qtdUsuarios])
            escreva("Idioma (portugues ou ingles): ")
            leia(idiomas[qtdUsuarios])

            // Valida��o do idioma digitado
            enquanto (idiomas[qtdUsuarios] != "portugues" e idiomas[qtdUsuarios] != "ingles")
            {
                escreva("Idioma inv�lido. Digite 'portugues' ou 'ingles': ")
                leia(idiomas[qtdUsuarios])
            }

            // Verifica��o de duplicidade de e-mail
            logico emailValido = falso
            enquanto (emailValido == falso)
            {
                emailValido = verdadeiro
                escreva("E-mail: ")
                leia(emails[qtdUsuarios])

                // Checa se o e-mail j� foi cadastrado
                para (i = 0; i < qtdUsuarios; i = i + 1)
                {
                    se (emails[i] == emails[qtdUsuarios])
                    {
                        escreva("E-mail j� cadastrado. Digite outro.\n")
                        emailValido = falso
                        pare
                    }
                }
            }

            escreva("Senha: ")
            leia(senhas[qtdUsuarios]) // Leitura da senha

            qtdUsuarios = qtdUsuarios + 1 // Incrementa a quantidade de usu�rios

            // Pergunta se o usu�rio deseja cadastrar outro
            se (qtdUsuarios < MAX)
            {
                escreva("Cadastrar outro usu�rio? (1-sim / 0-nao): ")
                leia(opcao)
                se (opcao == 0)
                {
                    pare // Sai do la�o se o usu�rio n�o quiser continuar
                }
            }
            senao
            {
                escreva("Limite de usu�rios atingido.\n")
            }
        }

        // Tela de login
        enquanto (tentativas < 3 e autenticado == falso)
        {
            escreva("\n=== LOGIN ===\n")
            escreva("1 - Entrar\n2 - Recuperar senha\nEscolha: ")
            leia(opcaoLogin)

            se (opcaoLogin == 1)
            {
                escreva("Digite seu e-mail: ")
                leia(emailInput)
                escreva("Digite sua senha: ")
                leia(senhaInput)

                posUsuario = -1 // Inicializa a posi��o do usu�rio como inv�lida

                // Verifica se as credenciais s�o v�lidas
                para (i = 0; i < qtdUsuarios; i = i + 1)
                {
                    se (emails[i] == emailInput e senhas[i] == senhaInput)
                    {
                        posUsuario = i
                        autenticado = verdadeiro
                        pare
                    }
                }

                // Verifica se o login foi bem-sucedido
                se (autenticado)
                {
                    escreva("Login realizado com sucesso!\n")
                    menuPrincipal(idiomas[posUsuario], nomes[posUsuario]) // Chama o menu
                }
                senao
                {
                    escreva("E-mail ou senha incorretos.\n")
                    tentativas = tentativas + 1
                }
            }
            senao se (opcaoLogin == 2) // Recupera��o de senha
            {
                escreva("Digite seu e-mail para recupera��o: ")
                leia(emailInput)

                posUsuario = -1

                // Busca pelo e-mail
                para (i = 0; i < qtdUsuarios; i = i + 1)
                {
                    se (emails[i] == emailInput)
                    {
                        posUsuario = i
                        pare
                    }
                }

                se (posUsuario != -1)
                {
                    escreva("Sua senha �: ", senhas[posUsuario], "\n")
                }
                senao
                {
                    escreva("E-mail n�o encontrado.\n")
                }
            }
            senao
            {
                escreva("Op��o inv�lida.\n")
            }
        }

        // Exibe mensagem se o usu�rio falhar no login
        se (autenticado == falso)
        {
            escreva("N�mero m�ximo de tentativas atingido. Saindo...\n")
        }
    }

    // Menu principal, ap�s login
    funcao menuPrincipal(cadeia idioma, cadeia nomeUsuario)
    {
        inteiro i
        inteiro opcaoMenu = 0
        inteiro indiceUsuario = -1

        // Busca o �ndice do usu�rio no vetor
        para (i = 0; i < qtdUsuarios; i = i + 1)
        {
            se (nomes[i] == nomeUsuario)
            {
                indiceUsuario = i
                pare
            }
        }

        // Se n�o encontrar o usu�rio
        se (indiceUsuario == -1)
        {
            escreva("Erro: usu�rio n�o encontrado.\n")
            retorne
        }

        // La�o de menu at� o usu�rio decidir sair
        enquanto (opcaoMenu != 5)
        {
            se (idioma == "portugues")
            {
                // Exibe o menu em portugu�s
                escreva("\n=== MENU PRINCIPAL ===\n")
                escreva("Ol�, ", nomes[indiceUsuario], "!\n")
                escreva("1 - Ver Perfil\n")
                escreva("2 - Alterar Senha\n")
                escreva("3 - Editar Perfil\n")
                escreva("4 - Excluir Conta\n")
                escreva("5 - Sair\n")
                escreva("6 - Ver Todos os Usu�rios\n")
                escreva("Escolha uma op��o: ")
                leia(opcaoMenu)

                // Op��es do menu
                se (opcaoMenu == 1) // Ver perfil
                {
                    escreva("Nome: ", nomes[indiceUsuario], "\n")
                    escreva("Nacionalidade: ", nacionalidades[indiceUsuario], "\n")
                    escreva("Idioma: ", idiomas[indiceUsuario], "\n")
                    escreva("E-mail: ", emails[indiceUsuario], "\n")
                }
                senao se (opcaoMenu == 2) // Alterar senha
                {
                    cadeia novaSenha
                    escreva("Digite a nova senha: ")
                    leia(novaSenha)
                    senhas[indiceUsuario] = novaSenha
                    escreva("Senha alterada com sucesso!\n")
                }
                senao se (opcaoMenu == 3) // Editar perfil
                {
                    escreva("Novo nome: ")
                    leia(nomes[indiceUsuario])
                    escreva("Nova nacionalidade: ")
                    leia(nacionalidades[indiceUsuario])
                    escreva("Novo idioma (portugues ou ingles): ")
                    leia(idiomas[indiceUsuario])
                    escreva("Perfil atualizado com sucesso!\n")
                }
                senao se (opcaoMenu == 4) // Excluir conta
                {
                    escreva("Tem certeza que deseja excluir sua conta? (1-sim / 0-nao): ")
                    leia(i)
                    se (i == 1)
                    {
                        excluirUsuario(indiceUsuario)
                        escreva("Conta exclu�da com sucesso. Saindo...\n")
                        opcaoMenu = 5
                    }
                }
                senao se (opcaoMenu == 6) // Listar todos os usu�rios
                {
                    escreva("\n=== USU�RIOS CADASTRADOS ===\n")
                    para (i = 0; i < qtdUsuarios; i = i + 1)
                    {
                        escreva(i+1, ". ", nomes[i], " - ", emails[i], "\n")
                    }
                }
                senao se (opcaoMenu == 5)
                {
                    escreva("Saindo...\n")
                }
                senao
                {
                    escreva("Op��o inv�lida.\n")
                }
            }
            senao se (idioma == "ingles")
            {
                // Exibe o menu em ingl�s
                escreva("\n=== MAIN MENU ===\n")
                escreva("Hello, ", nomes[indiceUsuario], "!\n")
                escreva("1 - View Profile\n")
                escreva("2 - Change Password\n")
                escreva("3 - Edit Profile\n")
                escreva("4 - Delete Account\n")
                escreva("5 - Logout\n")
                escreva("Choose an option: ")
                leia(opcaoMenu)

                // Op��es traduzidas
                se (opcaoMenu == 1)
                {
                    escreva("Name: ", nomes[indiceUsuario], "\n")
                    escreva("Nationality: ", nacionalidades[indiceUsuario], "\n")
                    escreva("Language: ", idiomas[indiceUsuario], "\n")
                    escreva("Email: ", emails[indiceUsuario], "\n")
                }
                senao se (opcaoMenu == 2)
                {
                    cadeia novaSenha
                    escreva("Enter new password: ")
                    leia(novaSenha)
                    senhas[indiceUsuario] = novaSenha
                    escreva("Password updated successfully!\n")
                }
                senao se (opcaoMenu == 3)
                {
                    escreva("New name: ")
                    leia(nomes[indiceUsuario])
                    escreva("New nationality: ")
                    leia(nacionalidades[indiceUsuario])
                    escreva("New language (portugues or ingles): ")
                    leia(idiomas[indiceUsuario])
                    escreva("Profile updated successfully!\n")
                }
                senao se (opcaoMenu == 4)
                {
                    escreva("Are you sure you want to delete your account? (1-yes / 0-no): ")
                    leia(i)
                    se (i == 1)
                    {
                        excluirUsuario(indiceUsuario)
                        escreva("Account deleted successfully. Logging out...\n")
                        opcaoMenu = 5
                    }
                }
                senao se (opcaoMenu == 5)
                {
                    escreva("Logging out...\n")
                }
                senao
                {
                    escreva("Invalid option.\n")
                }
            }
            senao
            {
                escreva("Idioma inv�lido. Saindo...\n")
                pare
            }
        }
    }

    // Fun��o para excluir um usu�rio dos vetores
    funcao excluirUsuario(inteiro indice)
    {
        inteiro i
        // Move todos os usu�rios uma posi��o para tr�s
        para (i = indice; i < qtdUsuarios - 1; i = i + 1)
        {
            nomes[i] = nomes[i + 1]
            nacionalidades[i] = nacionalidades[i + 1]
            idiomas[i] = idiomas[i + 1]
            emails[i] = emails[i + 1]
            senhas[i] = senhas[i + 1]
        }
        qtdUsuarios = qtdUsuarios - 1 // Decrementa a contagem
    }
}