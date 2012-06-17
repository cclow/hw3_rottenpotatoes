# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(/, */).each do |rating|
    if uncheck.present?
      step %Q|I uncheck "ratings_#{rating}"|
    else
      step %Q|I check "ratings_#{rating}"|
    end
  end
end

Then /I should see all of the movies/ do
  page.has_css?("tbody#movielist tr", count: Movie.count)
  Movie.all.each do |movie|
    step %Q|I should see "#{movie.title}"|
  end
end
