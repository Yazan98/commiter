# Commiter

# Description
Commiter is a Cli Written in Ruby To Ask some Questions about how you want to write the commit message validation before write any commit and if this commit is not matching the commiter configuration file it will reject the commit and kill the process

# The Problem
In each git Repository when you initialize the Project you dont have Rules to make All Developers inside this Project Follow same way in Commit Messages and in the Future if you cant find any key inside the messages to see the history you will never know how this feature implemented like this until you deep dive into it because you dont have the main reason about this area you just found the commit message (fix) and this is not a commit message :D so with this configuration all the team will have same commit rules and if someone is not following this rules the commit will be rejected

# Screenshots for Validation
1. Ticket Number Validation

![Capture](https://user-images.githubusercontent.com/29167110/113469102-8df87980-9453-11eb-9727-2240e6914c59.PNG)

2. Black list Validation

![Capture](https://user-images.githubusercontent.com/29167110/113469122-bda78180-9453-11eb-9360-710185340f55.PNG)

3. Regex Expression Validation

![Capture](https://user-images.githubusercontent.com/29167110/113469144-f6475b00-9453-11eb-8952-c30d34784c56.PNG)

# Validations Supported
1. Ticket Number
2. Black List Words
3. Regex Expression

# Installation
1. Ruby Required
2. Bundler To Fetch Gem

### Include in Another Supported Ruby Project
1. Create File in your Root Directory inside The Project (Gemfile)
2. Add This Line at the First

```ruby19regexp
source 'https://rubygems.org'
```

3. Add this Line inside This File

```ruby19regexp
gem 'commiter', '~> 0.0.1'
```

4. Run this Commands

```ruby19regexp
gem install commiter
bundle install
bundle package
```

6. Copy commiter gem file From Vendor Directory to your Project

# Quick Installation
If you dont wanna use gem file you can copy the files and Edit the Config json File from result folder into you .git/hooks folder inside your git repository you will find variables described in table section

| Key Name      | Description |
| ----------- | ----------- |
| is_enabled      | Decide if commit command will check the validation or not       |
| ticket_number_example   | What is the Ticket Number Key like SW-{#} The {#} is the Dynamic Number Value        |
| generated_style   | You Have 3 Options To Validation (t -> Ticket Number) / (b -> Black List Words) / (r -> Regex Expression) |
| regex_input   |  The Regex String to match Message with it if the generated style (r) is Selected  |
| black_list_words   |  The Black list words Blocked  |

# Cli
This Project is a Command line Interface to Generate this File inside your git file If you want to Install the Cli Clone this Repo then install ruby and run this command inside the Project

```ruby19regexp
rake install -g
```

The Cli should be started

![Capture](https://user-images.githubusercontent.com/29167110/113469182-53431100-9454-11eb-863a-3d14b0eb45dd.PNG)

