class MovieFacade
  def self.search(query = nil)
    uri = query.nil? ? 'movie/top_rated' : 'search/movie'
    films = []
    2.times do |n|
      films << MovieService.movies_search(n, uri, query)
    end
    films.flatten.map do |film_info|
      Film.new(film_info)
    end
  end

  def self.details(movie_id)
    raw_data = MovieService.movie_details(movie_id)
    @movie = Film.new(raw_data)
  end
end
