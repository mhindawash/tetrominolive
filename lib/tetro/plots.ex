defmodule Tetro.Plots do
  def shape(:i) do
    # the long I shape
    [
      {2,1},
      {2,2},
      {2,3},
      {2,4}
    ]
  end
  def shape(:l) do
    # the L shape to the right
    [
      {2,1},
      {2,2},
      {2,3}, {3,3}
    ]
  end
  def shape(:j) do
    # the L shape to the left
    [
            {3,1},
            {3,2},
      {2,3},{3,3}
    ]
  end
  def shape(:o) do
    # the [](O) shape, aka box
    [
      {2,1},{3,1},
      {2,2},{3,2}
    ]
  end
  def shape(:z) do
    # the Z shape facing left
    [
      {2,1},{3,1},
            {3,2},{4,2}
    ]
  end
  def shape(:s) do
    # the Z shape facing right
    [
            {3,1},{4,1},
      {2,2},{3,2}
    ]
  end
  def shape(:t) do
    # the T shape
    [
      {2,1},{3,1},{4,1},
            {3,2}
    ]
  end

end
