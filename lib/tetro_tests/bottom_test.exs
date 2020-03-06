defmodule Tetro.BottomTest do
  use Phoenix.ConnCase
  import Tetro.Bottom

  test "checking various collisions" do
    bottom = %{{1,1} => {1,1, :red}}
    assert collides?(bottom, {1,1})
    refute collides?(bottom, {1,2})
    refute collides?(bottom, {1,2, :red})
    refute collides?(bottom, {1,3, :blue})
  end

  test "checking various merges" do
    bottom = %{{1,1} => {1,1, :blue}}
    actual = merge(bottom, [{1,2, :red}, {1,3, :red}])
    expected = %{
      {1,1} => {1,1, :blue},
      {1,2} => {1,2, :red},
      {1,3} => {1,3, :red}}
    assert actual == expected
  end

end
