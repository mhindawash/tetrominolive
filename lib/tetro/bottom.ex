defmodule Tetro.Bottom do

  def merge(points, bottom) do
    points
    |> Enum.map(fn {x, y, c} -> {{x,y}, {x, y, c}} end)
    |> Enum.into(bottom)
  end

  # def collides?(bottom, {x,y, _color}) do
  #    collides?(bottom, {x,y})
  # end
  # def collides?(bottom, {x,y}) do
  #   !!Map.get(bottom, {x,y}) or x < 1 and x > 10 and y > 20
  # end
  # def collides?(bottom, points) when is_list(points) do
  #   # Enum.any?(points, fn x -> collides?(bottom, x) end)
  #   Enum.any?(points, &collides?(bottom, &1))
  # end


  # B code
  # -------------------------------------------
  # M code


  # def end_of_line?(bottom, new_tetromino, tetromino) do
  #     collides_bottom?(bottom, new_tetromino, tetromino, points)
  # end

  def edge_of_bounds({x, y}) do
        y >= 20
  end

  def collides_bottom?(bottom, new_tetromino, tetromino) do
      bad =
        for point <- bottom do
          edge_of_bounds(point)
        end
        |> Enum.any?

      if bad, do: Tetro.Tetromino.random_brick |> IO.inspect(label: "***********"), else: new_tetromino
  end

  # def pause_and_merge_brick(points, bottom) do
  #   for points
  #   |> Enum.map(fn {x, y, c} -> {{x,y}, {x, y, c}} end)
  #   |> Enum.into(bottom)
  # end

end
