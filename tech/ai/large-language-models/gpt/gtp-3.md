## Resources

- https://github.com/stars/acheong08/lists/awesome-chatgpt
- https://github.com/Kamigami55/awesome-chatgpt
- https://github.com/f/awesome-chatgpt-prompts
- InstructGPT
  - InstructGPT paper

## How to

- https://openai.com/blog/customized-gpt-3/#example
- https://beta.openai.com/docs/guides/fine-tuning
- https://openai.com/blog/instruction-following/
- https://beta.openai.com/examples
- https://beta.openai.com/docs/models/gpt-3
- https://beta.openai.com/docs/guides/embeddings/use-cases
- https://www.reddit.com/r/GPT3/
- https://www.buildgpt3.com/
- https://prompts.ai/
- "Gpt3 prompt engineering" Google Search
- "Gpt3 prompt design" Google Search
- https://www.reddit.com/user/techn0_cratic/
- https://txt.cohere.ai/
- https://txt.cohere.ai/text-analysis-nlp-google-sheets/
- https://www.width.ai/post/business-applications-for-gpt-3
- https://towardsdatascience.com/gpt-3-parameters-and-prompt-design-1a595dc5b405
- https://medium.com/analytics-vidhya/ai-stock-researcher-powered-by-gpt-3-3b451a2c6fe1
- https://nogood.io/2021/06/25/gpt-3-tools/
- https://www.twilio.com/blog/ultimate-guide-openai-gpt-3-language-model
- https://simonwillison.net/2022/Jun/5/play-with-gpt3/
- https://venturebeat.com/business/what-it-takes-to-create-a-gpt-3-product/
- https://blog.andrewcantino.com/blog/2021/04/21/prompt-engineering-tips-and-tricks/
- https://www.dolthub.com/blog/2020-08-12-ai-dungeon-scraper/
- https://wandb.ai/ivangoncharov/GPT-3/reports/Summary-Sentiment-Question-Answering-More-5-Creative-Tips-for-GPT-3-Prompt-Engineering--VmlldzoxODY0Nzky
- https://towardsdatascience.com/3-tips-to-reduce-openai-gpt-3s-costs-by-smart-prompting-53c457229cfc
- https://arxiv.org/abs/2103.08493
- https://analyticsindiamag.com/gpt-3-prompts-technical-progress-or-just-ai-alchemy/
- https://beta.openai.com/docs/guides/fine-tuning/preparing-your-dataset
- https://www.datacamp.com/blog/a-beginners-guide-to-gpt-3
- https://blog.seekwell.io/gpt3
- **Tokenizer** <https://beta.openai.com/tokenizer>
- **WebGPT** <https://openai.com/blog/webgpt/>
- **GPT-3 related Twitter** <https://twitter.com/i/lists/1568608092056866818?t=w0uL0gSKAbMkoDpFos7XXw&s=09>
- **Embeddings** <https://beta.openai.com/docs/guides/embeddings>

## GTP-3 features

- Text prompts and responses
- Semantic file search and comprehension
- Fine-tuning
- Text classification
  - Text classification is the process of categorizing the text into organized groups. By using NLP, text classification can automatically analyze text and then assign a set of predefined tags or categories based on its context. Text classification involves analyzing the text provided as input and assigning it a label, score, or another attribute that characterizes the text. Some common examples of text classification are sentiment analysis, entity recognition, and anomaly or outlier detection which we discuss in the later part of this section. You can use a number of approaches to get GTP-3 to classify text, again ranging from zero-shot classification (where you don’t give any examplesto the model) to single-shot and few-shot classification (where you show some examples to the model).
- Zero-shot classification
  - perform predictive functions on data it has never seen before
- Single Shot/ Few Shots Classification
  - fine tuning an AI model on a single or few training examples also known as single shot or few shots text classification
- Batch Classification
- Named Entity Recognition
  - Named entity recognition is an information extraction task that seeks to locate and classify named entities mentioned in unstructured text into pre- defined categories such as person names, organizations, locations, expressions of time, quantities, monetary values, percentages, etc.
  - Example
    -
      ```
      Extract the name and mailing address from this email:
      Shubham,
      It was great to talk to you the other day!
      I'm SO looking forward to start working on our book.
      Here's my address 1307 Roosevelt Street, San Francisco CA
      94107
      Best,
      Sandra Kublik

      Name and mailing address:
      
      Sandra Kublik
      1307 Roosevelt Street, San Francisco CA 94107
      ```
- Text Summarization
  - Example: To achieve the desired result, we pasted the full email and then simply added “one-sentence summary:'' at the end. **We also included a “.” stop sequence to tell the model that it should stop its summary generation after a single sentence**. Our prompt:
    ```
    Hey Greg,
    We are Sandra and Shubham. We are the co-authors of a GPT-3 based book that aims to be a go-to manual for API users. It will provide the readers with the knowledge to get started with GPT-3 as well as the context of the growing ecosystem surrounding it. The book will be released by O’Reilly publishing house by early 2022. We’d like to connect and explore the possibility of collaboration with OpenAI to evangelize access to API for people from all backgrounds and enable them to build exciting new solutions using GPT-3. We would appreciate your input to ensure we accurately represent OpenAI's stance on GPT-3 and inform our readers on the upcoming advancements/features of the API. It will be great if we can catch up sometime this week to discuss it further?
    Best,
    S&S
    one-sentence summary:
    We’re writing a book on GPT-3 and would like to connect with OpenAI to get a better understanding of the API and the future developments
    ```

---

## Here is our five-step formula for creating efficient and effective training prompts:
1. Define the problem you are trying to solve and what kind of NLP task
it is, such as classification, Q & A, text generation, or creative writing.
2. Ask yourself if there is a way to get a zero-shot solution.
3. If you think that you need external examples to prime the model for
your use case, go back to step 2 and think really hard.
4. Now think of how you might encounter the problem in a textual
fashion given the “text-in, text-out” interface of GPT-3. Think about
all the possible scenarios to represent your problem in textual form.
For example, you want to build an ad copy assistant that can generate
creative copies by looking at product name and description. So to
frame it in the “text-in, text-out” format you can define input and
output as the following:Input: Product Name and Description (Betty’s Bikes for Price-sensitive
shoppers)
Output: Creative ad copy (Low prices and huge selection. Free and fast
delivery. Order online today!)
5. If you do end up using external examples, use as few as possible and
try to incorporate diversity, capturing all the representations to avoid
essentially overfitting the model or skewing the predictions.

These steps will act as a standard framework whenever you create a training
prompt from scratch. Before building an end-to-end solution for your data
problems, however, you need to understand a few more things about how
the API works. Let’s dig deeper by looking at its components.

---

## Temperature and Top P
The temperature dial controls the randomness of the response, represented
as a range from 0 to 1. A lower value of temperature means the API will
predict the first thing that the model sees; a higher value means the model
evaluates possible responses that could fit into the context before predicting
the result.
Top P controls how many random results the model should consider for
completion, as suggested by the temperature dial; it determines the scope of
randomness. Top P’s range is from 0 to 1. A value close to zero means the
random responses will be limited to a certain fraction: for example, if the
value is 0.1, then only 10% of the random responses will be considered for
completion. This makes the engine deterministic, which means that it will
always generate the same output for a given input text. If the value is set to
1, the API will consider all responses for completion, taking risks and
coming up with creative responses. A lower value limits randomness; a
higher value expands its horizons.

## Frequency and Presence Penalties
Like the temperature and Top P dials, the frequency penalty and presence
penalty dials consider text prompts (the previous completion plus the new
input) instead of internal model parameters when deciding on output.
Existing text thus influences the new completions. The frequency penalty
decreases the likelihood that the model will repeat the same line verbatim
by “punishing” it. The presence penalty increases the likelihood that it will
talk about new topics.
These come in handy when you want to prevent the same completion text
from being repeated across multiple completions. Although these dials are
similar, there is one important distinction. The frequency penalty is applied
if the suggested text output is repeated (for example, the model used the
exact token in previous completions or during the same session) and the
model chooses an old output over a new one. The presence penalty is
applied if a token is present in a given text at all.

## Best Of
GPT-3 allows you to generate multiple completions on the server side and
evaluate them behind the scenes, so it can provide you with the best
probabilistic result. Using the “best of” parameter, you can specify the
number of completions (n) to generate on the server side. The model will
return the best of n completions.
This allows you to evaluate multiple prompt completions in a single API
call rather than calling the API repeatedly to check the quality of different
completions for the same input. However, using “best of” is expensive: it
costs n times the tokens in the prompt. For example, if you select the best-
of value as 2, then you will be charged double the tokens present in the
input prompt, because in the backend the API will generate two
completions and show you the best one.
We advise keeping response length minimal while generating multiple
prompts using the best-of parameter to avoid additional charges.

## Stop Sequence
A stop sequence is a set of characters that signals the API to stop generating
completions. This helps avoid using unnecessary tokens, an essential cost-
saving feature for regular users.
You can provide up to 4 sequences for the API to stop generating further
tokens.
Let’s look at the example language translation task in Figure 2-5 to
understand how the stop sequence works. In this example, English phrases
are being translated into French. We use the restart sequence “English:” as a
stop sequence: whenever the API encounters that phrase, it will stop
generating new tokens.

![Stop Sequence](stop-sequence-gtp3.png)

## Inject Start Text and Inject Restart Text
The inject start text and inject restart text parameters allow you to insert text
at the beginning or end of the completion, respectively. You can use them to
keep a desired pattern going. Often, these settings work in tandem with the
stop sequence, as in our example. The prompt has the pattern where an
English sentence is provided with the prefix “English:” (the restart text) and
the translated output is generated with the prefix “French:” (the start text).
As a result, anyone can easily distinguish between the two and create a
training prompt that both the model and the user can clearly comprehend.
Whenever we run the model for such kinds of prompts, the model
automatically injects a start text “French:”before the output and a restart
text “English:” before the next input, so that this pattern can be sustained

## Show Probabilities
The “show probabilities” parameter is at the bottom of the Playground’s
settings pane. In conventional software engineering, developers use a
debugger to troubleshoot (debug) a piece of code. You can use the “showprobabilities” parameter to debug your text prompt. Whenever you select
this parameter, you will see highlighted text. Hovering over it with the
cursor will show a list of tokens that the model can generate for the
particular input specified, with their respective probabilities.
You can use this parameter to examine your options. In addition, it can
make it easier to see alternatives that might be more effective. The “show
probabilities” parameter has three settings:
  - Most Likely
    - Lists the tokens most likely to be considered for completion, in decreasing order of probability.
  - Least Likely
    - Lists the tokens least likely to be considered for completion, in decreasing order of probability.
  - Full Spectrum
    - Shows the entire universe of tokens that could be selected for completion.

## Models
- Davinci
  - Da Vinci is the largest execution engine and the default when you first open the Playground. It can do anything the others can, often with fewer instructions and better outcomes. However, the trade-off is that it costs more to use per API call and is slower than other engines.
- Curie
  - Curie aims to find an optimal balance between power and speed, that is very important for performing high-frequency tasks like classification on a very large scale or putting a model into production.Curie is also quite good at answering questions, performing Q&As, and serving as a general purpose chatbot. For instance if you are building a customer-support chatbot ,you might choose Curie to serve high-volume requests faster. While Davinci is stronger at analyzing complicated texts, Curie can perform with low latency and lightning-fast speed. It is always sensible to figure out what your use case is and do a cost-benefit analysis before choosing Davinci over Curie in production.
- Babbage
  - Babbage is faster than Cuire but not capable of performing tasks that involve understanding complex intent. However, it is quite capable and is preferable when it comes to semantic search rankings and analyzing how well documents match up with search queries. It’s less expensive than Curie and Davinci and is a preferred choice for simple problems involving frequent API calls.
- Ada
  - Ada is the fastest and least expensive of all the engines available. It can perform simple tasks that do not require a nuanced understanding of context, like parsing text, correcting grammar, or simple classification. It is often possible to improve Ada’s performance by providing more context with the input.

---

## Semantic search in documents

### Semantic Search 
The semantic search endpoint allows you to provide a query in natural language to search a set of documents, which can be words, sentences, paragraphs or even longer texts. It will score and rank the documents based on how semantically related they are to the input query. For example, if you provide the documents ["school”, “hospital”, “park"] and query “the doctor”, you’ll get a different similarity score for each document. The similarity score is a positive score that usually ranges from 0 to 300 (but can sometimes go higher), where a score above 200 usually indicates that the document is semantically similar to the query. The higher the similarity score, the more semantically similar the document is to the query (in this example, “hospital” will be most similar to “the doctor”). You can provide up to 200 documents as part of your request to the API. 1 Following is the signature for the semantic search endpoint: POST https://api.openai.com/v1/engines/{engine_id}/search

### Files Endpoint

Files Endpoint can be used across different endpoints like Answers, Classification and Semantic Search. It is used to upload documents or files to the OpenAI storage which is accessible throughout the API features. The same endpoint can be used with different signatures to perform the following tasks: 

### List Files
It simply returns the list of files that belong to the user’s organization or that are linked to a particular user’s account. It’s an HTTP GET call which doesn’t require any parameters to be passed with the request. GET https://api.openai.com/v1/files

### Upload Files
It is used to upload a file that contains documents to be used across various endpoints. It uploads the documents to the already allocated internal space by OpenAI for the users organization. It is a HTTP POST call that requires the file path to be added with the API request. POST https://api.openai.com/v1/files 

#### Retrieve File
It returns the information about a specific file by just providing the file id as the request parameter. Following is the signature for the Retrieve endpoint: GET https://api.openai.com/v1/files/{file_id}

### Delete File
It deletes the specific file by providing the file as the request parameter. Following is the signature for the Delete endpoint: DELETE https://api.openai.com/v1/files/{file_id}

### Classification (Beta)

The classification endpoint lets you leverage a labeled set of examples without fine-tuning. It classifies the query using the provided examples thereby avoiding fine-tuning, and in turn eliminating the need for hyperparameter tuning. You can use it for virtually any machine learning classification task. The endpoint provides an easy-to-configure “autoML” solution that can easily adapt to the changing label schema. You can provide up to 200 labeled examples as part of the request or a pre-uploaded file can be provided during the query. In addition to providing a URI path, the API endpoint requires a model and query, along with examples. Its signature is: POST https://api.openai.com/v1/classifications

### Answers (Beta)

GPT-3’s question-answering endpoint is still in beta as of this writing in late 2021. When given a question, it generates answers based on information provided in a set of documents or training examples. For example, if you want to implement a QA endpoint on a set of PDFs, you just upload them using the files endpoint and provide the file ID with the request parameters. The answers endpoint will use those files as the context to answer any query. It also allows you to steer the model’s contextual tone and responses by providing a list of (question, answer) pairs in the form of training examples. It first searches the provided documents or examples to find the relevant context, then combines it with relevant examples and questions to generate a response. Its signature is: POST https://api.openai.com/v1/answers

--- 

## Fine-tuning

- Needs CLI
  - `pip install --upgrade openai`
  - `export OPENAI_API_KEY=<api_key>`
- https://openai.com/blog/customized-gpt-3/#example

- Prepare JSON file with the following structure
```
{"prompt": "<prompt text>", "completion": "<ideal generated text>"}
{"prompt": "<prompt text>", "completion": "<ideal generated text>"}
{"prompt": "<prompt text>", "completion": "<ideal generated text>"}
```

- run `openai tools fine_tunes.prepare_data -f <JSON FILE>` to convert to JSONL.
- run `openai api fine_tunes.create -t <CONVERTED JSONL FILE> -m <MODEL>`

## Text Generation

### Article generation

Our prompt:
```
Here are the top 5 tips for personal productivity.
```
And the output:
```
1. Develop a routine. Work can be overwhelming. You don’t need to remember every little detail. By having a routine, you will be able to work more efficiently.
2. Avoid multitasking. If you are multitasking, you are bound to miss something. It is better to work on one task at a time.
3. Take breaks. It is true that if you do not take breaks, you will be more productive. However, if you take breaks too often you will get tired and stressed. If you work more effectively, you will shorten the time needed to complete a task.
4. Learn to delegate. If you have a lot of work to do, you should not do everything on your own. Delegate some of the work to others.
5. Prioritize. Prioritize what you have to do and do the most important tasks first. Don’t worry about the small things.
```

### Social media Post Generation

Here is our prompt:
```
Write a social media post for Facebook, Twitter, and Instagram about launching a new beta version of the personal productivity app.
```
Facebook post:
And the output:
```
“After extensive user testing, we are happy to announce that our latest update is available for download! Our team has worked hard to create the best version of our app yet. Download it now for free at www.app.com.”
Twitter post:
“We're rolling out an updated version of your favorite productivity app! Now available on iOS and Android. #productivity #beta”
Instagram post:
“We just released a new beta version of your favorite productivity app! Download it today for free on iOS and Android. #productivity #beta”
```
