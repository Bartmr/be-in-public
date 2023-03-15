- Pull latest release of `doctl`
  ```bash
  curl -s https://api.github.com/repos/digitalocean/doctl/releases/latest \
    | jq -r '.assets[] | select(.name|match("^.*linux-amd64\\.tar\\.gz$")) | .browser_download_url'
  ```

## Droplets

- Access a machine: `ssh user@public-ip`

## Functions

- Organize your project as you would in any other
  - file structure
    - src
      - main
        - module-1.ts
        - module-2.ts
        - login.ts
    - project
      - ...everything else is gitignored
      - project.yml
    - node_modules
    - package.json
    - webpack.config.js
    - tsconfig.json
    - .gitignore
- Use Webpack to concatenate all dependencies to the functions that use them. It will create a single JS bundle for each function, ready to be uploaded to DigitalOcean Functions. This will make it easier to not hit the 50MB function limit, since the alternative is sending the function code and all of its node_modules to DigitalOcean functions.
  - each DigitalOcean Function has a Webpack entrypoint and output
  - file structure
    - src
      - main
        - login.ts
    - project
      - main
        - login.js (this will be uploaded to DigitalOcean functions)
      - project.yml
    - node_modules
    - package.json
    - webpack.config.js
    - tsconfig.json
    - .gitignore
