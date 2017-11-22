#
# MicroTESK for RISC-V
#
# Copyright (c) 2017 Institute for System Programming of the Russian Academy of Sciences
# All Rights Reserved
#
# Institute for System Programming of the Russian Academy of Sciences (ISP RAS)
# 25 Alexander Solzhenitsyn st., Moscow, 109004, Russia
# http://www.ispras.ru
#

require_relative 'riscv_base'

#
# Description:
#
# This test template demonstrates how to use instruction groups in test templates.
#
class GroupsTemplate < RISCVBaseTemplate

  def run
    # Using groups defined in the specification

    10.times {
      sequence {
        # Placeholder to return from an exception
        epilogue { nop }

        # Selects from {add, sub, and, ...}
        rv32i_arithmetic_rrr t0, t1, t2

        # Selects from {lui, auipc}
        rv32i_load_upper_imm t3, rand(0, 0xFFFFF)

        # Selects from {addi, subi, andi}
        rv32i_arithmetic_rri s1, s2, rand(0, 0xFFF)
      }.run
    }

    # Using user-defined groups

    # Probability distribution for instruction names (NOTE: group names are not allowed here)
    xxx_dist = dist(range(:value => 'add',                       :bias => 40),
                    range(:value => 'sub',                       :bias => 30),
                    range(:value => ['and', 'or', 'xor'], :bias => 30))

    define_op_group('xxx', xxx_dist)
    10.times {
      atomic {
        # Placeholder to return from an exception
        epilogue { nop }

        # Selects an instruction according to the 'xxx_dist' distribution
        xxx t0, t1, t2
        xxx t3, t4, t5
        xxx s0, s1, s2
      }.run
    }
  end
end
