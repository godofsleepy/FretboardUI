//
//  ChordModel.swift
//  FretboardUI
//
//  Created by Rifat Khadafy on 07/07/24.
//

import Foundation

enum ChordType: String {
    case D = "D"
    case E = "E"
    case A = "A"
    case G = "G"
    case C = "C"
    case Dm = "Dm"
    case Am = "Am"
}

struct ChordModel: Identifiable {
    let id = UUID()
    let chord: ChordType
    let time: TimeInterval
}
