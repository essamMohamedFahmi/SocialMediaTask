//
//  NotificationsMessages.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import Toast_Swift

final class NotifiyMessage
{
    private init() {}
    static let shared = NotifiyMessage()

    func configNotify()
    {
        ToastManager.shared.isTapToDismissEnabled = true
        ToastManager.shared.isQueueEnabled = true
        ToastManager.shared.duration = 2
        ToastManager.shared.position = .bottom
    }
    
    func toast(toastMessage: String, completion: (() -> Void)? = nil)
    {
        guard let view = UIApplication.getTopViewController()?.view else { return }
        view.makeToast(toastMessage) { _ in
            completion?()
        }
    }
}
