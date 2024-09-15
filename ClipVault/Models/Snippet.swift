//
//  Snippet.swift
//  ClipVault
//
//  Created by Jasper on 15/09/2024.
//

import Foundation


struct Snippet: Identifiable, Hashable {
    let id = UUID()
    let icon: String
    var title: String
    
    
    static func examples() -> [Snippet] {
        [
            Snippet(icon: "doc.text.fill", title: "Alfred Powerpack..."),
            Snippet(icon: "doc.text.fill", title: "https://www.alfredapp.com/blog/a..."),
            Snippet(icon: "doc.text.fill", title: """
    import SwiftUI



    struct ContentView: View {
        @State private var snippets: [Snippet] = Snippet.examples()
        
        @State private var selectedSnippet: Snippet?
        @State private var searchText: String = ""
        
        var filteredItems: [Snippet] {
             if searchText.isEmpty {
                 return snippets
             } else {
                 return snippets.filter { $0.title.lowercased().contains(searchText.lowercased()) }
             }
         }
        
        var body: some View {
            NavigationView {
                VStack {
                    TextField("Search...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 4)
                    
                    List(selection: $selectedSnippet) {
                        ForEach(filteredItems) { snippet in
                            HStack {
                                Image(systemName: snippet.icon)
                                    .foregroundColor(.purple)
                                
                                Text(snippet.title)
                                Spacer()
                                Text("CMD-A")
                            }
                            .tag(snippet)
                        }
                    }
                    .listStyle(SidebarListStyle())
                    .frame(minWidth: 200)
                }
                
                if let selected = selectedSnippet {
                    DetailView(snippet: selected)
                } else {
                    Text("Select a snippet")
                }
            }
            .navigationTitle("Snippets")
        }
    }

    struct DetailView: View {
        let snippet: Snippet
        
        var body: some View {
            VStack(alignment: .leading) {
             
                Text(snippet.title)
                    .padding(.top)
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Label("Copy", systemImage: "doc.on.clipboard.fill")
                })
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }

    @main
    struct ClipVaultApp: App {
        @State private var isShowingPopup = false
        
        var body: some Scene {
            WindowGroup {
                ContentView()
            }
        }
    }

    #Preview {
        ContentView()
    }

    """),
        ]
    }
}


