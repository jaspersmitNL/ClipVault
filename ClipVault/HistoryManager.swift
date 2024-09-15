//
//  HistoryManager.swift
//  ClipVault
//
//  Created by Jasper on 14/09/2024.
//

import Foundation

class HistoryManager: Observable {
    @Published var history: [String] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        startClipBoardMonitor()
    }
    
    private func startClipBoardMonitor() {
        Timer.publish(every: 1.0, on: .main, in: .common)
               .autoconnect()
               .sink { _ in
                   if let newString = NSPasteboard.general.string(forType: .string),
                      !self.clipboardHistory.contains(newString) {
                       self.clipboardHistory.insert(newString, at: 0)
                       if self.clipboardHistory.count > 20 {
                           self.clipboardHistory = Array(self.clipboardHistory.prefix(20))
                       }
                   }
               }
               .store(in: &cancellables)
    }

}
