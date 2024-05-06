<p align="center"><img src="https://dydx.exchange/icon.svg?" width="256" /></p>

<h1 align="center">dYdX Chain Localization</h1>

<div align="center">
  <a href='https://www.npmjs.com/package/@dydxprotocol/v4-localization'>
    <img src='https://img.shields.io/npm/v/@dydxprotocol/v4-localization.svg' alt='NPM'/>
  </a>
  <a href='https://github.com/dydxprotocol/v4-localization/blob/main/LICENSE'>
    <img src='https://img.shields.io/badge/License-AGPL_v3-blue.svg' alt='License' />
  </a>
</div>

# Translation structures

There are four folders for translations.

/config/localization
/config/localization_notifications
/config/localizations_native
/marketing

Each of them contains a list of language folders, such as
/en (English)
/es (Spanish)
/fr (French)
/ja (Japanese)
/ko (Korean)
/pt (Portugal)
/ru (Russian)
/tr (Turkey)
/zh-CN (Simplified Chinese)

Each folder contains either a list of JSON files ending .json, or text files ending .txt

# Syntax and Structure

Text that goes within tooltip pop ups should go in the config/localization/{language}/tooltips.json
Other text goes to config/localization/{language}/app.json

Within each json file, find the component/view that your text belongs in (or create a new key for it) and your text.

Typically, tooltips will have both `TITLE` and `BODY` text.

## Parameters

If you need to inject dynamic text or other values, use {} to notate an input parameter.

Ex:
```
"SOME_TEXT": "A zebra has {ZEBRA_PATTERN} stripes"
```

The term within the {} will be the name of the variable used to inject your dynamic values.
Parameters are quite flexible - you can even insert react components (as long as they can be rendered properly).


# Work with Github

The "main" branch cannot be written directly. You must create a separate branch, make the changes there, commit and push the branch, and then create a PR (Push request) to "main"

For your branch, recommend to use "/changes/{language-code}-{date}" as the branch name.

For example, if you are working on Spanish, and started the work on July 13th, 2022, use the branch name "/changes/es-2022-07-13".

Once your PR is accepted and merged into "main", the branch is removed from the repo. Create a new branch for next batch of changes.

## Committing Changes
Before committing your changes to the repo, you need to run the following commands: 

`npm run generate` to auto generate required code

`npm version patch` to update the package version number


# JSON Translations

Please translate each JSON entry, using the file in /en folder as the original, and translate into the same file name in other language files.

For example, there is a /config/localization/en/app.json file. It should be translated into Spanish in /config/localization/es/app.json file.

The key should stay the same. The value should be translated. For example
"YOUR_POSITION_WAS_LIQUIDATED": "Your position was liquidated." is translated to Spanish as
"YOUR_POSITION_WAS_LIQUIDATED": "Tu posición ha sido liquidada."

You will see curly brackets in some cases. Keep the text in the curly brackets as is. For example
"LEAGUES_LAUNCH_BODY": "Climb the rankings ladder to earn your share of the {PRIZE}." is translated to Spanish as
"LEAGUES_LAUNCH_BODY": "Asciende en la clasificación para ganar tu parte del {PRIZE}.",

"{PRIZE}" should not be translated.

Make sure the JSON format is still valid. Recommend to use https://jsonformatter.curiousconcept.com to validate the translated JSON

# TXT Translations

Text files can be translated as a single unit.

# Generating app.ts
'''
./codegen_localization_app.swift ../config/localization/en/app.json > ./generated/app.ts
'''

# Generating tooltips.ts
'''
./codegen_localization_tooltips.swift ../config/localization/en/tooltips.json > ./generated/tooltips.ts
'''

# Generating notifications.ts
'''
./codegen_localization_notifications.swift ../config/localization_notifications/en/app.json > ./generated/notifications.ts
'''
