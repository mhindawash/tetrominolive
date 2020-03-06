defmodule Tetro.Points do
  alias Tetro.{Point}
  def rotate(points, degrees) do
    points
    |> Enum.map( fn point -> Point.rotate(point, degrees) end)
  end
  def move(points, location) do
    points
    |> Enum.map( fn point -> Point.move(point, location) end)
  end
  def with_color(points, color) do
      Enum.map(points, fn point -> add_color(point, color) end)
  end
  defp add_color({_x, _y, _c}=point, _color) do
    point
  end
  defp add_color({x,y}, color) do
    {x, y, color}
  end
end
