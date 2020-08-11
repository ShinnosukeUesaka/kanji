module QuestionsHelper
    
    

  
  def full_mondai
    tag.p  @question.ex_top.to_s +  @question.yomi.to_s +  @question.ex_bottom.to_s 
    
    #"<p>" ++ "</p>"
    
    # <p><span>ex_top<span><span class="bold">yomi</span><span>ex_bottom</span></p>
  end

    
    
    
end
