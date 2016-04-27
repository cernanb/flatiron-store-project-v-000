class Cart < ActiveRecord::Base

  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user

  def total
    sum = 0
    self.line_items.each do |li|
      item = Item.find_by(id: li.item_id)
      sum += item.price * li.quantity
    end
    sum
  end

  def add_item(item_id)
    existing_li = self.line_items.find_by(item_id: item_id)
    if existing_li
      existing_li.quantity += 1
      existing_li
    else
      self.line_items.build(item_id: item_id)
    end
  end

  def update_inventory
    line_items.each do |li|
      item = Item.find_by(id: li.item_id)
      new_inventory = item.inventory - li.quantity
      item.update(inventory: new_inventory)
    end
  end
end
