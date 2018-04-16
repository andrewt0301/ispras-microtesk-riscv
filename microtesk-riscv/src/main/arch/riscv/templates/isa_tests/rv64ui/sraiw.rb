#
# Copyright 2018 ISP RAS (http://www.ispras.ru)
#
# Licensed under the Apache License, Version 2.0 (the "License")
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# THIS FILE IS BASED ON THE FOLLOWING RISC-V TEST SUITE SOURCE FILE:
# https://github.com/riscv/riscv-tests/blob/master/isa/rv64ui/sraiw.S
# WHICH IS DISTRIBUTED UNDER THE FOLLOWING LICENSE:
#
# Copyright (c) 2012-2015, The Regents of the University of California (Regents).
# All Rights Reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. Neither the name of the Regents nor the
#    names of its contributors may be used to endorse or promote products
#    derived from this software without specific prior written permission.
#
# IN NO EVENT SHALL REGENTS BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT,
# SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS, ARISING
# OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF REGENTS HAS
# BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# REGENTS SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE. THE SOFTWARE AND ACCOMPANYING DOCUMENTATION, IF ANY, PROVIDED
# HEREUNDER IS PROVIDED "AS IS". REGENTS HAS NO OBLIGATION TO PROVIDE
# MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
#

require_relative '../../riscv_base'

class SraiwTemplate < RISCVBaseTemplate

  def run
    RVTEST_RV64U()
    RVTEST_CODE_BEGIN()

    #-------------------------------------------------------------
    # Arithmetic tests
    #-------------------------------------------------------------

    TEST_IMM_OP( 2,  'sraiw', 0xffffffff80000000, 0xffffffff80000000, 0  )
    TEST_IMM_OP( 3,  'sraiw', 0xffffffffc0000000, 0xffffffff80000000, 1  )
    TEST_IMM_OP( 4,  'sraiw', 0xffffffffff000000, 0xffffffff80000000, 7  )
    TEST_IMM_OP( 5,  'sraiw', 0xfffffffffffe0000, 0xffffffff80000000, 14 )
    TEST_IMM_OP( 6,  'sraiw', 0xffffffffffffffff, 0xffffffff80000001, 31 )

    TEST_IMM_OP( 7,  'sraiw', 0x000000007fffffff, 0x000000007fffffff, 0  )
    TEST_IMM_OP( 8,  'sraiw', 0x000000003fffffff, 0x000000007fffffff, 1  )
    TEST_IMM_OP( 9,  'sraiw', 0x0000000000ffffff, 0x000000007fffffff, 7  )
    TEST_IMM_OP( 10, 'sraiw', 0x000000000001ffff, 0x000000007fffffff, 14 )
    TEST_IMM_OP( 11, 'sraiw', 0x0000000000000000, 0x000000007fffffff, 31 )

    TEST_IMM_OP( 12, 'sraiw', 0xffffffff81818181, 0xffffffff81818181, 0  )
    TEST_IMM_OP( 13, 'sraiw', 0xffffffffc0c0c0c0, 0xffffffff81818181, 1  )
    TEST_IMM_OP( 14, 'sraiw', 0xffffffffff030303, 0xffffffff81818181, 7  )
    TEST_IMM_OP( 15, 'sraiw', 0xfffffffffffe0606, 0xffffffff81818181, 14 )
    TEST_IMM_OP( 16, 'sraiw', 0xffffffffffffffff, 0xffffffff81818181, 31 )

    #-------------------------------------------------------------
    # Source/Destination tests
    #-------------------------------------------------------------

    TEST_IMM_SRC1_EQ_DEST( 17, 'sraiw', 0xffffffffff000000, 0xffffffff80000000, 7 )

    #-------------------------------------------------------------
    # Bypassing tests
    #-------------------------------------------------------------

    TEST_IMM_DEST_BYPASS( 18, 0, 'sraiw', 0xffffffffff000000, 0xffffffff80000000, 7  )
    TEST_IMM_DEST_BYPASS( 19, 1, 'sraiw', 0xfffffffffffe0000, 0xffffffff80000000, 14 )
    TEST_IMM_DEST_BYPASS( 20, 2, 'sraiw', 0xffffffffffffffff, 0xffffffff80000001, 31 )

    TEST_IMM_SRC1_BYPASS( 21, 0, 'sraiw', 0xffffffffff000000, 0xffffffff80000000, 7 )
    TEST_IMM_SRC1_BYPASS( 22, 1, 'sraiw', 0xfffffffffffe0000, 0xffffffff80000000, 14 )
    TEST_IMM_SRC1_BYPASS( 23, 2, 'sraiw', 0xffffffffffffffff, 0xffffffff80000001, 31 )

    TEST_IMM_ZEROSRC1( 24, 'sraiw', 0, 31 )
    TEST_IMM_ZERODEST( 25, 'sraiw', 31, 28 )

    TEST_IMM_OP( 26, 'sraiw', 0x0000000000000000, 0x00e0000000000000, 28)
    TEST_IMM_OP( 27, 'sraiw', 0xffffffffff000000, 0x00000000f0000000, 4)

    TEST_PASSFAIL()

    RVTEST_CODE_END()

    RVTEST_DATA_BEGIN()
    TEST_DATA()
    RVTEST_DATA_END()
  end

end
