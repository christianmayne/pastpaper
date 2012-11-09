require 'gedcom'

class GedcomExtractor < GEDCOM::Parser
	def initialize(gedcom_document_id)
		super
		@gedcom_document_id = gedcom_document_id

		setPreHandler  [ "INDI" ], method( :startPerson )
		setPreHandler  [ "INDI", "NAME" ], method( :registerName )
		setPreHandler  [ "INDI", "SEX" ], method( :registerSex )
		setPreHandler  [ "INDI", "TITL" ], method( :registerTitle )

		facts = ['BIRT', 'EDUC', 'EMIG', 'OCCU', 'RESI', 'DEAT']
		facts.each do |fact|
			setPreHandler  [ "INDI", fact], method( :startFact), fact
			setPreHandler  [ "INDI", fact, "DATE" ], method( :registerFactDate)
			setPreHandler  [ "INDI", fact, "PLAC" ], method( :registerFactLocation)
			setPostHandler [ "INDI", fact ], method( :endFact)
		end

		setPostHandler [ "INDI" ], method( :endPerson )

		@currentPerson = nil
	end

	def numeric?(object)
		true if Float(object) rescue false
	end

	def startPerson( data, state, parm )
		@currentPerson = GedcomPerson.new
		@currentPerson.gedcom_document_id = @gedcom_document_id
	end

	def registerName (data, state, parm)
		if @currentPerson.first_name == nil
			full_name = data.strip
			full_name.gsub!('/', '')
			name_parts = full_name.split(' ')

			if name_parts.size == 1
				@currentPerson.first_name = name_parts[0]
			elsif name_parts.size == 2
				@currentPerson.first_name = name_parts[0]
				@currentPerson.last_name = name_parts[1]
			elsif name_parts.size > 2
				@currentPerson.first_name = name_parts[0]
				@currentPerson.middle_name = name_parts.slice(1, name_parts.size - 2).join(' ')
				@currentPerson.last_name = name_parts[name_parts.size - 1]
			end
		end
	end

	def registerSex (data, state, parm)
		@currentPerson.sex = data if @currentPerson.sex == nil
	end

	def registerTitle(data, state, parm)
		@currentPerson.title = data if @currentPerson.title == nil
	end

	def startFact( data, state, parm )
		@currentFact = GedcomFact.new
		@currentFact.kind = parm
	end

	def registerFactDate( data, state, parm )
		if @currentFact.year == nil
			date = data.strip
			@currentFact.date_modifier = 'AFT' if date.include? 'AFT'
			@currentFact.date_modifier = 'BEF' if date.include? 'BEF'
			@currentFact.date_modifier = 'EST' if date.include? 'EST'
			@currentFact.date_modifier = 'EST' if date.include? 'ABT'
			date.gsub!('ABT.', '')
			date.gsub!('AFT.', '')
			date.gsub!('BEF.', '')
			date.gsub!('EST.', '')
			date.gsub!('AFT', '')
			date.gsub!('BEF', '')
			date.gsub!('EST', '')
			date.gsub!('ABT', '')
			date.strip!
			date_parts = date.split(' ')
			if date_parts.size == 1
				@currentFact.year = date_parts[0]
			elsif date_parts.size == 2
				month = date_parts[0]
				@currentFact.year = date_parts[1]
			elsif date_parts.size == 3
				@currentFact.day = date_parts[0]
				month = date_parts[1]
				@currentFact.year = date_parts[2]
			end

			if month
				if numeric?(month)
						@currentFact.month = date_parts[0]
						@currentFact.year = date_parts[1]
				else
					@currentFact.month = Date.strptime(month, '%b').month
				end
			end

			if @currentFact.year.to_s.include? '/'
				@currentFact.modifier = 'EST'
				@currentFact.year = @currentFact.year.slice(0..3)
			end
		end
	end

	def registerFactLocation( data, state, parm )
		@currentFact.location = data  if @currentFact.location == nil
	end

	def endFact( data, state, parm )
		@currentPerson.gedcom_facts << @currentFact
		@currentFact = nil if @currentFact
	end

	def endPerson( data, state, parm )
		@currentPerson.save
		@currentPerson = nil
	end
end
