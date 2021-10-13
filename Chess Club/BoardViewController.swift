//
//  ViewController.swift
//  Chess Club
//
//  Created by Charles Berghausen on 7/27/21.
//

import UIKit
import SocketIO

class BoardViewController: UIViewController {
    @IBOutlet weak var myBoard: Board!
    
    var checkmateVar = false {
        didSet {
            print("$%*$&%^")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        myBoard.setBoard(controller: self)
        print("White plays first!")
    }
    
    @IBAction func endGame(_ sender: Any) {
        myBoard.clearBoard()
    }
}

//uses code from examples on https://github.com/socketio/socket.io-client-swift

class OnlineViewController: UIViewController {
    @IBOutlet weak var onlineBoard: Board!
//    let manager = SocketManager(socketURL: URL(string: "http://localhost:8900")!, config: [.log(true), .compress])
//    var socket:SocketIOClient!
//    var name: String?
//    var resetAck: SocketAckEmitter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        socket = manager.defaultSocket
//        addHandlers()
//        socket.connect()
    }
    
//    func addHandlers() {
//        socket.on(clientEvent: .connect) {data, ack in
//            print("socket connected")
//        }
//    }
    
    
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

