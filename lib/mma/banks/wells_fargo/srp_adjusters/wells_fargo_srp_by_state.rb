module MMA   # MMA::Banks::WellsFargo::SrpAdjusters::SrpByState.get_srp_adjuster('MN','arm')
  module Banks
    module WellsFargo
      module SrpAdjusters
        WELLS_FARGO_SRP_HASH  = {
            'AK'=>{'fixed'=>-0.150,'arm'=>-0.040},
            'AL'=>{'fixed'=>-0.160,'arm'=>-0.040},
            'AR'=>{'fixed'=>-0.180,'arm'=>-0.070},
            'AZ'=>{'fixed'=>-0.090,'arm'=>-0.030},
            'CA'=>{'fixed'=>-0.040,'arm'=> 0.000},
            'CO'=>{'fixed'=>-0.090,'arm'=>-0.030},
            'CT'=>{'fixed'=>-0.110,'arm'=> 0.000},
            'DC'=>{'fixed'=>-0.090,'arm'=>-0.030},
            'DE'=>{'fixed'=>-0.130,'arm'=>-0.030},
            'FL'=>{'fixed'=>-0.310,'arm'=>-0.090},
            'GA'=>{'fixed'=>-0.220,'arm'=>-0.060},
            'HI'=>{'fixed'=>-0.060,'arm'=>-0.020},
            'IA'=>{'fixed'=>-0.170,'arm'=>-0.050},
            'ID'=>{'fixed'=>-0.100,'arm'=>-0.030},
            'IL'=>{'fixed'=>-0.180,'arm'=>-0.050},
            'IN'=>{'fixed'=>-0.160,'arm'=>-0.040},
            'KS'=>{'fixed'=>-0.190,'arm'=>-0.070},
            'KY'=>{'fixed'=>-0.220,'arm'=>-0.070},
            'LA'=>{'fixed'=>-0.240,'arm'=>-0.100},
            'MA'=>{'fixed'=>-0.100,'arm'=>-0.030},
            'MD'=>{'fixed'=> 0.000,'arm'=> 0.000},
            'ME'=>{'fixed'=>-0.120,'arm'=>-0.040},
            'MI'=>{'fixed'=>-0.200,'arm'=>-0.060},
            'MN'=>{'fixed'=>-0.150,'arm'=>-0.050},
            'MO'=>{'fixed'=>-0.220,'arm'=>-0.080},
            'MS'=>{'fixed'=>-0.190,'arm'=>-0.080},
            'MT'=>{'fixed'=>-0.130,'arm'=>-0.030},
            'NC'=>{'fixed'=>-0.190,'arm'=>-0.060},
            'ND'=>{'fixed'=>-0.320,'arm'=>-0.110},
            'NE'=>{'fixed'=>-0.230,'arm'=>-0.050},
            'NH'=>{'fixed'=>-0.190,'arm'=>-0.060},
            'NJ'=>{'fixed'=>-0.130,'arm'=>-0.040},
            'NM'=>{'fixed'=>-0.100,'arm'=>-0.030},
            'NV'=>{'fixed'=>-0.100,'arm'=>-0.030},
            'NY'=>{'fixed'=>-0.100,'arm'=> 0.000},
            'OH'=>{'fixed'=>-0.200,'arm'=>-0.060},
            'OK'=>{'fixed'=>-0.260,'arm'=>-0.090},
            'OR'=>{'fixed'=>-0.190,'arm'=>-0.070},
            'PA'=>{'fixed'=>-0.310,'arm'=>-0.090},
            'RI'=>{'fixed'=>-0.030,'arm'=> 0.000},
            'SC'=>{'fixed'=>-0.190,'arm'=>-0.060},
            'SD'=>{'fixed'=>-0.170,'arm'=>-0.040},
            'TN'=>{'fixed'=>-0.190,'arm'=>-0.060},
            'TX'=>{'fixed'=>-0.400,'arm'=>-0.130},
            'UT'=>{'fixed'=>-0.120,'arm'=>-0.040},
            'VA'=>{'fixed'=>-0.120,'arm'=>-0.030},
            'VT'=>{'fixed'=>-0.180,'arm'=>-0.080},
            'WA'=>{'fixed'=>-0.120,'arm'=>-0.040},
            'WI'=>{'fixed'=>-0.260,'arm'=>-0.090},
            'WV'=>{'fixed'=>-0.110,'arm'=>-0.040},
            'WY'=>{'fixed'=>-0.100,'arm'=>-0.030}
        }

        class SrpByState

          def self.get_srp_adjuster( state, type = 'fixed' )
            WELLS_FARGO_SRP_HASH[state.upcase][type] if state && state.length == 2
          end
        end
      end
    end
  end
end
