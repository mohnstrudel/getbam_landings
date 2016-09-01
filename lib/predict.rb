module Predict

	include Dictionary
	require 'libsvm'

	def self.init
			# This library is namespaced.
		problem = Libsvm::Problem.new
		parameter = Libsvm::SvmParameter.new

		parameter.cache_size = 1 # in megabytes

		parameter.eps = 0.001
		parameter.c = 10

		return problem, parameter
	end

	def self.execute(base_dictionary, labels, object_to_predict)
		problem = init[0]
		parameter = init[1]

		# Setup the Dictionary
		encoded_object_to_predict = Dictionary::get_arrayed_test_hash(object_to_predict)
		# puts Dictionary::predict(learning_data,test_hash)

		# Line commended out to preserve original state. Below modified version 
		# examples = [ [1,0,1], [-1,0,-1], [0,0,1], [0,0,0,1] ].map {|ary| Libsvm::Node.features(ary) }
		examples = Dictionary::prepare_learning_data(base_dictionary).map {|ary| Libsvm::Node.features(ary) }

		# labels are our landing pages

		problem.set_examples(labels, examples)

		model = Libsvm::Model.train(problem, parameter)

		pred = model.predict(Libsvm::Node.features(encoded_object_to_predict))
		puts "Example #{encoded_object_to_predict} - Predicted landing number #{pred}"

		return pred
	end

	# An example of learning data (data, which our learning machine will consider
	# as "base")
	# 
	# learning_data = [
	# 	{"gender" => "female", "age" => "25", "city" => "Moscow"},
	# 	{"gender" => "female", "age" => "45", "city" => "Volgograd"},
	# 	{"gender" => "female", "age" => "30", "city" => "Moscow"},
	# 	{"gender" => "male", "age" => "20", "city" => "Moscow"},
	# 	{"gender" => "male", "age" => "30", "city" => "Voronezh"},
	# 	{"gender" => "male", "age" => "40", "city" => "Moscow"},
	# 		]

	# Some test hash
	# test_hash = {"gender" => "female", "age" => "28", "city" => "Moscow"}

	# data = [
	# 	[1, {hash}],
	# 	[2, {hash}],
	# 	[3, {hash}],
	# 	[4, {hash}] 
	# ]



	# examples are our training data
	# let's say 
	# first place is moscow 
	# second place 

	
end