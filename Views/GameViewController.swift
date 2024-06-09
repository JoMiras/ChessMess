//
//  GameViewController.swift
//  ChessMess
//
//  Created by Jonah Mirasol on 2023/8/6.
//

import UIKit

class ViewController: UIViewController {
    var chessBoard: ChessBoard!
    var boardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chessBoard = ChessBoard()
        setupBoardView()
        displayChessBoard()
    }
    
    func setupBoardView() {
        let boardSize: CGFloat = min(view.frame.width, view.frame.height) - 40
        boardView = UIView(frame: CGRect(x: 20, y: 20, width: boardSize, height: boardSize))
        view.addSubview(boardView)
        
        let squareSize = boardSize / 8
        for row in 0..<8 {
            for col in 0..<8 {
                let square = UIView(frame: CGRect(x: CGFloat(col) * squareSize, y: CGFloat(row) * squareSize, width: squareSize, height: squareSize))
                square.backgroundColor = (row + col) % 2 == 0 ? .white : .gray
                boardView.addSubview(square)
            }
        }
    }
    
    func displayChessBoard() {
        let squareSize = boardView.frame.width / 8
        for row in 0..<8 {
            for col in 0..<8 {
                if let piece = chessBoard.squares[row][col] {
                    let pieceLabel = UILabel(frame: CGRect(x: CGFloat(col) * squareSize, y: CGFloat(row) * squareSize, width: squareSize, height: squareSize))
                    pieceLabel.textAlignment = .center
                    pieceLabel.font = UIFont.systemFont(ofSize: squareSize * 0.75)
                    
                    switch piece.type {
                    case .pawn:
                        pieceLabel.text = piece.color == .white ? "♙" : "♟"
                    case .rook:
                        pieceLabel.text = piece.color == .white ? "♖" : "♜"
                    case .knight:
                        pieceLabel.text = piece.color == .white ? "♘" : "♞"
                    case .bishop:
                        pieceLabel.text = piece.color == .white ? "♗" : "♝"
                    case .queen:
                        pieceLabel.text = piece.color == .white ? "♕" : "♛"
                    case .king:
                        pieceLabel.text = piece.color == .white ? "♔" : "♚"
                    }
                    
                    boardView.addSubview(pieceLabel)
                }
            }
        }
    }
}
