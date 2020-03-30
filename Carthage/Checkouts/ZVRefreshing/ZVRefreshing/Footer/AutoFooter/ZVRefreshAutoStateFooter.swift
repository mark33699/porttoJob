//
//  ZRefreshAutoStateFooter.swift
//  ZVRefreshing
//
//  Created by zevwings on 16/3/31.
//  Copyright © 2016年 zevwings. All rights reserved.
//

import UIKit

open class ZVRefreshAutoStateFooter : ZVRefreshAutoFooter {

    struct LocalizedKey {
        static let idle = "tap or pull up to load more"
        static let refreshing = "loading"
        static let noMoreData = "no more data"
    }
    
    // MARK: - Property
    
    public var labelInsetLeft: CGFloat = 12.0
    
    public var stateTitles: [RefreshState : String] = [:]
    public private(set) var stateLabel: UILabel?
    
    // MARK: - Subviews
    
    override open func prepare() {
        super.prepare()

        if stateLabel == nil {
            stateLabel = .default
            addSubview(stateLabel!)
        }
        
        setTitle(with: LocalizedKey.idle, for: .idle)
        setTitle(with: LocalizedKey.refreshing, for: .refreshing)
        setTitle(with: LocalizedKey.noMoreData, for: .noMoreData)
        
        addTarget(self, action: #selector(_stateLabelClicked), for: .touchUpInside)
    }
    
    override open func placeSubViews() {
        super.placeSubViews()
        
        if let stateLabel = stateLabel, stateLabel.constraints.isEmpty {
            stateLabel.frame = bounds
        }
    }
    
    // MARK: - State Update

    open override func refreshStateUpdate(
        _ state: ZVRefreshControl.RefreshState,
        oldState: ZVRefreshControl.RefreshState
    ) {
        super.refreshStateUpdate(state, oldState: oldState)

        setTitleForCurrentState()
    }

    open func setTitle(_ title: String, for state: RefreshState) {
           stateTitles[state] = title
           stateLabel?.text = stateTitles[refreshState]
           setNeedsLayout()
       }

       open func setTitle(with localizedKey: String, for state: RefreshState) {
           let title = ZVLocalizedString(localizedKey)
           setTitle(title, for: state)
       }

       open func setTitleForCurrentState() {
           guard let stateLabel = stateLabel else { return }
           if stateLabel.isHidden && refreshState == .refreshing {
               stateLabel.text = nil
           } else {
               stateLabel.text = stateTitles[refreshState]
           }
       }
}

// MARK: - System Override

extension ZVRefreshAutoStateFooter {
    
    override open var tintColor: UIColor! {
        didSet {
            stateLabel?.textColor = tintColor
        }
    }
}

// MARK: - Private

private extension ZVRefreshAutoStateFooter {
    
    @objc func _stateLabelClicked() {
        if refreshState == .idle { beginRefreshing() }
    }
}
