## Embeddings

- You need `few-shot prompting`
- Convert all your knowledge base into embeddings.
- When the user queries OpenAI for questions related to your knowledge base, convert the the user's query into embeddings, and query your knowledge base embeddings for your closest match, and prepend them to the prompt.

## Summarization of previous chunks

- Split document into chunks
- Loop `
  - Ask GPT to convert chunk into bullet points, given all previously chunks bullet points
    - We give all previous bullet points because there might be references between chunk `1`and chunk `4` for exambple
  - Continue
