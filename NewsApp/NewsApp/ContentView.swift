import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = NewsViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.news) { newsItem in
                        HStack {
                            VStack(alignment: .leading) {
                                AsyncImage(url: URL(string: newsItem.image)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 330, height: 150)
                                        .cornerRadius(8)
                                }
                                placeholder: {
                                    ProgressView()
                                        .frame(width: 100, height: 100)
                                }
                                .padding(.trailing, 8)
                                
                                Text(newsItem.source)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                                
                                Text(newsItem.name)
                                    .font(.headline)
                                
                                Text(newsItem.description)
                                    .font(.subheadline)
                                    .lineLimit(5)
                            }
                        }
                        .contentShape(Rectangle())  // Tüm alanı tıklanabilir yapar
                        .onTapGesture {
                            viewModel.selectNewsItem(newsItem)
                        }
                    }
                }
                
                HStack {
                    Button(action: {
                        if viewModel.paging>0{
                            viewModel.paging -= 1
                            viewModel.fetchDutyNews()
                        }
                    }) {
                        Text("<--Önceki")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            
                            .font(.subheadline)
                            .cornerRadius(25)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    Text("sayfa:\(viewModel.paging+1)")
                        .foregroundStyle(Color.gray)
                        
                        
                    Button(action: {
                        viewModel.paging += 1
                        viewModel.fetchDutyNews()
                    }) {
                        Text("Sonraki-->")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            
                            .font(.subheadline)
                            .cornerRadius(25)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                }
            }
            .navigationTitle("HABERLER")
            .onAppear {
                viewModel.fetchDutyNews()
            }
            .sheet(item: $viewModel.selectedURL) { identifiableURL in
                SafariView(url: identifiableURL.url)
            }
        }
    }
}


#Preview {
    ContentView()
}
