def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie.select(:title, :id)
    .joins(:actors)
    .where(actors: { name: those_actors })
    .group('movies.id')
    .having("COUNT(actors.name) >= #{those_actors.length}")
end

def golden_age
  # Find the decade with the highest average movie score.
  Movie.select('AVG(score)', 'yr / 10')
    .group('yr / 10').order('AVG(score) DESC')
    .limit(1)
    .pluck('yr / 10')
    .first * 10
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  movies = Movie.joins(:actors).where(actors: { name: name }).pluck(:title)
  Actor.joins(:movies)
    .where(movies: { title: movies })
    .where.not(actors: {name: name})
    .pluck(:name).uniq
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor.left_outer_joins(:castings)
    .where(castings: { actor_id: nil })
    .count
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"
  chars = "%#{whazzername.split('').join('%')}%"
  Movie.joins(:actors)
    .where('UPPER(actors.name) LIKE UPPER(?)', chars)
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.
  Actor.select('actors.name', 'actors.id', 'MAX(movies.yr) - MIN(movies.yr) AS career')
    .joins(:movies)
    .group('actors.id')
    .order('career DESC, actors.name')
    .limit(3)
end
