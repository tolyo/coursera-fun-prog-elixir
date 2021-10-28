defmodule Dictionary do
  @spec loadDictionary() :: [String.t()]
  def loadDictionary() do
    File.open!("./lib/linuxwords.txt")
    |> IO.stream(:line)
    |> Enum.map(&String.trim_trailing(&1))
    |> Enum.into([])
  end
end
