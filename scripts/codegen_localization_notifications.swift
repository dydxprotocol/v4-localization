#!/usr/bin/env swift

import Foundation

// This script is used to generate the TS constants for the localization_notifications/.json file

if CommandLine.arguments.count < 2 {
    print("Usage: codegen_localization_notifications.swift <path to notification app.json>")
    exit(1)
}

let appJsonPath = CommandLine.arguments[1]

guard let appJsonData = FileManager.default.contents(atPath: appJsonPath) else {
    print("Could not read notification app.json file at path \(appJsonPath)")
    exit(1)
}

guard let appJson = try? JSONSerialization.jsonObject(with: appJsonData, options: []) as? [String: Any] else {
    print("Could not parse notification app.json file at path \(appJsonPath)")
    exit(1)
}

print("// !! GENERATED FILE - DO NOT EDIT\n")
print("// Generated from \(appJsonPath) using \(CommandLine.arguments[1])\n")

print("export const NOTIFICATIONS_STRING_KEYS = {")

generateItems(keyPath: "", lastKey: nil, value: appJson["NOTIFICATIONS"])
print("};\n") 

func generateItems(keyPath: String, lastKey: String?, value: Any?) {
    if let value = value as? [String: Any] {
        if let lastKey = lastKey,  value.keys.contains("TITLE"),  value.keys.contains("BODY") {
            print("    \(lastKey)_BODY: \'NOTIFICATIONS.\(keyPath).BODY\',")
            print("    \(lastKey)_TITLE: \'NOTIFICATIONS.\(keyPath).TITLE\',")
        } else {
            if let lastKey = lastKey {
                print("\n    // \(lastKey)\n")
            }
            for subKey in value.keys.sorted() {
                if !subKey.starts(with: "__") {
                    generateItems(keyPath: keyPath + (keyPath.isEmpty ? "" : ".") + subKey, lastKey: subKey, value: value[subKey])
                }
            }
        }
    } 
}