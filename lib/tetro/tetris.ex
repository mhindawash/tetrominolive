defmodule Tetro.Tetris do
  alias Tetro.{Tetromino, Bottom, Points}

  # def try_attempts(tetromino, f, points) do
  #   new_tetromino = f.(tetromino)
  #   bottom = Tetromino.prepare_points(new_tetromino)
  #   bottomtest = Bottom.collides?(bottom, points)
  #
  #       test_points(tetromino, bottom, bottomtest)
  # end
  #
  # def in_bounds({x, y}) do
  #   x > 0 and x < 11 and y > 0 and y < 21
  # end
  #
  # def test_points(tetromino, bottom, new_tetromino) do
  #   good =
  #     for point <- bottom do
  #       in_bounds(point)
  #     end
  #     |> Enum.all?
  #
  #   if good, do: new_tetromino, else: tetromino
  # end

  # M code
  # ---------------------------------------------------------------
  # M & B code

  def prepare(tetromino) do
    tetromino
    |> Tetromino.prepare_points
    |> Points.move(tetromino.location)
  end

  def move_down(tetromino, bottom, color) do
    new_tetromino =
      Tetromino.down(tetromino)

    maybe_move_down(
      Bottom.collides?(bottom, prepare(new_tetromino)),
      bottom,
      tetromino,
      new_tetromino,
      color
    )
  end
  def maybe_move_down(true=_bottom, bottom, old_tetromino, _new_tetromino, color) do
      new_tetromino = Tetromino.random_brick()

      points =
        old_tetromino
        |> prepare
        |> Points.with_color(color)

      {count, new_bottom} =
        bottom
        |> Bottom.merge(points)
        |> Bottom.full_bottom_delete

    %{
      tetromino: new_tetromino,
      bottom: new_bottom,
      score: score(count),
      game_over: Bottom.collides?(new_bottom, prepare(new_tetromino))
    }
  end
  def maybe_move_down(false=_notbottom, bottom, _old_tetromino, new_tetromino, _color) do
    %{
      tetromino: new_tetromino,
      bottom: bottom,
      score: 1,
      game_over: false
    }
  end

  def score(0), do: 0
  def score(count) do
    100 * round(:math.pow(2, count))
  end

  def try_left(tetromino, bottom) do
    try_attempts(tetromino, bottom, &Tetromino.left/1)
  end
  def try_right(tetromino, bottom) do
    try_attempts(tetromino, bottom, &Tetromino.right/1)
  end
  def try_spin_90(tetromino, bottom) do
    try_attempts(tetromino, bottom, &Tetromino.rotation/1)
  end
  defp try_attempts(tetromino, bottom, f) do
    new_tetromino = f.(tetromino)

    if Bottom.collides?(bottom, prepare(new_tetromino)) do
      tetromino
    else
      new_tetromino
    end
  end
end
