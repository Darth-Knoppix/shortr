defmodule Shortr.Metrics.Visit do
  use Ecto.Schema
  import Ecto.Changeset
  alias Shortr.Links.Link

  schema "visits" do
    field :agent, :string
    field :ip, :string
    field :hash, :string

    belongs_to :link, Link, references: :hash, define_field: false

    timestamps(updated_at: false)
  end

  @doc false
  def changeset(visit, attrs) do
    visit
    |> cast(attrs, [:agent, :ip])
    |> validate_required([:agent, :ip])
  end
end
