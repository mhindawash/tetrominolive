defmodule Tetro.Plots do
  def points(:i) do
    # the long I points
    [
      {2,1},
      {2,2},
      {2,3},
      {2,4}
    ]
  end
  def points(:l) do
    # the L points to the right
    [
      {2,1},
      {2,2},
      {2,3}, {3,3}
    ]
  end
  def points(:j) do
    # the L points to the left
    [
            {3,1},
            {3,2},
      {2,3},{3,3}
    ]
  end
  def points(:o) do
    # the [](O) points, aka box
    [
      {2,1},{3,1},
      {2,2},{3,2}
    ]
  end
  def points(:z) do
    # the Z points facing left
    [
      {2,1},{3,1},
            {3,2},{4,2}
    ]
  end
  def points(:s) do
    # the Z points facing right
    [
            {3,1},{4,1},
      {2,2},{3,2}
    ]
  end
  def points(:t) do
    # the T points
    [
      {2,1},{3,1},{4,1},
            {3,2}
    ]
  end

end
