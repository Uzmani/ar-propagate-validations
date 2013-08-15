# Prevent Events from being saved when: a. The events date is 
# empty, in the past, or is not valid. b. The events 
# title is already taken or empty. c. The event organizers 
# name is empty. d. The event organizers email address is
# invalid.

class Event < ActiveRecord::Base
   
  validate :date_cannot_be_in_the_past
  validates :title, presence: true
  validates :organizer_name, presence: true
  validates :title, uniqueness: true
  validates_format_of :organizer_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  def date_cannot_be_in_the_past
    if date.present? && date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end
end


