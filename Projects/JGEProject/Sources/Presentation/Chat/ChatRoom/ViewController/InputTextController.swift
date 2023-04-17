import UIKit

extension ChatRoomViewController {
    func resetAfterSendingMessage() {
//        guard isUser else {
//            contentTableView.reloadData()
//            scrollToBottom()
//            return
//
//        }
        
        inputTextView.text = ""
        inputTextView.setToAspectSize()
        
        textViewLine = 1
        
        letterCountWrapperView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 5.0, right: 10.0)
        letterCountWrapperView.isHidden = true
        
        contentTableView.reloadData()
        scrollToBottom()
        
        sendMessageButton.setImage(nil, for: .normal)
        sendMessageButton.setTitle("#", for: .normal)
        sendMessageButton.tintColor = Color.LighterBlack
    }
    
    func sendMessage(owner: User, text: String?, isGPTRoom: Bool = true) {
        
        isGPTRoom
        ? chatViewModel.sendMessageToGPT(text: inputTextView.text)
        : chatViewModel.sendMessage(owner: owner, text: text!)
        
        
        guard !chatViewModel.isMessageEmpty(text) else { return }
        
        resetAfterSendingMessage()
    }
}

extension ChatRoomViewController: UITextViewDelegate {
    func getTextViewHeight() -> Double {
        return inputTextView.getTextViewSize().height
    }

    public func setTextViewHeight() {
        let lines = inputTextView.numberOfLines()
        guard lines <= 5 else { return }
        
        textViewLine = lines
        inputTextView.setToAspectSize()
//        inputTextViewHeight.constant = getTextViewHeight()
    }
    
    func setSendMessageButtonImage(isEmpty: Bool) {
        if isEmpty {
            sendMessageButton.setImage(nil, for: .normal)
            sendMessageButton.setTitle("#", for: .normal)
            sendMessageButton.tintColor = Color.LighterBlack
        } else {
            sendMessageButton.setTitle("", for: .normal)
            sendMessageButton.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
            sendMessageButton.tintColor = Color.Yellow
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        // 글자 수 제한
        guard textView.text.count <= Constants.inputLimit else {
            textView.text = String(textView.text.prefix(Constants.inputLimit))
            
            return
        }
        
        setTextViewHeight()
        
        setSendMessageButtonImage(isEmpty: textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        
        if !textView.text.isEmpty {
            letterCountWrapperView.isHidden = false
            letterCountLabel.text = "\(textView.text.count) / \(Constants.inputLimit)"
        } else {
            letterCountWrapperView.isHidden = true
        }
    }
}
