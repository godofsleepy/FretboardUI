//
//  GuitarComponent.swift
//  FretboardUI
//
//  Created by Rifat Khadafy on 07/07/24.
//

import SwiftUI

struct FretView: View {
    var index: Int
    var chords: [ChordModel]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<6) { string in
                StringView(
                    thickness: CGFloat(1 + Float(string) * 0.5)
                )
            }
        }
        .background(.black)
        .frame(width: 300)
        .overlay {
            ChordOverlay(index: index, chords: chords)
        }
    }
}

struct ChordOverlay: View {
    var index: Int
    var chords: [ChordModel]
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(.white)
                .frame(width: 0.5, height: 250)
            ZStack{
                ForEach(getChords(index: index)) { chord in
                    ChordView(chord: chord)
                }
            }
            Spacer()
        }
    }
    
    func getChords(index: Int) -> [ChordModel] {
        let startTime = Double((index - 2) * 2)
        let endTime = startTime + 2
        return chords.filter { startTime <= $0.time && $0.time < endTime }
    }
}

struct ChordView: View {
    var chord: ChordModel
    
    var body: some View {
        VStack{
            Rectangle()
                .fill(Color(.accent))
                .frame(width: 64, height: CGFloat(getChordHeight()), alignment: .top)
                .cornerRadius(10)
                .overlay {
                    VStack(alignment: .center){
                        Text("\(chord.chord.rawValue)")
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                    }
                }
        }
        .frame(height: 210, alignment: .top)
        .offset(x:CGFloat(getChordOffset()))
    }
    
    
    func getChordHeight() -> Int {
        switch(chord.chord){
        case .D:
            130
        case .E:
            210
        case .A:
            130
        case .G:
            210
        case .C:
            170
        case .Dm:
            130
        case .Am:
            170
        }
    }
    
    func getChordOffset() -> Int {
        let time = chord.time.truncatingRemainder(dividingBy: 2)
        if time == 0 {
            return 0
        } else if time == 0.5 {
            return 72
        } else if time == 1 {
            return 145
        } else if time == 1.5 {
            return 220
        } else {
            return 0
        }
    }
}

struct StringView: View {
    var thickness: CGFloat
    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .frame(height: thickness)
            .padding(.vertical, 17)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

