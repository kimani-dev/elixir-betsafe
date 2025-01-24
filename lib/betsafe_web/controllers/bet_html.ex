defmodule BetsafeWeb.BetHTML do
  use BetsafeWeb, :html

  embed_templates "bet_html/*"

  @doc """
  Renders a bet form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def bet_form(assigns)
end
