//
//  Game.swift
//  ChessMess
//
//  Created by Jonah Mirasol on 2024/8/31.
//

class Game {
    var board: Board
    var isWhiteTurn: Bool
    
    init() {
        self.board = Board()
        self.isWhiteTurn = true
    }
    
    func makeMove(from: (Int, Int), to: (Int, Int)) -> Bool {
        guard let piece = board.board[from.0][from.1] else { return false }
        guard piece.isWhite == isWhiteTurn else { return false }
        
        if piece.canMove(from: from, to: to, board: board) {
            board.board[to.0][to.1] = piece
            board.board[from.0][from.1] = nil
            isWhiteTurn.toggle()
            
            return true
        }
        return false
    }
    func play() {
        while true {
            board.printBoard()
            print(isWhiteTurn ? "White's turn" : "Black's turn")
            
            // Wait for move input
            print("Enter your move (e.g., 'e2 e4') :")
            if let input = readLine() {
                let parts = input.split(separator: " " )
                if parts.count == 2,
                   let from = convertPosition(String(parts[0])),
                   let to = convertPosition(String(parts[1])),
                   makeMove(from: from, to: to ){
                    continue
                } else {
                    print("Invalid move!")
                }
            }
        }
    }
    
    func convertPosition(_ position: String) -> (Int, Int)? {
        guard position.count == 2 else { return nil }
        let file = position.first!.asciiValue! - 97
        guard let rank = Int(String(position.last!)) else { return nil}
        return ( 8 - rank, Int (file))
    }
}

//Review error issues on line 18 + 23
