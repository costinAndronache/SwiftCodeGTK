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

func rebindMutable<T, U>(from: UnsafeMutablePointer<T>) -> UnsafeMutablePointer<U> {
  return UnsafeMutableRawPointer(from).bindMemory(to: U.self, capacity: MemoryLayout<U>.size)
}

func rebindMutable<T, U>(from: UnsafeMutablePointer<T>, to: U.Type) -> UnsafeMutablePointer<U> {
  return UnsafeMutableRawPointer(from).bindMemory(to: to, capacity: MemoryLayout<U>.size)
}

extension UnsafeMutablePointer {
  func rebound<U>(to: U.Type) -> UnsafeMutablePointer<U> {
      return UnsafeMutableRawPointer(self).bindMemory(to: to, capacity: MemoryLayout<U>.size)
  }
}