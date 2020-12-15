namespace :slurp do
  desc "TODO"
  task items: :environment do
    require 'csv'

    csv_text = File.read(Rails.root.join('db', 'data', 'items.csv'))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      i = Item.new
      i.id = row['id'].to_i
      i.name = row['name']
      i.description = row['description']
      i.unit_price = row['unit_price'].to_f / 100
      i.merchant_id = row['merchant_id']
      i.created_at = row['created_at']
      i.updated_at = row['updated_at']
      i.save
    end
  end

end
