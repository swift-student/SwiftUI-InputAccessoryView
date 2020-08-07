//
//  ContentView.swift
//  InputAccessoryView
//
//  Created by Shawn Gee on 8/7/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let accessoryViewController = TextFieldAccessoryViewController()
    let font = UIFont.systemFont(ofSize: 20)
    
    @State var firstName = ""
    @State var lastName = ""
    @State var age = ""
    @State var favoriteColor = ""
    
    var body: some View {
        Form {
            SSTextField("First Name", text: $firstName)
                .font(font)
                .accessoryViewController(accessoryViewController, tag: 0)
            SSTextField("Last Name", text: $lastName)
                .font(font)
                .accessoryViewController(accessoryViewController, tag: 1)
            SSTextField("Age", text: $age)
                .font(font)
                .accessoryViewController(accessoryViewController, tag: 2)
            SSTextField("Favorite Color", text: $favoriteColor)
                .font(font)
                .accessoryViewController(accessoryViewController, tag: 3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


