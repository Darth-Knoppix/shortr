defmodule Shortr.MetricsTest do
  use Shortr.DataCase

  alias Shortr.Metrics

  describe "visits" do
    alias Shortr.Metrics.Visit

    import Shortr.MetricsFixtures
    import Shortr.LinksFixtures

    @invalid_attrs %{agent: nil, ip: nil}

    test "list_visits/0 returns all visits" do
      visit = visit_fixture()
      link = Metrics.list_visits(visit.hash)
      assert link.views == [visit]
    end

    test "get_visit!/1 returns the visit with given id" do
      visit = visit_fixture()
      assert Metrics.get_visit!(visit.id) == visit
    end

    test "create_visit/1 with valid data creates a visit" do
      valid_attrs = %{agent: "some agent", ip: "some ip"}
      link = link_fixture()

      assert {:ok, %Visit{} = visit} = Metrics.create_visit(link, valid_attrs)
      assert visit.agent == "some agent"
      assert visit.ip == "some ip"
    end

    test "create_visit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Metrics.create_visit(link_fixture(), @invalid_attrs)
    end

    test "update_visit/2 with valid data updates the visit" do
      visit = visit_fixture()
      update_attrs = %{agent: "some updated agent", ip: "some updated ip"}

      assert {:ok, %Visit{} = visit} = Metrics.update_visit(visit, update_attrs)
      assert visit.agent == "some updated agent"
      assert visit.ip == "some updated ip"
    end

    test "update_visit/2 with invalid data returns error changeset" do
      visit = visit_fixture()
      assert {:error, %Ecto.Changeset{}} = Metrics.update_visit(visit, @invalid_attrs)
      assert visit == Metrics.get_visit!(visit.id)
    end

    test "delete_visit/1 deletes the visit" do
      visit = visit_fixture()
      assert {:ok, %Visit{}} = Metrics.delete_visit(visit)
      assert_raise Ecto.NoResultsError, fn -> Metrics.get_visit!(visit.id) end
    end

    test "change_visit/1 returns a visit changeset" do
      visit = visit_fixture()
      assert %Ecto.Changeset{} = Metrics.change_visit(visit)
    end
  end
end
