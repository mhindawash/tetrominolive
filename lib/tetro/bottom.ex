defmodule Tetro.Bottom do

  # def end_of_line?(bottom, new_tetromino, tetromino) do
  #     collides_bottom?(bottom, new_tetromino, tetromino, points)
  # end
  # def collides?(bottom, new_tetromino, tetromino)
  # bad =
  #   for point <- bottom do
  #     collides?(bottom, &1)
  #    end
  #   |> Enum.any?
  #
  # if bad, do: merge(tetromino, bottom), else: new_tetromino
  # end

  # M code
  # -------------------------------------------
  # M & B code

  def merge?(bottom, points) do
      points
      |> Enum.map(fn {x, y, c} -> {{x,y}, {x, y, c}} end)
      |> Enum.into(bottom)
  end
  def collides?(bottom, {x, y}) do
    !!Map.get(bottom, {x,y}) || x < 0 || x > 20 || y > 20
  end
  def collides?(bottom, {x,y, _color}) do
    collides?(bottom, {x,y})
  end
  def collides?(bottom, points) when is_list(points) do
    Enum.any?(points, &collides?(bottom, &1))
  end
  
end
