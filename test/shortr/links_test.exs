defmodule Shortr.LinksTest do
  use Shortr.DataCase

  alias Shortr.Links

  import Shortr.AccountsFixtures

  describe "links" do
    alias Shortr.Links.Link

    import Shortr.LinksFixtures

    @invalid_attrs %{hash: nil, url: nil}

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Links.list_links(link.user_id) == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Links.get_link!(link.hash) == link
    end

    test "create_link/1 with valid data creates a link" do
      valid_attrs = %{url: "https://example.com"}
      user = user_fixture()

      assert {:ok, %Link{} = link} = Links.create_link(user, valid_attrs)
      assert link.url == "https://example.com"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Links.create_link(user_fixture(), @invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      update_attrs = %{url: "some updated url"}

      assert {:ok, %Link{} = link} = Links.update_link(link, update_attrs)
      assert link.url == "some updated url"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Links.update_link(link, @invalid_attrs)
      assert link == Links.get_link!(link.hash)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Links.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Links.get_link!(link.hash) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Links.change_link(link)
    end
  end
end
