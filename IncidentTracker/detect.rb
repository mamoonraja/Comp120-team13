#!/usr/bin/env ruby
require "opencv"
include OpenCV

def detect(image)
	data = 'haarcascade_frontalface_alt.xml'
	detector = CvHaarClassifierCascade::load(data)
	image = CvMat.load(image)
	i=0
	detector.detect_objects(image).each do |region|
	  i=i+1
	end
	return i
end

a=detect('/home/mamoon/test_opencv/people-03.png')
puts a