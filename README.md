## Алгоритм получения нового токена

```mermaid
graph TD
    A[Начало] --> B{Достигнут конец<br>исходного кода?}
    B -- Да --> C[Вернуть токен<br>конца файла]
    C --> D[Конец]
    B -- Нет --> E{Текущая позиция<br>в начале строки?}
    E -- Да --> F[Обработать отступы]
    F --> G{Неожиданный отступ?}
    G -- Да --> H[Вернуть токен<br>ошибки отступа]
    H --> D
    G -- Нет --> I{Достигнут конец<br>исходного кода?}
    I -- Да --> C
    I -- Нет --> J{Текущий символ<br>является переводом строки?}
    J -- Да --> K[Вернуть токен<br>новой строки]
    K --> L[Перейти на<br>следующую строку]
    L --> B
    J -- Нет --> M[Пропустить пробелы<br>и комментарии]
    M --> N{Текущий символ<br>является цифрой?}
    N -- Да --> O[Распознать числовой<br>литерал]
    O --> P[Вернуть токен<br>числового литерала]
    P --> B
    N -- Нет --> Q{Текущий символ<br>является буквой или '_'?}
    Q -- Да --> R[Распознать ключевое слово<br>или идентификатор]
    R --> S{Найдено<br>ключевое слово?}
    S -- Да --> T[Вернуть токен<br>ключевого слова]
    T --> B
    S -- Нет --> U[Вернуть токен<br>идентификатора]
    U --> B
    Q -- Нет --> V{Текущий символ<br>является оператором?}
    V -- Да --> W[Распознать оператор]
    W --> X[Вернуть токен<br>оператора]
    X --> B
    V -- Нет --> Y{Текущий символ<br>является специальным символом?}
    Y -- Да --> Z[Распознать специальный<br>символ]
    Z --> AA[Вернуть токен<br>специального символа]
    AA --> B
    Y -- Нет --> AB[Вернуть токен<br>ошибки]
    AB --> D
```

## Алгоритм разбора выражений

```mermaid
graph TD
    A[Начало] --> B{Конец входных данных?}
    B -- Да --> C[Вернуть NULL]
    B -- Нет --> D{Тип токена?}

    D -- TOK_IF --> E[Вызвать parse_if_statement]
    E --> F{Ошибка?}
    F -- Нет --> G[Вернуть ASTNode]
    F -- Да --> H[Сообщить об ошибке]
    H --> I[Вернуть NULL]

    D -- TOK_FOR --> J[Вызвать parse_for_loop]
    J --> K[Вызвать parse_expression для итерируемого объекта]
    K --> L{Ошибка?}
    L -- Нет --> M[Создать узел AST_FOR_LOOP]
    M --> N[Вызвать parse_statement для тела цикла]
    N --> O{Ошибка?}
    O -- Нет --> P[Добавить statement в тело цикла]
    P --> Q{Еще statement?}
    Q -- Да --> N
    Q -- Нет --> G
    O -- Да --> H
    L -- Да --> H

    D -- TOK_WHILE --> R[Вызвать parse_while]
    R --> S[Вызвать parse_expression для условия]
    S --> T{Ошибка?}
    T -- Нет --> U[Создать узел AST_WHILE_LOOP]
    U --> V[Вызвать parse_statement для тела цикла]
    V --> W{Ошибка?}
    W -- Нет --> X[Добавить statement в тело цикла]
    X --> Y{Еще statement?}
    Y -- Да --> V
    Y -- Нет --> G
    W -- Да --> H
    T -- Да --> H

    D -- TOK_DEF --> Z[Вызвать parse_function_definition]
    Z --> AA[Вызвать parse_ident для имени функции]
    AA --> AB[Вызвать parse_argument_list для аргументов]
    AB --> AC{Ошибка?}
    AC -- Нет --> AD[Создать узел AST_FUNCTION_DEF]
    AD --> AE[Вызвать parse_statement для тела функции]
    AE --> AF{Ошибка?}
    AF -- Нет --> AG[Добавить statement в тело функции]
    AG --> AH{Еще statement?}
    AH -- Да --> AE
    AH -- Нет --> G
    AF -- Да --> H
    AC -- Да --> H

    D -- TOK_DEL --> AI[Вызвать parse_delete]
    AI --> AJ[Вызвать parse_expression для цели удаления]
    AJ --> AK{Ошибка?}
    AK -- Нет --> AL[Создать узел AST_DEL]
    AL --> G
    AK -- Да --> H

    D -- TOK_RETURN --> AM[Вызвать parse_return]
    AM --> AN[Вызвать parse_expression для возвращаемого значения]
    AN --> AO{Ошибка?}
    AO -- Нет --> AP[Создать узел AST_RETURN]
    AP --> G
    AO -- Да --> H

    D -- TOK_BREAK --> AQ[Вызвать parse_break]
    AQ --> AR[Создать узел AST_BREAK]
    AR --> G

    D -- TOK_ASSIGN, TOK_AUG... --> AS[Вызвать parse_assign]
    AS --> AT[Вызвать parse_expression для цели присваивания]
    AT --> AU{Ошибка?}
    AU -- Нет --> AV[Создать узел AST_ASSIGN]
    AV --> AW[Вызвать parse_expression для значения присваивания]
    AW --> AX{Ошибка?}
    AX -- Нет --> AY[Добавить значение в узел AST_ASSIGN]
    AY --> AZ{Еще присваивание?}
    AZ -- Да --> AW
    AZ -- Нет --> G
    AX -- Да --> H
    AU -- Да --> H

    D -- Другой тип --> BA[Вызвать parse_expression]
    BA --> BB{Ошибка?}
    BB -- Нет --> G
    BB -- Да --> H

```

## Алгоритм компиляции дерева в промежуточное представление

```mermaid
graph TD
    A[Начало] --> B{Тип корневого узла?}
    B -- AST_SUBPROGRAM --> C[Создать CompilationUnit]
    C --> D[Создать список инструкций]
    D --> E{Есть еще узлы в подпрограмме?}
    E -- Да --> F[Получить следующий узел]
    F --> G[Вызвать compile_node]
    G --> E
    E -- Нет --> H[Вернуть CompilationUnit]
    B -- Другой --> I[Создать CompilationUnit]
    I --> J[Создать список инструкций]
    J --> K[Вызвать compile_node для корневого узла]
    K --> H

    G --> L{Тип узла?}
    L -- AST_IDENT --> M[Вызвать compile_ident]
    L -- AST_INT --> N[Вызвать compile_int]
    L -- AST_FLOAT --> O[Вызвать compile_float]
    L -- AST_BINARY_OP --> P[Вызвать compile_binop]
    L -- AST_TERNARY --> Q[Вызвать compile_ternary_if]
    L -- AST_ASSIGN --> R[Вызвать compile_assign]
    L -- AST_FUNCTION_DEF --> S[Вызвать compile_function_def]
    L -- AST_LAMBDA --> T[Вызвать compile_lambda_def]
    L -- AST_FUNCTION_CALL --> U[Вызвать compile_function_call]
    L -- AST_RETURN --> V[Вызвать compile_return]
    L -- Другой --> W[Вывести сообщение о нераспознанном узле]

    M --> X[Создать инструкцию COMP_LOAD]
    N --> Y[Создать инструкцию COMP_LOAD_INT]
    O --> Z[Создать инструкцию COMP_LOAD_FLOAT]
    P --> AA[Скомпилировать левый узел]
    P --> AB[Скомпилировать правый узел]
    P --> AC[Создать инструкцию COMP_BINOP]
    Q --> AD[Скомпилировать условие]
    Q --> AE[Создать инструкцию COMP_JUMP_REL_IF_FALSE]
    Q --> AF[Скомпилировать тело if]
    Q --> AG[Создать инструкцию COMP_JUMP_REL]
    Q --> AH[Скомпилировать тело else]
    R --> AI{Тип присваивания?}
    AI -- Обычное --> AJ[Скомпилировать значение]
    AJ --> AK{Тип цели присваивания?}
    AK -- AST_IDENT --> AL[Создать инструкцию COMP_STORE]
    AK -- Другой --> AM[Скомпилировать цель присваивания]
    AM --> AN[Создать инструкцию COMP_STORE_INDEX]
    AI -- Составное --> AO[Скомпилировать цель присваивания]
    AO --> AP[Скомпилировать значение]
    AP --> AQ[Создать инструкцию COMP_BINOP]
    AQ --> AK
    S --> AR[Скомпилировать аргументы]
    AR --> AS[Создать CompilationUnit для тела функции]
    AS --> AT[Добавить инструкции COMP_LOAD_NONE и COMP_RETURN]
    AT --> AU[Создать инструкцию COMP_FUNCTION_ANON]
    AU -->AV[Создать инструкцию COMP_STORE]
    T --> AW[Скомпилировать аргументы]
    AW --> AX[Создать CompilationUnit для тела лямбды]
    AX --> AY[Добавить инструкцию COMP_RETURN]
    AY --> AZ[Создать инструкцию COMP_FUNCTION_ANON]
    U --> BA{Есть еще аргументы?}
    BA -- Да --> BB[Скомпилировать следующий аргумент]
    BB --> BA
    BA -- Нет --> BC[Скомпилировать вызываемый объект]
    BC --> BD[Создать инструкцию COMP_CALL]
    V --> BE[Скомпилировать возвращаемое значение]
    BE --> BF[Создать инструкцию COMP_RETURN]

    X --> BG[Добавить инструкцию в список]
    Y --> BG
    Z --> BG
    AC --> BG
    AE --> BG
    AG --> BG
    AL --> BG
    AN --> BG
    AU --> BG
    AV --> BG
    AZ --> BG
    BD --> BG
    BF --> BG
```

## Алгоритм интерпретации промежуточного представления

```mermaid
graph TD
    A[Начало] --> B{Есть еще инструкции?}
    B -- Да --> C[Получить текущую инструкцию]
    C --> D[Вызвать interpret_instruction]
    D --> E{Ошибка?}
    E -- Да --> F[Вернуть ошибку]
    E -- Нет --> G[Перейти к следующей инструкции]
    G --> B
    B -- Нет --> H[Конец]

    D --> I{Тип инструкции?}
    I -- COMP_LOAD --> J[Вызвать interpret_load]
    I -- COMP_LOAD_NONE --> K[Вызвать interpret_load_none]
    I -- COMP_RETURN --> L[Вызвать interpret_return]
    I -- COMP_LOAD_INT --> M[Вызвать interpret_load_int]
    I -- COMP_LOAD_FLOAT --> N[Вызвать interpret_load_float]
    I -- COMP_BINOP --> O[Вызвать interpret_binop]
    I -- COMP_JUMP_REL --> P[Вызвать interpret_jump_relative]
    I -- COMP_JUMP_REL_IF_FALSE --> Q[Вызвать interpret_jump_relative_if_false]
    I -- COMP_STORE --> R[Вызвать interpret_store]
    I -- COMP_FUNCTION_ANON --> S[Вызвать interpret_anon_fun]
    I -- COMP_CALL --> T[Вызвать interpret_call]
    I -- Другой тип --> U[Установить ошибку UnrecognizedOperationError]

    J --> V[Загрузить значение из окружения]
    V --> W[Поместить значение на стек]

    K --> X[Поместить NULL на стек]

    L --> Y[Установить текущий узел в NULL]

    M --> Z[Создать объект PyObject типа PY_INT]
    Z --> AA[Установить значение объекта]
    AA --> AB[Поместить объект на стек]

    N --> AC[Создать объект PyObject типа PY_FLOAT]
    AC --> AD[Установить значение объекта]
    AD --> AE[Поместить объект на стек]

    O --> AF[Получить правый операнд со стека]
    AF --> AG[Получить левый операнд со стека]
    AG --> AH{Тип бинарной операции?}
    AH -- TOK_PLUS --> AI[Вызвать функцию add_binop]
    AH -- TOK_MINUS --> AJ[Вызвать функцию sub_binop]
    AH -- TOK_MUL --> AK[Вызвать функцию mul_binop]
    AH -- TOK_DIV --> AL[Вызвать функцию div_binop]
    AH -- TOK_LT --> AM[Вызвать функцию lt_binop]
    AH -- TOK_LEQ --> AN[Вызвать функцию leq_binop]
    AH -- TOK_GT --> AO[Вызвать функцию gt_binop]
    AH -- TOK_GEQ --> AP[Вызвать функцию geq_binop]
    AH -- TOK_EQ --> AQ[Вызвать функцию eq_binop]
    AH -- TOK_NEQ --> AR[Вызвать функцию neq_binop]
    AH -- Другой тип --> AS[Установить ошибку UnrecognizedOperationError]

    P --> AT[Вызвать perform_jump]

    Q --> AU[Получить значение со стека]
    AU --> AV{Значение равно NULL?}
    AV -- Да --> AW[Вызвать perform_jump]
    AV -- Нет --> AX{Тип значения?}
    AX -- OBJ_T_REFERENCE --> AY{Ссылка на NULL?}
    AY -- Да --> AW
    AY -- Нет --> AZ[Перейти к следующей инструкции]
    AX -- PY_INT --> BA{Значение равно 0?}
    BA -- Да --> AW
    BA -- Нет --> AZ
    AX -- PY_FLOAT --> BB{Значение равно 0?}
    BB -- Да --> AW
    BB -- Нет --> AZ
    AX -- PY_BOOL --> BC{Значение равно false?}
    BC -- Да --> AW
    BC -- Нет --> AZ
    AX -- Другой тип --> BD[Установить ошибку TypeError]

    R --> BE[Получить значение со стека]
    BE --> BF[Сохранить значение в окружении]

    S --> BG[Создать объект PyObject типа OBJ_T_REFERENCE]
    BG --> BH[Установить тип ссылки в PY_FUNC]
    BH --> BI[Создать объект Func]
    BI --> BJ[Установить значение Func из инструкции]
    BJ --> BK[Поместить объект PyObject на стек]

    T --> BL[Получить объект функции со стека]
    BL --> BM{Количество аргументов совпадает с сигнатурой функции?}
    BM -- Нет --> BN[Установить ошибку NotEnoughArgsError]
    BM -- Да --> BO[Создать список аргументов]
    BO --> BP{Есть еще аргументы на стеке?}
    BP -- Да --> BQ[Получить аргумент со стека]
    BQ --> BR[Добавить аргумент в список]
    BR --> BP
    BP -- Нет --> BS[Развернуть список аргументов]
    BS --> BT[Создать новое окружение]
    BT --> BU{Есть еще аргументы в списке?}
    BU -- Да --> BV[Получить следующий аргумент]
    BV --> BW[Получить следующий параметр из сигнатуры функции]
    BW --> BX[Сохранить аргумент в окружении]
    BX --> BU
    BU -- Нет --> BY[Создать новый интерпретатор]
    BY --> BZ[Установить окружение интерпретатора]
    BZ --> CA[Установить стек интерпретатора]
    CA --> CB[Установить функции интерпретатора]
    CB --> CC[Установить программу интерпретатора]
    CC --> CD[Вызвать interpret для нового интерпретатора]
    CD --> CE[Поместить результат на стек текущего интерпретатора]
    CE --> CF[Освободить ресурсы нового интерпретатора]
```
