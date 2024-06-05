//
//  ContentView.swift
//  Brickbreaker
//
//  Created by Jigar on 05/06/24.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    var body: some View {
        SpriteView(scene: MainMenuScene(size: UIScreen.main.bounds.size))
            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
