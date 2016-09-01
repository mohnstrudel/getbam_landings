module Dictionary
	extend self
	@dictionary = {}

	def setup(basis)
		hash_array = Array.new

		basis.each do |basis_item|
			complete_hash = {}
			
			basis_item.each do |key, value|	
				if value.to_f > 0
					# puts "A number found! - #{value}"
					complete_hash[key.to_sym] = value
				else
					complete_hash[value.to_sym] = 1
				end
			end
			hash_array << complete_hash
		end

		build_dictionary(hash_array)
	end

	def build_dictionary(hash_array)
		# Goal of this method is to build a dictionary, meaning a flat hash with ALL values equal to 0.
		# We then proceed to build input hashes based on this dictionary, but filled with 1 or values if they are integers
		# Example: this would be a dictionary line - {"female"=>0, "age"=>0, "Moscow"=>0, "Volgograd"=>0, "male"=>0, "Voronezh"=>0}
		# and this would be one possible input - {"female"=>1, "age"=>39, "Moscow"=>0, "Volgograd"=>1, "male"=>0, "Voronezh"=>0}
		# meaning it's a 39 years old female from Volgograd 

		
		hash_array.each do |hash_item| 
			@dictionary = @dictionary.merge(hash_item)

		end


		@dictionary.each_key do |key|
			@dictionary[key] = 0
		end
		return @dictionary
	end

	def get_arrayed_dict(learning_data)
		result = setup(learning_data)
		transform_hash_into_array(result)
	end

	def transform_hash_into_array(input)
		# here we simply transform our dictionary hash into an array
		# meaning a line like this - {"female"=>0, "age"=>0, "Moscow"=>0, "Volgograd"=>0, "male"=>0, "Voronezh"=>0}
		# will transform into [0, 0, 0, 0, 0 ,0]
		# simple, eh?

		result_array = Array.new
		input.each_value do |value|
			result_array << value
		end

		return result_array
	end

	def transform_data_into_dict_hash(data)
		# In this method we need to tansform our initial input into an input based on our dictionary
		# meaning from {"gender" => "male", "age" => "20", "city" => "Moscow"}
		# we should get {"female"=>0, "age"=>20, "Moscow"=>1, "Volgograd"=>0, "male"=>1, "Voronezh"=>0}
		# if our initial dictionary was {"female"=>0, "age"=>0, "Moscow"=>0, "Volgograd"=>0, "male"=>0, "Voronezh"=>0}
		# As input is only one hash expected!
		right_hash = {}
		data.each do |key, value|
			if value.to_f > 0
				right_hash[key.to_sym] = value.to_f
			else
				right_hash[value.to_sym] = 1
			end
		end
		return_hash = @dictionary.merge(right_hash)

		return return_hash
	end

	def get_arrayed_test_hash(test_data)
		result = transform_data_into_dict_hash(test_data)
		transform_hash_into_array(result)
	end

	def prepare_learning_data(learning_data)
		landing_to_show = [1,2,3,4,5,5]
		endresult = [[]]
		
		learning_data.each_with_index do |learning_data_item, index|
			# Code line is depricated for current method, because we don't include labels 
			# endresult[index] = [ landing_to_show[index], transform_data_into_dict_hash(learning_data_item) ]
			endresult[index] = transform_hash_into_array(transform_data_into_dict_hash(learning_data_item))
		end

		return endresult
	end

	def predict(dictionary_data, input_to_predict)
		# Here we first get the dictionary data in the right format, meaning a two-dimensional array
		# of a form [[landing, hash]], where landing is the number of a landing page we want to show
		# and hash is the params hash of the current user
		# Example: data = [ [1, {female: 0, male: 1, age: 30}], [2, {female: 0, male: 1, age: 20}] ]

		dictionary_data_working = prepare_learning_data(dictionary_data)
		puts "We are working with this training data:"
		p dictionary_data_working
		puts "=========="
		puts "And with following input, for which we predict landing page:"
		input_to_predict_working = transform_data_into_dict_hash(input_to_predict)
		p input_to_predict_working

		return Svm::example(dictionary_data_working, input_to_predict_working)
	end
end