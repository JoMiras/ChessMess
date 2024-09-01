//
//  ChessPiece.swift
//  ChessMess
//
//  Created by Jonah Mirasol on 2024/8/31.
//

class ChessPiece {
    let isWhite: Bool
    let symbol: String
    
    init(isWhite: Bool, symbol: String) {
        self.isWhite = isWhite
        self.symbol = symbol
    }
    
    func canMove(from: (Int, Int), to: (Int, Int), board: Board) -> Bool {
        return false
    }
}

class Pawn: ChessPiece {
    init(isWhite: Bool) {
        super.init(isWhite: isWhite, symbol: isWhite ? "P" : "p")
    }
    
    override func canMove(from: (Int, Int), to: (Int, Int), board: Board) -> Bool {
        let direction = isWhite ? -1 : 1
        if from.1 == to.1 && to.0 == from.0 + direction && board,.board[to.0][to.1] == nil {
            return true
        }
        return false
    }
}

class Rook: ChessPiece {
    init(isWhite: Bool) {
        super.init(isWhite: isWhite, symbol: isWhite ? "R" : "r")
        
    }
    override func canMove(from: (Int, Int), to: (Int, Int), board: Board) -> Bool {
        return from.0 == to.0 || from.1 == to.1
    }
}

class Queen: ChessPiece {
    init(isWhite: Bool) {
        super.init(isWhite: isWhite, symbol: isWhite ? "Q" : "q")
    }
    override func canMove(from: (Int, Int), to: (Int, Int), board: Board) -> Bool {
        return from.0 == to.0 || from.1 == to.1
    }
}

class Knight: ChessPiece {
    init(isWhite: Bool) {
        super.init(isWhite: isWhite, symbol: isWhite ? "KN" : "kn" )
    }
    override func canMove(from: (Int, Int), to: (Int, Int), board: Board) -> Bool {
        return from.0 == to.0 || from.1 == to.1
    }
}


class King: ChessPiece {
    init(isWhite: Bool) {
        super.init(isWhite: isWhite, symbol: isWhite ? "K" : "k" )
    }
    override func canMove(from: (Int, Int), to: (Int, Int), board: Board) -> Bool {
        return from.0 == to.0 || from.1 == to.1
    }
}

class Bishop: ChessPiece {
    init(isWhite: Bool) {
        super.init(isWhite: isWhite, symbol: isWhite ? "B" : "b" )
    }
    override func canMove(from: (Int, Int), to: (Int, Int), board: Board) -> Bool {
        return from.0 == to.0 || from.1 == to.1
    }
}
