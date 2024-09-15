//
//  ClipVaultApp.swift
//  ClipVault
//
//  Created by Jasper on 14/09/2024.
//

import SwiftUI

func setClipboardString(text:String) {
    let pasteboard = NSPasteboard.general
    pasteboard.clearContents()
    pasteboard.setString(text, forType: .string)
}

 


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
        NavigationSplitView() {
            VStack {
                List(selection: $selectedSnippet) {
                    ForEach(filteredItems) { snippet in
                        let index = snippets.firstIndex(of: snippet)!
                        HStack {
                            Image(systemName: snippet.icon)
                                .foregroundColor(.purple)
                            
                            Text(snippet.title)
                            Spacer()
                            if index < 9 {
                                Text("⌘\(index)")
                            }
                           
                        }
                        .tag(snippet)
                        .contextMenu {
                            Button("Copy") {
                                setClipboardString(text: snippet.title)
                            }
                            Button("Delete", role: .destructive) {
                                if let index = snippets.firstIndex(where: {$0.id == snippet.id}){
                                    snippets.remove(at: index)
                                }
                            }
                        }
                        
                    }
                }
                .listStyle(SidebarListStyle())
                .frame(minWidth: 200)
            }
            .toolbar(removing: .sidebarToggle)
            .searchable(text: $searchText)
            
        } detail: {
            if selectedSnippet != nil {
                DetailView(snippet: $selectedSnippet, snippets: $snippets)
            } else {
                Text("Select a snippet")
            }
        }
        .navigationTitle("ClipVault")
    
    }
    

}

struct DetailView: View {
    @Binding var snippet: Snippet?
    @Binding var snippets: [Snippet]
    
    
    
    var body: some View {
        
        if let snippet = snippet {VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                Text(snippet.title)
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .background(Color(NSColor.textBackgroundColor))
            
            Divider()
            
            HStack {
                Button(action: {
                    setClipboardString(text: snippet.title)
                }, label: {
                    Label("Copy", systemImage: "doc.on.clipboard.fill")
                })
                .padding()
                
                
                Button(action: {
                    if let index = snippets.firstIndex(where: {$0.id == snippet.id}){
                        snippets.remove(at: index)
                    }
                    self.snippet = nil
                }, label: {
                    Label("Delete", systemImage: "trash.fill")
                })
                
                
                Spacer()
            }
            .background(Color(NSColor.controlBackgroundColor))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
    }

}

struct AppMenu: View {


    var body: some View {

        ContentView()
        
    }
}

@main
struct ClipVaultApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#Preview {
    ContentView()
}
