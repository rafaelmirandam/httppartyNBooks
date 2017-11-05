

module Helpers

    def get_token(user)
        result = Books.post(
            '/api/token', 
            body: {
                email: @user[:email],
                password: @user[:password]
            }.to_json
        )
        return result.parsed_response['account_token']
    end

    def books
        [
            {
                title: 'A culpa é das estrelas',
                author: 'John Green',
                tags: [
                    'Romance'
                ]
            },
            {
                title: 'Game of Thrones',
                author: 'George R. R. Martin',
                tags: [
                    'Fantasia',
                    'Aventura'
                ]
            },
            {
                title: 'A Batalha do Apocalipse',
                author: 'Eduardo Spohr',
                tags: [
                    'Literatura fantástica',
                    'Literatura nacional'
                ]
            },
            {
                title: 'O Guia do Mochileiro Das Galáxias',
                author: 'Douglas Adams',
                tags: [
                    'Literatura Internacional',
                    'Ficção Cientifica'
                ]
            }
        ]
    end

end