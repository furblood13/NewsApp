//
//  SafariView.swift
//  NewsApp
//
//  Created by Furkan buğra karcı on 19.08.2024.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        // Güncellemeye gerek yok, bu kısım boş bırakılabilir
    }
}
#Preview {
    SafariView(url: URL(string: "https://www.example.com")!)
}

