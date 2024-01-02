//
//  ContentView.swift
//  WordCapsule
//
//  Created by Cagla CANITEZ on 8.11.2023.
//

import SwiftUI

struct ContentView: View {
    @State var showNextView = false
    @State var fightView = false
    @State var viewIndex = 0
    let options: [Option] = [
        Option(pageTitle: "Make Your Step",
               stepOptions: ["Fight", "Training", "Quiz"],
               buttonColors: [Color(#colorLiteral(red: 0.6293563069, green: 1, blue: 0.8426308106, alpha: 0.8403105778)), Color(#colorLiteral(red: 0.8356435616, green: 0.6275514296, blue: 1, alpha: 0.835320189)), Color(#colorLiteral(red: 1, green: 0.9699594332, blue: 0.4056734552, alpha: 0.84))]),
        Option(pageTitle: "Place to Challenge",
               stepOptions: ["Make A Fight", "Join A Fight"],
               buttonColors: [ Color(#colorLiteral(red: 1, green: 0.6650804661, blue: 0.9354331803, alpha: 0.8403105778)), Color(#colorLiteral(red: 0.6609598777, green: 0.9016503197, blue: 0.9686274529, alpha: 0.8993574253))]),
        Option(pageTitle: "Chose Your Level",
               stepOptions: ["A1", "A2", "B1", "B2", "C1", "C2"],
               buttonColors: [Color(#colorLiteral(red: 0.6293563069, green: 1, blue: 0.8426308106, alpha: 0.8403105778)), Color(#colorLiteral(red: 0.7879904464, green: 0.6399459111, blue: 1, alpha: 0.720493739)), Color(#colorLiteral(red: 1, green: 0.9699594332, blue: 0.4056734552, alpha: 0.84)), Color(#colorLiteral(red: 1, green: 0.5767133819, blue: 0.4263963641, alpha: 0.8403105778)), Color(#colorLiteral(red: 1, green: 0.6650804661, blue: 0.9354331803, alpha: 0.8403105778)), Color(#colorLiteral(red: 0.6609598777, green: 0.9016503197, blue: 0.9686274529, alpha: 0.8993574253))]),
        Option(pageTitle: "Word Count",
               stepOptions: ["10 Words", "20 Words", "30 Words", "40 Words", "50 Words", "60 Words"],
               buttonColors: [Color(#colorLiteral(red: 0.6293563069, green: 1, blue: 0.8426308106, alpha: 0.8403105778)), Color(#colorLiteral(red: 0.7879904464, green: 0.6399459111, blue: 1, alpha: 0.720493739)), Color(#colorLiteral(red: 1, green: 0.9699594332, blue: 0.4056734552, alpha: 0.84)), Color(#colorLiteral(red: 1, green: 0.5767133819, blue: 0.4263963641, alpha: 0.8403105778)), Color(#colorLiteral(red: 1, green: 0.6650804661, blue: 0.9354331803, alpha: 0.8403105778)), Color(#colorLiteral(red: 0.6609598777, green: 0.9016503197, blue: 0.9686274529, alpha: 0.8993574253))]),
        Option(pageTitle: "Word Duration",
               stepOptions: ["3s", "5s", "7s", "10s", "12s", "15s"],
               buttonColors: [Color(#colorLiteral(red: 0.6293563069, green: 1, blue: 0.8426308106, alpha: 0.8403105778)), Color(#colorLiteral(red: 0.7879904464, green: 0.6399459111, blue: 1, alpha: 0.720493739)), Color(#colorLiteral(red: 1, green: 0.9699594332, blue: 0.4056734552, alpha: 0.84)), Color(#colorLiteral(red: 1, green: 0.5767133819, blue: 0.4263963641, alpha: 0.8403105778)), Color(#colorLiteral(red: 1, green: 0.6650804661, blue: 0.9354331803, alpha: 0.8403105778)), Color(#colorLiteral(red: 0.6609598777, green: 0.9016503197, blue: 0.9686274529, alpha: 0.8993574253))])
    ]
    
    var body: some View {
        NavigationStack {
            WordOptionView(option: options[viewIndex]) { index in
                print(viewIndex)
                if viewIndex == 0 {
                    if index == 0 {
                        viewIndex += 1
                        fightView = true
                    } else {
                        viewIndex += 2
                        fightView = false
                    }
                } else {
                    if viewIndex == options.count - 1 {
                        showNextView = true
                    } else {
                        viewIndex += 1
                    }
                }
            }
            .navigationDestination(isPresented: $showNextView) {
                if fightView {
                    StartTheFightView()
                } else {
                    LearnNewWordView()
                }
            }
            .navigationBarItems(
                leading: viewIndex > 0 ? Button(action: {
                    if viewIndex > 0 {
                        if fightView {
                            viewIndex -= 1
                        } else {
                            viewIndex -= (viewIndex == 2) ? 2 : 1
                        }
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                } : nil
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
