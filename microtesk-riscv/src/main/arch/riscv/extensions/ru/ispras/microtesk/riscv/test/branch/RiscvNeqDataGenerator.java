/*
 * Copyright 2018 ISP RAS (http://www.ispras.ru)
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License
 * is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied. See the License for the specific language governing permissions and limitations under
 * the License.
 */

package ru.ispras.microtesk.riscv.test.branch;

import ru.ispras.fortress.util.Pair;
import ru.ispras.testbase.TestBaseQuery;
import ru.ispras.testbase.TestData;
import ru.ispras.testbase.knowledge.iterator.Iterator;

/**
 * {@link RiscvNeqDataGenerator} is a test data generator for BNE-family instructions.
 *
 * @author <a href="mailto:andrewt@ispras.ru">Andrei Tatarnikov</a>
 */
public final class RiscvNeqDataGenerator extends RiscvBranchDataGenerator {
  @Override
  public Iterator<TestData> generateThen(final TestBaseQuery query) {
    final Pair<Long, Long> values = generateDistinct(
        // rs1 is always unknown because it is chosen to be used as a stream register.
        null, // getValue("rs1", query),
        getValue("rs2", query));
    return generate(query, values.first, values.second);
  }

  @Override
  public Iterator<TestData> generateElse(final TestBaseQuery query) {
    final long value = generateEqual(
        // rs1 is always unknown because it is chosen to be used as a stream register.
        null, // getValue("rs1", query),
        getValue("rs2", query));
    return generate(query, value, value);
  }
}

