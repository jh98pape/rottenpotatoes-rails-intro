class Movie < ActiveRecord::Base
    @all_ratings
    def self.set_ratings()
        self.all_ratings= ['G','PG','PG-13','R']
    end
    def self.get_ratings()
        return ['G','PG','PG-13','R']
    end
end
