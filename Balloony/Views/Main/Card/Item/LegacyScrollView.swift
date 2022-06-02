//
//  LegacyScrollView.swift
//  Balloony
//
//  Created by Wind Versi on 1/6/22.
//

import SwiftUI

struct LegacyScrollView<Content: View>: UIViewControllerRepresentable {
    
    var showsIndicators: Bool
    var offsetToScroll: CGPoint
    var onEndedScrolling: () -> Void
    var onEndedDragging: () -> Void
    @Binding var contentOffset: CGPoint
    var isScrollDisabled: Bool
    @ViewBuilder var content: () -> Content

    func makeUIViewController(context: Context) -> UIScrollViewController<Content> {
        return .init(
            showsIndicators: showsIndicators,
            offsetToScroll: offsetToScroll,
            onEndedScrolling: onEndedScrolling,
            onEndedDragging: onEndedDragging,
            contentOffset: $contentOffset,
            isScrollDisabled: isScrollDisabled,
            contentView: content()
        )
    }
    
    func updateUIViewController(
        _ scrollViewController: UIScrollViewController<Content>,
        context: Context
    ) {
        scrollViewController.hostingController.rootView = content()
        scrollViewController.showsIndicators = showsIndicators
        scrollViewController.isScrollDisabled = isScrollDisabled
        scrollViewController.offsetToScroll = offsetToScroll
    }
    
}

extension UIHostingController {
    
    convenience public init(
        rootView: Content,
        ignoreSafeArea: Bool
    ) {
        self.init(rootView: rootView)
        // removes the extra safe area insets
        if ignoreSafeArea {
            disableSafeArea()
        }
    }
        
    func disableSafeArea() {
        guard let viewClass = object_getClass(view) else { return }
        
        let viewSubclassName = String(cString: class_getName(viewClass)).appending("_IgnoreSafeArea")
        if let viewSubclass = NSClassFromString(viewSubclassName) {
            object_setClass(view, viewSubclass)
        }
        
        else {
            guard let viewClassNameUtf8 = (viewSubclassName as NSString).utf8String
            else { return }
            
            guard let viewSubclass = objc_allocateClassPair(viewClass, viewClassNameUtf8, 0)
            else { return }
            
            if let method = class_getInstanceMethod(
                UIView.self,
                #selector(getter: UIView.safeAreaInsets)
            ) {
                let safeAreaInsets: @convention(block) (AnyObject) -> UIEdgeInsets = { _ in
                    return .zero
                }
                class_addMethod(
                    viewSubclass,
                    #selector(getter: UIView.safeAreaInsets),
                    imp_implementationWithBlock(safeAreaInsets),
                    method_getTypeEncoding(method)
                )
            }
            
            objc_registerClassPair(viewSubclass)
            object_setClass(view, viewSubclass)
        }
    }
}

class UIScrollViewController<Content: View>:
    UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    var scrollView = UIScrollView()
    
    var showsIndicators: Bool = true {
        didSet {
             scrollView.showsVerticalScrollIndicator = showsIndicators
             scrollView.showsHorizontalScrollIndicator = showsIndicators
        }
    }
    
    var offsetToScroll: CGPoint = .zero {
        didSet {
            scrollView.setContentOffset(offsetToScroll, animated: true)
        }
    }
    
    var onEndedScrolling: () -> Void
    
    var onEndedDragging: () -> Void
    
    @Binding var contentOffset: CGPoint
    
    var isScrollDisabled: Bool = false {
        didSet {
            scrollView.isScrollEnabled = !isScrollDisabled
        }
    }
    
    // hosting controller to hold the content view
    // it enables us to convert it to ui view
    var hostingController: UIHostingController<Content>
    
    init(
        showsIndicators: Bool,
        offsetToScroll: CGPoint,
        onEndedScrolling: @escaping () -> Void,
        onEndedDragging: @escaping () -> Void,
        contentOffset: Binding<CGPoint>,
        isScrollDisabled: Bool,
        contentView: Content
    ) {
        self.showsIndicators = showsIndicators
        self.offsetToScroll = offsetToScroll
        self.onEndedScrolling = onEndedScrolling
        self.onEndedDragging = onEndedDragging
        self._contentOffset = contentOffset
        self.isScrollDisabled = isScrollDisabled
        hostingController = .init(rootView: contentView, ignoreSafeArea: true)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set scroll animation duration
        scrollView.setValue(0.1, forKey: "contentOffsetAnimationDuration")
                
        // drag gesture of root view
        let panGestureRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(didPan(_:))
        )
        scrollView.addGestureRecognizer(panGestureRecognizer)
        panGestureRecognizer.delegate = self
        
        // listen to events
        scrollView.delegate = self

        // add scroll view
        hostingController.view.backgroundColor = .clear
        view.addSubview(scrollView)
        
        // add content view
        scrollView.addSubview(hostingController.view)
        
        // add constraints
        addConstraints()
    }
    
    func addConstraints() {
        var constraints = [NSLayoutConstraint]()

        // enable auto layout
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        // add all side constraints
        constraints.append(
            contentsOf: generateAllConstraints(child: scrollView, parent: view)
        )
        
        if let contentView = hostingController.view {
            
            // enable auto layout
            contentView.translatesAutoresizingMaskIntoConstraints = false
            
            // add all side constraints
            constraints.append(
                contentsOf: generateAllConstraints(child: contentView, parent: scrollView)
            )
        }

        // apply constraints
        NSLayoutConstraint.activate(constraints)
    }
    
    func generateAllConstraints(child: UIView, parent: UIView) -> [NSLayoutConstraint] {
        return [
            child.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            child.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            child.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            child.topAnchor.constraint(equalTo: parent.topAnchor)
        ]
    }
    
    func scrollViewDidEndDragging(
        _ scrollView: UIScrollView,
        willDecelerate decelerate: Bool
    ) {
        onEndedScrolling()
    }
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // print("didScroll yPos: ", scrollView.contentOffset)
        DispatchQueue.main.async {
            self.contentOffset = scrollView.contentOffset
        }
    }
    
    @objc private func didPan(_ gesture: UIPanGestureRecognizer) {
        // print("didPan yPos: ", sender.translation(in: view).y)
        if gesture.state == .ended {
            onEndedDragging()
        }
    }

    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true
    }
        
}
