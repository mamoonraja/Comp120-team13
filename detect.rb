#!/usr/bin/env ruby
require "opencv"
include OpenCV

def detect(image)
	data = 'haarcascade_frontalface_alt.xml'
	detector = CvHaarClassifierCascade::load("haarcascade_frontalface_alt.xml")
	image = CvMat.load(image)
	i=0
	detector.detect_objects(image).each do |region|
	  i=i+1
	end
	puts i
	return i
end

detect('upstatement.jpg')
