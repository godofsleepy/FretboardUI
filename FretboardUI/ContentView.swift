//
//  ContentView.swift
//  FretboardUI
//
//  Created by Rifat Khadafy on 07/07/24.
//

import SwiftUI

struct ContentView: View {
    @State var viewLoaded: Bool = false
    @State var offset: CGFloat = 122
    @State var contentWidth: CGFloat = 0
    @State var timer: Timer?
    @State var currentTime: Double = 0
    var speed: Double = 0.01
    private var scrollSpeed: CGFloat {
        300 / CGFloat(2 / speed)
    }
    
    let chords: [ChordModel] = [
        ChordModel(chord: ChordType.C, time: 8),
        ChordModel(chord: ChordType.C, time: 8.5),
        ChordModel(chord: ChordType.Am, time: 9),
        ChordModel(chord: ChordType.Am, time: 20.5),
        ChordModel(chord: ChordType.Dm, time: 26.5),
        ChordModel(chord: ChordType.G, time: 33),
        ChordModel(chord: ChordType.C, time: 39),
        ChordModel(chord: ChordType.Am, time: 45.5),
    ]
    
    private var getFretBoardLong: Int {
        return Int(ceil(Double(chords.last!.time) / 2.0 )) + 10
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    LazyHStack(spacing: 0) {
                        ForEach(2..<getFretBoardLong) { index in
                            FretView(index: index, chords: chords)
                        }
                        Spacer()
                    }
                    .background(
                        GeometryReader { proxy in
                            Color.clear.onAppear {
                                if !viewLoaded {
                                    contentWidth = proxy.size.width
                                    viewLoaded = true
                                    timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) {_ in
                                        self.currentTime += speed
                                        animator()
                                    }
                                }
                            }
                        }
                    )
                    .offset(x: offset)
                }
                .frame(width: geometry.size.width, alignment: .bottomLeading)
            }
        }.overlay{
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.accent)
                    .frame(width: 8, height: 270)
                    .offset(x: -300)
                    .shadow(color: .accent, radius: 10, x: 0, y: 0)
                    .blur(radius: 2)
            }
        }
        .background(.gray)
    }
    
    func animator() {
        if(currentTime > (chords.last?.time ?? 0 ) + 2 ){
            timer?.invalidate()
            return
        }
        offset -= scrollSpeed
        if offset <= -contentWidth {
            offset = 122
        }
    }
}

#Preview {
    ContentView()
}
