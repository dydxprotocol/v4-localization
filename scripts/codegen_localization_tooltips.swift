#!/usr/bin/env swift

import Foundation

// This script is used to generate the TS constants for the tooltips.json file

if CommandLine.arguments.count < 2 {
    print("Usage: codegen_localization_app.swift <path to tooltips.json>")
    exit(1)
}

let appJsonPath = CommandLine.arguments[1]

guard let appJsonData = FileManager.default.contents(atPath: appJsonPath) else {
    print("Could not read tooltips.json file at path \(appJsonPath)")
    exit(1)
}

guard let appJson = try? JSONSerialization.jsonObject(with: appJsonData, options: []) as? [String: Any] else {
    print("Could not parse tooltips.json file at path \(appJsonPath)")
    exit(1)
}

print("// !! GENERATED FILE - DO NOT EDIT\n")
print("// Generated from \(appJsonPath) using \(CommandLine.arguments[1])\n")

print("export const TOOLTIP_STRING_KEYS = {")
generateItems(keyPath: "TOOLTIPS", lastKey: nil, value: appJson)
print("};\n") 


func generateItems(keyPath: String, lastKey: String?, value: Any?) {
    if let value = value as? [String: Any] {
        if let lastKey = lastKey, value.keys.contains("BODY") || value.keys.contains("TITLE") {
            if value.keys.contains("BODY") {
                print("    \(lastKey)_BODY: \'\(keyPath).BODY\',")
            }            
            if value.keys.contains("TITLE") {
                print("    \(lastKey)_TITLE: \'\(keyPath).TITLE\',")
            }
        } else {
            if let lastKey = lastKey {
                print("\n    // \(lastKey)\n")
            }
            for subKey in value.keys.sorted() {
                if !subKey.starts(with: "__") {
                    generateItems(keyPath: keyPath + "." + subKey, lastKey: subKey, value: value[subKey])
                }
            }
        }
    } 
}
