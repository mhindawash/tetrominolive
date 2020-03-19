defmodule Tetro.BottomTest do
  use ExUnit.Case
  import Tetro.Bottom

  test "checking various collisions" do
    bottom = %{{1,1} => {1,1, :red}}
    assert collides?(bottom, {1,1})
    refute collides?(bottom, {1,2})
    refute collides?(bottom, {1,2, :red})
    refute collides?(bottom, {1,3, :blue})
  end

  test "simple merge test" do
   bottom = %{{1, 1} => {1, 1, :blue}}

   actual = merge bottom, [{1, 2, :red}, {1, 3, :red}]
   expected = %{
     {1, 1} => {1, 1, :blue},
     {1, 2} => {1, 2, :red},
     {1, 3} => {1, 3, :red}}

   assert actual == expected
 end

  test "compute ys reached bottom" do
    bottom = new_bottom(20, [{{19, 19}, {19, 19, :red}}])

    assert ys_reached_bottom(bottom) == [20]
  end

  test "delete a single row" do
    bottom = new_bottom(20, [{{19, 19}, {19, 19, :red}}])
    actual = Map.keys(delete_row(bottom, 20))
    refute {19,19} in actual
    assert {19,20} in actual
    assert Enum.count(actual) == 1
  end

  test "full row delete with single row" do
    bottom = new_bottom(20, [{{19, 19}, {19, 19, :red}}])
    {actual_count, actual_bottom} = full_bottom_delete(bottom)

    assert actual_count == 1
    assert {19,20} in Map.keys(actual_bottom)
  end

  def new_bottom(complete_row, xtras) do
    (xtras ++
      (1..10
        |> Enum.map(fn x ->
          {{x, complete_row}, {x, complete_row, :red}}
        end)))
      |> Map.new
    end
end
