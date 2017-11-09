#
# Copyright 2017 ISP RAS (http://www.ispras.ru)
#
# Licensed under the Apache License, Version 2.0 (the "License");
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

require_relative 'riscv_base'

#
# Description:
#
# This small tests for RV64I instructions.
#

class InstructionRV64I < RISCVBaseTemplate

  def run
    trace "Run RV64I instruction:"

    lwu t0, t1, 0x0
    trace "t0 = %x", gpr_observer(5)
    ld t2, t3, 0x0
    #sd t4, t5, 0x0

    addiw a0, a1, 0x11
    slliw t0, a1, 0x11
    srliw t1, a1, 0x11
    sraiw t2, a1, 0x11

    addw t1, t2, t3
    subw t2, t3, t4

    sllw t0, t1, t2
    srlw t0, t1, t2
    sraw t0, t1, t2

    nop
  end

end
