# **Clerkie-cli**

Clerkie-cli is a terminal tool that uses a large language model (LLM) to provide suggestions and assistance when you encounter errors in your code. It is designed to help developers of all skill levels improve their productivity and efficiency by providing them with quick and accurate solutions to common coding problems.

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/clerkieai)
## **Features**

- Analyzes stack traces in any programming language and provides explanations and suggested fixes
- Offers guidance on debugging and troubleshooting techniques
- Provides code snippets and examples to help you debug errors
- Automatic in terminal error detection and suggested fixes

## **Installation**

Requirements: As of now Clerkie-cli only works for Zsh shell, Macs default to zsh [https://support.apple.com/guide/terminal/change-the-default-shell-trml113/mac#:~:text=The default shell is zsh,windows and tabs open with](https://support.apple.com/guide/terminal/change-the-default-shell-trml113/mac#:~:text=The%20default%20shell%20is%20zsh,windows%20and%20tabs%20open%20with). We are working to add support for bash

To install Clerkie-cli, open a terminal and run the following command:

```bash
curl -fsSL https://raw.githubusercontent.com/ishaan-jaff/clerkie-cli/main/install.sh | sh -
```

This will download and install the latest version of Clerkie-cli on your machine. Once the installation is complete, you need to open a new Terminal Window and Clerkie will be active

## **Usage**

Clerkie-cli automatically runs whenever it notices an error in your terminal. Simply run your code as you normally would, and if an error occurs, Clerkie-cli will provide you with an explanation of the error and suggest potential fixes.

![carbon](https://user-images.githubusercontent.com/29436595/209611631-91a4d559-7810-42c9-8584-b3a8e1b794ac.png)
![carbon (2)](https://user-images.githubusercontent.com/29436595/209611683-f7cd91de-d889-4e11-9123-ec23393adaf6.png)

Clerkie-cli will then provide you with an explanation of the error and suggest potential fixes.

## How to disable Clerkie-cli

Open ~/.zshrc and delete the following lines (you can edit zshrc using vi ~/.zshrc)

```bash
# clerkie-cli configs
export CLERKIE_SRC=/Users/daddyish/.clerkie-cli/clerkie-src
[[ -f "$HOME/.clerkie-cli/clerkie-src/setup.sh" ]] && builtin source "$HOME/.clerkie-cli/clerkie-src/setup.sh"
```

## **Support**

If you have any questions or need help using Clerkie-cli, you can reach out to us through the following channels:

- **[GitHub](https://github.com/ishaan-jaff/clerkie-cli)**
- [**Discord**](https://discord.gg/KvG3azf39U)
- [**Twitter**](https://twitter.com/ishaan_jaff)

We are always happy to help!
