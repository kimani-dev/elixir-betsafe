defmodule Betsafe.Bets do
  @moduledoc """
  The Bets context.
  """

  import Ecto.Query, warn: false
  alias Betsafe.Bets.Prediction
  alias Betsafe.Repo

  alias Betsafe.Bets.Bet

  @doc """
  Returns the list of bets.

  ## Examples

      iex> list_bets()
      [%Bet{}, ...]

  """
  def list_bets do
    Repo.all(Bet)
  end

  @doc """
  Gets a single bet.

  Raises `Ecto.NoResultsError` if the Bet does not exist.

  ## Examples

      iex> get_bet!(123)
      %Bet{}

      iex> get_bet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bet!(id), do: Repo.get!(Bet, id)

  @doc """
  Creates a bet.

  ## Examples

      iex> create_bet(%{field: value})
      {:ok, %Bet{}}

      iex> create_bet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bet(attrs \\ %{}) do
    %Bet{}
    |> Bet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bet.

  ## Examples

      iex> update_bet(bet, %{field: new_value})
      {:ok, %Bet{}}

      iex> update_bet(bet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bet(%Bet{} = bet, attrs) do
    bet
    |> Bet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bet.

  ## Examples

      iex> delete_bet(bet)
      {:ok, %Bet{}}

      iex> delete_bet(bet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bet(%Bet{} = bet) do
    Repo.delete(bet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bet changes.

  ## Examples

      iex> change_bet(bet)
      %Ecto.Changeset{data: %Bet{}}

  """
  def change_bet(%Bet{} = bet, attrs \\ %{}) do
    Bet.changeset(bet, attrs)
  end

  # List all predictions
  def list_predictions do
    Repo.all(Prediction)
    |> Repo.preload([:bet, :game])
  end

  # Get a prediction by ID
  def get_prediction!(id) do
    Prediction
    |> Repo.get!(id)
    |> Repo.preload([:bet, :game])
  end

  # Create a prediction
  def create_prediction(attrs) do
    %Prediction{}
    |> Prediction.changeset(attrs)
    |> Repo.insert()
  end

  # Update a prediction
  def update_prediction(%Prediction{} = prediction, attrs) do
    prediction
    |> Prediction.changeset(attrs)
    |> Repo.update()
  end

  # Delete a prediction
  def delete_prediction(%Prediction{} = prediction) do
    Repo.delete(prediction)
  end

  # Create a bet with predictions
  def create_bet_with_predictions(bet_attrs, predictions_attrs) do
    Repo.transaction(fn ->
      bet = create_bet(bet_attrs)

      Enum.each(predictions_attrs, fn prediction_attrs ->
        create_prediction(Map.put(prediction_attrs, :bet_id, bet.id))
      end)

      bet
    end)
  end

  # Fetch all bets with predictions
  def list_bets_with_predictions do
    Repo.all(Bet)
    |> Repo.preload([:predictions])
  end
end
