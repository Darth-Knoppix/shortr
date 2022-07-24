defmodule Shortr.MetricsFixtures do
  alias Shortr.LinksFixtures

  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shortr.Metrics` context.
  """

  @doc """
  Generate a visit.
  """
  def visit_fixture(attrs \\ %{}) do
    new_attrs =
      attrs
      |> Enum.into(%{
        agent: "some agent",
        ip: "some ip"
      })

    {:ok, visit} = Shortr.Metrics.create_visit(LinksFixtures.link_fixture(), new_attrs)

    visit
  end
end
