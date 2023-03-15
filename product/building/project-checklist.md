- Planning
  - Research competitors
  - Create a directory for the project, under `my-projects`
  - Features
  - Mockup design (Uizard)
  - Database graph (Google Drawings at Google Drive)
  - Plan needed backend endpoints and jobs (this repository)
- Implementing
  - Create a new repository 
    - Enable branch protection for the repository
      - Stop force-pushes
      - Stop branch deletion
      - Make merge requests mandatory
      - Apply the above to administrators too
    - Add this repository to every place that has `# IMPORTANT REPOS` in `my-notes`
    - Is it from scratch, or will it be based on `estirador`?
      - `estirador`
        - pick the layers you want to use
    - from scratch
      - create `Dockerfile` and `devcontainer` for local development
        - remember to set a non-root user at the end, with the same group and user ids as the current user in the host machine
      - in case of a monorepo, create a directory for each app (`server`, `web-app`, etc...) and a `shared` directory for code that is shared between multiple apps
        - for each app
          - Setup compiler / build tool (example: `Typescript`)
          - setup code-sharing between apps
            - can be through the use of a `shared` directory
            - to avoid having to build the shared code invidually, setup a _symlink_ inside every app that points to the `shared` directory. This way, the shared code becomes the app code, and all builds, lints and typechecks treat this _symlink_ and the app code as a whole.
          - Setup loading of environment variables
            - Validate said environment variables
              - during build-time for client-side applications
              - at run-time start, for backend applications 
          - Setup a migrations tool, to reflect schema changes in databases and 3rd party services
          - Setup code formatting tool (example: `Prettier`)
          - Setup Linter
          - Setup integrity check command
      - Setup precommit and pre merge hook
      - sort code by feature (users, payments, auth, notes, etc...), NOT by technical concept (models, views, controllers, etc...). If needed, setup your frameworkds and libraries to work that way
        - Technical concepts in a single feature
          - Controllers / Methods / Workers
          - Services
          - DTO Classes / Types for request body and parameters, and response
          - Per persisted entity
            - Model Class / Type (per schema version, if needed, in case of Document-oriented databases with no migrations)
            - Repository Class that allows you to inject a transaction instance or a database connection
              - should abstract the resolution of schema version differences, when using a document-oriented database with no migrations
      - if you are using a document-oriented database with no migrations, check these schema versioning patterns
        - https://www.mongodb.com/blog/post/building-with-patterns-the-document-versioning-pattern
        - https://www.mongodb.com/blog/post/building-with-patterns-the-schema-versioning-pattern
        - basically, you assign a version tag to each document, and then when pulling them, you resolve their differences, like so
          - 
            ```typescript
            type UserV1 = {
              /*
                old documents don't have a version property,
                because developers did not expect versioning at the time the entity was developed
              */
              version?: undefined;
              phoneNumber: string
            }

            type UserV2 = {
              version: 2
              contacts: {
                email: string;
                phoneNumber: string
              }
            }

            type User =  {
              contacts: {
                email?: string // optional, since first v1 users didn't submit an email
                phoneNumber: string
              }
            }

            function mapVersionedToUser(versioned: UserV1 | UserV2): User {
              if(versioned.version === 1) {
                return {
                  contacts: {
                    phoneNumber: versioned.phoneNumber
                  }
                }
              } else {
                return versioned
              }
            }

            class UsersRepository {

              async findOne(): Promise<User> {
                const versioned = await this.nativeDriver.collection('users').findOne()

                return mapVersionedToUser(versioned)
              }
            }
            ```
  - Do authentication flow (backend and frontend)
    - **Authentication Methods**
      - Email / Phone Number + Password
      - One-time password / login link sent by email or phone number
      - 2 Factor Auth codes generated in the moment through an app like Authy or Google Authenticator
      - Use another authentication provider with Single Sign-on / OAuth
    - **Account Recovery Methods**
      - Email
      - Phone Number
    - In-house authentication
      - Login
      - Signup + email verification
      - Forgot password flow
      - Change user email + email verification
      - Change user details
      - Change user password + email verification to prove it's the owner of the account
      - Log out from devices
      - 2-factor authentication (optional)
    - Authentication managed by 3rd parties
      - See `tech/low-code-no-code`
    - Extras
      - Logout
      - Logout from all devices
      - Delete / disable account
      - Allow users to change their email. That means repeating the email verification flow
      - Allow users to change the SSO account that logged them in the first time. That means repeating the SSO flow
      - Account recovery in case of lost credentials and lost access
  - Do backend
  - Do frontend
    - Implement SEO
      - Social media HTML tags
      - Robots.txt
      - sitemap.xml
      - Google JSON-LD / Structured Data
        - <https://developers.google.com/search/docs/advanced/structured-data/intro-structured-data>
- Logo and branding
- Get services and compliance ready
  - in case you are deploying to bare-metal servers
    - setup a firewall like `ufw`
    - setup an https certificate
      - https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-uswgi-and-nginx-on-ubuntu-18-04#step-6-configuring-nginx-to-proxy-requests
  - Update your project dependencies
  - Update your project with the latest changes from `estirador`, or any other boilerplate you're using
    - Reject any merge conflicts regarding dependencies versions, since you already updated them in the step above
  - Setup hosting
    > In case you use a monorepo, make sure that frontend builds don't start when only the backend was changed and vice-versa. This can be solved by having `deploy-server` and `deploy-web-app` branches, and each hosting provider listens to its own branch
    - Web Apps
      - Hosting Platforms
        - Netlify
        - Vercel
    - Server (API + background jobs) hosting
      - Use PM2 to fork multiple server threads and have cron jobs scheduled in the code
  - Setup cron jobs
  - Connect your infrastructure and services to a logging provider
    - Backend (server, workers and jobs)
      - Caught errors (that were purposefully thrown)
      - Uncaught errors and unhandled promise rejections
      - Process hanging on shutdown
      - `stdin`, `stderr`, `console.warn` and `console.error`
    - Frontend
      - Decide if sourcemaps should or not be visible to the public (after submitting them to the logging tool)
      - Failed requests and malformed server responses
      - Caught errors (that were purposefully thrown)
      - Uncaught errors and unhandled promise rejections
      - `console.warn` and `console.error`
  - Multi-threading in production environments (for technologies that use only 1 thread/CPU)
    - Use PM2 to fork multiple server threads and have cron jobs scheduled in the code
  - API rate limiting / protection from abuse
  - Implement Health checks and performance monitoring
    - Backend
      - monitor CPU and RAM usage
      - monitor database load
      - monitor response time and per endpoint
    - Frontend
      - Do regular Lighthouse checks
      - Check SEO and Social media tags regularly
      - Monitor Time to Interactive
      - Monitor responsiveness when using the app
  - Analytics
    - Events logging
      - Page views
      - Sign ups
      - Purchases
    - Google Search Console
    - User session recording like LogRocket or Microsoft Clarity
  - Automated email provider
  - Business email
  - Activate all other external services that are needed
  - Cache your CORS requests
    - https://httptoolkit.tech/blog/cache-your-cors/
      - To cache CORS responses in browsers, just add this header to your preflight responses: `Access-Control-Max-Age: 86400`. This is a cache time in seconds.
  - Resolve/implement all the `TODO` comments
  - Create Social Media Accounts
    - Add said social media account links to website
  - Add website to Google Search Console, in order to make it crawlable by Google
  - Way for users to make suggestions for new features
    - Way to notifiy those users that their suggestions were read
  - Way for users to rate the app
  - Way for users to get support
    - Helpdesk
    - Record critical events in the product (like purchases) in order to provide recovery to users after an error or system malfunction
  - Way for users to report bugs
  - Way to notify users about improvements and new features, and also product-related news
    - Also a way to show a list with those past improvements, features and news
  - Compliance
    - Check Levels.io websites and products
    - Check IndieHackers on the topic
    - Generate using a LLM like GPT
    - GDPR banner and cookies
      - https://complianz.io/
      - https://www.cookiebot.com/en/cookie-texts/
    - Privacy policy
      - https://www.freeprivacypolicy.com/free-privacy-policy-generator/
    - Terms of use
      - Make sure user accepts terms of use before signing up
  - Setup a spending limit for all your 3rd party services, in order to avoid an unexpected overcharge caused by users abusing the project
    - Example: set a spending limit on your serverless provider, to protect yourself in case of a surge in users, a buggy function that keeps the lambda awake, or a DDoS.
  - Read all of the vendors instructions for when you're going to production, like [Firebase Launch Checklist](https://firebase.google.com/support/guides/launch-checklist).
- Launch
  - Setup materials
  - Gather all channels where you'll launch
  - Tagging which services and companies you used to make your product might improve your reach
