class RenameMaxTotalToMaxReview < ActiveRecord::Migration[5.2]
  def change
    rename_column :settings, :max_total_questions, :max_review_questions
  end
end
