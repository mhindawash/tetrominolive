defmodule Tetro.TetrisTest do
  use ExUnit.Case
  alias Tetro.Tetris

  test "try to move right, success" do
    tetromino = Tetro.Tetromino.new_tetromino
    bottom = %{}

    expected = tetromino |> Tetro.Tetromino.right
    actual = Tetris.try_right(tetromino, bottom)

    assert actual == expected
  end

  test "try to move left, success" do
    tetromino = Tetro.Tetromino.new_tetromino
    bottom = %{}

    expected = tetromino |> Tetro.Tetromino.left
    actual = Tetris.try_left(tetromino, bottom)

    assert actual == expected
  end

  test "drops without merging" do
    tetromino = Tetro.Tetromino.new_tetromino
    bottom = %{}

    expected =
      %{
        tetromino: Tetro.Tetromino.down(tetromino),
        bottom: %{},
        score: 1,
        game_over: false
      }

    actual = Tetris.move_down(tetromino, bottom, :red)

    assert actual == expected
  end

  test "drops and merges" do
    tetromino = Tetro.Tetromino.new(location: {5,16})
    bottom = %{}

    %{score: score, bottom: bottom} =
      Tetris.move_down(tetromino, bottom, :red)

    assert Map.get(bottom, {7, 20}) == {7, 20, :red}
    assert score == 0
  end

  test "drops to bottom and compresses" do
    tetromino = Tetro.Tetromino.new(location: {5,16})
    bottom =
      for x <- 1..10, y <- 17..20, x != 7 do
        {{x,y}, {x, y, :red}}
      end
      |> Map.new

    %{score: score, bottom: bottom} =
       Tetris.move_down(tetromino, bottom, :red)

    assert bottom == %{}
    assert score == 1600
  end

end
