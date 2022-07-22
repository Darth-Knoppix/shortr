defmodule Shortr.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset
  alias Shortr.Ecto.HashId
  alias Shortr.Metrics.Visit

  @primary_key {:hash, HashId, [autogenerate: true]}
  @derive {Phoenix.Param, key: :hash}
  schema "links" do
    field :url, :string

    has_many :views, Visit, foreign_key: :hash

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url])
    |> validate_required([:url])
    |> unique_constraint(:url)
  end
end
