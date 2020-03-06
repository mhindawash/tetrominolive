defmodule Tetro.Point do
  def left({x,y}), do: {x-1,y}
  def right({x,y}), do: {x+1,y}
  def down({x,y}), do: {x,y+1}
  def move({x,y},{a_x,a_y}) do
    {x + a_x, y + a_y}
  end
  def mirror({x,y}) do
    {5-x,y}
  end
  def flip({x,y}) do
    {x,5-y}
  end
  def transpose({x,y}) do
    {y,x}
  end
  def rotate(point, 0) do
    point
  end
  def rotate(point, 90) do
    point
    |> transpose
    |> mirror
  end
  def rotate(point, 180) do
    point
    |> mirror
    |> flip
  end
  def rotate(point, 270) do
    point
    |> transpose
    |> flip
  end
end
