//
//  Dangerfile.swift
//  DemoGitHubActions
//
//  Created by Boudhayan Biswas on 19/11/22.
//

import Foundation
import Danger

let danger = Danger()

// fileImport: DangerfileExtensions/ChangelogCheck.swift
checkChangelog()

if danger.git.createdFiles.count + danger.git.modifiedFiles.count - danger.git.deletedFiles.count > 300 {
    warn("Big PR, try to keep changes smaller if you can")
}

let swiftFilesWithCopyright = danger.git.createdFiles.filter {
    $0.fileType == .swift
        && danger.utils.readFile($0).contains("//  Created by")
}

if !swiftFilesWithCopyright.isEmpty {
    let files = swiftFilesWithCopyright.joined(separator: ", ")
    warn("In Danger JS we don't include copyright headers, found them in: \(files)")
}
