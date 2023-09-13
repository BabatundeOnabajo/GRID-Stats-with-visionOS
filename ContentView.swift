//
//  ContentView.swift
//  GRID Data CSGo
//
//  Created by Babatunde Onabajo on 13/09/2023.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct csGoPlayers: Identifiable{
    let id = UUID().uuidString
   
    let idAsString: String
    let nameOfTeam: String
    let kills: String
    let killAssistsReceived: String
    let killAssistsGiven: String
    let winOrLose: String //Ideally this should be an enumeration but we can amend this at a later date.
}

struct ContentView: View {

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        VStack {
            
            Spacer()
            
            Model3D(named: "Scene", bundle: realityKitContentBundle)
                .padding(.bottom, 50)
            Image(systemName: "trophy").resizable().frame(width: 33.0, height: 30.0)
            Text("CS:Go Statistics For Various Players/Teams").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 36)).padding(10).underline() //I resized the text so that it is more visible and added an underline as well to increase its prominence.

            Table(of: csGoPlayers.self){
                TableColumn("Name", value: \.idAsString)
                TableColumn("Name of Team", value: \.nameOfTeam)
                TableColumn("Kills", value: \.kills)
                TableColumn("Kills Assists Received", value: \.killAssistsReceived)
                TableColumn("Kill Assists Given", value: \.killAssistsGiven)
                TableColumn("Win Or Lose", value: \.winOrLose)
            } rows: {
                TableRow(csGoPlayers(idAsString: "forZe",  nameOfTeam: "", kills: "165", killAssistsReceived: "35", killAssistsGiven: "35", winOrLose: "false"))
                TableRow(csGoPlayers(idAsString: "r3salt", nameOfTeam: "", kills: "32", killAssistsReceived: "35", killAssistsGiven: "35", winOrLose: "false"))
                TableRow(csGoPlayers(idAsString: "ECSTASTIC", nameOfTeam: "", kills: "112", killAssistsReceived: "15", killAssistsGiven: "15", winOrLose: "true"))
                TableRow(csGoPlayers(idAsString: "salazar", nameOfTeam: "", kills: "31", killAssistsReceived: "4", killAssistsGiven: "2", winOrLose: "true"))
                
            }
            
            Toggle("Show Immersive Space", isOn: $showImmersiveSpace)
                .toggleStyle(.button)
                .padding(.top, 20)
            
            
        }
        .padding().foregroundStyle(.red)
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    switch await openImmersiveSpace(id: "ImmersiveSpace") {
                    case .opened:
                        immersiveSpaceIsShown = true
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        immersiveSpaceIsShown = false
                        showImmersiveSpace = false
                    }
                } else if immersiveSpaceIsShown {
                    await dismissImmersiveSpace()
                    immersiveSpaceIsShown = false
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
