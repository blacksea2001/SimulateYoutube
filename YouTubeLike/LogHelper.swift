//
//  LogHelper.swift
//  YouTubeLike
//
//  Created by Wesley on 2017/5/28.
//  Copyright © 2017年 WesleyChen. All rights reserved.
//

import Foundation

enum LogLevel: Int {
    case verbose = 1
    case debug = 2
    case info = 3
    case warning = 4
    case error = 5
}

extension LogLevel: Comparable {}

func <(lhs: LogLevel, rhs: LogLevel) -> Bool {
    return lhs.rawValue < rhs.rawValue
}

protocol Logger {
    func writeLogEntry(
        logLevel: LogLevel,
        _ message: @autoclosure () -> String,
        file: StaticString,
        line: Int,
        function: StaticString)
}

extension Logger {
    func log(logLevel: LogLevel,
             _ message: @autoclosure () -> String,
             file: StaticString = #file,
             line: Int = #line,
             function: StaticString = #function)
    {
        writeLogEntry(logLevel: logLevel,
                      message,
                      file: file,
                      line: line,
                      function: function)
    }
}

struct PrintLogger {
    let minimumLogLevel: LogLevel
}

extension PrintLogger: Logger {
    internal func writeLogEntry(logLevel: LogLevel,
                                _ message: @autoclosure () -> String,
                                file: StaticString,
                                line: Int,
                                function: StaticString)
    {
        if logLevel >= minimumLogLevel {
            print("\(logLevel) – \(file):\(line) – \(function) – \(message())\n")
        }
    }
}
