defmodule TetroWeb.GameLive do
  use Phoenix.LiveView
  import Phoenix.HTML, only: [raw: 1]
  alias Tetro.{Tetromino, Points, Tetris}

  @box_width 20
  @box_height 20

  def mount(_session, socket) do
    :timer.send_interval 250, self(), :tick

    {:ok, start_game(socket)}
  end
  def begin_svg() do
    """
    <div>
      <svg
      version="1.0"
      style="background-color: #d5eff7"
      id="Layer_1"
      xmlns="http://www.w3.org/2000/svg"
      xmlns:xlink="http://www.w3.org/1999/xlink"
      width="200" height="400"
      viewBox="0 0 200 400"
      xml:space="preserve">
    """
  end
  def end_svg() do
    "</svg>
    </div>"
  end

  def boxes(points_with_colors) do
    points_with_colors
    |> Enum.map( fn {x, y, color} ->
      box({x, y}, color)
    end)
    |> Enum.join("\n")
  end

  def box(point, color) do
    """
    #{square(point, shades(color).light)}
    #{triangle(point, shades(color).dark)}
    """
  end

  def square(point, shade) do
    {x, y} = to_pixels(point)
      """
      <rect
        x="#{x+1}" y="#{y+1}"
        style="fill:##{shade}"
        width="#{@box_width - 1}" height="#{@box_height - 1}" />
      """
  end

  def triangle(point, shade) do
    {x, y} = to_pixels(point)
    {w, h} = {@box_width, @box_height}
      """
      <polyline
        style="fill:##{shade}";
        points="#{x + 1}, #{y + 1} #{x + w}, #{y + 1} #{x + w}, #{y + h}" />
      """
  end

  defp to_pixels({x,y}) do
    {(x-1) * @box_width, (y-1) * @box_height}
  end

  def render(%{state: :playing}=assigns) do
    ~L"""
      <div phx-keydown="keydown" phx-target="window">
        <h2 style="color: white;">
          Score: <%= @score %>
          State: <%= @state %>
        </h2>
          <body style="background-color:black;">
            <%= raw begin_svg() %>
            <%= raw boxes(@brick) %>
            <%= raw boxes(Map.values(@bottom)) %>
            <%= raw end_svg() %>
          </body>
        <div style="margin-left: 30px;">
          <div style="margin-left: 29px;">
            <div class="myButton" phx-click="arrow_up">
              ^
            </div>
          </div>
          <div class="myButton" phx-click="arrow_left">
            <
          </div>
          <div style="margin-left: 18px;" class="myButton" phx-click="arrow_right">
            >
          </div>
          <div style="margin-left: 29px;">
            <div class="myButton" phx-click="arrow_down">
              v
            </div>
          </div>
        </div>
      </div>
    """
  end
  def render(%{state: :starting}=assigns) do
    ~L"""
      <h1 style="color: white;">Let's play Tetris!</h1>
      <body style="background-color:black;">
      <button phx-click="start">Start</button>
      </body>
    """
  end
  def render(%{state: :game_over}=assigns) do
    ~L"""
      <h1 style="color: white;"> Game Over </h1>
      <h2 style="color: white;"> You're score: <%= @score %></h2>
      <body style="background-color:black;">
      <button phx-click="start">Play Again!</button>
      </body>
    """
  end

  def new_block(socket) do
    tetromino =
      Tetromino.random_brick
      |> Map.put(:location, {3,-2})

      assign(socket,
        tetromino: tetromino
    )
  end

  def show(socket) do
    tetromino = socket.assigns.tetromino

    points =
      tetromino
      |> Tetromino.prepare_points
      |> Points.move(tetromino.location)
      |> Points.with_color(color(tetromino))

    assign(socket, brick: points)
  end
  defp start_game(socket) do
    assign(socket,
        state: :starting
    )
  end
  defp new_game(socket) do
    assign(socket,
        state: :playing,
        score: 0,
        bottom: %{}
    )
    |> new_block
    |> show
  end

  defp shades(:red) do
    %{light: "DB7160", dark: "AB574B"}
  end
  defp shades(:blue) do
    %{light: "83C1C8", dark: "66969C"}
  end
  defp shades(:green) do
    %{light: "8BBF57", dark: "769359"}
  end
  defp shades(:orange) do
    %{light: "CB8E4E", dark: "AC7842"}
  end
  defp shades(:grey) do
    %{light: "A1A09E", dark: "7F7F7E"}
  end

  defp color(%{shape: :t}) do
    :red
  end
  defp color(%{shape: :i}) do
    :blue
  end
  defp color(%{shape: :l}) do
    :green
  end
  defp color(%{shape: :j}) do
    :green
  end
  defp color(%{shape: :o}) do
    :orange
  end
  defp color(%{shape: :z}) do
    :grey
  end
  defp color(%{shape: :s}) do
    :grey
  end

  def drop(:playing, socket, fast) do
    old_tetromino = socket.assigns.tetromino

    response =
      Tetris.move_down(
      old_tetromino,
      socket.assigns.bottom,
      color(old_tetromino))

    bonus = if fast, do: 2, else: 0

    socket
    |> assign(
      tetromino: response.tetromino,
      bottom: response.bottom,
      score: socket.assigns.score + response.score + bonus,
      state: (if response.game_over, do: :game_over, else: :playing)
      )
    |> show
  end
  def drop(_not_playing, socket, _not_fast), do: socket

  def move(direction, socket) do
    socket
    |> do_move(direction)
    |> show
  end

  def rotate(degrees, socket) do
    socket
    |> do_rotate(degrees)
    |> show
  end

  def do_rotate(socket, :rotate) do
    assign(socket, tetromino: socket.assigns.tetromino
    |> Tetris.try_spin_90(socket.assigns.bottom))
  end
  def do_move(socket, :left) do
    assign(socket, tetromino: socket.assigns.tetromino
    |> Tetris.try_left(socket.assigns.bottom))
  end
  def do_move(socket, :right) do
    assign(socket, tetromino: socket.assigns.tetromino
    |> Tetris.try_right(socket.assigns.bottom))
  end

  # -------------------------------------------------
  # Button Code For Mobile Beneath

  def handle_event("arrow_right", _arrow_right, socket) do
    {:noreply, move(:right, socket)}
  end
  def handle_event("arrow_left", _arrow_left, socket) do
    {:noreply, move(:left, socket)}
  end
  def handle_event("arrow_down", _arrow_down, socket) do
    {:noreply, drop(socket.assigns.state, socket, :true)}
  end
  def handle_event("arrow_up", _arrow_up, socket) do
    {:noreply, rotate(:rotate, socket)}
  end

  # -------------------------------------------------
  # ArrowKey code for Web on PC

  def handle_event("keydown", %{"key" => "ArrowRight"}, socket) do
    {:noreply, move(:right, socket)}
  end
  def handle_event("keydown", %{"key" => "ArrowLeft"}, socket) do
    {:noreply, move(:left, socket)}
  end
  def handle_event("keydown", %{"key" => "ArrowDown"}, socket) do
    {:noreply, drop(socket.assigns.state, socket, :true)}
  end
  def handle_event("keydown", %{"key" => "ArrowUp"}, socket) do
    {:noreply, rotate(:rotate, socket)}
  end
  def handle_event("keydown", _, socket) do
    {:noreply, socket}
  end

  def handle_event("start", _, socket) do
    {:noreply, new_game(socket)}
  end

  def handle_info(:tick, socket) do
    {:noreply, drop(socket.assigns.state, socket, :false)}
  end

  def x({x,y}) do
    {((x-1) * @box_width), y}
  end
  def y({x,y}) do
    {x, ((y-1) * @box_height)}
  end
end
