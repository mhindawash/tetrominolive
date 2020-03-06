defmodule Tetro.Tetromino do
  defstruct [:shape, :location, :rotation]

  def random_shape do
    [:i,:l,:j,:o,:z,:s,:t]
    |> Enum.random
    # j and L , z and s are the reflects. nothing else is a reflect
  end
  def random_rotation do
    [0,90,180,270]
    |> Enum.random
  end
  def random_brick do #random tetris piece spawn
    shape = random_shape()
    rotation = random_rotation()
    %__MODULE__{
      shape: shape,
      location: {1,1},
      rotation: rotation
    }
  end
  def new_tetromino do #single piece of tetris for testing
    %__MODULE__{
      shape: :i,
      rotation: 90,
      location: {3,1}
    }
  end

  def left(tetromino) do #action to move tetris piece left
    %{tetromino| location: Tetro.Point.left(tetromino.location)}
  end
  def right(tetromino) do #action to move tetris piece right
    %{tetromino| location: Tetro.Point.right(tetromino.location)}
  end
  def down(tetromino) do #action to move tetris piece down
    %{tetromino| location: Tetro.Point.down(tetromino.location)}
  end
  def rotation(tetromino) do #action to rotate the tetris piece
    %{tetromino| rotation: rotate(tetromino.rotation)}
  end
  def rotate(270), do: 0
  # above code is the math to not rotate the tetris piece
  def rotate(degrees), do: degrees + 90
      # above code is the math to rotate the tetris piece
  def prepare_points(tetromino) do #the steps to move all points not a single point
    tetromino.shape
    |> Tetro.Plots.points()
    |> Tetro.Points.rotate(tetromino.rotation)
    |> Tetro.Points.move(tetromino.location)
  end
end
