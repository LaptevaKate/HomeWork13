//
//  ImageSavingSettings.swift
//  HomeWork13
//
//  Created by Екатерина Лаптева on 1.05.22.
//

import UIKit


class ImageSavingSettings {
    static func add (_ image: UIImage?) {
        guard let image = image,
              let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return }
        let fileName = UUID().uuidString
        let fileURL = URL(fileURLWithPath: fileName, relativeTo: directoryURL).appendingPathExtension("png")
        guard let data = image.pngData() else { return }
        do {
            try data.write(to: fileURL)
            addFileName(fileName)
        } catch {
            return
        }
    }
    
    static func getAllImages() -> [UIImage?] {
        var images: [UIImage?] = []
        let allNames = getFileNames()
        for filename in allNames {
            guard let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { continue }
            let fileURL = URL(fileURLWithPath: filename, relativeTo: directoryURL).appendingPathExtension("png")
            guard let savedData = try? Data(contentsOf: fileURL) else { continue }
            images.append(UIImage(data: savedData))
        }
        return images
    }
    
    private static func addFileName(_ fileName: String) {
      let newArray = getFileNames() + [fileName]
        setFileNames(newArray)
    }
    
    private static func getFileNames() -> [String] {
        guard let filenames = UserDefaults.standard.array(forKey: UserKeys.filenames.rawValue) as? [String] else { return [] }
        return filenames
    }
    
    private static func setFileNames(_ filenames: [String]) {
        UserDefaults.standard.set(filenames, forKey: UserKeys.filenames.rawValue)
    }
}

private enum UserKeys: String {
    case filenames
}
