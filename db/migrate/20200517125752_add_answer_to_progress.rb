class AddAnswerToProgress < ActiveRecord::Migration[5.2]
  def change
    add_column :progresses, :answer, :integer
  end
end
