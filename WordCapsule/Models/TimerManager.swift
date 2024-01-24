//
//  TimerManager.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 23.01.2024.
//

import SwiftUI
import Combine

class TimerManager: ObservableObject {
    @Published var count: Int
    private var timerCancellable: AnyCancellable?
    
    init(initialCount: Int) {
        self.count = initialCount
    }

    func startTimer(duration: Int) {
        count = duration
        stopTimer()
        
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if self.count > 0 {
                    self.count -= 1
                } else {
                    self.stopTimer()
                }
            }
    }

    func stopTimer() {
        timerCancellable?.cancel()
    }
}
