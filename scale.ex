
defmodule ScaleFile do

  def get_scales(file) do
    File.read!(file) |> String.split("\n")
  end

  def to_map([hs | ts], scaleMap) do
    [hl | tl] = String.split(hs, "=")
    nm = Map.put_new(scaleMap, hl, List.to_string(tl))
    to_map(ts, nm)
  end

  def to_map([], scaleMap) do
    scaleMap
  end

end

defmodule Const do

  @notes ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "Bb", "B"]
  def get_notes, do: @notes


  @interval %{
    "1" => 0,
    "b2" => 1,
    "2" => 2,
    "b3" => 3,
    "3" => 4,
    "4" => 5,
    "#4" => 6,
    "b5" => 6,
    "5" => 7,
    "b6" => 8,
    "6" => 9,
    "b7" => 10,
    "7" => 11
  }
  #def get_interval, do: @interval
  def get_interval(val), do: @interval[val]

  @posnote %{
    "E" => "A",
    "F" => "B",
    "F#" => "C",
    "G" => "D",
    "G#" => "E",
    "A" => "F",
    "Bb" => "G",
    "B" => "H",
    "C" => "I",
    "C#" => "J",
    "D" => "K",
    "D#" => "L"
  }
  #def pos_note, do: @getnote
  def pos_note(val), do: @posnote[val]

end

defmodule Notes do
  def get_pos([head | tail], val, pos) when pos < 12 do
    if head == val, do: pos, else: get_pos(tail, val, pos + 1)
  end

  defp get_value(val) do
    if val > 11, do: val-12 , else: val
  end

  def get_played_notes([head | tail], pos, playednotes) do
    value = get_value(pos + Const.get_interval(head))
    get_played_notes(tail, pos, playednotes ++ [Enum.at(Const.get_notes(),value)])
  #  get_played_notes(tail, pos, [Enum.at(Const.get_notes(),value) | playednotes]) # reverse order
  end

  def get_played_notes([], _, playednotes) do
    playednotes
  end

  def change_string_pos(gstring, [head | tail], val) do
    change_string_pos(String.replace(gstring, Const.pos_note(head), val), tail, val)
  end

  def change_string_pos(gstring, [], _) do
    gstring
  end

end

[tone, mode] = System.argv()

scale = ScaleFile.get_scales("scales.txt") |> ScaleFile.to_map(%{})
note_pos = Notes.get_pos(Const.get_notes(), tone, 0)
playednotes = scale[mode] |> String.split(" ") |> Notes.get_played_notes(note_pos, [])
playednotes |> IO.inspect()

"024-023-022-021-020-019-018-017-016-015-014-013-012-011-010-009-008-007-006-005-004-003-002-001-000" |> IO.puts()
"---------------------------------------------------------------------------------------------------" |> IO.puts()

e_saite="-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-"
a_saite="-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-"
d_saite="-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-"
g_saite="-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-"
h_saite="-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-|-G-|-F-|-E-|-D-|-C-|-B-|-A-|-L-|-K-|-J-|-I-|-H-"

unplayed = Const.get_notes() -- playednotes

e_saite = Notes.change_string_pos(e_saite, playednotes, "O")
|> Notes.change_string_pos(unplayed, "-")
e_saite |> IO.puts()

Notes.change_string_pos(h_saite, playednotes, "O")
|> Notes.change_string_pos(unplayed, "-")
|> IO.puts()
Notes.change_string_pos(g_saite, playednotes, "O")
|> Notes.change_string_pos(unplayed, "-")
|> IO.puts()
Notes.change_string_pos(d_saite, playednotes, "O")
|> Notes.change_string_pos(unplayed, "-")
|> IO.puts()
Notes.change_string_pos(a_saite, playednotes, "O")
|> Notes.change_string_pos(unplayed, "-")
|> IO.puts()

e_saite |> IO.puts()
