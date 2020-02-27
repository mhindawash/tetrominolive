defmodule Tetro.Tetris do
  alias Tetro.{Tetromino}

  def try_attempts(oldbrick, change, _) do
    updated_brick = change.(oldbrick)
    points = Tetromino.prepare_points(updated_brick)
    test_points(points, oldbrick, updated_brick)
  end

  def in_bounds({x, y}) do
    x > 0 and x < 14 and y > 0 and y < 21
  end

  def test_points(points, oldbrick, updated_brick) do
    good =
      for point <- points do
        in_bounds(point)
      end
      |> Enum.all?

    if good, do: updated_brick, else: oldbrick
    end
end
