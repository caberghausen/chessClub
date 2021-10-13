//
//  Board.swift
//  Chess Club
//
//  Created by Charles Berghausen on 7/27/21.
//

import Foundation
import UIKit
import AudioToolbox

//variables that both Board and Piece need to access
var boardWidth: CGFloat = 0.0
var pieces = [Piece]()
var whoseTurn = colors.White
var whiteMove: SystemSoundID = 0
var takeNoise: SystemSoundID = 1
var castle: SystemSoundID = 2
var checkNoise: SystemSoundID = 3
var checkmateNoise: SystemSoundID = 4
var gameStartNoise: SystemSoundID = 5
var whiteInCheck = false
var blackInCheck = false
var viewController = UIViewController()

class Board: UIView {
    var movingPiece: Piece?
    let path = UIBezierPath()
    var highlightedRectX: CGFloat = 1
    var highlightedRectY: CGFloat = 1
    let myGreenColor = UIColor(red: 0.357, green: 0.667, blue: 0.357, alpha: 0.8)
    var highlightedRectColor = UIColor.clear
    
    //sets the board for a game to be played. Essentially an init() called from BoardViewController
    func setBoard(controller: UIViewController) {
        boardWidth = UIScreen.main.bounds.size.width
        viewController = controller
        registerSounds()
        addPiece(type: .Pawn, color: .Black, x: 1, y: 2)
        addPiece(type: .Pawn, color: .Black, x: 2, y: 2)
        addPiece(type: .Pawn, color: .Black, x: 3, y: 2)
        addPiece(type: .Pawn, color: .Black, x: 4, y: 2)
        addPiece(type: .Pawn, color: .Black, x: 5, y: 2)
        addPiece(type: .Pawn, color: .Black, x: 6, y: 2)
        addPiece(type: .Pawn, color: .Black, x: 7, y: 2)
        addPiece(type: .Pawn, color: .Black, x: 8, y: 2)
        addPiece(type: .Rook, color: .Black, x: 1, y: 1)
        addPiece(type: .Knight, color: .Black, x: 2, y: 1)
        addPiece(type: .Bishop, color: .Black, x: 3, y: 1)
        addPiece(type: .Queen, color: .Black, x: 4, y: 1)
        addPiece(type: .King, color: .Black, x: 5, y: 1)
        addPiece(type: .Bishop, color: .Black, x: 6, y: 1)
        addPiece(type: .Knight, color: .Black, x: 7, y: 1)
        addPiece(type: .Rook, color: .Black, x: 8, y: 1)
        addPiece(type: .Pawn, color: .White, x: 1, y: 7)
        addPiece(type: .Pawn, color: .White, x: 2, y: 7)
        addPiece(type: .Pawn, color: .White, x: 3, y: 7)
        addPiece(type: .Pawn, color: .White, x: 4, y: 7)
        addPiece(type: .Pawn, color: .White, x: 5, y: 7)
        addPiece(type: .Pawn, color: .White, x: 6, y: 7)
        addPiece(type: .Pawn, color: .White, x: 7, y: 7)
        addPiece(type: .Pawn, color: .White, x: 8, y: 7)
        addPiece(type: .Rook, color: .White, x: 1, y: 8)
        addPiece(type: .Knight, color: .White, x: 2, y: 8)
        addPiece(type: .Bishop, color: .White, x: 3, y: 8)
        addPiece(type: .Queen, color: .White, x: 4, y: 8)
        addPiece(type: .King, color: .White, x: 5, y: 8)
        addPiece(type: .Bishop, color: .White, x: 6, y: 8)
        addPiece(type: .Knight, color: .White, x: 7, y: 8)
        addPiece(type: .Rook, color: .White, x: 8, y: 8)
        
//        addPiece(type: .King, color: .Black, x: 8, y: 1)
//        addPiece(type: .Knight, color: .Black, x: 7, y: 1)
//        addPiece(type: .Pawn, color: .Black, x: 7, y: 2)
//        addPiece(type: .Pawn, color: .Black, x: 8, y: 2)
//        addPiece(type: .Queen, color: .Black, x: 7, y: 3)
//        addPiece(type: .Knight, color: .White, x: 7, y: 4)
//        addPiece(type: .Queen, color: .White, x: 8, y: 5)
//        addPiece(type: .Pawn, color: .White, x: 7, y: 6)
//        addPiece(type: .King, color: .White, x: 7, y: 7)
        AudioServicesPlaySystemSound(gameStartNoise)
    }
    
    func clearBoard() {
        whoseTurn = .White
        pieces.removeAll()
    }
    
    func registerSounds() {
        guard let whiteMoveURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "whiteMove" as CFString, "m4a" as CFString, nil) else {
            print("error in sound file path for moving")
            return
        }
        guard let takeNoiseURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "takeNoise" as CFString, "m4a" as CFString, nil) else {
            print("error in sound file path for capturing")
            return
        }
        guard let castleURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "castle" as CFString, "m4a" as CFString, nil) else {
            print("error in sound file path for castling")
            return
        }
        guard let checkmateNoiseURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "checkmateNoise" as CFString, "m4a" as CFString, nil) else {
            print("error in sound file path for checkmate")
            return
        }
        guard let checkNoiseURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "checkNoise" as CFString, "m4a" as CFString, nil) else {
            print("error in sound file path for check")
            return
        }
        guard let gameStartURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), "gameStart" as CFString, "m4a" as CFString, nil) else {
            print("error in sound file path for game start")
            return
        }
        AudioServicesCreateSystemSoundID(whiteMoveURL, &whiteMove)
        AudioServicesCreateSystemSoundID(takeNoiseURL, &takeNoise)
        AudioServicesCreateSystemSoundID(castleURL, &castle)
        AudioServicesCreateSystemSoundID(checkmateNoiseURL, &checkmateNoise)
        AudioServicesCreateSystemSoundID(checkNoiseURL, &checkNoise)
        AudioServicesCreateSystemSoundID(gameStartURL, &gameStartNoise)
    }
    
    func switchTurn() {
        if whoseTurn == .Black {
            whoseTurn = .White
            print("White's turn")
        }
        else {
            whoseTurn = .Black
            print("Black's turn")
        }
    }
    
    func addPiece(type: pieceTypes, color: colors, x: Int, y: Int){
        let piece = Piece(type: type, color: color, xPos: x, yPos: y)
        self.addSubview(piece.imageView)
        pieces.append(piece)
    }
    
    //snap piece to place on board and logically add it to game
    func movePiece(x: Int, y: Int) {
        if movingPiece != nil {
            if movingPiece!.executeMove(x, y){
                switchTurn()
            }
        }
    }
    
    //graphically drag piece in the Board view
    func dragPiece(location: CGPoint){
        movingPiece?.imageView.frame = CGRect(x: location.x - boardWidth/16, y: location.y - boardWidth/16, width: boardWidth/8, height: boardWidth/8)
    }
    
    //selects the piece the user is moving
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1,
          let touchPoint = (touches.first)!.location(in: self) as CGPoint?
        else {
            return
        }
        let coords = calculateCoordinates(location: touchPoint)
        if let piece = pieces.last(where: { $0.xPos == coords.0 && $0.yPos == coords.1}) {
            movingPiece = piece
            if movingPiece!.color == whoseTurn {
                self.bringSubviewToFront(movingPiece!.imageView)
                highlightedRectX = CGFloat(coords.0)
                highlightedRectY = CGFloat(coords.1)
                highlightedRectColor = myGreenColor
                path.removeAllPoints()
                self.setNeedsDisplay()
            }
        }
    }
    
    
    //uses dragPiece() to visually move piece
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1,
          let touchPoint = (touches.first)!.location(in: self) as CGPoint?
        else {
            return
        }
        if movingPiece != nil {
            if movingPiece!.color == whoseTurn {
                dragPiece(location: touchPoint)
                let coords = calculateCoordinates(location: touchPoint)
                highlightedRectX = CGFloat(coords.0)
                highlightedRectY = CGFloat(coords.1)
                path.removeAllPoints()
                self.setNeedsDisplay()
            }
        }
    }
    
    //calls movePiece() which decides whether a move is allowed or if the piece should be snapped back to place
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 1,
          let touchPoint = (touches.first)!.location(in: self) as CGPoint?
        else {
            return
        }
        if movingPiece != nil {
            let coord = calculateCoordinates(location: touchPoint)
            movePiece(x: coord.0, y: coord.1)
        }
        movingPiece = nil
        path.removeAllPoints()
        highlightedRectColor = .clear
        self.setNeedsDisplay()
    }
    
    //translates CGPoint coordinates from the view to integer coordinates useful for game logic
    func calculateCoordinates(location: CGPoint) -> (Int, Int){
        return (Int(location.x * 8 / boardWidth) + 1, Int(location.y * 8 / boardWidth)+1)
    }
    
    //draws a square to show the highlighted area
    override func draw(_ rect: CGRect) {
        path.move(to: CGPoint(x: (highlightedRectX - 1) * boardWidth / 8 + 1, y: (highlightedRectY - 1) *  boardWidth / 8 + 1))
        path.addLine(to: CGPoint(x: highlightedRectX * boardWidth / 8 - 1, y: (highlightedRectY - 1) * boardWidth / 8 + 1))
        path.addLine(to: CGPoint(x: highlightedRectX * boardWidth / 8 - 1, y: highlightedRectY * boardWidth / 8 - 1))
        path.addLine(to: CGPoint(x: (highlightedRectX - 1) * boardWidth / 8 + 1, y: highlightedRectY * boardWidth / 8 - 1))
        path.close()
        highlightedRectColor.set()
        path.lineWidth = 2
        path.stroke()
    }
    
}

enum pieceTypes {
    case Pawn, Rook, Knight, Bishop, King, Queen
}
enum colors {
    case White, Black
}
class Piece {
    var imageView: UIImageView
    var xPos: Int
    var yPos: Int
    var pieceType: pieceTypes
    var color: colors
    var hasMoved: Bool
    
    init(type: pieceTypes, color: colors, xPos: Int, yPos: Int) {
        self.xPos = xPos
        self.yPos = yPos
        self.pieceType = type
        self.color = color
        self.hasMoved = false
        
        //calculates frame based on integer x and y positions
        self.imageView = UIImageView(frame: CGRect(x: CGFloat(CGFloat(xPos-1) * boardWidth / 8), y: CGFloat(CGFloat(yPos-1) * boardWidth / 8), width: boardWidth/8, height: boardWidth/8))
        
        //sets image property
        let imageName: String
        switch(color){
        case .Black:
            switch(type){
            case .Pawn: imageName = "blackPawn"
            case .Rook: imageName = "blackRook"
            case .Knight: imageName = "blackKnight"
            case .Bishop: imageName = "blackBishop"
            case .King: imageName = "blackKing"
            case .Queen: imageName = "blackQueen"
            }
        case .White:
            switch(type){
            case .Pawn: imageName = "whitePawn"
            case .Rook: imageName = "whiteRook"
            case .Knight: imageName = "whiteKnight"
            case .Bishop: imageName = "whiteBishop"
            case .King: imageName = "whiteKing"
            case .Queen: imageName = "whiteQueen"
            }
        }
        self.imageView.image = UIImage(named: imageName)
    }
    
    //synthesizes validMove(), take(), noPieceInPath(), and move(). returns true if move was allowed
    var pawnCanTake = false
    func executeMove(_ x: Int, _ y: Int) -> Bool {
        var tookPiece = false
        switch(pieceType){
        //pawn is the only piece with a different attack pattern from its normal move, so instance variable above is set in validMove() to differentiate
        case .Pawn:
            if whoseTurn == color && validMove(x, y) {
                if pawnCanTake {
                    take(x, y)
                    pawnCanTake = false
                }
                else {
                    move(x, y)
                }
                return true
            }
            else { snapBack() }
        default:
            if whoseTurn == color && validMove(x, y) {
                if let testPiece = getPieceOnSpot(x, y) {
                    if testPiece.color != whoseTurn {
                        take(x, y)
                        tookPiece = true
                    }
                    else {
                        snapBack()
                        return false
                    }
                }
                moveNoSound(x, y)
                if check(x, y, forColor: getOppositeColor()) {
                    print("check!")
                    if checkmate(x, y, forColor: getOppositeColor()){
                        print("CHECKMATE")
                        playCheckmateSound()
                    }
                    else { playCheckSound() }
                }
                else if !tookPiece { playMoveSound() }
                return true
            }
            else {
                snapBack()
            }
        }
        return tookPiece
    }
    
    //checks if move puts opposite king in check
    func check(_ x: Int, _ y: Int, forColor: colors) -> Bool {
        let king = getKing(color: forColor)
        if validMove(king.xPos, king.yPos) {
            if whoseTurn == .White { blackInCheck = true }
            else { whiteInCheck = true }
            return true
        }
        return false
    }
    
    func getOppositeColor(_ color: colors) -> colors{
        if color == .White { return .Black }
        else { return .White }
    }
    
    //checks for checkmate -- check first if King is in check
    func checkmate(_ x: Int, _ y: Int, forColor: colors) -> Bool {
        let king = getKing(color: forColor)
        var thisColorPieces = [Piece]()
        for piece in pieces {
            if piece.color == forColor {
                thisColorPieces.append(piece)
            }
        }
        let path = path(beginX: king.xPos, beginY: king.yPos, endX: x, endY: y)
        for piece in thisColorPieces {
            //if player's piece can take the checking piece, return false
            if piece.validMove(x, y){
                print("can take this piece, not checkmate")
                return false
            }
            //if player's piece can move in front of checking piece, return false
            for square in path {
                if piece.validMove(square.0, square.1) && piece.pieceType != .King {
                    print("can move \(piece.pieceType) on \(piece.xPos), \(piece.yPos) in front of piece, not checkmate")
                    return false
                }
            }
        }
        //if king can move out of check, return false
        for i in -1...1 {
            for j in -1...1 {
                if !(i == 0 && j == 0) && !kingCantMove(king.xPos + i, king.yPos + j, forColor: forColor) && getPieceOnSpot(king.xPos + i, king.yPos + j)?.color != king.color {
                    print("king can move out of checkmate to space \(king.xPos + i), \(king.yPos + j)")
                    return false
                }
            }
        }
        //otherwise, return true
        return true
    }

    //stops king from moving into check. Also a helper method for checkmate()
    func kingCantMove(_ x: Int, _ y: Int, forColor: colors) -> Bool {
        if x > 8 || x < 1 || y > 8 || y < 1 {
            return true
        }
        var oppositeColorPieces = [Piece]()
        for piece in pieces {
            if piece.color != forColor {
                oppositeColorPieces.append(piece)
            }
        }
        let king = getKing(color: forColor)
        let oldX = king.xPos; let oldY = king.yPos
        king.xPos = x; king.yPos = y
        for piece in oppositeColorPieces {
            if piece.pieceType != .King && piece.validMove(x, y) {
                print("can't move here- \(piece.color) \(piece.pieceType) on \(piece.xPos), \(piece.yPos)")
                king.xPos = oldX; king.yPos = oldY
                return true
            }
            if piece.pieceType == .King {
                let otherKingPos = (piece.xPos, piece.yPos)
                switch(otherKingPos) {
                case(x-1...x+1, y-1...y+1):
                    king.xPos = oldX; king.yPos = oldY
                    return true
                default:
                    break
                }
            }
        }
        king.xPos = oldX; king.yPos = oldY
        return false
    }
    
    //returns whether moving a piece would place the king in check. Not really just discovered checks
    func discoveredCheck(_ x: Int, _ y: Int, forColor: colors) -> Bool {
        //try setting piece's position to these x,y coordinates
        let oldX = xPos
        let oldY = yPos
        let king = getKing(color: forColor)
        
        //if player's piece can move the king out of check by taking opponent's piece, return false
        if let i = pieces.lastIndex(where: {$0.xPos == x && $0.yPos == y}) {
            if pieces[i].color != color {
                let savedPiece = pieces[i]
                pieces.remove(at: i)
                xPos = x
                yPos = y
                if kingCantMove(king.xPos, king.yPos, forColor: forColor) {
                    pieces.append(savedPiece)
                    xPos = oldX
                    yPos = oldY
                    return true
                }
                pieces.append(savedPiece)
                xPos = oldX
                yPos = oldY
                if whiteInCheck {  whiteInCheck = false }
                if blackInCheck { blackInCheck = false }
                return false
            }
        }
        xPos = x
        yPos = y
        //use kingCantMove to check if he would still be in check after move
        if kingCantMove(king.xPos, king.yPos, forColor: forColor) {
            xPos = oldX
            yPos = oldY
            return true
        }
        xPos = oldX
        yPos = oldY
        if whiteInCheck { whiteInCheck = false }
        if blackInCheck { blackInCheck = false }
        return false
    }
    
    //moves a piece to the specified coordinates, updating its instance variables
    func move(_ x: Int, _ y: Int) {
        imageView.frame = CGRect(x: CGFloat(CGFloat(x-1) * boardWidth / 8), y: CGFloat(CGFloat(y-1) * boardWidth / 8), width: boardWidth/8, height: boardWidth/8)
        xPos = x
        yPos = y
        hasMoved = true
        //to handle diff noise for castling
        if pieceType != .King {
            playMoveSound()
        }
    }
    func moveNoSound(_ x: Int, _ y: Int) {
        imageView.frame = CGRect(x: CGFloat(CGFloat(x-1) * boardWidth / 8), y: CGFloat(CGFloat(y-1) * boardWidth / 8), width: boardWidth/8, height: boardWidth/8); xPos = x; yPos = y; hasMoved = true
    }
    
    //takes a piece on the given square
    func take(_ x: Int, _ y: Int) {
        if let i = pieces.lastIndex(where: {$0.xPos == x && $0.yPos == y}) {
            pieces[i].imageView.image = nil
            pieces.remove(at: i)
            print("took piece at \(x), \(y)")
            imageView.frame = CGRect(x: CGFloat(CGFloat(x-1) * boardWidth / 8), y: CGFloat(CGFloat(y-1) * boardWidth / 8), width: boardWidth/8, height: boardWidth/8)
            xPos = x
            yPos = y
            hasMoved = true
            playCaptureSound()
        }
    }
    
    //snaps a piece back to its original position if the move wasn't allowed
    func snapBack() {
        imageView.frame = CGRect(x: CGFloat(CGFloat(xPos-1) * boardWidth / 8), y: CGFloat(CGFloat(yPos-1) * boardWidth / 8), width: boardWidth/8, height: boardWidth/8)
    }
    
    func getKing(color: colors) -> Piece {
        let nilPiece = Piece(type: .King, color: .White, xPos: 0, yPos: 0)
        for piece in pieces {
            if piece.pieceType == .King && piece.color == color {
                return piece
            }
        }
        return nilPiece
    }
    
    //for each piece type, return whether or not the passed coordinates are a valid square to move to
    func validMove(_ x: Int, _ y: Int) -> Bool{
        //to fix bug where pieces can sometimes be dragged off screen
        if x > 8 || x < 1 || y > 8 || y < 1 {
            return false
        }
        let newPoint = (x, y)
        
        //if piece was picked up and put back down in same space, don't move it
        if newPoint == (xPos, yPos) {
            return false
        }
        
        //if there's already a piece on a straight or diagonal line between passed coordinates and this piece's current position, return false. noPieceInPath ignores knights, which can jump pieces.
        if !noPieceInPath(x, y){
            return false
        }
        
        //cannot move a piece if it would place King in check
        if color == whoseTurn && discoveredCheck(x, y, forColor: color) {
            print("would place king in check!")
            return false
        }
        
        //otherwise, decide whether the piece can be moved here based on its type
            switch(pieceType){
            case .Rook:
                switch(newPoint){
                case(_, yPos): return true
                case(xPos, _): return true
                default: return false
                }
            case .Bishop:
                if xPos - x == yPos - y || xPos - x == y - yPos {
                    return true
                }
                else { return false }
            case .Queen:
                if xPos - x == yPos - y || xPos - x == y - yPos {
                    return true
                }
                switch(newPoint){
                case(_, yPos): return true
                case(xPos, _): return true
                default: return false
                }
            case .King:
                if kingCantMove(x, y, forColor: color) {
                    return false
                }
                //Castling: black queenside
                if x == 3 && y == 1 && getPieceOnSpot(2, 1) == nil && getPieceOnSpot(3, 1) == nil && getPieceOnSpot(4, 1) == nil && !self.hasMoved && !(getPieceOnSpot(1, 1)?.hasMoved ?? true) {
                    getPieceOnSpot(1, 1)?.moveNoSound(4, 1)
                    playCastleSound()
                    return true
                }
                //black kingside
                if x == 7 && y == 1 && getPieceOnSpot(7, 1) == nil && getPieceOnSpot(6, 1) == nil && !self.hasMoved && !(getPieceOnSpot(8, 1)?.hasMoved ?? true) {
                    getPieceOnSpot(8, 1)?.moveNoSound(6, 1)
                    playCastleSound()
                    return true
                }
                //white queenside
                if x == 3 && y == 8 && getPieceOnSpot(2, 8) == nil && getPieceOnSpot(3, 8) == nil && getPieceOnSpot(4, 8) == nil && !self.hasMoved && !(getPieceOnSpot(1, 8)?.hasMoved ?? true) {
                    getPieceOnSpot(1, 8)?.moveNoSound(4, 8)
                    playCastleSound()
                    return true
                }
                //white kingside
                if x == 7 && y == 8 && getPieceOnSpot(7, 8) == nil && getPieceOnSpot(6, 8) == nil && !self.hasMoved && !(getPieceOnSpot(8, 8)?.hasMoved ?? true) {
                    getPieceOnSpot(8, 8)?.moveNoSound(6, 8)
                    playCastleSound()
                    return true
                }
                //normal movement
                switch(newPoint){
                case(xPos-1...xPos+1, yPos-1...yPos+1):
                    if xPos != x || yPos != y {
                        playMoveSound()
                    }
                    return true
                default: return false
                }
            case .Knight:
                switch(newPoint){
                case(xPos-1, yPos+2): return true
                case(xPos+1, yPos+2): return true
                case(xPos+2, yPos+1): return true
                case(xPos+2, yPos-1): return true
                case(xPos+1, yPos-2): return true
                case(xPos-1, yPos-2): return true
                case(xPos-2, yPos-1): return true
                case(xPos-2, yPos+1): return true
                default: return false
                }
            case .Pawn:
                switch(color){
                case .Black:
                    if x == xPos + 1 && y == yPos + 1 && pieceOnSpot(x, y) && getPieceOnSpot(x, y)?.color == .White {
                        pawnCanTake = true
                        return true
                    }
                    if x == xPos - 1 && y == yPos + 1 && pieceOnSpot(x, y) && getPieceOnSpot(x, y)?.color == .White {
                        pawnCanTake = true
                        return true
                    }
                    if !hasMoved && xPos == x && (y == yPos + 1 || y == yPos + 2) && !pieceOnSpot(x, y) {
                        return true
                    }
                    else if hasMoved && xPos == x && y == yPos + 1 && !pieceOnSpot(x, y) {
                        return true
                    }
                    else { return false }
                case .White:
                    if x == xPos + 1 && y == yPos - 1 && pieceOnSpot(x, y) && getPieceOnSpot(x, y)?.color == .Black {
                        pawnCanTake = true
                        return true
                    }
                    if x == xPos - 1 && y == yPos - 1 && pieceOnSpot(x, y)  && getPieceOnSpot(x, y)?.color == .Black {
                        pawnCanTake = true
                        return true
                    }
                    if !hasMoved && xPos == x && (y == yPos - 1 || y == yPos - 2) && !pieceOnSpot(x, y) {
                        return true
                    }
                    else if hasMoved && xPos == x && y == yPos - 1 && !pieceOnSpot(x, y) {
                        return true
                    }
                    else { return false }
                }
            
        }
    }
    
    func pieceOnSpot(_ x: Int, _ y: Int) -> Bool {
        return pieces.contains(where: {$0.xPos == x && $0.yPos == y})
    }
    
    func getPieceOnSpot(_ x: Int, _ y: Int) -> Piece? {
        return pieces.last(where: {$0.xPos == x && $0.yPos == y})
    }
    
    func getOppositeColor() -> colors{
        if self.color == .White {
            return .Black
        }
        return .White
    }
    
    //returns true when there's no piece in the way of a move diagonally, horizontally, or vertically. This method is used for all pieces
    func noPieceInPath(_ newX: Int, _ newY: Int) -> Bool{
        //since Knights can never have a piece in their path, noPieceInPath() always returns true. Whether or not a piece is on this coordinate is handled in validMove()
        if pieceType == .Knight {
            return true
        }
        let path = path(beginX: xPos, beginY: yPos, endX: newX, endY: newY)
        for square in path {
            if pieces.contains(where: {$0.xPos == square.0 && $0.yPos == square.1}){
                return false
            }
        }
        return true
    }
    
    //returns an array of coordinates between two points diagonally/horizontally/vertically
    func path(beginX: Int, beginY: Int, endX: Int, endY: Int) -> [(Int, Int)] {
        var returnPath = [(Int, Int)]()
        let difference = (beginX - endX, beginY - endY)
        //loops below will error unless there's at least one square between new space and start space
        switch(difference){
        case(-1...1, -1...1):
            return returnPath
        default:
            break
        }
        
        //positive diagonal
        if beginX - endX == beginY - endY {
            if beginX > endX {
                for i in 1..<beginX-endX {
                    returnPath.append((beginX - i, beginY - i))
                }
            } else {
                for i in 1..<endX-beginX {
                    returnPath.append((beginX + i, beginY + i))
                }
            }
        }
        //negative diagonal
        if endX - beginX == beginY - endY {
            if beginX > endX {
                for i in 1..<beginX-endX {
                    returnPath.append((beginX - i, beginY + i))
                }
            } else {
                for i in 1..<endX-beginX {
                    returnPath.append((beginX + i, beginY - i))
                }
            }
        }
        //horizontal
        if endY == beginY {
            if endX > beginX {
                for i in 1..<endX - beginX{
                    returnPath.append((beginX + i, beginY))
                }
            }
            else {
                for i in 1..<beginX - endX{
                    returnPath.append((beginX - i, beginY))
                }
            }
        }
        //vertical
        if endX == beginX {
            if endY > beginY {
                for i in 1..<endY - beginY{
                    returnPath.append((beginX, beginY + i))
                }
            }
            else {
                for i in 1..<beginY - endY{
                    returnPath.append((beginX, beginY - i))
                }
            }
        }
        return returnPath
    }
    
    func playMoveSound() {
        AudioServicesPlaySystemSound(whiteMove)
    }
    func playCaptureSound() {
        AudioServicesPlaySystemSound(takeNoise)
    }
    func playCheckSound() {
        AudioServicesPlaySystemSound(checkNoise)
    }
    func playCheckmateSound() {
        AudioServicesPlaySystemSound(checkmateNoise)
    }
    func playCastleSound() {
        AudioServicesPlaySystemSound(castle)
    }
}

//CHUCK CHESS by CHARLES BERGHAUSEN
