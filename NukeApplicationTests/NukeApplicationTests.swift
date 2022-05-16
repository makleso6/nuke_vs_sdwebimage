//
//  NukeApplicationTests.swift
//  NukeApplicationTests
//
//  Created by Maksim Kolesnik on 13.05.2022.
//

import XCTest

class NukeApplicationTests: XCTestCase {

    var imageData: Data!
    var webpData: Data!
    
//    lazy var imageData: Data = {
//
//        let big = Bundle.main.url(forResource: "image", withExtension: "jpg")!
//        return try! Data(contentsOf: big)
//
//    }()
//
//    lazy var webpData: Data = {
//        let encoder = WebPEncoder()
//        let image = UIImage(data: imageData)!
//        return try! encoder.encode(image, config: .preset(WebPEncoderConfig.Preset.default, quality: 1))
//    }()
    
    override func setUpWithError() throws {
        
        if imageData == nil {
            let big = Bundle.main.url(forResource: "image", withExtension: "jpg")!
            imageData = try Data(contentsOf: big)
        }

        if webpData == nil {
            let encoder = WebPEncoder()
            let image = UIImage(data: imageData)!
            webpData = try encoder.encode(image, config: .preset(WebPEncoderConfig.Preset.default, quality: 1))
        }
        bytes(in: imageData)
        bytes(in: webpData)


    }
    
    func bytes(in data: Data) {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useKB] // optional: restricts the units to MB only
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: Int64(data.count))
        print("formatted result: \(string)")

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

 
//    func testJPG() throws {
//        print("start")
//
//        measure {
//            print("[TEST] START")
//            for _ in 1..<10_000 {
//                _ = UIImage(data: imageData)
//            }
//            print("[TEST] END")
//
//        }
//    }
    
    func testWebP() throws {
        
        measure {
            print("[TEST] START")

            let decoder = WebPDecoder()

            for _ in 1..<100_000 {
                if let image = UIImage(data: webpData) {
                } else {
                    print("failed image created")
                }

//                do {
//                    _ = try decoder.decode(toUImage: webpData, options: .init())
//                } catch {
//                    print("[TEST]", error)
//                }
            }
            print("[TEST] END")

        }
    }

}
