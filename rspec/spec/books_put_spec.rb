

describe('PUT /api/books') do

    before(:all) do
        @user = {
            name: 'Rafael5',
            email: 'rafael5@email.com',
            password: '221133'
        }
        Books.delete("/api/accounts/#{@user[:email]}")
        Books.post('/api/accounts', body: @user.to_json)
        
        @token = get_token(@user)
    end

    describe('status 200') do
        
        before(:all) do
            @book = {
                title: 'Ready Player One',
                author: 'Ernest Cline',
                tags: [
                    'Literatura estrangeira',
                    'Ficção'
                ]
            }

            Books.post(
                '/api/books',
                body: @book.to_json,
                headers: {
                    'ACCESS_TOKEN' => @token
                }
            )

            @book = Books.get(
                '/api/books',
                query: {title: @book[:title]},
                headers: {
                    'ACCESS_TOKEN' => @token
                }
            ).first
        end
        
        it('atualizar dados do livro') do
           
            @change_book = {
                title: 'Jogador Nº1',
                author: 'Ernest Cline',
                tags: [
                    'Literatura estrangeira',
                    'Ficção utópica',
                    'Ficção distópica'
                ]
            }
            
            @result = Books.put(
                "/api/books/#{@book['id']}",
                body: @change_book.to_json,
                headers: {
                    'ACCESS_TOKEN' => @token
                }
            )
            expect(@result.response.code).to eql '200'

            @target = @result.parsed_response
            
            expect(@target['title']).to eql @change_book[:title]
            expect(@target['tags']).to eql @change_book[:tags]
            
        end
    end

    describe('status 404') do

        it('quando o livro não é encontrado') do

            @change_book = {
                title: 'Jogador Nº1',
                author: 'Ernest Cline',
                tags: [
                    'Literatura estrangeira',
                    'Ficção utópica',
                    'Ficção distópica'
                ]
            }

            @result = Books.put(
                "/api/books/#{Faker::Lorem.characters(25)}",
                body: @change_book.to_json,
                headers: {'ACCESS_TOKEN' => @token}
            )

            expect(@result.response.code).to eql '404'

            expect(@result.parsed_response['message']).to eql 'Livro não encontrado!'
        end
    end

    after(:each) do |example|
        puts @result.parsed_response if example.exception
    end
end