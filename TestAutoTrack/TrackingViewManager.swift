import UIKit

class TrackingViewManager : NSObject{
    
    static let sharedInstance = TrackingViewManager()
    var timer: Timer!
    var oldp :UnsafeMutableRawPointer = Unmanaged<AnyObject>.passRetained("" as AnyObject).toOpaque()
    
    func start(){
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        self.timer.fire()
    }
    
    func stop() {
        self.timer.invalidate()
    }
    
    func update(tm: Timer) {
        
        if let topController = self.topViewController() {
            
            let newp :UnsafeMutableRawPointer = self.bridge(obj: topController)
            
            if newp == self.oldp {
                
            }else{
                
                self.trackWithPropaty(controller: topController)
                
            }
            
            self.oldp = newp
        }
    }
    
    func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        if let child = controller?.childViewControllers.last {
            return topViewController(controller: child)
        }
        return controller
    }

    
    func trackWithPropaty(controller: UIViewController) {
        print("TrackingViewManager \(self.classNameAsString(obj: controller)) : \(self.propertyMirror(controller: controller).description)")
    }

    func bridge<T: AnyObject>(obj: T) -> UnsafeMutableRawPointer {
        return Unmanaged.passRetained(obj).toOpaque()
    }
    
    func classNameAsString(obj: Any) -> String {
        return String(describing: type(of: obj))
    }
    
    func propertyMirror(controller: Any) -> [String:Any] {
        var dictionary =  [String:Any]()
        
        let mirrored_object = Mirror(reflecting: controller)
        
        for (_, attr) in mirrored_object.children.enumerated() {
            if let labelStr = attr.label as String! {
                let valueStr =  attr.value as? String ?? ""
                dictionary.updateValue(valueStr, forKey: labelStr)
            }
        }
        
        return dictionary
    }
    
}
