func makeCString(from str: String) -> UnsafeMutablePointer<Int8> {
    let count = str.utf8.count + 1
    let result = UnsafeMutablePointer<Int8>.allocate(capacity: count)
    str.withCString { (baseAddress) in
        // func initialize(from: UnsafePointer<Pointee>, count: Int) 
        result.initialize(from: baseAddress, count: count)
    }
    return result
}

func commandLineToCArgs(commandLine: [String]) -> UnsafeMutablePointer<UnsafeMutablePointer<Int8>?> {
   let result = UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>.allocate(capacity: commandLine.count)
   for i in 0..<commandLine.count {
		result[i] = makeCString(from: commandLine[i])
   }
   return result
}

extension UnsafeMutablePointer {
  func rebound<U>(to: U.Type) -> UnsafeMutablePointer<U> {
    return UnsafeMutableRawPointer(self).bindMemory(to: to, capacity: MemoryLayout<U>.stride)
  }
  
  func rebound<U>() -> UnsafeMutablePointer<U> {
	return UnsafeMutableRawPointer(self).bindMemory(to: U.self, capacity: MemoryLayout<U>.stride)
  }
  
  var opaque: OpaquePointer {
	return OpaquePointer(self)
  }
}

extension Bool {
	func cast<T: BinaryInteger>() -> T {
		return self ? T(1) : T(0)
	}
}
