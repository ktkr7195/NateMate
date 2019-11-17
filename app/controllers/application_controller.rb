class ApplicationController < ActionController::Base


    def hello
        a=gets.chomp.to_i
        if a >= 80
            puts 'great'
        elsif a >=70
            puts 'nice'
        elsif a>= 50
            puts 'soso'
        else
            puts 'get effort'
        end
    end


end
