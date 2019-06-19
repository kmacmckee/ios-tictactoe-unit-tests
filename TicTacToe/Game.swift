//
//  Game.swift
//  TicTacToe
//
//  Created by Kobe McKee on 6/19/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Game {
    
    enum GameState {
        case active(GameBoard.Mark)
        case cat
        case won(GameBoard.Mark)
    }
    
    private(set) var board: GameBoard = GameBoard()
    private(set) var gameState = GameState.active(.x)
    
    internal var  activePlayer: GameBoard.Mark = GameBoard.Mark.x
    internal var gameIsOver: Bool = false
    internal var winningPlayer: GameBoard.Mark? = nil
    
    mutating internal func restart() {
        activePlayer = .x
        gameIsOver = false
        winningPlayer = nil
        gameState = .active(activePlayer)
        board = GameBoard()
    }
    
    
    mutating internal func makeMark(at coordinate: Coordinate) {
        
        guard case let GameState.active(player) = gameState else {
            NSLog("Game is over")
            return
        }
        
        do {
            try board.place(mark: player, on: coordinate)
            if game(board: board, isWonBy: player) {
                gameState = .won(player)
            } else if board.isFull {
                gameState = .cat
            } else {
                switchTurns()
            }
        } catch {
            NSLog("Illegal Move")
        }
        
    }
    
    
    mutating private func switchTurns() {
        switch activePlayer {
        case .x:
            activePlayer = .o
        case .o:
            activePlayer = .x
        }
        gameState = .active(activePlayer)
    }
    

    
}