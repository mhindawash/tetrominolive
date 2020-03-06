defmodule Tetro.TetrisTest do
  use Tetro.Case
  import Tetro.{Tetris, Tetromino}

  test "try to move right, success" do
    tetromino = Tetromino.new_tetromino
    bottom = %{}

    expected = tetromino |> Tetromino.right
    actual = try_right(tetromino, bottom)

    assert actual == expected
  end

  test "try to move left, success" do
    tetromino = Tetromino.new_tetromino
    bottom = %{}

    expected = tetromino |> Tetromino.left
    actual = try_left(tetromino, bottom)

    assert actual == expected
  end

end
