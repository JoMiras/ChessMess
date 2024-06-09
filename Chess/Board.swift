//
//  Board.swift
//  ChessMess
//
//  Created by Jonah Mirasol on 2024/8/21.
//


enum PieceType: String, Codable {
    case pawn
    case rook
    case bishop
    case knight
    case king
    case queen
    
    var value: Int {
        switch self {
        case .king:
            return 0
        case .queen:
            return 9
        case .pawn:
            return 1
        case .knight, .bishop:
            return 3
        case .rook:
            return 5
        }
    }
}

enum Color: String, Codable {
    case black
    case white
    
    var other: Color {
        self == .black ? .white : . black
    }
}

struct Piece: Equatable, Codable, ExpressibleByStringLiteral {
    let id: stringLiteral
    var type: PieceType
    let color: Color
    init(stringLiteral: String) {
        id = stringLiteral
        let chars = Array(stringLiteral)
    }
}
