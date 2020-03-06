defmodule Tetro.Tetris do
  alias Tetro.{Tetromino, Bottom}

  def try_attempts(tetromino, change, _) do
    new_tetromino = change.(tetromino)
    bottom = Tetromino.prepare_points(new_tetromino)
    bottomtest = Bottom.collides_bottom?(bottom, new_tetromino, tetromino)

        test_points(tetromino, bottom, bottomtest)
  end

  def in_bounds({x, y}) do
    x > 0 and x < 11 and y > 0 and y < 21
  end

  def test_points(tetromino, bottom, new_tetromino) do
    good =
      for point <- bottom do
        in_bounds(point)
      end
      |> Enum.all?

    if good, do: new_tetromino, else: tetromino
  end

  def try_left(tetromino, bottom) do
    try_attempts(tetromino, &Tetromino.left/1, bottom)
  end
  def try_right(tetromino, bottom) do
    try_attempts(tetromino, &Tetromino.right/1, bottom)
  end
  def try_down(tetromino, bottom) do
    try_attempts(tetromino, &Tetromino.down/1, bottom)
  end
  def try_spin_90(tetromino, bottom) do
    try_attempts(tetromino, &Tetromino.rotation/1, bottom)
  end
end





  # def prepare(tetromino) do
  #   tetromino
  #   |> Tetromino.prepare_points
  #   |> Tetro.Points.move(tetromino.location)
  # end
  #
  # def try_attempts(tetromino, bottom, f) do
  #   new_tetromino = f.(tetromino)
  #
  #   if Bottom.collides?(bottom, prepare(new_tetromino)) |> IO.inspect(label: "THIS IS THE BOTTOM") do
  #     tetromino
  #   else
  #     new_tetromino
  #   end
  # end
  #
