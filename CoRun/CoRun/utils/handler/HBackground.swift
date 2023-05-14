//
//  HBackground.swift
//  CoRun
//
//  Created by Marselus Richard on 14/05/23.
//

import BackgroundTasks



//let bgTaskIdentifier = "com.example.apple-samplecode.ColorFeed.refresh"
//BGTaskScheduler.shared.register(forTaskWithIdentifier: bgTaskIdentifier, using: nil) { task in
//   let request = BGAppRefreshTaskRequest(identifier: bgTaskIdentifier)
//   // Fetch no earlier than 15 minutes from now
//   request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60)
//        
//   do {
//      try BGTaskScheduler.shared.submit(request)
//   } catch {
//      print("Could not schedule app refresh: \(error)")
//   }
//                                                                                                                      
//   // Create an operation that performs the main part of the background task
//   let operation = RefreshAppContentsOperation()
//   
//   // Provide an expiration handler for the background task
//   // that cancels the operation
//   task.expirationHandler = {
//      operation.cancel()
//   }
//
//   // Inform the system that the background task is complete
//   // when the operation completes
//   operation.completionBlock = {
//      task.setTaskCompleted(success: !operation.isCancelled)
//   }
//
//   // Start the operation
//   operationQueue.addOperation(operation)
//}
