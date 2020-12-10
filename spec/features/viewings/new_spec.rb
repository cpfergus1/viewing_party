require "rails_helper"

feature 'As a user' do
given!(:user) {@user = create(:user)}
  describe 'when I visit the new viewing party page' do
    before(:each) do
      @friend_1 = create(:user)
      @friend_2 = create(:user)
      @friend_3 = create(:user)
      @friend_4 = create(:user)
      @user.friends << @friend_1
      @user.friends << @friend_2
      @user.friends << @friend_3
      @user.friends << @friend_4
      page.set_rack_session(user_id: @user.id)
      visit movie_path(155)
    end

    it 'I should see a form with viewing party details', :vcr do
      expect(page).to have_button('Create Viewing Party for Movie')
      click_on 'Create Viewing Party for Movie'
      expect(current_path).to eq(new_movie_viewing_party_path(155))
      expect(page).to have_content('The Dark Knight')
      expect(page).to have_field('viewing[duration_of_party]')
      expect(page).to have_field('viewing[date(2i)]')
      expect(page).to have_field('viewing[start_time(4i)]')
      @user.friends.each do |friend|
        expect(page).to have_field("viewing[friends[#{friend.id}]]", checked: false)
        check "viewing[friends[#{friend.id}]]"
        expect(page).to have_field("viewing[friends[#{friend.id}]]", checked: true)
      end
      expect(page).to have_button('Create Viewing Party')
    end

    it 'I fill out the form and create a viewing party', :vcr do
      click_on 'Create Viewing Party for Movie'
      fill_in 'viewing[duration_of_party]', with: 160
      select_date '2020,Dec,30', :from => "Day"
      select_time "20,30", from: 'viewing_start_time'
      find(:css, "#Friend_#{@friend_1.id}").set(true)
      find(:css, "#Friend_#{@friend_2.id}").set(true)
      find(:css, "#Friend_#{@friend_3.id}").set(true)
      click_on 'Create Viewing Party'
      expect(current_path).to eq(user_dashboard_path(@user.username))
      viewing1 = Viewing.last
      within('.viewing-parties') do
        expect(page).to have_content(viewing1.movie.title)
        expect(page).to have_content(viewing1.start_time.strftime('%m-%d-%Y'))
        expect(page).to have_content(viewing1.start_time.strftime('%I:%M'))
        expect(page).to have_content('Host')
      end
      expect(viewing1.guests.count).to eq(4)
    end

    it 'I cannot create a new viewing party when i do not select any friends', :vcr do
      click_on 'Create Viewing Party for Movie'
      fill_in 'viewing[duration_of_party]', with: 160
      select_date '2020,Dec,30', :from => "Day"
      select_time "20,30", from: 'viewing_start_time'
      click_on 'Create Viewing Party'
      expect(current_path).to_not eq(user_dashboard_path(@user.username))
      expect(page).to have_content("You don't want to have a viewing party with only yourself do you?")
    end

    it 'I cannot create a new viewing party when the party duration is less than the movie duration', :vcr do
      click_on 'Create Viewing Party for Movie'
      fill_in 'viewing[duration_of_party]', with: 100
      select_date '2020,Dec,30', :from => "Day"
      select_time "20,30", from: 'viewing_start_time'
      find(:css, "#Friend_#{@friend_1.id}").set(true)
      find(:css, "#Friend_#{@friend_2.id}").set(true)
      find(:css, "#Friend_#{@friend_3.id}").set(true)
      click_on 'Create Viewing Party'
      expect(current_path).to_not eq(user_dashboard_path(@user.username))
      expect(page).to have_content("Your party is not long enough to see the whole movie! Please change your time to accomidate the full viewing.")
    end

    it 'when I create a viewing party, an invitation with details about the viewing party is emailed to each invited user', :vcr do
      click_on 'Create Viewing Party for Movie'
      find(:css, "#Friend_#{@friend_1.id}").set(true)
      find(:css, "#Friend_#{@friend_2.id}").set(true)
      find(:css, "#Friend_#{@friend_3.id}").set(true)
      click_on 'Create Viewing Party'
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      email = ActionMailer::Base.deliveries.last
      viewing = Viewing.last
      subject = "#{@user.username} has invited you to watch #{viewing.movie.title}"
      expect(email.to.count).to eq(3)
    end
  end
end
