class Song
    @@all = []

    attr_accessor :name, :artist, :genre

    def initialize(name, artist=nil, genre=nil)
        @name = name
        if artist != nil 
            self.artist=artist
        end
        if genre != nil
            self.genre=genre
        end
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
        Song.new(name)
    end

    def artist
        @artist
    end

    def artist=(artist)
        @artist=artist
        @artist.add_song(self)
    end

    def genre=(genre)
        @genre=genre
        unless @genre.songs.include?(self)
            @genre.songs << self
        end
    end

    def self.find_by_name(name)
        #binding.pry
        self.all.find do |song|
            if song.name == name
                song.name
            end
        end
        
    end

    def self.find_or_create_by_name(name)
        #binding.pry
        if self.find_by_name(name) 
            self.find_by_name(name)
        else
            self.create(name)
        end
    end

    def self.new_from_filename(path)
        name = path.split(" - ")[1]
        artist = path.split(" - ")[0]
        genre = path.split(" - ")[2].gsub(".mp3","")
        song = self.new(name)
        #binding.pry
        song.artist=Artist.find_or_create_by_name(artist)
        song.genre = Genre.find_or_create_by_name(genre)
        song
    end

    def self.create_from_filename(path)
        self.new_from_filename(path).save
    end
end