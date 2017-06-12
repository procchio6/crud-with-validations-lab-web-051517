class Song < ActiveRecord::Base
  validates :title, :artist_name, presence:true
  validate :not_repeated
  validates :released, inclusion: {in:[true,false]}
  validates :release_year, presence:true, if: :released
  validate :release_year_before_current_year, if: :released

  def not_repeated
    repeated_song = Song.where(title:title, artist_name:artist_name, release_year:release_year).limit(1).first
    if !repeated_song.nil?
      errors.add(:song, "song can not be repeated")
    end
  end

  def release_year_before_current_year
    if release_year
      if release_year > Date.today.year
        errors.add(:release_year, "can't be after current year")
      end
    end
  end
  
end
