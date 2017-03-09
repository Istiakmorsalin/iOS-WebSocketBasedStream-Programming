//
//  StreamUtil
//  SocketProgrammingExample
//
//  Created by Slbd on 3/9/17.
//  Copyright © 2017 Slbd. All rights reserved.
//

import Foundation

class Connection: NSObject, NSStreamDelegate {
    var host:String?
    var port:Int?
    var inputStream: NSInputStream?
    var outputStream: NSOutputStream?
    
    func connect(host: String, port: Int) {
        
        self.host = host
        self.port = port
        
        NSStream.getStreamsToHostWithName(host, port: port, inputStream: &inputStream, outputStream: &outputStream)
        
        if inputStream != nil && outputStream != nil {
            
            // Set delegate
            inputStream!.delegate = self
            outputStream!.delegate = self
            
            // Schedule
            inputStream!.scheduleInRunLoop(.mainRunLoop(), forMode: NSDefaultRunLoopMode)
            outputStream!.scheduleInRunLoop(.mainRunLoop(), forMode: NSDefaultRunLoopMode)
            
            print("Start open()")
            
            // Open!
            inputStream!.open()
            outputStream!.open()
        }
    }
    
    func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
        if aStream === inputStream {
            switch eventCode {
            case NSStreamEvent.ErrorOccurred:
                print("input: ErrorOccurred: \(aStream.streamError?.description)")
            case NSStreamEvent.OpenCompleted:
                print("input: OpenCompleted")
            case NSStreamEvent.HasBytesAvailable:
                print("input: HasBytesAvailable")
                // Here you can `read()` from `inputStream`
            default:
                break
            }
        }
        else if aStream === outputStream {
            switch eventCode {
            case NSStreamEvent.ErrorOccurred:
                print("output: ErrorOccurred: \(aStream.streamError?.description)")
            case NSStreamEvent.OpenCompleted:
                print("output: OpenCompleted")
            case NSStreamEvent.HasSpaceAvailable:
                print("output: HasSpaceAvailable")
                self.writeToOutputStream()
                
            default:
                break
            }
        }
    }
    
    //For reading from File
    func setUpStreamForFile(path: String) {
        // iStream is NSInputStream instance variable
        let iStream = NSInputStream(fileAtPath: path)
        iStream!.delegate = self
        iStream!.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        iStream!.open()
    }
    
    //for writing to network outputStream
    func writeToOutputStream () {
        let myString = "Hello world!"
        let data: NSData = myString.dataUsingEncoding(NSUTF8StringEncoding)!
        var buffer = [UInt8](count:data.length, repeatedValue:0)
        outputStream?.write(&buffer, maxLength: data.length)
    }
    
}