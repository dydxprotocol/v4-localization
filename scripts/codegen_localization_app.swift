#!/usr/bin/env swift

import Foundation

// This script is used to generate the TS constants for the app.json file

if CommandLine.arguments.count < 2 {
    print("Usage: codegen_localization_app.swift <path to app.json>")
    exit(1)
}

let appJsonPath = CommandLine.arguments[1]
var keys: Set<String> = []

guard let appJsonData = FileManager.default.contents(atPath: appJsonPath) else {
    print("Could not read app.json file at path \(appJsonPath)")
    exit(1)
}

guard let appJson = try? JSONSerialization.jsonObject(with: appJsonData, options: []) as? [String: Any] else {
    print("Could not parse app.json file at path \(appJsonPath)")
    exit(1)
}

print("// !! GENERATED FILE - DO NOT EDIT\n")
print("// Generated from \(appJsonPath) using \(CommandLine.arguments[0])\n")

for key in appJson.keys.sorted() {
    print("export const \(key)_STRING_KEYS = {")
    generateItems(keyPath: key, lastKey: nil, value: appJson[key])
    print("};\n") 
}

func generateItems(keyPath: String, lastKey: String?, value: Any?) {
    let digits = CharacterSet.decimalDigits

    if let value = value as? [String: Any] {
        if let lastKey = lastKey {
            print("\n    // \(lastKey)\n")
        }
        for subKey in value.keys.sorted() {
            generateItems(keyPath: keyPath + "." + subKey, lastKey: subKey, value: value[subKey])
        }
    } else if let lastKey = lastKey {
        // ensure no duplicate keys
        if (keys.contains(lastKey)) {
            return
        }
        
        keys.insert(lastKey)

        // add single quotes to keys that start with a number
        if let range = lastKey.rangeOfCharacter(from: digits), range.lowerBound == lastKey.startIndex {
            print("    \'\(lastKey)\': \'\(keyPath)\',")
        } else {
            print("    \(lastKey): \'\(keyPath)\',")
        }
    }
}
