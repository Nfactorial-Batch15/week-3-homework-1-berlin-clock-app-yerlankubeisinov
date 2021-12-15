//
//  ContentView.swift
//  berlin_clock_ui
//
//  Created by Yerlan Kubeisinov on 14.12.2021.
//

import SwiftUI

struct ContentView: View {
    var rectangleWidth: CGFloat = 21.0
    var rectangleHeight: CGFloat = 32.0
    var rectangleCornerRadious: CGFloat = 4.0
    var cubeWidth: CGFloat = 74.0
    var cubeHeight: CGFloat = 32.0
    var cubeCornerRadious: CGFloat = 4.0
    
    @State var berlinDate: [String] = []
    @State var normalClock: String = ""
    @State var currentDate: Date = Date()
    
    
    var body: some View {
        VStack {
            if(berlinDate.count>0) {

                Text("Time is \(normalClock)")
                    .padding(.top)
                HStack {
                    Circle()
                        .fill(berlinDate[0] == "Y" ? Color.yellow : Color(#colorLiteral(red: 255/255, green: 204/255, blue: 0, alpha: 1)))
                        .frame(width: 56, height: 56)
                }
                HStack {
                    ForEach((1..<5)) {i in
                        RoundedRectangle(cornerRadius: cubeCornerRadious, style: .continuous)
                            .fill(berlinDate[i] == "R" ? Color.red : Color(#colorLiteral(red: 1, green: 137/255, blue: 131/255, alpha: 1)))
                            .frame(width: cubeWidth, height: cubeHeight)
                    }
                }
                HStack {
                    ForEach((5..<9)) {i in
                        RoundedRectangle(cornerRadius: cubeCornerRadious, style: .continuous)
                            .fill(berlinDate[i] == "R" ? Color.red : Color(#colorLiteral(red: 1, green: 137/255, blue: 131/255, alpha: 1)))
                            .frame(width: cubeWidth, height: cubeHeight)
                    }
                }
                HStack {
                    Group {
                        ForEach((9..<20)) {i in
                            RoundedRectangle(cornerRadius: rectangleCornerRadious, style: .continuous)
                                .fill(berlinDate[i] == "Y" ? Color.yellow : (berlinDate[i] == "R" ? Color.red : Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))))
                                .frame(width: rectangleWidth, height: rectangleHeight)
                        }
                    }
                }
                HStack {
                    ForEach((20..<24)) {i in
                        RoundedRectangle(cornerRadius: cubeCornerRadious, style: .continuous)
                            .fill(berlinDate[i] == "Y" ? Color.yellow : Color(#colorLiteral(red: 1, green: 224/255, blue: 102/255, alpha: 0.5)))
                            .frame(width: cubeWidth, height: cubeHeight)
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.init(red: 118/255, green: 118/255, blue: 128/255)).opacity(0.12)
                        .frame(width: 358, height: 54)
                        .padding()
                    HStack {
                        Spacer()
                        Text("Insert Time")
                            .fontWeight(.regular)
                            .font(.system(size: 18))
                            .padding(.all, 16)
                        Spacer()
                        pickerdate(currentDate: $currentDate)
                            .padding()
                        Spacer()
                        
                    }
                    
                }
                
                Spacer()
                
                
                
            }
        }
        .onAppear {
            displayDate()
        }
    }
    
//
    func displayDate() {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
            
            let date = currentDate
            let calendar = Calendar.current
            let seconds = calendar.component(.second, from: date)
            let minutes = calendar.component(.minute, from: date)
            let hours = calendar.component(.hour, from: date)
            let berlinClock = BerlinClock()
            normalClock = "\(hours):\(minutes):\(seconds)"
            berlinDate = berlinClock.rawBerlinClock(hours, minutes, seconds).map{String($0)}
            print(berlinClock.berlinClock(hours, minutes, seconds))
        }).fire()
    }
    
}

struct pickerdate: View {
    @Binding var currentDate: Date
    
    var body: some View {
        DatePicker("", selection: $currentDate, displayedComponents:
                        .hourAndMinute)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
