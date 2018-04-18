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
# https://github.com/riscv/riscv-tests/blob/master/isa/rv64ui/srli.S
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

class SrliTemplate < RISCVBaseTemplate

  def TEST_SRL(n, v, a)
    TEST_IMM_OP(n, 'srli', ((v) & ((1 << (__riscv_xlen-1) << 1) - 1)) >> (a), v, a)
  end

  def run
    RVTEST_RV64U()
    RVTEST_CODE_BEGIN()

    #-------------------------------------------------------------
    # Arithmetic tests
    #-------------------------------------------------------------

    TEST_SRL( 2,  0xffffffff80000000, 0  )
    TEST_SRL( 3,  0xffffffff80000000, 1  )
    TEST_SRL( 4,  0xffffffff80000000, 7  )
    TEST_SRL( 5,  0xffffffff80000000, 14 )
    TEST_SRL( 6,  0xffffffff80000001, 31 )

    TEST_SRL( 7,  0xffffffffffffffff, 0  )
    TEST_SRL( 8,  0xffffffffffffffff, 1  )
    TEST_SRL( 9,  0xffffffffffffffff, 7  )
    TEST_SRL( 10, 0xffffffffffffffff, 14 )
    TEST_SRL( 11, 0xffffffffffffffff, 31 )

    TEST_SRL( 12, 0x0000000021212121, 0  )
    TEST_SRL( 13, 0x0000000021212121, 1  )
    TEST_SRL( 14, 0x0000000021212121, 7  )
    TEST_SRL( 15, 0x0000000021212121, 14 )
    TEST_SRL( 16, 0x0000000021212121, 31 )

    #-------------------------------------------------------------
    # Source/Destination tests
    #-------------------------------------------------------------

    TEST_IMM_SRC1_EQ_DEST( 17, 'srli', 0x01000000, 0x80000000, 7 )

    #-------------------------------------------------------------
    # Bypassing tests
    #-------------------------------------------------------------

    TEST_IMM_DEST_BYPASS( 18, 0, 'srli', 0x01000000, 0x80000000, 7  )
    TEST_IMM_DEST_BYPASS( 19, 1, 'srli', 0x00020000, 0x80000000, 14 )
    TEST_IMM_DEST_BYPASS( 20, 2, 'srli', 0x00000001, 0x80000001, 31 )

    TEST_IMM_SRC1_BYPASS( 21, 0, 'srli', 0x01000000, 0x80000000, 7  )
    TEST_IMM_SRC1_BYPASS( 22, 1, 'srli', 0x00020000, 0x80000000, 14 )
    TEST_IMM_SRC1_BYPASS( 23, 2, 'srli', 0x00000001, 0x80000001, 31 )

    TEST_IMM_ZEROSRC1( 24, 'srli', 0, 4 )
    TEST_IMM_ZERODEST( 25, 'srli', 33, 10 )

    TEST_PASSFAIL()

    RVTEST_CODE_END()

    RVTEST_DATA_BEGIN()
    TEST_DATA()
    RVTEST_DATA_END()
  end

end