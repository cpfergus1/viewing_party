require 'rails_helper'

describe FriendNotifierMailer, type: :mailer do
  describe 'send_invites' do
    before :each do
      @user = create(:user)
      @friend_1 = create(:user)
      @friend_2 = create(:user)
      @friend_3 = create(:user)
      @friend_4 = create(:user)
      @user.friends << @friend_1
      @user.friends << @friend_2
      @user.friends << @friend_3
      @user.friends << @friend_4
      @movie = Movie.create!(
        api_id: 155,
        title: 'The Dark Knight',
        duration_of_movie: 100
      )
      @viewing = @movie.viewings.create!(
        start_time: DateTime.now,
        duration_of_party: @movie.duration_of_movie
      )
      @viewing.guests.create!(user_id: @user.id, hosting: true)
      @user.friends.each do |friend|
        @viewing.guests.create!(user_id: friend.id, hosting: false)
      end
      @email_info = {}
      @email_info[:viewing] = @viewing
      @email_info[:guests] = []
      @viewing.guests.each do |guest|
        user = guest.user
        @email_info[:guests] << { user: user, hosting: guest.hosting }
      end
    end

    let(:mail) { FriendNotifierMailer.send_invites(@email_info) }

    it 'renders the headers' do
      recipients = [@friend_1.email, @friend_2.email, @friend_3.email, @friend_4.email]
      subject = "#{@user.username} has invited you to watch #{@viewing.movie.title}"

      expect(mail.reply_to).to eq([@user.email])
      expect(mail.to).to eq(recipients)
      expect(mail.subject).to eq(subject)
      expect(mail.from).to eq(['no_reply@viewing_party.com'])
    end

    it 'renders the body' do
      expect(mail.text_part.body.to_s).to include("#{@viewing.movie.title} watch party:")
      expect(mail.html_part.body.to_s).to include("#{@viewing.movie.title} watch party:")
      expect(mail.text_part.body.to_s).to include("Starts: #{@viewing.start_time}")
      expect(mail.html_part.body.to_s).to include("Starts: #{@viewing.start_time}")
      expect(mail.text_part.body.to_s).to include("See you then!")
      expect(mail.html_part.body.to_s).to include("See you then!")
    end
  end
end
