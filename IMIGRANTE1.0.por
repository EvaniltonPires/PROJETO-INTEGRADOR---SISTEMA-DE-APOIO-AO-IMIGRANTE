programa
{
    // Constante e vetores
    const inteiro MAX = 10
    cadeia nomes[MAX], nacionalidades[MAX], idiomas[MAX], emails[MAX], senhas[MAX]
    inteiro qtdUsuarios = 0

    funcao inicio()
    {
        inteiro opcaoLogin, tentativas = 0
        inteiro posUsuario = -1
        logico autenticado = falso

        escreva("=== IMIGRA+ BRASIL ===\n")

        // Cadastro inicial
        enquanto (qtdUsuarios < MAX)
        {
            cadastrarUsuario()
            se (qtdUsuarios < MAX)
            {
                inteiro continuar
                escreva("Cadastrar outro usuário? (1-sim / 0-nao): ")
                leia(continuar)
                se (continuar == 0)
                {
                    pare
                }
            }
            senao
            {
                escreva("Limite de usuários atingido.\n")
            }
        }

        // Login
        enquanto (tentativas < 3 e nao autenticado)
        {
            escreva("\n=== LOGIN ===\n")
            escreva("1 - Entrar\n2 - Recuperar senha\nEscolha: ")
            leia(opcaoLogin)

            se (opcaoLogin == 1)
            {
                posUsuario = fazerLogin()
                autenticado = (posUsuario != -1)
                se (autenticado)
                {
                    escreva("Login realizado com sucesso!\n")
                    menuPrincipal(posUsuario)
                }
                senao
                {
                    escreva("E-mail ou senha incorretos.\n")
                    tentativas++
                }
            }
            senao se (opcaoLogin == 2)
            {
                recuperarSenha()
            }
            senao
            {
                escreva("Opção inválida.\n")
            }
        }

        se (nao autenticado)
        {
            escreva("Número máximo de tentativas atingido. Saindo...\n")
        }
    }

    // Cadastra um usuário
    funcao cadastrarUsuario()
    {
        cadeia idioma

        escreva("\nCadastro do usuário ", qtdUsuarios + 1, " de ", MAX, "\n")
        escreva("Nome: ")
        leia(nomes[qtdUsuarios])
        escreva("Nacionalidade: ")
        leia(nacionalidades[qtdUsuarios])

        // Validação do idioma
        escreva("Idioma (portugues ou ingles): ")
        leia(idiomas[qtdUsuarios])
        enquanto (idiomas[qtdUsuarios] != "portugues" e idiomas[qtdUsuarios] != "ingles")
        {
            escreva("Idioma inválido. Digite 'portugues' ou 'ingles': ")
            leia(idiomas[qtdUsuarios])
        }

        // E-mail único
        logico emailValido = falso
        enquanto (nao emailValido)
        {
            escreva("E-mail: ")
            leia(emails[qtdUsuarios])
            emailValido = verdadeiro

            para (inteiro i = 0; i < qtdUsuarios; i++)
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
        leia(senhas[qtdUsuarios])

        qtdUsuarios++
    }

    // Login
    funcao inteiro fazerLogin()
    {
        cadeia emailInput, senhaInput
        escreva("Digite seu e-mail: ")
        leia(emailInput)
        escreva("Digite sua senha: ")
        leia(senhaInput)

        para (inteiro i = 0; i < qtdUsuarios; i++)
        {
            se (emails[i] == emailInput e senhas[i] == senhaInput)
            {
                retorne i
            }
        }
        retorne -1
    }

    // Recuperação de senha
    funcao recuperarSenha()
    {
        cadeia emailRecuperar
        escreva("Digite seu e-mail para recuperação: ")
        leia(emailRecuperar)

        inteiro encontrado = -1
        para (inteiro i = 0; i < qtdUsuarios; i++)
        {
            se (emails[i] == emailRecuperar)
            {
                encontrado = i
                pare
            }
        }

        se (encontrado != -1)
        {
            escreva("Sua senha é: ", senhas[encontrado], "\n")
        }
        senao
        {
            escreva("E-mail não encontrado.\n")
        }
    }

    // Menu principal
    funcao menuPrincipal(inteiro indiceUsuario)
    {
        inteiro opcao = 0
        enquanto (opcao != 5)
        {
            cadeia idioma = idiomas[indiceUsuario]

            se (idioma == "portugues")
            {
                escreva("\n=== MENU PRINCIPAL ===\n")
                escreva("Olá, ", nomes[indiceUsuario], "!\n")
                escreva("1 - Ver Perfil\n2 - Alterar Senha\n3 - Editar Perfil\n4 - Excluir Conta\n5 - Sair\n6 - Ver Todos os Usuários\n")
                escreva("Escolha uma opção: ")
                leia(opcao)

                se (opcao == 1)
                {
                    verPerfil(indiceUsuario)
                }
                senao se (opcao == 2)
                {
                    alterarSenha(indiceUsuario)
                }
                senao se (opcao == 3)
                {
                    editarPerfil(indiceUsuario)
                }
                senao se (opcao == 4)
                {
                    excluirConta(indiceUsuario)
                    opcao = 5
                }
                senao se (opcao == 6)
                {
                    listarUsuarios()
                }
                senao se (opcao == 5)
                {
                    escreva("Saindo...\n")
                }
                senao
                {
                    escreva("Opção inválida.\n")
                }
            }
            senao
            {
                escreva("\n=== MAIN MENU ===\n")
                escreva("Hello, ", nomes[indiceUsuario], "!\n")
                escreva("1 - View Profile\n2 - Change Password\n3 - Edit Profile\n4 - Delete Account\n5 - Logout\n")
                escreva("Choose an option: ")
                leia(opcao)

                se (opcao == 1)
                {
                    verPerfil(indiceUsuario)
                }
                senao se (opcao == 2)
                {
                    alterarSenha(indiceUsuario)
                }
                senao se (opcao == 3)
                {
                    editarPerfil(indiceUsuario)
                }
                senao se (opcao == 4)
                {
                    excluirConta(indiceUsuario)
                    opcao = 5
                }
                senao se (opcao == 5)
                {
                    escreva("Logging out...\n")
                }
                senao
                {
                    escreva("Invalid option.\n")
                }
            }
        }
    }

    // Ver perfil
    funcao verPerfil(inteiro i)
    {
        escreva("Nome: ", nomes[i], "\n")
        escreva("Nacionalidade: ", nacionalidades[i], "\n")
        escreva("Idioma: ", idiomas[i], "\n")
        escreva("E-mail: ", emails[i], "\n")
    }

    // Alterar senha
    funcao alterarSenha(inteiro i)
    {
        cadeia nova
        escreva("Digite a nova senha: ")
        leia(nova)
        senhas[i] = nova
        escreva("Senha alterada com sucesso!\n")
    }

    // Editar perfil
    funcao editarPerfil(inteiro i)
    {
        escreva("Novo nome: ")
        leia(nomes[i])
        escreva("Nova nacionalidade: ")
        leia(nacionalidades[i])
        escreva("Novo idioma (portugues ou ingles): ")
        leia(idiomas[i])
        escreva("Perfil atualizado com sucesso!\n")
    }

    // Listar usuários
    funcao listarUsuarios()
    {
        escreva("\n=== USUÁRIOS CADASTRADOS ===\n")
        para (inteiro i = 0; i < qtdUsuarios; i++)
        {
            escreva(i+1, ". ", nomes[i], " - ", emails[i], "\n")
        }
    }

    // Excluir conta
    funcao excluirConta(inteiro indice)
    {
        inteiro confirmacao
        escreva("Tem certeza que deseja excluir sua conta? (1-sim / 0-nao): ")
        leia(confirmacao)

        se (confirmacao == 1)
        {
            para (inteiro i = indice; i < qtdUsuarios - 1; i++)
            {
                nomes[i] = nomes[i + 1]
                nacionalidades[i] = nacionalidades[i + 1]
                idiomas[i] = idiomas[i + 1]
                emails[i] = emails[i + 1]
                senhas[i] = senhas[i + 1]
            }
            qtdUsuarios--
            escreva("Conta excluída com sucesso.\n")
        }
    }
}
