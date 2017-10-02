# from https://www.chrisblunt.com/rails-3-how-to-autoload-and-autorequire-your-custom-library-code/

require 'active_record/add_reset_pk_sequence_to_base'
require 'mma/banks/utils/rate_matcher'
require 'mma/banks/wells_fargo/rate_sheet/wells_fargo_logic'
require 'mma/banks/wells_fargo/rate_sheet/wells_fargo_conforming_pricing'
require 'mma/banks/wells_fargo/rate_sheet/wells_fargo_conforming_adjusters'
require 'mma/banks/wells_fargo/regular_adjusters/adjusters'
require 'mma/excel/excel_utils'
require 'mma/excel/load_excel'
require 'mma/excel/parse_excel'
