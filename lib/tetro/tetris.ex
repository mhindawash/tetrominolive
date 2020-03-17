defmodule Tetro.Tetris do
  alias Tetro.{Tetromino, Bottom}

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
    |> Tetro.Points.move(tetromino.location)
  end

  def try_attempts(tetromino, bottom, f) do
    new_tetromino = f.(tetromino)

    if Bottom.collides?(bottom, prepare(new_tetromino)) do
      tetromino
    else
      new_tetromino
    end
  end
  def move_down(tetromino, bottom) do
    new_tetromino =
      Tetro.Tetromino.down(tetromino)

    maybe_move_down(
      Bottom.collides?(bottom, prepare(new_tetromino)),
      bottom,
      tetromino,
      new_tetromino
    )
  end
  def maybe_move_down(true=_bottom, bottom, old_tetromino, _new_tetromino) do
    points =
      old_tetromino
      |> prepare

    %{
      tetro: Tetro.Tetromino.random_brick,
      bottom: Bottom.merge?(bottom, points),
      score: 100,
    }
    # Tetro.Tetromino.random_brick()
  end
  def maybe_move_down(false=_notbottom, bottom, _old_tetromino, new_tetromino) do
    %{
      tetro: new_tetromino,
      bottom: bottom,
      score: 1
    }
  end
  def try_left(tetromino, bottom) do
    try_attempts(tetromino, bottom, &Tetromino.left/1)
  end
  def try_right(tetromino, bottom) do
    try_attempts(tetromino, bottom, &Tetromino.right/1)
  end
  def try_down(tetromino, bottom) do
    move_down(tetromino, bottom)
  end
  def try_spin_90(tetromino, bottom) do
    try_attempts(tetromino, bottom, &Tetromino.rotation/1)
  end
end
