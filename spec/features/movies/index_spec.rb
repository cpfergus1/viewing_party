require 'rails_helper'

feature 'as a user' do
  given!(:user) {@user = create(:user)}
  describe 'when I visit the discover page' do
    it 'I can search for movies', :vcr do
      page.set_rack_session(user_id: @user.id)

      visit discover_index_path
      expect(page).to have_field(:query)
      expect(page).to have_button('Search')

      fill_in :query, with: 'batman'
      click_button 'Search'

      expect(current_path).to eq(movies_path)
      expect(page).to have_css('.movie', count: 40)

      within(first('.movie')) do
        expect(page).to have_css('.title')
        expect(page).to have_css('.rating')
        expect(page).to have_link('Batman Begins')
        expect(page).to have_content('7.7')
        title = find('.title').text
        rating = find('.rating').text
        expect(title).to_not be_empty
        expect(rating).to_not be_empty
      end

      within(:xpath, '(//li[@class="movie"])[last()]') do
        expect(page).to have_css('.title')
        expect(page).to have_css('.rating')
        expect(page).to have_link('Batman', exact: false)
        title = find('.title').text
        rating = find('.rating').text
        expect(title).to_not be_empty
        expect(rating).to_not be_empty
      end
    end

    it 'can search for top 40 movies', :vcr do
      page.set_rack_session(user_id: @user.id)

      visit discover_index_path
      click_on 'Top Rated Movies'
      expect(page).to have_css('.movie', count: 40)

      within(first('.movie')) do
        title = find('.title').text
        rating = find('.rating').text
        expect(title).to_not be_empty
        expect(rating).to_not be_empty
      end

      within(:xpath, '(//li[@class="movie"])[last()]') do
        title = find('.title').text
        rating = find('.rating').text
        expect(title).to_not be_empty
        expect(rating).to_not be_empty
      end
    end
  end
end
