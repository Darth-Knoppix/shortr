defmodule Shortr.LinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shortr.Links` context.
  """

  @doc """
  Generate a unique link hash.
  """
  def unique_link_hash, do: "some hash#{System.unique_integer([:positive])}"

  @doc """
  Generate a unique link url.
  """
  def unique_link_url, do: "some url#{System.unique_integer([:positive])}"

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        hash: unique_link_hash(),
        url: unique_link_url()
      })
      |> Shortr.Links.create_link()

    link
  end
end
