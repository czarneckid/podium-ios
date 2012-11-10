class ViewLeaderboardScreen < ProMotion::TableScreen
  title "Leaderboard"

  def on_load
    BW::HTTP.get("http://podium-api.herokuapp.com/api/v1/leaderboard/members", {payload: {page: 1}}) do |response|
      if response.ok?
        @members = BW::JSON.parse(response.body.to_str)['data']['members']
        member_data = []
        @members.each do |member|
          member_data << {title: "#{member['member']}: #{member['score']}"}
        end

        @data = [
          {
            cells: member_data
          }
        ]
      end
    end
  end

  def on_appear
    self.updateTableViewData(@data)
  end

  def table_data
    []
  end
end