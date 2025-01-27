# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Betsafe.Repo.insert!(%Betsafe.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Betsafe.Sports.Game
alias Betsafe.Sports.Sport
alias Betsafe.Teams.Team
alias Betsafe.Repo

teams = [
  %Team{name: "Manchester United"},
  %Team{name: "Manchester City"},
  %Team{name: "Chelsea"},
  %Team{name: "Arsenal"},
  %Team{name: "Liverpool"}
]

Enum.each(teams, fn team ->
  Repo.insert!(team)
end)

# seed sport football
sport = %Sport{name: "Football"}
Repo.insert!(sport)

# seed games for football
games = for i <- 1..6 do
  %Game{
    sport_id: 1,
    team_a_id: Enum.random([1, 2, 3, 4, 5]),
    team_b_id: Enum.random([1, 2, 3, 4, 5]),
    odds_team_a: Enum.random([1.5, 2.0, 2.5, 3.0]),
    odds_team_b: Enum.random([1.5, 2.0, 2.5, 3.0]),
    odds_draw: Enum.random([1.5, 2.0, 2.5, 3.0]),
    outcome: Enum.random(["home", "away", "draw"])
  }
end

Enum.each(games, fn game ->
  Repo.insert!(game)
end)

IO.puts "Seeds inserted successfully"
