defmodule Shortr.LinksFixtures do
  alias Shortr.AccountsFixtures

  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shortr.Links` context.
  """

  @doc """
  Generate a unique link url.
  """
  def unique_link_url, do: "https://#{System.unique_integer([:positive])}.example.com"

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    new_attrs =
      attrs
      |> Enum.into(%{
        url: unique_link_url()
      })

    {:ok, link} = Shortr.Links.create_link(AccountsFixtures.user_fixture(), new_attrs)

    link
  end
end
