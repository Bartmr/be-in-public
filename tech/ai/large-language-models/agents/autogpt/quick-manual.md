## https://docs.agpt.co/usage/

## `./run.sh --help`

## 💀 Continuous Mode ⚠️

Run the AI without user authorization, 100% automated. Continuous mode is NOT recommended. It is potentially dangerous and may cause your AI to run forever or carry out actions you would not usually authorize. Use at your own risk.

./run.sh --continuous

To exit the program, press Ctrl+C

## ♻️ Self-Feedback Mode ⚠️

Running Self-Feedback will INCREASE token use and thus cost more. This feature enables the agent to provide self-feedback by verifying its own actions and checking if they align with its current goals. If not, it will provide better feedback for the next loop. To enable this feature for the current loop, input `S` into the input field.

## Logs

Activity and error logs are located in the ./output/logs

To print out debug logs:

./run.sh --debug

## Run Auto-GPT with a different AI Settings file

`./run.sh --ai-settings <filename>`

## Run Auto-GPT with a different Prompt Settings file

`./run.sh --prompt-settings <filename>`

## GPT-4 ONLY Mode

If you have access to GPT-4, this mode allows you to use Auto-GPT solely with GPT-4. This may give your bot increased intelligence.

`./run.sh --gpt4only`
