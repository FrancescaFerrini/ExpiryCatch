import SwiftUI
import AVFoundation

struct BarcodeScannerView: View {
    @State private var scannedCode: String?
    @State private var isShowingScanner = true
    @State private var isModalPresented = false // New state variable for modal presentation
    internal let captureSession = AVCaptureSession()
    
    @Binding var productResponse: ProductResponse?
    @State var isLoading = false
    @State var errorMessage: String?
    @ObservedObject var savedProduct: SavedFoodViewModel

    var body: some View {
        
            ScannerView(scannedCode: $scannedCode, isShowingScanner: $isShowingScanner, isModalPresented: $isModalPresented, productResponse: $productResponse, savedProduct: savedProduct)
            
                .sheet(isPresented: $isModalPresented) { // Present ModalView as a modal
                    ModalView(isShowingScanner: $isShowingScanner, productResponse: $productResponse, savedProduct: savedProduct, scannedCode: $scannedCode)
                }
        
    }
}

struct ScannerView: UIViewControllerRepresentable {
    @Binding var scannedCode: String?
    @Binding var isShowingScanner: Bool
    @Binding var isModalPresented: Bool // Add isModalPresented binding
    @Binding var productResponse: ProductResponse?
    @State var isLoading = false
    @State var errorMessage: String?
    @ObservedObject var savedProduct: SavedFoodViewModel
    
    typealias UIViewControllerType = ScannerViewController
    
    func makeUIViewController(context: Context) -> ScannerViewController {
        let scannerViewController = ScannerViewController()
        scannerViewController.delegate = context.coordinator
        return scannerViewController
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {
        if context.coordinator.parent.isShowingScanner {
            uiViewController.captureSession.startRunning()
           
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, ScannerViewControllerDelegate {
        var parent: ScannerView

        init(parent: ScannerView) {
            self.parent = parent
        }

        func didFindCode(_ code: String) {
            parent.scannedCode = code
            parent.isShowingScanner = false
            parent.isModalPresented = true
        }
    }
}

protocol ScannerViewControllerDelegate: AnyObject {
    func didFindCode(_ code: String)
}

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    weak var delegate: ScannerViewControllerDelegate?
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var boundingBoxLayer: CAShapeLayer?
    var focusSquareLayer: CAShapeLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.layer.bounds
        focusSquareLayer?.frame = view.layer.bounds
    }

    private func setupCaptureSession() {
        view.backgroundColor = .black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417, .qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
       
        addFocusSquareOverlay()
        captureSession.startRunning()
    }
    
    private func addFocusSquareOverlay() {
        
        let squareSideLength: CGFloat = 200
        let squareRect = CGRect(x: (view.bounds.width - squareSideLength) / 2,
                                y: (view.bounds.height - squareSideLength) / 2,
                                width: squareSideLength,
                                height: squareSideLength)
        
        
        let focusSquarePath = UIBezierPath(rect: squareRect)
        
       
        let focusSquareLayer = CAShapeLayer()
        focusSquareLayer.path = focusSquarePath.cgPath
        focusSquareLayer.fillColor = UIColor.clear.cgColor
        focusSquareLayer.strokeColor = UIColor.white.cgColor
        focusSquareLayer.lineWidth = 2.0
        
       
        view.layer.addSublayer(focusSquareLayer)
        
        
        self.focusSquareLayer = focusSquareLayer
    }

    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
 
        let squareSideLength: CGFloat = 100 // Adjust the size of the square as needed
        let squareRect = CGRect(x: (view.bounds.width - squareSideLength) / 2, y: (view.bounds.height - squareSideLength) / 2, width: squareSideLength, height: squareSideLength)
        

        for metadataObject in metadataObjects {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
                  let stringValue = readableObject.stringValue else { continue }
            
            let transformedBounds = previewLayer.layerRectConverted(fromMetadataOutputRect: readableObject.bounds)
            if squareRect.intersects(transformedBounds) {
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                delegate?.didFindCode(stringValue)
            }
        }
    }
}
/*
struct BarcodeScannerView: View {
    @State private var scannedCode: String?
    @State private var isShowingScanner = true
    @State private var isModalPresented = false // New state variable for modal presentation
    internal let captureSession = AVCaptureSession()
    
    @Binding  var productResponse: ProductResponse?
    @State  var isLoading = false
    @State  var errorMessage: String?
    @ObservedObject var savedProduct: SavedFoodViewModel

    var body: some View {
        
        NavigationStack {
            ScannerView(scannedCode: $scannedCode, isShowingScanner: $isShowingScanner, isModalPresented: $isModalPresented, productResponse: $productResponse, savedProduct: savedProduct) 
                
           
            
        }
        .sheet(isPresented: $isModalPresented) { // Present ModalView as a modal
            ModalView(isShowingScanner: $isShowingScanner, productResponse: $productResponse, savedProduct: savedProduct, scannedCode: $scannedCode)
        }
    }
    
    
   }


struct ScannerView: UIViewControllerRepresentable {
    @Binding var scannedCode: String?
    @Binding var isShowingScanner: Bool
    @Binding var isModalPresented: Bool // Add isModalPresented binding
    @Binding  var productResponse: ProductResponse?
    @State  var isLoading = false
    @State  var errorMessage: String?
    @ObservedObject var savedProduct: SavedFoodViewModel
    
    typealias UIViewControllerType = ScannerViewController
    
    func makeUIViewController(context: Context) -> ScannerViewController {
        let scannerViewController = ScannerViewController()
        scannerViewController.delegate = context.coordinator
        return scannerViewController
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {
        if context.coordinator.parent.isShowingScanner {
               uiViewController.captureSession.startRunning()
           }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, ScannerViewControllerDelegate {
        var parent: ScannerView

        init(parent: ScannerView) {
            self.parent = parent
        }

        func didFindCode(_ code: String) {
            parent.scannedCode = code
            parent.isShowingScanner = false
            parent.isModalPresented = true
        }
    }
}

protocol ScannerViewControllerDelegate: AnyObject {
    func didFindCode(_ code: String)
}

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    weak var delegate: ScannerViewControllerDelegate?
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417, .qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            delegate?.didFindCode(stringValue)
        }
    }
    
}
*/
