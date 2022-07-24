defmodule ShortrWeb.LinkLiveTest do
  use ShortrWeb.ConnCase

  import Phoenix.LiveViewTest
  import Shortr.LinksFixtures
  import Shortr.AccountsFixtures
  alias ShortrWeb.UserAuth
  alias Shortr.Accounts

  @create_attrs %{url: "some url"}
  @update_attrs %{url: "some updated url"}
  @invalid_attrs %{url: nil}

  setup(%{conn: conn}) do
    link = link_fixture()
    user = user_from!(link.user_id)
    %{user: user, link: link, conn: log_in_user(conn, user)}
  end

  describe "Index" do
    test "lists no new link hint", %{conn: conn, link: link} do
      {:ok, _index_live, html} = live(conn, Routes.link_index_path(conn, :index))

      assert html =~ "Listing Links"
      assert html =~ link.url
    end

    test "saves new link", %{conn: conn, link: link} do
      {:ok, index_live, _html} = live(conn, Routes.link_index_path(conn, :index))

      assert index_live |> element("a", "New Link") |> render_click() =~
               "New Link"

      assert_patch(index_live, Routes.link_index_path(conn, :new))

      assert index_live
             |> form("#link-form", link: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#link-form", link: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.link_index_path(conn, :index))

      assert html =~ "Link created successfully"
      assert html =~ link.hash
    end

    test "updates link in listing", %{conn: conn, link: link} do
      {:ok, index_live, _html} = live(conn, Routes.link_index_path(conn, :index))

      assert index_live |> element("#link-#{link.hash} a", "Edit") |> render_click() =~
               "Edit Link"

      assert_patch(index_live, Routes.link_index_path(conn, :edit, link))

      assert index_live
             |> form("#link-form", link: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#link-form", link: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.link_index_path(conn, :index))

      assert html =~ "Link updated successfully"
    end

    test "deletes link in listing", %{conn: conn, link: link} do
      {:ok, index_live, _html} = live(conn, Routes.link_index_path(conn, :index))

      assert index_live |> element("#link-#{link.hash} a", "Delete") |> render_click()
      refute has_element?(index_live, "#link-#{link.hash}")
    end
  end
end
