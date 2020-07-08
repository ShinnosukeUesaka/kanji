module PracticePdf
  class BasicPdf < Prawn::Document
    def initialize
      # 新規PDF作成
      super(page_size: 'A4')
      # 座標を表示
      stroke_axis
    end
  end
end