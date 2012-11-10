class SubmitScoreScreen < ProMotion::Screen
  title "Submit Score"

  def on_load
    @form = Formotion::Form.new({
      sections: [{
        rows: [{
          title: "Name",
          key: :member,
          type: :string,
          placeholder: "James Bond",
          auto_correction: :no,
          auto_capitalization: :none
        }, {
          title: "Score",
          key: :score,
          placeholder: "1337",
          type: :number,
        }]
      }, {
        rows: [{
          title: "Submit Score",
          type: :submit,
        }]
      }]
    })

    @form.on_submit do
      submit_form
    end

    @form_controller = Formotion::FormController.alloc.initWithForm(@form)
    set_view_controller(@form_controller)
  end

  def submit_form
    data = @form.render
    BW::HTTP.post("http://podium-api.herokuapp.com/api/v1/leaderboard/update", {payload: {id: data[:member], score: data[:score]}}) do |response|
      if response.ok?
      end
    end

    close_screen action: :submit_score, member: data[:member], score: data[:score]
  end
end