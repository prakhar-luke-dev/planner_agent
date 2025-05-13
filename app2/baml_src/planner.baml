class Add {
  num1_to_add int @description("1st number to add")
  num2_to_add int @description("2nd number to add")
}

class Subtract {
  num1_to_subtract int @description("1st number to Subtract")
  num2_to_subtract int @description("2nd number to Subtract")
}

class Divide {
  num1_to_divide int @description("1st number to Divide, the numerator")
  num2_to_divide int @description("2nd number to Divide, the denominator")
}

class Multiply {
  num1_to_multiply int @description("1st number to Multiply")
  num2_to_multiply int @description("2nd number to Multiply")
}

class Planner {
    steps string @description(#"
        Breakdown the user instruction to provided a detailed steps for the course of action.
        Provide the steps as new line with step number as well example : step 1, step 2 etc.
    "#)
    ans_part1 string @description(#"
        List all the steps along with Tool as a new line. 
        example : step 1 use the <tool name> and uses the arguments <args only>.\n and so on
    "#)
}

class Executor {
    plan string @description(#"
        Steps to be performed (those were broken down by planner)
    "#)
    // tool_to_use string @description(#"
    //     List all the Tool that are to be used as per the step
    // "#)
    ans_part2 int @description(#"
        Final answer after execution of tools
    "#)
}

function UseTool(user_message: string) -> (Planner | Add | Subtract | Divide | Multiply | Executor)[]{
  client CustomGPT4oMini
  prompt #"
    Then analyze which tool to use.
    Then execute the tool as per the steps provided by Planner.
    ---
    {{ user_message }}
    ---

    {# special macro to print the output schema. #}
    {{ ctx.output_format }}

    JSON:
  "#
}

test TestOne {
  functions [UseTool]
  args {
    user_message #"
      Get the sum of ten and twenty, then multiply it by hundred
    "#
  }
}
