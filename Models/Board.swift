//
//  Board.swift
//  ChessMess
//
//  Created by Jonah Mirasol on 2023/8/6.
//

enum PieceType: String {
    case pawn
    case rook
    case knight
    case bishop
    case king
    case queen
    case additionalPiece
    
    var value: Int {
        switch self {
        case .pawn:
            return 1
        case .knight, .bishop:
            return 3
        case .rook:
            return 5
        case .queen:
            return 9
        case .king:
            return 0
        case .additionalPiece:
            return 0
        }
    }
}

enum Color: String {
    case black
    case white
    
    var other: Color {
        return self == .black ? .white : .black
    }
}

struct Piece: Equatable, ExpressibleByStringLiteral {
    let id: String
    var type: PieceType
    let color: Color
    
    init(stringLiteral: String) {
        id = stringLiteral
        let chars = Array(stringLiteral)
        precondition(chars.count == 3)
        switch chars[0] {
        case "B": color = .black
        case "W": color = .white
        default:
            preconditionFailure()
        }
        switch chars[1] {
        case "P": type = .pawn
        case "N": type = .knight
        case "R": type = .rook
        case "B": type = .bishop
        case "K": type = .king
        case "Q": type = .queen
        default:
            preconditionFailure()
        }
    }
}

struct Delta: Hashable {
    var x, y: Int
}

struct Position: Hashable {
    var x, y: Int
}

struct Board: Equatable {
    private(set) var pieces: [[Piece?]]
}

extension Board {
    static let allPositions = (0 ..< 8).flatMap { y in
        (0 ..< 8).map { Position(x: $0, y: y) }
    }
    
    var allPositions: [Position] { return Self.allPositions }
    
    var allPieces: [(position: Position, piece: Piece)] {
        return allPositions.compactMap { position in
            pieces[position.y][position.x].map { (position, $0) }
        }
    }
    
    init() {
        pieces = [
            ["BR0", "BN1", "BB2", "BQ3", "BK4", "BB5", "BN6", "BR7"],
            ["BP0", "BP1", "BP2", "BP3", "BP4", "BP5", "BP6", "BP7"],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            ["WP0", "WP1", "WP2", "WP3", "WP4", "WP5", "WP6", "WP7"],
            ["WR0", "WN1", "WB2", "WQ3", "WK4", "WB5", "WN6", "WR7"]
        ]
    }
}
