import Foundation 

protocol SwiftCompilerFlags {
     func buildSwiftFlags() -> String
}

struct DefaultSDKRootFlags: SwiftCompilerFlags {
	
	func buildSwiftFlags() -> String {
		let SDKROOT = #"C:\Library\Developer\Platforms\Windows.platform\Developer\SDKs\Windows.sdk"#
		let SWIFTFLAGS = #"-sdk \#(SDKROOT) -I \#(SDKROOT)/usr/lib/swift -L \#(SDKROOT)/usr/lib/swift/windows"#
		return SWIFTFLAGS
	}
}

struct CompilerOptions {
	let outputFilePath: String
	let inputSourceFiles: [String]
	let inputRootDirectory: String
}

struct Compiler {

	func compileWith(options: CompilerOptions) {
		let fileList = options.inputSourceFiles.reduce("", {
			a, b in 
			return a + " " + b
		})
		let allFlags = "\(DefaultSDKRootFlags().buildSwiftFlags()) \(fileList)"
		system("cd \(options.inputRootDirectory) && swiftc -v -o \(options.outputFilePath) \(allFlags)")
	}
}