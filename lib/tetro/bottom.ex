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

  def merge(bottom, points) do
      points
      |> Enum.map(fn {x, y, c} -> {{x,y}, {x, y, c}} end)
      |> Enum.into(bottom)
  end
  def collides?(bottom, {x, y}) do
    !!Map.get(bottom, {x,y}) || x < 0 || x > 10 || y > 20
  end
  def collides?(bottom, {x,y, _color}) do
    collides?(bottom, {x,y})
  end
  def collides?(bottom, points) when is_list(points) do
    Enum.any?(points, &collides?(bottom, &1))
  end

  def ys_reached_bottom(bottom) do
    bottom
    |> Map.keys
    |> Enum.map(&elem(&1, 1))
    |> Enum.uniq
    |> Enum.filter( fn row -> reached_bottom?(bottom, row) end)
  end

  def reached_bottom?(bottom, row) do
    count =
      bottom
      |> Map.keys
      |> Enum.filter(fn {_x, y} -> y == row end)
      |> Enum.count

    count == 10
  end

  def delete_row(bottom, row) do
    bad_keys =
      bottom
      |> Map.keys
      |> Enum.filter(fn {_x, y} -> y == row end)

    bottom
    |> Map.drop(bad_keys)
    |> Enum.map(&move_bad_point_up(&1, row))
    |> Map.new
  end

  def move_bad_point_up({{x,y}, {x,y,color}}, row) when y < row do
    {{x, y+1}, {x, y+1, color}}
  end
  def move_bad_point_up(key_value, _row) do
    key_value
  end

  def full_bottom_delete(bottom) do
    rows =
      bottom
      |> ys_reached_bottom
      |> Enum.sort

    new_bottom =
      Enum.reduce(rows, bottom, &delete_row(&2, &1))

    {Enum.count(rows), new_bottom}
  end

end
