/* // ==============================================
//        SISTEMA DE CADASTRO IMIGRA+ BRASIL
// ==============================================
// Este programa simula um sistema de cadastro de usuários,
// com as seguintes funcionalidades principais:
//
// 1. Cadastro de até 10 usuários com:
//    - Nome
//    - Nacionalidade
//    - Idioma (português ou inglês)
//    - E-mail (único)
//    - Senha
//
// 2. Login com autenticação por e-mail e senha
//    - Máximo de 3 tentativas
//
// 3. Recuperação de senha por e-mail
//
// 4. Menu principal após login (em português ou inglês):
//    - Ver perfil
//    - Alterar senha
//    - Editar informações do perfil
//    - Excluir conta
//    - Listar todos os usuários cadastrados (apenas em português)
//
// 5. Validações incluídas:
//    - Idioma deve ser "portugues" ou "ingles"
//    - E-mail deve ser único
//
// OBS: Os dados são armazenados temporariamente em memória (vetores).
// Não há persistência em arquivo.
//
// Desenvolvido para fins educacionais com estrutura em pseudocódigo.
// ==============================================

 */

programa
{
    // Constante para o número máximo de usuários
    const inteiro MAX = 10

    // Vetores para armazenar os dados dos usuários
    cadeia nomes[MAX]
    cadeia nacionalidades[MAX]
    cadeia idiomas[MAX]
    cadeia emails[MAX]
    cadeia senhas[MAX]
    inteiro qtdUsuarios = 0 // Contador de usuários cadastrados

    // Função principal
    funcao inicio()
    {
        // Variáveis auxiliares para login e controle
        inteiro opcao, opcaoLogin, i, posUsuario
        cadeia emailInput, senhaInput
        logico autenticado = falso
        inteiro tentativas = 0

        escreva("=== IMIGRA+ BRASIL ===\n") // Título do programa

        // Início do processo de cadastro de usuários
        enquanto (qtdUsuarios < MAX)
        {
            escreva("\nCadastro do usuário ", qtdUsuarios + 1, " de ", MAX, "\n")
            
            // Leitura dos dados
            escreva("Nome: ")
            leia(nomes[qtdUsuarios])
            escreva("Nacionalidade: ")
            leia(nacionalidades[qtdUsuarios])
            escreva("Idioma (portugues ou ingles): ")
            leia(idiomas[qtdUsuarios])

            // Validação do idioma digitado
            enquanto (idiomas[qtdUsuarios] != "portugues" e idiomas[qtdUsuarios] != "ingles")
            {
                escreva("Idioma inválido. Digite 'portugues' ou 'ingles': ")
                leia(idiomas[qtdUsuarios])
            }

            // Verificação de duplicidade de e-mail
            logico emailValido = falso
            enquanto (emailValido == falso)
            {
                emailValido = verdadeiro
                escreva("E-mail: ")
                leia(emails[qtdUsuarios])

                // Checa se o e-mail já foi cadastrado
                para (i = 0; i < qtdUsuarios; i = i + 1)
                {
                    se (emails[i] == emails[qtdUsuarios])
                    {
                        escreva("E-mail já cadastrado. Digite outro.\n")
                        emailValido = falso
                        pare
                    }
                }
            }

            escreva("Senha: ")
            leia(senhas[qtdUsuarios]) // Leitura da senha

            qtdUsuarios = qtdUsuarios + 1 // Incrementa a quantidade de usuários

            // Pergunta se o usuário deseja cadastrar outro
            se (qtdUsuarios < MAX)
            {
                escreva("Cadastrar outro usuário? (1-sim / 0-nao): ")
                leia(opcao)
                se (opcao == 0)
                {
                    pare // Sai do laço se o usuário não quiser continuar
                }
            }
            senao
            {
                escreva("Limite de usuários atingido.\n")
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

                posUsuario = -1 // Inicializa a posição do usuário como inválida

                // Verifica se as credenciais são válidas
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
            senao se (opcaoLogin == 2) // Recuperação de senha
            {
                escreva("Digite seu e-mail para recuperação: ")
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
                    escreva("Sua senha é: ", senhas[posUsuario], "\n")
                }
                senao
                {
                    escreva("E-mail não encontrado.\n")
                }
            }
            senao
            {
                escreva("Opção inválida.\n")
            }
        }

        // Exibe mensagem se o usuário falhar no login
        se (autenticado == falso)
        {
            escreva("Número máximo de tentativas atingido. Saindo...\n")
        }
    }

    // Menu principal, após login
    funcao menuPrincipal(cadeia idioma, cadeia nomeUsuario)
    {
        inteiro i
        inteiro opcaoMenu = 0
        inteiro indiceUsuario = -1

        // Busca o índice do usuário no vetor
        para (i = 0; i < qtdUsuarios; i = i + 1)
        {
            se (nomes[i] == nomeUsuario)
            {
                indiceUsuario = i
                pare
            }
        }

        // Se não encontrar o usuário
        se (indiceUsuario == -1)
        {
            escreva("Erro: usuário não encontrado.\n")
            retorne
        }

        // Laço de menu até o usuário decidir sair
        enquanto (opcaoMenu != 5)
        {
            se (idioma == "portugues")
            {
                // Exibe o menu em português
                escreva("\n=== MENU PRINCIPAL ===\n")
                escreva("Olá, ", nomes[indiceUsuario], "!\n")
                escreva("1 - Ver Perfil\n")
                escreva("2 - Alterar Senha\n")
                escreva("3 - Editar Perfil\n")
                escreva("4 - Excluir Conta\n")
                escreva("5 - Sair\n")
                escreva("6 - Ver Todos os Usuários\n")
                escreva("Escolha uma opção: ")
                leia(opcaoMenu)

                // Opções do menu
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
                        escreva("Conta excluída com sucesso. Saindo...\n")
                        opcaoMenu = 5
                    }
                }
                senao se (opcaoMenu == 6) // Listar todos os usuários
                {
                    escreva("\n=== USUÁRIOS CADASTRADOS ===\n")
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
                    escreva("Opção inválida.\n")
                }
            }
            senao se (idioma == "ingles")
            {
                // Exibe o menu em inglês
                escreva("\n=== MAIN MENU ===\n")
                escreva("Hello, ", nomes[indiceUsuario], "!\n")
                escreva("1 - View Profile\n")
                escreva("2 - Change Password\n")
                escreva("3 - Edit Profile\n")
                escreva("4 - Delete Account\n")
                escreva("5 - Logout\n")
                escreva("Choose an option: ")
                leia(opcaoMenu)

                // Opções traduzidas
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
                escreva("Idioma inválido. Saindo...\n")
                pare
            }
        }
    }

    // Função para excluir um usuário dos vetores
    funcao excluirUsuario(inteiro indice)
    {
        inteiro i
        // Move todos os usuários uma posição para trás
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