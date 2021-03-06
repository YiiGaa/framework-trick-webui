# encoding=UTF-8
require_relative '../../Think/think.rb'

class CMoveMakeMenu
	def initialize()
		@ObjThink = CThink.new
		@menuParam = {
			"MakeCode"=>{
					"path"=>"#{$ModelPath}/MakeCodeNormal"
				},
			# "CheckModel"=>{
			# 		"path"=>"#{$ModelPath}/MakeCodeNormal"
			# 	},
			"MakeEngineering"=>{
					"path"=>"#{$ModelPath}/MakeEngineeringNormal"
				}
		}
	end
	
	def step1()
		@ObjThink.start({"action" => "WriteCleanFile","path"=>$MenuPath })
	end

	def step2(param)
		param.each do |list|
			isNext = false
			@menuParam.each do |key,value|
				if list.include?key
					if value['fileList'] == nil
						value['fileList'] = @ObjThink.start({"action" => "ReadDirectoryList","path"=>value['path'] })
					end
					value['fileList'].each do |list_1|
						@ObjThink.start({"action" => "WriteCreateFile","path"=>$MenuPath+"/"+list+list_1 })
					end
					isNext = true
					break
				end
			end
			if !isNext
				@ObjThink.start({"action" => "WriteCreateFile","path"=>$MenuPath+"/"+list })
			end
		end
	end
	
	def start(param)
		puts 'Step 1: clean Menu.'
		step1()
		puts 'Step 2: create Menu.'
		step2(param)
		puts 'Success!'
	end
end
