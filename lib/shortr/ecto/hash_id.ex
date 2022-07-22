defmodule Shortr.Ecto.HashId do
  @behaviour Ecto.Type

  @doc "Called when creating an Ecto.Changeset"
  @spec cast(any) :: Map.t()
  def cast(value), do: hash_id_format(value)

  @doc "Converts/accepts a value that has been directly placed into the ecto struct after a changeset"
  @spec dump(any) :: Map.t()
  def dump(value), do: hash_id_format(value)

  @doc "Converts a value from the database into the HashId type"
  @spec load(any) :: Map.t()
  def load(value), do: hash_id_format(value)

  @doc "Callback invoked by autogenerate fields."
  @spec autogenerate() :: String.t()
  def autogenerate, do: generate()

  @doc "The Ecto type."
  def type, do: :string

  @spec hash_id_format(any) :: Map.t()
  def hash_id_format(value) do
    case validate_hash_id(value) do
      true -> {:ok, value}
      _ -> {:error, "'#{value}' is not a string"}
    end
  end

  @doc "Validate the given value as a string"
  def validate_hash_id(string) when is_binary(string), do: true
  def validate_hash_id(_), do: false

  @doc "Generates a HashId"
  @spec generate() :: String.t()
  def generate do
    {:ok, pid} = Cuid.start_link()
    Cuid.generate(pid)
  end
end
