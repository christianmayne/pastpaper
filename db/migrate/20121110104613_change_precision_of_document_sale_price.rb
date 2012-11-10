class ChangePrecisionOfDocumentSalePrice < ActiveRecord::Migration
  def change
  	change_column :documents, :sale_price, :decimal, :precision => 10, :scale => 2
  end

end
