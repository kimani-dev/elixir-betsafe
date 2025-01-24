defmodule Betsafe.BetsTest do
  use Betsafe.DataCase

  alias Betsafe.Bets

  describe "bets" do
    alias Betsafe.Bets.Bet

    import Betsafe.BetsFixtures

    @invalid_attrs %{prediction: nil, amount: nil}

    test "list_bets/0 returns all bets" do
      bet = bet_fixture()
      assert Bets.list_bets() == [bet]
    end

    test "get_bet!/1 returns the bet with given id" do
      bet = bet_fixture()
      assert Bets.get_bet!(bet.id) == bet
    end

    test "create_bet/1 with valid data creates a bet" do
      valid_attrs = %{prediction: "some prediction", amount: "120.5"}

      assert {:ok, %Bet{} = bet} = Bets.create_bet(valid_attrs)
      assert bet.prediction == "some prediction"
      assert bet.amount == Decimal.new("120.5")
    end

    test "create_bet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bets.create_bet(@invalid_attrs)
    end

    test "update_bet/2 with valid data updates the bet" do
      bet = bet_fixture()
      update_attrs = %{prediction: "some updated prediction", amount: "456.7"}

      assert {:ok, %Bet{} = bet} = Bets.update_bet(bet, update_attrs)
      assert bet.prediction == "some updated prediction"
      assert bet.amount == Decimal.new("456.7")
    end

    test "update_bet/2 with invalid data returns error changeset" do
      bet = bet_fixture()
      assert {:error, %Ecto.Changeset{}} = Bets.update_bet(bet, @invalid_attrs)
      assert bet == Bets.get_bet!(bet.id)
    end

    test "delete_bet/1 deletes the bet" do
      bet = bet_fixture()
      assert {:ok, %Bet{}} = Bets.delete_bet(bet)
      assert_raise Ecto.NoResultsError, fn -> Bets.get_bet!(bet.id) end
    end

    test "change_bet/1 returns a bet changeset" do
      bet = bet_fixture()
      assert %Ecto.Changeset{} = Bets.change_bet(bet)
    end
  end
end
