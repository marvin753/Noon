// ConnectBankView.swift
// Noon
// Purpose: WebView for Tink Link bank connection flow provided by backend

import SwiftUI
import WebKit

struct ConnectBankView: UIViewRepresentable {
    let tinkLinkURL: URL
    let onComplete: (Result<String, Error>) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onComplete: onComplete)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: tinkLinkURL)
        webView.load(request)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        let onComplete: (Result<String, Error>) -> Void

        init(onComplete: @escaping (Result<String, Error>) -> Void) {
            self.onComplete = onComplete
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let url = navigationAction.request.url else {
                decisionHandler(.allow)
                return
            }

            // Check if this is the callback URL
            if url.absoluteString.contains("noon://callback") || url.absoluteString.contains("callback") {
                // Extract authorization code from URL
                if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                   let queryItems = components.queryItems,
                   let code = queryItems.first(where: { $0.name == "code" })?.value {
                    onComplete(.success(code))
                } else {
                    onComplete(.failure(NSError(domain: "ConnectBankView", code: -1, userInfo: [NSLocalizedDescriptionKey: "No authorization code found"])))
                }
                decisionHandler(.cancel)
                return
            }

            decisionHandler(.allow)
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            onComplete(.failure(error))
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            onComplete(.failure(error))
        }
    }
}

#Preview {
    ConnectBankView(
        tinkLinkURL: URL(string: "https://link.tink.com")!,
        onComplete: { _ in }
    )
}
