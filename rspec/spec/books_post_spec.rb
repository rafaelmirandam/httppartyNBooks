

describe('post /api/books') do

    before(:all) do
        @user = {
            name: 'Rafael',
            email: 'rafael@email.com',
            password: '123456'        }

        Books.delete("/api/accounts/#{@user[:email]}")
        Books.post('/api/accounts', body: @user.to_json)
        
        @token = get_token(@user)
    end

    describe('status 200') do
        it('cadastrar novo livro') do
            @book = {
                title: 'Dom Casmurro',
                author: 'Machado de Assis',
                tags: [
                    'Literatura',
                    'Romance'
                ]
            }
            @result = Books.post(
                '/api/books',
                body: @book.to_json,
                headers: {
                    'ACCESS_TOKEN' => @token
                }
            )
            expect(@result.response.code).to eql '200'
        end
    end

    describe('status 409') do

        before(:all) do
            @book = {
                title: 'Senhora',
                author: 'José de Alencar',
                tags: [
                    'Literatura',
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
        end

        it('quando o livro ja foi cadastrado') do
            @result = Books.post(
                '/api/books',
                body: @book.to_json,
                headers: {
                    'ACCESS_TOKEN' => @token
                }
            )
            expect(@result.response.code).to eql '409'
            expect(
                @result.parsed_response['message']
            ).to eql "O livro com título #{@book[:title]}, ja está cadastrado."
        end
    end

    after(:each) do |example|
        puts @result.parsed_response if example.exception
    end
end