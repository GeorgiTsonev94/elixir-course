defmodule Dog do
  @moduledoc """
  Documentation for Httpoison.
  """
  def get_dog_picture() do
    HTTPoison.get!("https://dog.ceo/api/breeds/image/random")
  end
end
