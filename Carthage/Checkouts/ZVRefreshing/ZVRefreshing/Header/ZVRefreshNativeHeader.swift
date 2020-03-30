//
//  ZVRefreshDIYHeader.swift
//  ZVRefreshing
//
//  Created by zevwings on 2017/7/17.
//  Copyright © 2017年 zevwings. All rights reserved.
//

import UIKit

public class ZVRefreshNativeHeader: ZVRefreshStateHeader {
    
    // MARK: - Property
    
    private var arrowView: UIImageView?
    private var activityIndicator: UIActivityIndicatorView?
    
    // MARK: didSet
    
    public var activityIndicatorViewStyle: UIActivityIndicatorView.Style = .gray {
        didSet {
            activityIndicator?.style = activityIndicatorViewStyle
            setNeedsLayout()
        }
    }

    // MARK: - Subviews
    
    override public func prepare() {
        super.prepare()
        
        self.labelInsetLeft = 24.0
        
        if arrowView == nil {
            arrowView = UIImageView()
            arrowView?.contentMode = .scaleAspectFit
            arrowView?.image = UIImage.arrow
            arrowView?.tintColor = .lightGray
            addSubview(arrowView!)
        }
        
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView()
            activityIndicator?.style = activityIndicatorViewStyle
            activityIndicator?.hidesWhenStopped = true
            activityIndicator?.color = .lightGray
            addSubview(activityIndicator!)
        }
    }
    
    override public func placeSubViews() {
        super.placeSubViews()
        
        var centerX = frame.width * 0.5
        if let stateLabel = stateLabel, !stateLabel.isHidden {
            var maxLabelWidth: CGFloat = 0.0
            if let lastUpdatedTimeLabel = lastUpdatedTimeLabel, !lastUpdatedTimeLabel.isHidden {
                maxLabelWidth = max(lastUpdatedTimeLabel.textWidth, stateLabel.textWidth)
            } else {
                maxLabelWidth = stateLabel.textWidth
            }
            
            let activityIndicatorOffset = (activityIndicator?.frame.width ?? 0.0) * 0.5
            centerX -= (maxLabelWidth * 0.5 + labelInsetLeft + activityIndicatorOffset)
        }
        let centerY = frame.height * 0.5
        let center = CGPoint(x: centerX, y: centerY)
        
        if let arrowView = arrowView, arrowView.constraints.isEmpty && arrowView.image != nil {
            arrowView.isHidden = false
            arrowView.frame.size = arrowView.image!.size
            arrowView.center = center
        } else {
            arrowView?.isHidden = true
        }
        
        if let activityIndicator = activityIndicator, activityIndicator.constraints.isEmpty {
            activityIndicator.center = center
        }
    }
    
    // MARK: - State Update

    public override func refreshStateUpdate(
        _ state: ZVRefreshControl.RefreshState,
        oldState: ZVRefreshControl.RefreshState
    ) {
        super.refreshStateUpdate(state, oldState: oldState)

        switch state {
        case .idle:
            if refreshState == .refreshing {
                arrowView?.transform = CGAffineTransform.identity
                UIView.animate(withDuration: 0.15, animations: {
                    self.activityIndicator?.alpha = 0.0
                }, completion: { _ in
                    guard self.refreshState == .idle else { return }
                    self.activityIndicator?.alpha = 1.0
                    self.activityIndicator?.stopAnimating()
                    self.arrowView?.isHidden = false
                })
            } else {
                activityIndicator?.stopAnimating()
                arrowView?.isHidden = false
                UIView.animate(withDuration: 0.15, animations: {
                    self.arrowView?.transform = CGAffineTransform.identity
                })
            }
        case .pulling:
            activityIndicator?.stopAnimating()
            arrowView?.isHidden = false
            UIView.animate(withDuration: 0.15, animations: {
                self.arrowView?.transform = CGAffineTransform(rotationAngle: 0.000001 - CGFloat(Double.pi))
            })
        case .refreshing:
            activityIndicator?.alpha = 1.0
            activityIndicator?.startAnimating()
            arrowView?.isHidden = true
        default:
            break
        }
    }
}

extension ZVRefreshNativeHeader {
    
    override public var tintColor: UIColor! {
        didSet {
            self.arrowView?.tintColor = tintColor
            self.activityIndicator?.color = tintColor
        }
    }
}
