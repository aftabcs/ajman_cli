# Ajman CLI

Ajman CLI (`ajman`) is a command-line tool designed to streamline development tasks such as generating pages, managing internationalization strings, and building Flutter applications efficiently.

## Installation

To install `ajman_cli`, run the following command:
```sh
dart pub global activate ajmancli
```
Ensure that Dart's global bin directory is added to your system's PATH to use `ajman` from anywhere in the terminal.

## Usage

The `ajman` command provides multiple subcommands for different tasks.

### General Command Structure
```sh
ajman <command> [options]
```

## Commands

### 1. Generate a Page (`genpage`)
This command generates a new page in the project.

**Usage:**
```sh
ajman genpage -n <PageName> [-a]
```
**Example:**
```sh
ajman genpage -n HomePage
```
**Options:**
- `-n, --name` (required): Specifies the page name.
- `-a, --args` (optional): Generates additional argument handling logic in the generated page.

**Validation Rules:**
- The page name must be alphanumeric and cannot contain spaces or special characters.

### 2. Add Internationalization (`addintl`)
This command adds a new localized string to the `.arb` files.

**Usage:**
```sh
ajman addintl -v <ValueString> [-a <ArabicString>]
```
**Example:**
```sh
ajman addintl -v "Hello" -a "مرحبا"
```
**Options:**
- `-v, --value` (required): The default language string.
- `-a, --arabic` (optional): The Arabic translation for the string.

### 3. Build the Application (`build`)
This command builds the application for a specified environment.

**Usage:**
```sh
ajman build <environment>
```
**Example:**
```sh
ajman build dev
```
**Requirements:**
- The `environment` argument is required and should be one of the predefined environments (e.g., `dev`, `staging`, `prod`).

### 4. Generate APIs
This command is used to generate models and entity of an APIs
**Usage:**
```sh
ajmancli addapi -n <ApiName> -f <feature_name> -l [Optional]<ListOfOjectsInContent> -r [Optional]<Generate request entity>
```
**Example:**
```sh
ajman addapi -n RegisterUser -f user_registration -l Accounts -r 
```

## Additional Flags

### Version
To check the version of Ajman CLI:
```sh
ajman --version
```

### Help
To display help information:
```sh
ajman --help
```

## Error Handling
If incorrect arguments are provided, Ajman CLI will display an error message with the correct usage format.

Example error message:
```
Error: Page name is required.
Usage: ajman genpage -n <PageName> [-a]
```

Ensure that you follow the required format for each command to avoid errors.

## Conclusion
Ajman CLI simplifies development workflows by automating common tasks. Use the commands effectively to boost your productivity!

