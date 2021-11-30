Author.transaction do
  10.times do
    Author.create({
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email:  Faker::Internet.unique.email
    })
  end

  author_ids = Author.ids

  100.times do
    Book.create({
      title: Faker::Lorem.unique.paragraph(sentence_count: 1),
      author_id: author_ids.sample,
      published_date: Date.today
    })
  end
end
