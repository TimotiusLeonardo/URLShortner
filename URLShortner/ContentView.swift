//
//  ContentView.swift
//  URLShortner
//
//  Created by Timotius Leonardo Lianoto on 02/08/21.
//

import SwiftUI
import AlertToast

struct ContentView: View {
    @State var text = ""
    @StateObject var viewModel = ViewModel()
    @State private var showToast = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                header()
                
                ForEach(viewModel.models, id: \.self) { model in
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Result: ")
                                    .fontWeight(.light)
                                    .font(.title3)
                                Text("https://1pt.co/"+model.short)
                                    .fontWeight(.black)
                                    .font(.title3)
                            }
                            Spacer()
                            Text(model.long)
                                .fontWeight(.light)
                                .font(.caption)
                        }
                        Spacer()
                    }
                    .padding()
                    .onTapGesture(count: 2) {
                        guard let url = URL(string: "https://1pt.co/"+model.short) else {
                            return
                        }
                        UIPasteboard.general.string = url.absoluteString
                        showToast = true
                    }
                    .toast(isPresenting: $showToast, duration: 2) {
                        AlertToast(displayMode: .alert, type: .regular, title: "URL Copied to clipboard")
                    }
                    
                }
            }
            .navigationTitle("URLShorts")
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
    
    @ViewBuilder
    func header() -> some View {
        VStack {
            Text("Enter URL to be shortened")
                .bold()
                .font(.system(size: 32))
                .foregroundColor(.white)
            TextField("URL...", text: $text, onCommit:  {
                UIApplication.shared.endEditing()
            })
                .padding()
                .autocapitalization(.none)
                .background(Color.white)
                .foregroundColor(.black)
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
