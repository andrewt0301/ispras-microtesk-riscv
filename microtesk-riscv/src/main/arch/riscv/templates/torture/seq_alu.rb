#
# Copyright 2018 ISP RAS (http://www.ispras.ru)
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

module SeqAlu

  def seq_alu(use_mul, use_div)

    pick_random {
      seq_immfn('LUI', rand_bigimm)

      seq_src1_immfn('ADDI', rand_imm)
      seq_src1_immfn('SLLI', rand_shamt)
      seq_src1_immfn('SLTI', rand_imm)
      seq_src1_immfn('SLTIU', rand_imm)
      seq_src1_immfn('XORI', rand_imm)
      seq_src1_immfn('SRLI', rand_shamt)
      seq_src1_immfn('SRAI', rand_shamt)
      seq_src1_immfn('ORI', rand_imm)
      seq_src1_immfn('ANDI', rand_imm)
      seq_src1_immfn('ADDIW', rand_imm)
      seq_src1_immfn('SLLIW', rand_shamtw)
      seq_src1_immfn('SRLIW', rand_shamtw)
      seq_src1_immfn('SRAIW', rand_shamtw)

      ops = []

      ops += ['ADD', 'SUB', 'SLL', 'SLT', 'SLTU', 'XOR', 'SRL', 'SRA', 'OR', 'AND']
      ops += ['ADDW', 'SUBW', 'SLLW', 'SRLW', 'SRAW']

      if use_mul then
        ops += ['MUL', 'MULH', 'MULHSU', 'MULHU', 'MULW']
      end

      if use_div
        ops += ['DIV', 'DIVU', 'REM', 'REMU', 'DIVW', 'DIVUW', 'REMW', 'REMUW']
      end

      ops.each { |op|
        seq_src1(op)
        seq_src1_zero(op)
        seq_src2(op)
        seq_src2_zero(op)
      }
    }
  end

  private

  def instr(op, *args)
    self.send :"#{op}", args
  end

  def seq_immfn(op, imm)
    dest = x(_) # reg_write_visible(xregs)

    instr op, dest, imm
  end

  def seq_src1(op)
    src1 = x(_) # reg_read_any(xregs)
    dest = x(_) # reg_write(xregs, src1)

    instr op, dest, src1, src1
  end

  def seq_src1_immfn(op, imm)
    src1 = x(_) # reg_read_any(xregs)
    dest = x(_) # reg_write(xregs, src1)

    instr op, dest, src1, imm
  end

  def seq_src1_zero(op)
    tmp = x(_) # reg_write_visible(xregs)
    dest = x(_) # reg_write(xregs, src1)

    addi tmp, zero, rand_imm
    instr op, dest, tmp, tmp
  end

  def seq_src2(op)
    src1 = x(_) # reg_read_any(xregs)
    src2 = x(_) # reg_read_any(xregs)
    dest = x(_) # reg_write(xregs, src1, src2)

    instr op, dest, src1, src2
  end

  def seq_src2_zero(op)
    dest = x(_) # reg_write(xregs, src1)
    tmp1 = x(_) # reg_write_visible(xregs)
    tmp2 = x(_) # reg_write_visible(xregs)

    addi tmp1, zero, rand_imm
    addi tmp2, zero, rand_imm
    instr op, dest, tmp1, tmp2
  end

end