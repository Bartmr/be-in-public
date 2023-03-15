- Remove sentences that have too many tokens for a language model
  ```python
  from transformers import GPT2TokenizerFast
  tokenizer = GPT2TokenizerFast.from_pretrained("gpt2")

  # remove reviews that are too long
  df['n_tokens'] = df.combined.apply(lambda x: len(tokenizer.encode(x)))
  df = df[df.n_tokens<2000].tail(1_000)
  len(df)
  ```

- https://bakztfuture.substack.com/p/2023-prediction-a-new-kind-of-language