defmodule Shortr.MetricsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shortr.Metrics` context.
  """

  @doc """
  Generate a visit.
  """
  def visit_fixture(attrs \\ %{}) do
    {:ok, visit} =
      attrs
      |> Enum.into(%{
        agent: "some agent",
        ip: "some ip"
      })
      |> Shortr.Metrics.create_visit()

    visit
  end
end
