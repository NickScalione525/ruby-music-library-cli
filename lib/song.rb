require 'pry'

class Song
    attr_accessor   :name
    attr_reader :artist, :genre

    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
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
        song = Song.new(name)
        song
    end

    def artist=(artist)
        if artist != nil
        @artist = artist
        artist.add_song(self)
        end
    end
    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def self.find_by_name(name)
        self.all.detect {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)

    end
        def self.new_from_filename(filename)
        file = filename.split(" - ")
        artist = file[0]
        name = file[1]
        genre = file[2].gsub(".mp3","")
        genre = Genre.find_or_create_by_name(genre)
        artist = Artist.find_or_create_by_name(artist)
        self.new(name, artist, genre)

        end


        def self.create_from_filename(filename)
            self.new_from_filename(filename)
        end



end