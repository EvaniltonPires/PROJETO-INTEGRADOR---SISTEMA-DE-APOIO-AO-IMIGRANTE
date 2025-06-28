programa
{
    const inteiro MAX = 10

    cadeia nomes[MAX]
    cadeia nacionalidades[MAX]
    cadeia idiomas[MAX]
    cadeia emails[MAX]
    cadeia senhas[MAX]
    inteiro qtdUsuarios = 0

    funcao inicio()
    {
        inteiro opcao, opcaoLogin, posUsuario, tentativas
        cadeia emailInput, senhaInput
        logico autenticado

        tentativas = 0
        autenticado = falso

        escreva("=== IMIGRA+ BRASIL ===\n")

        // Cadastro inicial
        enquanto (qtdUsuarios < MAX)
        {
            cadastrarUsuario()
            se (qtdUsuarios < MAX)
            {
                escreva("Cadastrar outro usuário? (1-sim / 0-nao): ")
                leia(opcao)
                se (opcao == 0)
                {
                    pare
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

                posUsuario = -1
                para (inteiro i = 0; i < qtdUsuarios; i = i + 1)
                {
                    se (emails[i] == emailInput e senhas[i] == senhaInput)
                    {
                        posUsuario = i
                        autenticado = verdadeiro
                        pare
                    }
                }

                se (autenticado)
                {
                    escreva("Login realizado com sucesso!\n")
                    menuPrincipal(idiomas[posUsuario], posUsuario)
                }
                senao
                {
                    escreva("E-mail ou senha incorretos.\n")
                    tentativas = tentativas + 1
                }
            }
            senao se (opcaoLogin == 2)
            {
                escreva("Digite seu e-mail para recuperação: ")
                leia(emailInput)

                posUsuario = -1
                para (inteiro i = 0; i < qtdUsuarios; i = i + 1)
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

        se (autenticado == falso)
        {
            escreva("Número máximo de tentativas atingido. Saindo...\n")
        }
    }

    funcao cadastrarUsuario()
    {
        cadeia senha1, senha2, emailTemp, idiomaTemp, nomeTemp, nacionalidadeTemp
        logico emailValido, senhaConfere, idiomaValido, emailUnico

        emailValido = falso
        senhaConfere = falso

        escreva("\nCadastro do usuário ", qtdUsuarios + 1, " de ", MAX, "\n")

        escreva("Nome: ")
        leia(nomeTemp)

        escreva("Nacionalidade: ")
        leia(nacionalidadeTemp)

        escreva("Idioma (portugues ou ingles): ")
        leia(idiomaTemp)

        enquanto (idiomaTemp != "portugues" e idiomaTemp != "ingles")
        {
            escreva("Idioma inválido. Digite 'portugues' ou 'ingles': ")
            leia(idiomaTemp)
        }

        enquanto (emailValido == falso)
        {
            escreva("E-mail: ")
            leia(emailTemp)
            emailValido = verdadeiro

            // Verificar se tem '@'
            se (contemArroba(emailTemp) == falso)
            {
                escreva("E-mail inválido (deve conter '@'). Digite outro.\n")
                emailValido = falso
            }
            senao
            {
                emailUnico = verdadeiro
                para (inteiro i = 0; i < qtdUsuarios; i = i + 1)
                {
                    se (emails[i] == emailTemp)
                    {
                        escreva("E-mail já cadastrado. Digite outro.\n")
                        emailUnico = falso
                        pare
                    }
                }
                se (emailUnico == falso)
                {
                    emailValido = falso
                }
            }
        }

        enquanto (senhaConfere == falso)
        {
            escreva("Senha: ")
            leia(senha1)
            escreva("Confirme a senha: ")
            leia(senha2)

            se (senha1 == senha2)
            {
                senhaConfere = verdadeiro
            }
            senao
            {
                escreva("Senhas não conferem. Tente novamente.\n")
            }
        }

        nomes[qtdUsuarios] = nomeTemp
        nacionalidades[qtdUsuarios] = nacionalidadeTemp
        idiomas[qtdUsuarios] = idiomaTemp
        emails[qtdUsuarios] = emailTemp
        senhas[qtdUsuarios] = senha1

        qtdUsuarios = qtdUsuarios + 1
    }

    funcao menuPrincipal(cadeia idioma, inteiro indiceUsuario)
    {
        inteiro opcaoMenu, i, confirma
        opcaoMenu = 0

        enquanto (opcaoMenu != 5)
        {
            se (idioma == "portugues")
            {
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

                se (opcaoMenu == 1)
                {
                    escreva("Nome: ", nomes[indiceUsuario], "\n")
                    escreva("Nacionalidade: ", nacionalidades[indiceUsuario], "\n")
                    escreva("Idioma: ", idiomas[indiceUsuario], "\n")
                    escreva("E-mail: ", emails[indiceUsuario], "\n")
                }
                senao se (opcaoMenu == 2)
                {
                    alterarSenha(indiceUsuario)
                }
                senao se (opcaoMenu == 3)
                {
                    editarPerfil(indiceUsuario)
                }
                senao se (opcaoMenu == 4)
                {
                    escreva("Tem certeza que deseja excluir sua conta? (1-sim / 0-nao): ")
                    leia(confirma)
                    se (confirma == 1)
                    {
                        excluirUsuario(indiceUsuario)
                        escreva("Conta excluída com sucesso. Saindo...\n")
                        opcaoMenu = 5
                    }
                }
                senao se (opcaoMenu == 6)
                {
                    escreva("\n=== USUÁRIOS CADASTRADOS ===\n")
                    para (i = 0; i < qtdUsuarios; i = i + 1)
                    {
                        escreva(i + 1, ". ", nomes[i], " - ", emails[i], "\n")
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
                escreva("\n=== MAIN MENU ===\n")
                escreva("Hello, ", nomes[indiceUsuario], "!\n")
                escreva("1 - View Profile\n")
                escreva("2 - Change Password\n")
                escreva("3 - Edit Profile\n")
                escreva("4 - Delete Account\n")
                escreva("5 - Logout\n")
                escreva("Choose an option: ")
                leia(opcaoMenu)

                se (opcaoMenu == 1)
                {
                    escreva("Name: ", nomes[indiceUsuario], "\n")
                    escreva("Nationality: ", nacionalidades[indiceUsuario], "\n")
                    escreva("Language: ", idiomas[indiceUsuario], "\n")
                    escreva("Email: ", emails[indiceUsuario], "\n")
                }
                senao se (opcaoMenu == 2)
                {
                    alterarSenha(indiceUsuario)
                }
                senao se (opcaoMenu == 3)
                {
                    editarPerfil(indiceUsuario)
                }
                senao se (opcaoMenu == 4)
                {
                    escreva("Are you sure you want to delete your account? (1-yes / 0-no): ")
                    leia(confirma)
                    se (confirma == 1)
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

    funcao alterarSenha(inteiro i)
    {
        cadeia senha1, senha2
        logico senhaConfere

        senhaConfere = falso

        enquanto (senhaConfere == falso)
        {
            escreva("Digite a nova senha: ")
            leia(senha1)
            escreva("Confirme a nova senha: ")
            leia(senha2)

            se (senha1 == senha2)
            {
                senhas[i] = senha1
                escreva("Senha alterada com sucesso!\n")
                senhaConfere = verdadeiro
            }
            senao
            {
                escreva("Senhas não conferem. Tente novamente.\n")
            }
        }
    }

    funcao editarPerfil(inteiro i)
    {
        cadeia novoNome, novaNacionalidade, novoIdioma

        escreva("Novo nome: ")
        leia(novoNome)
        escreva("Nova nacionalidade: ")
        leia(novaNacionalidade)
        escreva("Novo idioma (portugues ou ingles): ")
        leia(novoIdioma)

        enquanto (novoIdioma != "portugues" e novoIdioma != "ingles")
        {
            escreva("Idioma inválido. Digite 'portugues' ou 'ingles': ")
            leia(novoIdioma)
        }

        nomes[i] = novoNome
        nacionalidades[i] = novaNacionalidade
        idiomas[i] = novoIdioma

        escreva("Perfil atualizado com sucesso!\n")
    }

    funcao excluirUsuario(inteiro indice)
    {
        para (inteiro i = indice; i < qtdUsuarios - 1; i = i + 1)
        {
            nomes[i] = nomes[i + 1]
            nacionalidades[i] = nacionalidades[i + 1]
            idiomas[i] = idiomas[i + 1]
            emails[i] = emails[i + 1]
            senhas[i] = senhas[i + 1]
        }
        qtdUsuarios = qtdUsuarios - 1
    }

    funcao logico contemArroba(cadeia texto)
    {
        inteiro i
        para (i = 0; i < comprimento(texto); i = i + 1)
        {
            se (subcadeia(texto, i, 1) == "@")
            {
                retorne verdadeiro
            }
        }
        retorne falso
    }
}
