100.times do
  Book.create({
    title: Faker::Lorem.unique.paragraph(sentence_count: 1),
    author: Faker::Name.name,
    published_date: Date.today
  })
end
