//
//  Board.swift
//  ChessMess
//
//  Created by Jonah Mirasol on 2024/8/21.
//


class Board {
    var board: [[ChessPiece]]
    
    init() {
        self.board = Array (repeating: Array( repeating: nil, count: 8), count: 8)
    }
    
    func setupBoard() {
        // Piece placement for either player
        for i in 0..<8 {
            board[1][i] = Pawn(isWhite: false)
            board[6][i] = Pawn(isWhite: true)
        }
        board[0][0] = Rook(isWhite: false)
        board[0][7] = Rook(isWhite: false)
        board[7][0] = Rook(isWhite: true)
        board[7][7] = Rook(isWhite: true)
        
        board[0][1] = Knight(isWhite: false)
        board[0][6] = Knight(isWhite: false)
        board[7][1] = Knight(isWhite: true)
        board[7][6] = Knight(isWhite: true)
        
        board[0][2] = Bishop(isWhite: false)
        board[0][5] = Bishop(isWhite: false)
        board[7][2] = Bishop(isWhite: true)
        board[7][5] = Bishop(isWhite: true)
        
        board[0][3] = Queen(isWhite: false)
        board[0][4] = King(isWhite: false)
        board[7][3] = Queen(isWhite: true)
        board[7][4] = King(isWhite: true)

    }
    func printBoard() {
        for row in board {
            for piece in row {
                if let piece = piece {
                    print(piece.symbol, terminator: " ")
                } else {
                    print (".", terminator: " ")
                }
            }
            print ()
        }
    }
}
// Line 46 and 13?
