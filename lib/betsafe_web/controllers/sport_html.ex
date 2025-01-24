defmodule BetsafeWeb.SportHTML do
  use BetsafeWeb, :html

  embed_templates "sport_html/*"

  @doc """
  Renders a sport form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def sport_form(assigns)
end
