import { useColors } from "@/components/ui-kit/core/use-colors";
import { useSpacers } from "@/components/ui-kit/core/use-spacers";
import ReactMarkdown from "react-markdown";

export function ExperienceSection() {
  const colors = useColors();
  const spacers = useSpacers();

  return <>
  <style jsx global>
    {`
    .experience-section h3 {
      background-color: ${colors.infoMuted};
      padding: ${spacers.base};
    }
    `}
  </style>
  <ReactMarkdown className="experience-section">
    {`## Work Experience

### Independent

> Sep 2021 - Present | After-hours

#### Skills

- **AI**: ChatGPT, GPT-3
- **Mobile**: React Native
- **No-code and 3rd party providers**: Firebase, Adalo, n8n.io
- **Soft-skills**: APIs, Business Models, Estimations

#### Roles

- MVP Consultant
  - I help co-founders navigate technology and finding out what they need to build the engineering side of their new MVP

### Lemon.io

> Apr 2023 - Present | After-hours

Lemon.io is the leading platform for hiring developers for startups. I am one of their vetted developers.

#### Roles

- MVP Consultant
  - I help co-founders navigate technology and finding out what they need to build the engineering side of their new MVP

#### Skills

- **AI**: ChatGPT, GPT-3
- **Mobile**: React Native
- **Soft-skills**: APIs, Business Models, Estimations

### Tech Expert Academy

> Feb 2023 - Present | After-hours

Tech Expert Academy offers high quality courses that help you become a tech professional in record time. They help you find a job at a great company. You only pay tuition once you get hired.

#### Skills

Tutoring, remote classes with remote debugging

#### Roles

- Help unblock students in their own independent path to become full-stack developers.

### Impossible + SyntheticUsers

> Aug 2022 - Apr 2023 (**9 months**) | Full-time

SyntheticUsers is a platform that gives you user interviews for product research and market validation, without real users. Through the use of AI, we emulate  specific audiences and demographics that you can interview and validate the market fit of your solution, without the need for sampling and recruiting people for user testing. It gives you a unique overview of your product, allowing you to uncover features and blockers, without spending as much time and money on user research.

#### Skills

- **AI**: GPT-3, ChatGPT, LangChain, Jupyter, Pinecone, Weaviate
- **Languages**: Python, Typescript, Javascript, Kotlin
- **Infrastructure**: Linux, Docker, Git
- **Storage**: PostgreSQL
- **Backend**: Node.js, NestJS, TypeORM, Spring Boot
- **Frontend**: React.js, Next.js, Ant Design, HTML, CSS
- **No-code and 3rd party providers**: Firebase, n8n.io, Adalo, Retool, OpenBlocks, Miro

#### Roles

As the only MVP developer:

- Building multiple product drafts from scratch for user testing and market validation
- Implement no-code and low-code tools so that stakeholders could change business rules without needing developer time
- Implemented large language models months before their boom, together with fine-tuning and search utilities

As a team of 2 members (me included):

- Integrating a team and developing a final product that suits the requirements gathered from the previous product drafts.

### Drawbotics + Mosaic

> Sep 2021 - Aug 2022 (**1 year**) | Full-time

Drawbotics offers everything a developer needs to sell his properties that are still off-plan. It offers innovative technologies like 3D renders of your properties, the ability to explore virtually the inside of properties (using our REVO technology), marketing materials, diffusion of your ads through many real-estate portals, and even a no-code tool to quickly build a landing page.

Mosaic is a CRM and end-to-end sales platform for property developers, powered by some of Drawbotics technologies

#### Skills

- **Infrastructure**: Heroku, Git
- **Backend**: GraphQL
- **Frontend**: React.js, JavaScript, TypeScript, Emotion (CSS-in-JS), npm, Webpack, HTML, CSS

#### Roles

- Develop and maintain features in Drawbotics and Mosaic's many frontends
- Occasional development of React embedded in Rails views
- Internal tooling maintenance

### Opplane

> Sep 2019 - Aug 2021 (**2 yrs**) | Full-time

Silicon Valley startup developing intelligent apps with machine learning and telco services

#### Skills

- **Infrastructure**: AWS, GCP, Linux, Terraform, Docker, Linux, Apache Kafka, Git
- **Storage**: PostgreSQL, MongoDB, Presto
- **Languages**: Javascript, Typescript, Java, Kotlin, Python
- **Backend**: Node.js, NestJS, TypeORM, Spring Boot
- **Frontend**: React.js, Next.js, Gatsby, Bootstrap, HTML, CSS, Sass
- **Mobile**: React Native, Android, iOS, Expo
- **No-code and 3rd party providers**: Pubnub, Firebase
- **Soft-skills**: planning, estimating, hiring

#### Roles

- Design and develop full-stack apps (database, workers and recurring processing of data, backend, auditing, web and mobile apps) for various clients in the finance and health sector.
- Architect project structures, tools and frameworks
- Direct support, planning and feedback with clients
- Conducting job interviews for developer positions

### Zenklub

> Sep 2018 - Sep 2019 (**1 year and 1 month**) | Full-time

Zenklub is a B2C and B2B mental healthcare provider in Brazil.

It offers many features, the main ones being a marketplace of therapists where you can book and pay appointments with the web or mobile app, and services that give you insights regarding your employees mental health.

Today they are the biggest provider of online mental health care in Brazil, and used by a lot of big companies as a perk for maintaining employee well-being.

#### Skills

- **AI**: IBM Watson
- **Languages**: Typescript, Javascript, C#
- **Infrastructure**: Azure, AWS, AWS Lambda, Linux, Docker, WebRTC, Rabbit MQ, Git
- **Storage**: PostgreSQL, MongoDB
- **Backend**: Node.js, Serverless Framework, Loopback, ASP.NET
- **Frontend**: React.js, Angular 5, Puppeteer, Bootstrap, HTML, CSS, Sass
- **Mobile**: React Native, Android, iOS
- **No-code and 3rd party providers**: Firebase, OneSignal, Applozic, Typeform, Jitsee Meet, Janus

#### Roles

Together with the CTO:

- Rebuilt the company's engineering side from the small MVP it once was, in a smooth transition that never locked the development of new features, and allowed to slowly move away from the legacy MVP.
- Maintaining the following services
  - ASP.NET legacy server
  - AWS Lambda gateway and business logic
  - Loopback persistence server
  - React Native user-facing app
  - Angular Website for scheduling, payments and live therapy sessions
  - Angular Back-office

### Farfetch

> Dec 2017 - Sep 2018 (**10 months**) | Full-time

Farfetch is a British-Portuguese online luxury fashion retail platform that sells products from over 700 boutiques and brands from around the world.

#### Skills

- **Languages**: Javascript, C#
- **Infrastructure**: Azure, Git
- **Storage**: Apache Cassandra
- **Backend**: ASP.NET
- **Frontend**: jQuery, HTML, CSS, Sass, PostCSS
- **Build Systems**: Gulp, Webpack, MSBuild

#### Roles

In a team responsible for maintaining and evolving the cross-cutting layout of the main website.

Some highlighted personal tasks were:
- improving Javascript and Post-CSS build system
- Proof-of-concept: migration from Gulp to Webpack with Hot Module Replacement
- improving MSBuild configs

These were all tasks designed to improve the development speed, that was very slow, sometimes having to wait 1 minute for the computer to build and show the changes on the screen

### Yelloh

> Aug 2017 - Dec 2017 (**5 months**) | Full-time

Video-based online surveys, right from the browser.

#### Skills

- **Languages**: Javascript, Flow
- **Infrastructure**: AWS, WebRTC, Git
- **Storage**: MongoDB
- **Backend**: Node.js, FeathersJS
- **Frontend**: React, Semantic UI, HTML, CSS, Less
- **Build Systems**: Webpack

#### Roles

Together with the CTO:

- build the following services from scratch:
  - web-app for users to see the questions and record themselves
  - back-office for companies to check their survey results
  - server

### CGI

> Jan 2017 - Jun 2017 (**6 mos**) | Full-time

Founded in 1976, CGI is among the largest IT and business consulting services firms in the world.

#### Skills

- **Languages**: Javascript, Java
- **Infrastructure**: Linux, Git
- **Backend**: SpringMVC
- **Storage**: PostgreSQL
- **Frontend**: Angular 1, Material UI, HTML, CSS
- **Build Systems**: Gulp

#### Roles

- Develop an NGO resources management app using SpringMVC and AngularJS.
`}
  </ReactMarkdown>
  </>
}