import { useColors } from "@/components/ui-kit/core/use-colors";
import { useSpacers } from "@/components/ui-kit/core/use-spacers";
import ReactMarkdown from "react-markdown";

export function IntroSection() {
  const colors = useColors();
  const spacers = useSpacers();

  return <>
  <style jsx global>
    {`
    .intro-section blockquote {
      background-color: ${colors.infoMuted};
      padding: ${spacers.base};
    }
    `}
  </style>
  <ReactMarkdown className="intro-section">
    {`# Bartolomeu Rodrigues

> Practical Full-stack developer | Building for startups | Building with GPT-3 before ChatGPT | Cybersecurity

🕒 Lisbon, Portugal | GMT+0

✉️ pbartmr@gmail.com - 👤 https://www.linkedin.com/in/**bartmr** - 📁 https://github.com/**Bartmr**

## Intro

🔧⌛ Practical and oriented towards simplicity.

🏗️ My career has been built around creating digital products and features.

🛡️ Cyber Security Certified

💻🌍 Experience working remotely for startups outside the country, even before COVID.

🎨 Jack-of-all-trades, master of ever-changing technology: Building for startups with a product-first mentality and engineering-second approach has enabled simplification of product construction with ever-changing technologies, as well as the ability to tackle troublesome bugs in all parts of the product.

🤖 On-the-job experience with GPT-3, fine-tuning and embeddings search, 3 months before the launch of ChatGPT

📊 experience consulting with future co-founders on what they need from the engineering side to build their MVP

📖 experience giving workshops and coaching newcomers into tech

💼 B2B Contractor, in order to legally work for companies outside Portugal

### Top skills

- **Languages**: Python, Typescript, Javascript
- **Backend**: Node.JS, NestJS
- **Frontend**: React.js, Next.js
- **Databases**: PostgreSQL
- **Infrastructure**: Linux, Docker, Git
- **Mobile**: React Native, Android, iOS
- **AI**: ChatGPT, GPT-3, Langchain, Jupyter
- **No-code and 3rd party providers**: Supabase, Firebase, n8n.io, Adalo, Retool

### Past Industries

PropTech, Healthcare, Telco, AI, User Research, Market Validation, Customer Satisfaction, Fashion

### What I'm looking for

- Ownership of a project or feature
- Be able to take on a complex feature from engineering and make it simpler, so it can offer more value for half the development time
- Improve my productivity, develop new apps and features at a faster pace
  -  The world keeps changing, but the ability to build will always be of value
- Connection to the business side, in order to be able to discuss trade-offs and offer the best value for the least amount of development time`}
  </ReactMarkdown>
  </>
}