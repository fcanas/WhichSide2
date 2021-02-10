//
//  ContentView.swift
//  Sides WatchKit Extension
//
//  Created by Fabián Cañas on 2/2/21.
//

import SwiftUI
import ClockKit

let formatter = ISO8601DateFormatter()

enum Side: String, Codable {
    case left = "L"
    case right = "R"
}

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

struct ContentView: View {
    
    @AppStorage("side") var side: Side = .left
    @AppStorage("time") var time: String = ""
    
    var body: some View {
        VStack {
            VStack {
                SideView()
                IntervalView()
            }
            Divider()
                .padding()
            HStack {
                Button {
                    self.side = .left
                    self.time = formatter.string(from: Date())
                    let complicationServer = CLKComplicationServer.sharedInstance()
                    complicationServer.activeComplications?.forEach({ (complication) in
                        complicationServer.reloadTimeline(for: complication)
                    })
                } label: {
                    Text("L").font(.largeTitle)
                        .padding()
                }
                Button {
                    self.side = .right
                    self.time = formatter.string(from: Date())
                    let complicationServer = CLKComplicationServer.sharedInstance()
                    complicationServer.activeComplications?.forEach({ (complication) in
                        complicationServer.reloadTimeline(for: complication)
                    })
                } label: {
                    Text("R").font(.largeTitle)
                        .padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
