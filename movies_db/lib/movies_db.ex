defmodule Movies do
  use GenServer
  alias Movies_BackUp
  
  ## INIT AND START UP FUNCTIONS
  def start_link(_args) do
    GenServer.start_link(__MODULE__, Movies_BackUp.state, name: __MODULE__)
  end
  
  def init(movies) do
    {:ok, movies}
  end

  ## CLIENT SIDE
  
  def state, do: GenServer.call(__MODULE__, {:state})

  def add_movie(name, genre, actors, year, rating) when is_bitstring(name) and is_bitstring(genre) and
  is_list(actors) and is_integer(year) and is_float(rating) do
    if Enum.all?(actors, &(is_bitstring(&1))) do
      GenServer.call(__MODULE__, {:add_movie, name, genre, actors, year, rating})
    else
      IO.puts("All actors in the list have to be strings!")
    end
  end
  def add_movie(_name, _genre, _actors, _year, _rating) do
    IO.puts("Requirements: Movie name- string, Genre- string, Actors- list of strings, Movie year- integer, Movie rating- float!")
  end

  
  def search_by_id(id) when is_integer(id) do
    GenServer.call(__MODULE__, {:by_id, id})
  end
  def search_by_id(_id), do: IO.puts("The id have to be integer!")

  
  def search_newer_then(year) when is_integer(year) do
    GenServer.call(__MODULE__, {:newer_than, year})
  end
  def search_newer_then(_year), do: IO.puts("The movie year have to be integer!")

  
  def search_older_then(year) when is_integer(year) do
    GenServer.call(__MODULE__, {:older_than, year})
  end
  def search_older_then(_year), do: IO.puts("The movie year have to be integer!")


  def search_by_genre(genre) when is_bitstring(genre) do
    GenServer.call(__MODULE__, {:genre, genre})
  end
  def search_by_genre(_genre), do: IO.puts("The movie genre have to be string!")


  def remove_movie_by_id(id) when is_integer(id) do
    GenServer.call(__MODULE__, {:remove, id})
  end
  def remove_movie_by_id(_id), do: IO.puts("The id have to be integer!")


  def search_movie_by_name(name) when is_bitstring(name) do
    GenServer.call(__MODULE__, {:by_name, name})
  end
  def search_movie_by_name(_name), do: IO.puts("The movie name have to be string!")

  
  def search_movie_by_actor(actor) when is_bitstring(actor) do
      GenServer.call(__MODULE__, {:by_actor, actor})
  end
  def search_movie_by_actor(_actor), do: IO.puts("The movie actor have to be string!")

  ## SERVER SIDE

  # all movies state
  def handle_call({:state}, _from, state) do
    list = Map.get(state, :list)
    {:reply, list, state}
  end

  # add new movie
  def handle_call({:add_movie, name, genre, actors, year, rating}, _from, state) do
    id = Map.get(state, :id) + 1
    list = [%{id: id, name: name, genre: genre, actors: actors, year: year, rating: rating} | Map.get(state, :list)]
    state = %{list: list, id: id}
    Movies_BackUp.change_state(state)
    {:reply, list, state}
  end

  # search movie by id
  def handle_call({:by_id, id}, _from, state) do
    result = Map.get(state, :list) |> Enum.filter(&Map.get(&1, :id) == id) 
    {:reply, result, state}
  end

  # search newer movie
  def handle_call({:newer_than, year}, _from, state) do
    result = Map.get(state, :list) |> Enum.filter(&Map.get(&1, :year) > year)
    {:reply, result, state}
  end

  # search older movie
  def handle_call({:older_than, year}, _from, state) do
    result = Map.get(state, :list) |> Enum.filter(&Map.get(&1, :year) < year)
    {:reply, result, state}
  end

  # search movie by genre
  def handle_call({:genre, genre}, _from, state) do
    result = Map.get(state, :list) |> Enum.filter(&Map.get(&1, :genre) == genre)
    {:reply, result, state}
  end

  # remove movie by id
  def handle_call({:remove, id}, _from, state) do
    list = Map.get(state, :list) |> Enum.reject(&Map.get(&1, :id) == id)
    state = %{list: list, id: Map.get(state, :id)}
    Movies_BackUp.change_state(state)
    {:reply, list, state}
  end

  # search for movie based on part of his name (case insesitive)
  def handle_call({:by_name, name}, _from, state) do
    list = Map.get(state, :list) |>
      Enum.filter(&String.contains?(String.downcase(Map.get(&1, :name)), String.downcase(name)))
    {:reply, list, state}
  end

  # search for all movies of particular actor
  def handle_call({:by_actor, actor}, _from, state) do
    list = Map.get(state, :list) |>
      Enum.filter(fn x -> Enum.any?(Map.get(x, :actors), &(&1 == actor)) end)
    {:reply, list, state}
  end
end

#################################

defmodule Movies_BackUp do
  use GenServer
  
   def start_link(_args) do
    GenServer.start_link(__MODULE__, %{list: [], id: 0}, name: __MODULE__)
  end
  
  def init(movies) do
    {:ok, movies}
  end

  # full backup satate of Movies module structure
  def state, do: GenServer.call(__MODULE__, {:state})

  # updating Movies_BackUp state after Movies state change
  def change_state(new_state) do
      GenServer.cast(__MODULE__, {:change_state, new_state})
  end

  def handle_call({:state}, _from, state) do
    {:reply, state, state}
  end
  
  def handle_cast({:change_state, new_state},_state) do
    {:noreply, new_state}
  end
end

