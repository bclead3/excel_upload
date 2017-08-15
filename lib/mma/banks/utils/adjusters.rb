
module MMA    # MMA::Banks::Utils::Adjusters.calculate_adjusters( )
  module Banks
    module Utils
      FICO_HIGH_LOW_CUTOFF  = 720
      DEFAULT_SHORT_YEARS   = 15
      DEFAULT_LONG_YEARS    = 30
      FANNIE_MAY            = 'FNMA'
      GINNIE_MAY            = 'GNMA'
      NON_CONF_IDENTIFIED   = 'non conforming (identified)'
      NON_CONF_UNIDENTIFIED = 'non conforming'
      SHORT_DURATION_WORDING= 'less than or equal to 15y'
      LONG_DURATION_WORDING = '20 years or more'
      FICO_HIGH_VERBIAGE    = "below #{FICO_HIGH_LOW_CUTOFF}"
      FICO_LOW_VERBIAGE     = 'above cutoff'

      class Adjusters

        def self.loan_hash
          return_hash = {}
          MMA::Loan.all.each do |loan_rec|
            hash = calculate_adjusters( loan_rec )
            id = hash[:loan_id]
            return_hash[id] = hash
          end
          return_hash
        end

        def self.calculate_adjusters( loan_record )
          loan_rate           = loan_record.note_rate
          loan_ltv            = loan_record.ltv
          loan_combined_ltv   = loan_record.combined_ltv

          loan_type_hash      = {}
          loan_type_hash[:loan_id]  = "#{loan_record.investor.gsub(' ','')}::#{loan_record.loan_num}"
          loan_type_hash[:program]  = loan_record.loan_program
          hash                = loan_type( loan_record.loan_program )
          loan_type_hash.merge!( hash )
          loan_type_hash[:amount]         = loan_record.loan_amt.to_s
          loan_type_hash[:rate]           = loan_rate.to_s
          loan_type_hash[:ltv]            = loan_ltv.to_s            if loan_ltv
          loan_type_hash[:combined_ltv]   = loan_combined_ltv.to_s   if loan_combined_ltv
          loan_fico                       = loan_record.fico
          if loan_fico
            f_h_l                           = fico_high_low( loan_fico )
            loan_type_hash[:fico]           = loan_fico
            loan_type_hash[:fico_high_low]  = f_h_l
          end
          loan_type_hash[:last_milestone]   = loan_record.last_finished_milestone
          loan_type_hash[:lock_status]      = loan_record.lock_status

          puts "#{loan_record.loan_num}\ttype:#{loan_record.loan_program}\trate:#{loan_rate}\tltv:#{loan_ltv}\tcombined_ltv:#{loan_combined_ltv}\tfico:#{loan_fico}"
          pp loan_type_hash
        end

        def self.is_conforming( loan_program_string )
          false
          if loan_program_string && loan_program_string.is_a?(String)
            true if loan_program_string.index('Conf')
          end
        end

        def self.loan_type( loan_program_string )
          hash = {}
          if MMA::FNMA_15_TYPE_ARRAY.index( loan_program_string )
            hash[:type] = FANNIE_MAY
            hash[:duration] = SHORT_DURATION_WORDING
            if /\d+/.match(loan_program_string)
              hash[:years] = /\d+/.match(loan_program_string).to_s.to_i
            else
              hash[:years] = DEFAULT_SHORT_YEARS
            end
          elsif MMA::FNMA_30_TYPE_ARRAY.index( loan_program_string )
            hash[:type] = FANNIE_MAY
            hash[:duration] = LONG_DURATION_WORDING
            if /\d+/.match(loan_program_string)
              hash[:years] = /\d+/.match(loan_program_string).to_s.to_i
            end
          elsif MMA::GNMA_15_TYPE_ARRAY.index( loan_program_string )
            hash[:type] = GINNIE_MAY
            hash[:duration] = SHORT_DURATION_WORDING
            if /\d+/.match(loan_program_string)
              hash[:years] = /\d+/.match(loan_program_string).to_s.to_i
            end
          elsif MMA::GNMA_30_TYPE_ARRAY.index( loan_program_string )
            hash[:type] = GINNIE_MAY
            hash[:duration] = LONG_DURATION_WORDING
            if /\d+/.match(loan_program_string)
              hash[:years] = /\d+/.match(loan_program_string).to_s.to_i
            else
              hash[:years] = DEFAULT_LONG_YEARS
            end
          elsif MMA::NON_CONFORMING_ARR.index( loan_program_string )
            hash[:type] = NON_CONF_IDENTIFIED
            hash[:duration] = LONG_DURATION_WORDING
            if /\d+/.match(loan_program_string)
              hash[:years] = /\d+/.match(loan_program_string).to_s.to_i
            else
              hash[:years] = DEFAULT_LONG_YEARS
            end
          else
            hash[:type] = NON_CONF_UNIDENTIFIED
            hash[:duration] = LONG_DURATION_WORDING
            if /\d+/.match(loan_program_string)
              hash[:years] = /\d+/.match(loan_program_string).to_s.to_i
            else
              hash[:years] = DEFAULT_LONG_YEARS
            end
          end
          hash
        end

        def self.fico_high_low( fico_val )
          fico_val = fico_val.to_i if fico_val.is_a?(String)
          if fico_val < FICO_HIGH_LOW_CUTOFF
            FICO_HIGH_VERBIAGE
          else
            FICO_LOW_VERBIAGE
          end
        end
      end
    end
  end
end
