class Artist

    extend Concerns::Findable

    @@all = []

    attr_accessor :name

    def initialize(name)
        @name = name
        @songs = []
        save
    end

    def self.all
        @@all
    end

    def self.destroy_all
        self.all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        Artist.new(name)
    end

    def songs
        @songs
    end

    def add_song(song)
        if song.artist == nil
            song.artist = self
            @songs << song
        end
    end

    def genres
        Genre.all
    end
end