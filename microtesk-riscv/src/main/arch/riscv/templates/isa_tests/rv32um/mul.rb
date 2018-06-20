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
# https://github.com/riscv/riscv-tests/blob/master/isa/rv32um/mul.S
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

class MulTemplate < RISCVBaseTemplate

  def pre_rvtest
    RVTEST_RV32U()
    RVTEST_CODE_BEGIN()
  end

  def run
    # Prevents test execution for irrelevant ISA versions
    if __riscv_xlen != 32
      j :pass
      return
    end

    #-------------------------------------------------------------
    # Arithmetic tests
    #-------------------------------------------------------------

    TEST_RR_OP(32,  'mul', 0x00001200, 0x00007e00, 0xb6db6db7 )
    TEST_RR_OP(33,  'mul', 0x00001240, 0x00007fc0, 0xb6db6db7 )

    TEST_RR_OP( 2,  'mul', 0x00000000, 0x00000000, 0x00000000 )
    TEST_RR_OP( 3,  'mul', 0x00000001, 0x00000001, 0x00000001 )
    TEST_RR_OP( 4,  'mul', 0x00000015, 0x00000003, 0x00000007 )

    TEST_RR_OP( 5,  'mul', 0x00000000, 0x00000000, 0xffff8000 )
    TEST_RR_OP( 6,  'mul', 0x00000000, 0x80000000, 0x00000000 )
    TEST_RR_OP( 7,  'mul', 0x00000000, 0x80000000, 0xffff8000 )

    TEST_RR_OP(30,  'mul', 0x0000ff7f, 0xaaaaaaab, 0x0002fe7d )
    TEST_RR_OP(31,  'mul', 0x0000ff7f, 0x0002fe7d, 0xaaaaaaab )

    TEST_RR_OP(34,  'mul', 0x00000000, 0xff000000, 0xff000000 )

    TEST_RR_OP(35,  'mul', 0x00000001, 0xffffffff, 0xffffffff )
    TEST_RR_OP(36,  'mul', 0xffffffff, 0xffffffff, 0x00000001 )
    TEST_RR_OP(37,  'mul', 0xffffffff, 0x00000001, 0xffffffff )

    #-------------------------------------------------------------
    # Source/Destination tests
    #-------------------------------------------------------------

    TEST_RR_SRC1_EQ_DEST( 8, 'mul', 143, 13, 11 )
    TEST_RR_SRC2_EQ_DEST( 9, 'mul', 154, 14, 11 )
    TEST_RR_SRC12_EQ_DEST( 10, 'mul', 169, 13 )

    #-------------------------------------------------------------
    # Bypassing tests
    #-------------------------------------------------------------

    TEST_RR_DEST_BYPASS( 11, 0, 'mul', 143, 13, 11 )
    TEST_RR_DEST_BYPASS( 12, 1, 'mul', 154, 14, 11 )
    TEST_RR_DEST_BYPASS( 13, 2, 'mul', 165, 15, 11 )

    TEST_RR_SRC12_BYPASS( 14, 0, 0, 'mul', 143, 13, 11 )
    TEST_RR_SRC12_BYPASS( 15, 0, 1, 'mul', 154, 14, 11 )
    TEST_RR_SRC12_BYPASS( 16, 0, 2, 'mul', 165, 15, 11 )
    TEST_RR_SRC12_BYPASS( 17, 1, 0, 'mul', 143, 13, 11 )
    TEST_RR_SRC12_BYPASS( 18, 1, 1, 'mul', 154, 14, 11 )
    TEST_RR_SRC12_BYPASS( 19, 2, 0, 'mul', 165, 15, 11 )

    TEST_RR_SRC21_BYPASS( 20, 0, 0, 'mul', 143, 13, 11 )
    TEST_RR_SRC21_BYPASS( 21, 0, 1, 'mul', 154, 14, 11 )
    TEST_RR_SRC21_BYPASS( 22, 0, 2, 'mul', 165, 15, 11 )
    TEST_RR_SRC21_BYPASS( 23, 1, 0, 'mul', 143, 13, 11 )
    TEST_RR_SRC21_BYPASS( 24, 1, 1, 'mul', 154, 14, 11 )
    TEST_RR_SRC21_BYPASS( 25, 2, 0, 'mul', 165, 15, 11 )

    TEST_RR_ZEROSRC1( 26, 'mul', 0, 31 )
    TEST_RR_ZEROSRC2( 27, 'mul', 0, 32 )
    TEST_RR_ZEROSRC12( 28, 'mul', 0 )
    TEST_RR_ZERODEST( 29, 'mul', 33, 34 )
  end

  def post
    TEST_PASSFAIL()
    RVTEST_CODE_END()
  end

end

