class TestController < ApplicationController
  def question
    @review_progresses = current_user.show_progresses.where(category: [:young, :mature])
    @new_progresses = current_user.show_progresses.where(category: [:new])
    @review_questions = @review_progresses.each.map {|progress| progress.question}
    @new_questions = @new_progresses.each.map {|progress| progress.question}
    #https://kuzugr.com/article/31
    # respond_to do |format|
    #   format.pdf do
    #     basic_pdf = PracticePdf::BasicPdf.new().render
    #     send_data basic_pdf,
    #       filename: 'basic_pdf.pdf',
    #       type: 'application/pdf',
    #       disposition: 'inline'
    #   end
    #end
  end

  def answer
    @review_progresses = current_user.show_progresses.where(category: [:young, :mature])
    @new_progresses = current_user.show_progresses.where(category: [:new])
    @review_questions = @review_progresses.each.map {|progress| progress.question}
    @review_questions = @review_progresses.each.map {|progress| progress.question}
  end

  def finished
    params[:responses].each do |id, response|
      @progress = Progress.find(id)
      @progress.answer = params[response]
      @progress.save
    end
  end
end
