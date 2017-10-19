

After do |scenario|
    if scenario.failed?
        puts "REQUEST=> #{@request.to_json}"
        puts "RESPONSE=> #{@result.parsed_response.to_json}"
    end
end