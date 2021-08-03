//
//  ContentView.swift
//  URLShortner
//
//  Created by Timotius Leonardo Lianoto on 02/08/21.
//

import SwiftUI

struct ContentView: View {
    @State var text = ""
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                header()
                
                ForEach(viewModel.models, id: \.self) { model in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("https://1pt.co/"+model.short)
                            Text(model.long)
                        }
                        Spacer()
                    }
                    .padding()
                    .onTapGesture {
                        guard let url = URL(string: "https://1pt.co/"+model.short) else {
                            return
                        }
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
            .navigationTitle("URLShorts")
        }
    }
    
    @ViewBuilder
    func header() -> some View {
        VStack {
            Text("Enter URL to be shortened")
                .bold()
                .font(.system(size: 32))
                .foregroundColor(.white)
            TextField("URL...", text: $text)
                .padding()
                .autocapitalization(.none)
                .background(Color.white)
                .cornerRadius(8.0)
                .padding()
            
            Button(action: {
                // make API call
                guard !text.isEmpty else {
                    return
                }
                viewModel.submit(url: text)
                text = ""
            }, label: {
                Text("SUBMIT")
                    .bold()
                    .frame(width: 240, height: 50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
            })
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color.purple)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
