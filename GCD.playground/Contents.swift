//: Playground - noun: a place where people can play

import PlaygroundSupport
import UIKit

PlaygroundPage.current.needsIndefiniteExecution = true

func task1() {
    print("Task 1 started")
    // make task1 take longer than task2
    sleep(1)
    print("Task 1 finished")
}

func task2() {
    print("Task 2 started")
    print("Task 2 finished")
}


example(of: "Serial Queue") {
    let mySerialQueue = DispatchQueue(label: "com.crafttang.serialqueue")
    mySerialQueue.async {
        task1()
    }
    mySerialQueue.async {
        task2()
    }
}

sleep(2)

example(of: "Concurrent Queue") {
    let concurrentQueue = DispatchQueue(label: "com.crafttang.currentqueue", attributes: .concurrent)
    concurrentQueue.async {
        task1()
    }
    concurrentQueue.async {
        task2()
    }
}

sleep(2)


example(of: "DispatchGroup") {
    let workerQueue = DispatchQueue(label: "com.crafttang.dispatchgroup", attributes: .concurrent)
    let dispatchGroup = DispatchGroup()
    let numberArray: [(Any,Any)] = [("A", "B"), (2,3), ("C", "D"), (6,7), (8,9)]
    for inValue in numberArray {
        workerQueue.async(group: dispatchGroup) {
            let result = slowJoint(inValue)
            print("Result = \(result)")
        }
    }
    
    //dispatchGroup.wait(timeout: .now() + 0.1)
    let notifyQueue = DispatchQueue.global()
    dispatchGroup.notify(queue: notifyQueue) {
        print(" 😀 joint tasks finished")
    }
}
sleep(2)

example(of: "BlockOperation") {
    let blockOperation = BlockOperation()
    for i in 1...10 {
        blockOperation.addExecutionBlock {
            sleep(2)
            print("\(i) in blockOperation: \(Thread.current)")
        }
    }
    
    blockOperation.completionBlock =  {
        print("All block operation task finished: \(Thread.current)")
    }
    
    blockOperation.start()

}

sleep(2)


example(of: "Operation") {
    let inputImage = UIImage(named: "girlfriend.jpg")
    class BlurImageOperation: Operation {
        var inputImage: UIImage?
        var outputImage: UIImage?
        
        override func main() {
            outputImage = blurImage(image: inputImage)
        }
    }
    
    let operation = BlurImageOperation()
    operation.inputImage = inputImage

    operation.start()
    
    operation.outputImage
}


example(of: "OperationQueue") {
    let printerQueue = OperationQueue()
    printerQueue.maxConcurrentOperationCount = 2
    printerQueue.addOperation { print("厉"); sleep(3) }
    printerQueue.addOperation { print("害"); sleep(3) }
    printerQueue.addOperation { print("了"); sleep(3) }
    printerQueue.addOperation { print("我"); sleep(3) }
    printerQueue.addOperation { print("的"); sleep(3) }
    printerQueue.addOperation { print("哥"); sleep(3) }
    
    printerQueue.waitUntilAllOperationsAreFinished()
}

PlaygroundPage.current.finishExecution()

