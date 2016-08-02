require "opencv"
include OpenCV

class Incident < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :categories
  validates :location, :severity, :presence => true
  before_save :override_field
  mount_uploader :media, MediaUploader

  def override_field
    if self.status.nil?
      self.status = 1
    end
  end

  def set_user!(user)
    puts "SET USER"
    self.user_id = user.id
  end

  def set_anonymous!
    puts "SET ANONYMOUS"
    self.user_id = 1
  end

  def detect(image)
    #data = Rails.root.join("assets", "opencvdata", "haarcascade_frontalface_alt.xml").to_s

    #puts data
    detector = CvHaarClassifierCascade::load("haarcascade_frontalface_alt.xml")
    image = CvMat.load(image)
    i = 0
    detector.detect_objects(image).each do |region|
      i = i + 1
    end
    puts i
    return i
  end
end
