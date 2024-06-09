//
//  ChessBoard.swift
//  ChessMess
//
//  Created by Jonah Mirasol on 2023/8/6.
//

import Foundation

enum PieceType {
    case pawn, knight, bishop, rook, queen, king
}

enum PieceColor {
    case white, black
}

struct Piece {
    var type: PieceType
    var color: PieceColor
}

class ChessBoard {
    var squares: [[Piece?]] = Array(repeating: Array(repeating: nil, count: 8), count: 8)
    
    init() {
        setupBoard()
    }

    func setupBoard() {
        // Setup pawns
        for i in 0..<8 {
            squares[1][i] = Piece(type: .pawn, color: .white)
            squares[6][i] = Piece(type: .pawn, color: .black)
        }

        // Setup rooks
        squares[0][0] = Piece(type: .rook, color: .white)
        squares[0][7] = Piece(type: .rook, color: .white)
        squares[7][0] = Piece(type: .rook, color: .black)
        squares[7][7] = Piece(type: .rook, color: .black)

        // Setup knights
        squares[0][1] = Piece(type: .knight, color: .white)
        squares[0][6] = Piece(type: .knight, color: .white)
        squares[7][1] = Piece(type: .knight, color: .black)
        squares[7][6] = Piece(type: .knight, color: .black)

        // Setup bishops
        squares[0][2] = Piece(type: .bishop, color: .white)
        squares[0][5] = Piece(type: .bishop, color: .white)
        squares[7][2] = Piece(type: .bishop, color: .black)
        squares[7][5] = Piece(type: .bishop, color: .black)

        // Setup queens
        squares[0][3] = Piece(type: .queen, color: .white)
        squares[7][3] = Piece(type: .queen, color: .black)

        // Setup kings
        squares[0][4] = Piece(type: .king, color: .white)
        squares[7][4] = Piece(type: .king, color: .black)
    }

    // Check if pawns form a triangle
    func isPawnTriangle(at position: (Int, Int)) -> Bool {
        let (row, col) = position
        if row < 1 || row > 6 || col < 1 || col > 6 {
            return false
        }
        let piece = squares[row][col]
        return piece?.type == .pawn &&
            squares[row-1][col-1]?.type == .pawn &&
            squares[row-1][col+1]?.type == .pawn
    }
    
    // Move triangle of pawns
    func moveTriangle(from start: (Int, Int), to end: (Int, Int)) {
        guard isPawnTriangle(at: start) else { return }
        
        let (startRow, startCol) = start
        let (endRow, endCol) = end
        
        squares[endRow][endCol] = squares[startRow][startCol]
        squares[endRow-1][endCol-1] = squares[startRow-1][startCol-1]
        squares[endRow-1][endCol+1] = squares[startRow-1][startCol+1]
        
        squares[startRow][startCol] = nil
        squares[startRow-1][startCol-1] = nil
        squares[startRow-1][startCol+1] = nil
    }

    // Check if stonewall move is valid
    func isStonewallMove(for piece: Piece, from start: (Int, Int), to end: (Int, Int)) -> Bool {
        guard piece.type == .pawn else { return false }
        let (startRow, startCol) = start
        let (endRow, endCol) = end
        
        if (startCol == 0 || startCol == 7) && (endRow == startRow + 3) {
            return squares[endRow][endCol] == nil
        }
        
        return false
    }
    
    // Capture royal pawn mechanic
    func canCaptureRoyalPawn(at position: (Int, Int)) -> Bool {
        let (row, col) = position
        let piece = squares[row][col]
        return piece?.type == .pawn && (col == 3 || col == 4)
    }
    
    // Move knight linearly
    func moveKnightLinearly(from start: (Int, Int), to end: (Int, Int)) {
        guard let piece = squares[start.0][start.1], piece.type == .knight else { return }
        let (startRow, startCol) = start
        let (endRow, endCol) = end
        
        if abs(endRow - startRow) <= 3 && startCol == endCol {
            if squares[endRow][endCol] == nil || canCaptureRoyalPawn(at: end) {
                squares[endRow][endCol] = piece
                squares[startRow][startCol] = nil
            }
        }
    }
    
    // Check if pawn is buffed
    func isPawnBuffed(at position: (Int, Int)) -> Bool {
        let (row, col) = position
        if row < 1 || row > 6 || col < 1 || col > 6 {
            return false
        }
        let piece = squares[row][col]
        return piece?.type == .pawn &&
            squares[row+1][col-1]?.type == .pawn &&
            squares[row+1][col+1]?.type == .pawn
    }
    
    // Move buffed pawns
    func moveBuffedPawns(from start: (Int, Int), to end: (Int, Int)) {
        guard isPawnBuffed(at: start) else { return }
        
        let (startRow, startCol) = start
        let (endRow, endCol) = end
        
        squares[endRow][endCol] = squares[startRow][startCol]
        squares[endRow+1][endCol-1] = squares[startRow+1][startCol-1]
        squares[endRow+1][endCol+1] = squares[startRow+1][startCol+1]
        
        squares[startRow][startCol] = nil
        squares[startRow+1][startCol-1] = nil
        squares[startRow+1][startCol+1] = nil
    }
    
    func printBoard() {
        for row in squares {
            var rowString = ""
            for square in row {
                if let piece = square {
                    switch piece.type {
                    case .pawn:
                        rowString += piece.color == .white ? "♙ " : "♟ "
                    case .rook:
                        rowString += piece.color == .white ? "♖ " : "♜ "
                    case .knight:
                        rowString += piece.color == .white ? "♘ " : "♞ "
                    case .bishop:
                        rowString += piece.color == .white ? "♗ " : "♝ "
                    case .queen:
                        rowString += piece.color == .white ? "♕ " : "♛ "
                    case .king:
                        rowString += piece.color == .white ? "♔ " : "♚ "
                    }
                } else {
                    rowString += "· "
                }
            }
            print(rowString)
        }
    }
}
