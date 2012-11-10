class HomeScreen < ProMotion::GroupedTableScreen
  title "Podium"

  def table_data
    [{
      cells: [
        { title: "Submit Score", action: :submit_score },
        { title: "View Leaderboard", action: :view_leaderboard },
        { title: "Clear Leaderboard", action: :clear_leaderboard }
      ]
    },
    {
      title: 'Debugging',
      cells: [
        { title: "About", action: :about }
      ]
    }]
  end

  def submit_score(args)
    open_screen SubmitScoreScreen
  end

  def view_leaderboard(args)
    open_screen ViewLeaderboardScreen
  end

  def clear_leaderboard(args)
    BW::HTTP.delete("http://podium-api.herokuapp.com/api/v1/leaderboard") do |response|
      if response.ok?
        p 'Leaderboard cleared'
      end
    end
  end

  def on_return(args = {})
  end
end