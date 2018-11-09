collection @rentals
attributes :movie_id, :customer_id, :due_date

glue :movie do
  attribute :title
end

glue :customer do
  attributes :name, :postal_code
  node(:checkout_date) { |customer| customer.created_at.to_date }
end
