collection @customers
attributes :id, :name, :registered_at, :postal_code, :phone
node(:movies_checked_out_count) { |customer| customer.movies_checked_out_count }
