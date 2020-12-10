require 'rails_helper'
feature 'as a user' do
  given!(:user) {@user = create(:user)}
  describe 'when I visit the movie page' do
    before(:each) do
      page.set_rack_session(:user)
    end
    describe 'and I click on a movie I want to see' do
      it 'It takes me to the the movie show page', :vcr do
        visit movies_path
        click_button 'Top Rated Movies'
        expected_id = 761053
        within(first('.movie')) do
          title = find('.title').text
          click_link title
        end
        expect(current_path).to eq(movie_path(expected_id))
      end
      it 'I can see movie details', :vcr do
        visit movie_path(155)
        expect(page).to have_css('.vote_average')
        expect(page).to have_css('.title_show_page')
        expect(page).to have_css('.runtime')
        expect(page).to have_css('.genre')
        expect(page).to have_css('.summary')
        expect(page).to have_css('.cast')
        expect(page).to have_css('.member', count: 10)
        expect(page).to have_css('.reviews')
        expect(page).to have_css('.author')
        expect(page).to have_css('.content')
        title = find('.title_show_page').text
        vote_average = find('.vote_average').text
        runtime = find('.runtime').text
        genre = find('.genre').text
        summary = find('.summary').text
        cast = find('.cast').text
        reviews = find('.reviews').text
        author = first('.author').text
        content = first('.content').text
        expect(title).to_not be_empty
        expect(vote_average).to_not be_empty
        expect(runtime).to_not be_empty
        expect(genre).to_not be_empty
        expect(summary).to_not be_empty
        expect(cast).to_not be_empty
        expect(reviews).to_not be_empty
        expect(author).to_not be_empty
        expect(content).to_not be_empty
      end

      it 'I can get movie recommendations', :vcr do
        visit movie_path(155)

        expect(page).to have_css('.recommendation')
        within ('.recommendation') do
          expect(page).to have_css('.recommendation-link', count: 10)
        end
      end

      it 'I can get similar movies', :vcr do
        visit movie_path(155)

        expect(page).to have_css('.similar')
        within ('.similar') do
          expect(page).to have_css('.similar-link', count: 10)
        end
      end

    end
  end
end
