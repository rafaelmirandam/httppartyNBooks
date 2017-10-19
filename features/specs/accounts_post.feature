#language: pt

Funcionalidade: Cadastro de usuários

    Contexto:Usuário informa os dados
            

    @smoke
    Cenario: Cadastro de novo usuário

        Dado que o cliente informou seus dados cadastrais:
            | name     | Rafael               |
            | email    | rafael@rafael.com    |
            | password | 123456               |
        Quando faço uma requisição POST para o serviço accounts
        Então o código de resposta deve ser "200"

    @duplicado
    Cenario: Não permite email duplicado

        Dado que o cliente informou seus dados cadastrais:
            | name     | Rafael               |
            | email    | rafael@rafael.com    |
            | password | 123456               |
        Mas esse cliente já está cadastrado
        Quando faço uma requisição POST para o serviço accounts
        Então o código de resposta deve ser "409"
        E deve ser exibido um JSON com a mensagem:
        """
        O e-mail informado, ja está cadastrado!
        """

        Esquema do Cenario: Campos obrigatórios

        Dado que o cliente informou seus dados cadastrais:
            | name     | <nome>  |
            | email    | <email> |
            | password | <senha> |
        Quando faço uma requisição POST para o serviço accounts
        Então o código de resposta deve ser "409"
        E deve ser exibido um JSON com a mensagem:
        """
        <mensagem>
        """

        Exemplos:
        |nome  |email           |senha  |mensagem                   |
        |      |rafael@teste.com|123456 |Nome deve ser obrigatório! |
        |Rafael|                |123456 |Email deve ser obrigatório!|
        |Rafael|rafael@teste.com|       |Senha deve ser obrigatório!|