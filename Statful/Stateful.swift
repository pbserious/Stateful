//
//  Stateful.swift
//  Statful
//
//  Created by Rattee Wariyawutthiwat on 11/6/2560 BE.
//  Copyright © 2560 Rattee. All rights reserved.
//

import UIKit

enum StatefulStatus {
    case loading
    case empty
    case error
    case content
}

protocol Stateful: class {
    
    var currentStatus: StatefulStatus { get set }
    
    var loadingView: UIView? { get set }
    
    var emptyView: UIView? { get set }
    
    var errorView: UIView? { get set }
    
    var contentView: UIView? { get set }
    
    func initialStatefulView()
 
    // Default: true (need to handle empty view if not implemented)
    func hasContent() -> Bool
    
    func show(state: StatefulStatus)
}

extension Stateful {
    
    func hasContent() -> Bool {
        return true
    }
    
    private func getView(from status:StatefulStatus) -> UIView? {
        switch status {
        case .loading:
            return loadingView
        case .empty:
            return emptyView
        case .error:
            return errorView
        case .content:
            if hasContent() {
                return contentView
            } else {
                return emptyView
            }
        }
    }
    
    func show(state: StatefulStatus) {
        guard let transitView =  getView(from: state),
                let hiddenView = getView(from: currentStatus),
                state != currentStatus else { return }
        
        if state == .content {
            UIView.animate(withDuration: 0.3, animations: {
                hiddenView.alpha = 0.0
            }) { completed in
                if completed {
                    self.handle(hiddenView: hiddenView)
                }
            }
        } else {
            handle(transitView: transitView)
            UIView.animate(withDuration: 0.3,
                           animations: {
                            transitView.alpha = 1.0
            }) { completed in
                if completed {
                    self.handle(hiddenView: hiddenView)
                }
            }
        }
        
        currentStatus = state
    }
    
    private func handle(transitView:UIView) {
        guard let contentView = contentView else { return }
        
        transitView.alpha = 0.0
        transitView.frame = contentView.bounds
        transitView.autoresizingMask = [.flexibleWidth,
                                        .flexibleHeight]
        if transitView != contentView {
            contentView.addSubview(transitView)
        }
        contentView.bringSubview(toFront: transitView)
    }
    
    private func handle(hiddenView:UIView) {
        guard let contentView = contentView else { return }
        
        if hiddenView != contentView {
            hiddenView.alpha = 0.0
            hiddenView.removeFromSuperview()
        }

    }
}

extension Stateful where Self:UIView {
    
    func initialStatefulView() {
        self.contentView? = self
        show(state: currentStatus)
    }
}

extension Stateful where Self:UIViewController {
    
    func initialStatefulView() {
        self.contentView? = self.view
        show(state: currentStatus)
    }
}
