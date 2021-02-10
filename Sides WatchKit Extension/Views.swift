//
//  Components.swift
//  Sides WatchKit Extension
//
//  Created by Fabián Cañas on 2/10/21.
//

import SwiftUI

struct SideView: View {
    
    @AppStorage("side") var side: Side = .left
    
    var body: some View {
        Text(side.rawValue).font(Font.largeTitle)
            .padding()
    }
}

struct IntervalView: View {
    
    @AppStorage("time") var time: String = ""
    @State var referenceDate = Date()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Group {
            if let loggedDate = formatter.date(from: self.time) {
                let minutes = Int(referenceDate.timeIntervalSince(loggedDate) / 60)
                Text("\(minutes / 60):\(String(format: "%02d", minutes % 60))")
                    .font(Font.subheadline.monospacedDigit())
            } else {
                Text("-")
            }
        }.onReceive(timer, perform: { _ in
            referenceDate = Date()
        })
    }
}

struct ComplicationView: View {
    
    @State var referenceDate: Date = Date()
    
    var body: some View {
        HStack {
            SideView().padding()
            Divider().padding()
            IntervalView(referenceDate: referenceDate).padding()
        }.padding()
    }
}
