//
//  ContentView.swift
//  Shared
//
//  Created by David on 02/16/23.
//

import SwiftUI
import AVFoundation
import Firebase
import FirebaseStorage
import Photos

struct CameraView_Previews: PreviewProvider {
        static var previews: some View {
            CameraView()
        }
    }
struct CameraPreview: UIViewRepresentable {
    
    @ObservedObject var camera : CameraModel
    
    func makeUIView(context: Context) ->  UIView {
        
        let view = UIView(frame: UIScreen.main.bounds)
        
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        
        // Your Own Properties...
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        // starting session
        camera.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

struct CameraView: View {
    
    @State private var selectedImage: UIImage?
    @StateObject var camera = CameraModel()
    @State private var showNewPostView = false
    
    
    var body: some View{
        
        
        ZStack{
            
            // Going to Be Camera preview...
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            
            
            VStack{
                
                
                
            
                if camera.isTaken{
                    
                    HStack {
                        
                        Spacer()
                        
                        
                        Button(action: camera.reTake, label: {
                            
                            Image(systemName: "arrow.uturn.backward")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        })
                        .padding(.trailing,10)
                    }
                }
                
                Spacer()
                
                HStack{
                    
                    // if taken showing save and again take button...
                    
                    if camera.isTaken{
                        Button(action: {
                            if !camera.isSaved{
                                camera.savePic(){ image in
                                    if let cameraImage = image {
                                        selectedImage = cameraImage
                                    } else{
                                        print("ERROR")
                                    }
                                }
                                showNewPostView.toggle()
                            }
                        },
                               label: {
                            Text(camera.isSaved ? "Flexed On" : "Flex")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical,10)
                                .padding(.horizontal,20)
                                .background(Color.white)
                                .clipShape(Capsule())
                        })
                        .padding(.leading)
                        .fullScreenCover(isPresented: $showNewPostView) {
                            NewPostView(selectedImage: selectedImage)
                        }
                        
                        Spacer()
                    }
                    else{
                        ZStack {
                            
                            Button(action: camera.changeTorchStatus, label: {
                                HStack{
                                    
                                    
                                    ZStack {
                                        
                                        
                                        if(camera.torchStatus){
                                            
                                            Image(systemName: "bolt.fill")
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 20)
                                                .padding(.bottom, 1300)
                                                .font(.system(size: 35))
                                        }
                                        else{
                                            Image(systemName: "bolt.slash.fill")
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 20)
                                                .padding(.bottom, 1300)
                                                .font(.system(size: 35))
                                        }
                                        
                                        
                                    }
                                    
                                    Spacer()
                                }
                                
                            })
                            
                            Spacer()
                            
                            Button(action: camera.switchCamera, label: {
                                Spacer()
                                Image(systemName: "arrow.triangle.2.circlepath.camera.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 35))
                                    .padding(.horizontal, 40)
                                    .padding(.bottom, 50)
                                
                            })
                            
                            Button(action: camera.takePic, label: {
                                
                                
                                ZStack{
                                    
                                    
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 65, height: 65)
                                    
                                    Circle()
                                        .stroke(Color.white,lineWidth: 2)
                                        .frame(width: 75, height: 75)
                                }
                                .padding(.bottom, 50)
                                
                                
                            })
                            
                            if(camera.takePicStatus && !camera.backCamera && camera.torchStatus){
                                Rectangle()
                                    .fill(Color.white.opacity(0.85))
                                    
                                    .frame(width: 425, height: 1600)
                            }
                            
                            
                        }
                    }
                    
                    
                }
                
                .frame(height: 75)
            }
        }
        .onAppear(perform: {
            //used to be camera.check()
            camera.Check()
        })
        .alert(isPresented: $camera.alert) {
            Alert(title: Text("Please Enable Camera Access"))
        }
    }
    
}

// Camera Model...

class CameraModel: NSObject,ObservableObject,AVCapturePhotoCaptureDelegate, AVCaptureFileOutputRecordingDelegate{
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if error != nil {
            print(error?.localizedDescription)
            return
        }
        
        previewURL = outputFileURL
        self.isTaken = true
        
        do {
            try self.mediaData = Data(contentsOf: outputFileURL)
        } catch {
            print("error occurred")
        }
    }
    
    @Published var takePicStatus = false
    
    @Published var torchStatus = false
    
    @Published var backCamera = true
    
    @Published var previewURL:URL?
    
    @Published var mediaData = Data(count: 0)
    
    @Published var video: Bool = false
    
    @Published var isTaken = false
    
    
    //@Published var torchStatus = false
    
    @Published var session = AVCaptureSession()
    
    @Published var alert = false
    
    // since were going to read pic data....
    @Published var output = AVCapturePhotoOutput()
    
    // preview....
    @Published var preview : AVCaptureVideoPreviewLayer!
    
    // Pic Data...
    
    @Published var isSaved = false
    
    @Published var isPosted = false
    
    @Published var picData = Data(count: 0)
    
    @Published var position :AVCaptureDevice.Position = .back
    
    
    
    func Check(){
        
        // first checking camera has got permission...
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp()
            
            return
            // Setting Up Session
        case .notDetermined:
            // retrusting for permission....
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                
                if status{
                    
                    self.setUp()
                    
                }
            }
        case .denied:
            self.alert.toggle()
            return
            
        default:
            return
        }
    }
    
    func setUp(){
        
        // setting up camera...
        
        do{
            
            // setting configs...
            self.session.beginConfiguration()
            
            // change for your own...
            //This might be the orientation or the back camera
            //used to be : AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            
            let newPosition: AVCaptureDevice.Position = position == .back ? .front : .back
            
            
            let input = try AVCaptureDeviceInput(device: device!)
            
            // checking and adding to session...
            
            if self.session.canAddInput(input){
                self.session.addInput(input)
            }
            
            // same for output....
            
            if self.session.canAddOutput(self.output){
                self.session.addOutput(self.output)
            }
            
            self.session.commitConfiguration()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    //Transfered over
    let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes:
                                                                [.builtInTrueDepthCamera, .builtInDualCamera, .builtInWideAngleCamera],
                                                            mediaType: .video, position: .unspecified)
    
    
    func changeTorchStatus(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation{self.torchStatus.toggle()
                
            }
        }
    }
    
    // take and retake functions...
    
    func takePic(){
        
        buttonPressed()
        
        
        if(torchStatus && backCamera){
            toggleTorch(on: true) // flashlight
        }
        
        
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.24) {
                
                
                self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
                
                
        }
            
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    
                    
                    self.session.stopRunning()
                    
                    
            }
            
            
            
            withAnimation{self.isTaken.toggle()}
            
       // }
    }
    
    func reTake(){
        
        DispatchQueue.global(qos: .background).async {
            
            self.session.startRunning()
            
            DispatchQueue.main.async {
                withAnimation{self.isTaken.toggle()}
                //clearing ...
                self.isSaved = false
                self.picData = Data(count: 0)
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if error != nil{
            return
        }
        
        print("pic taken...")
        
        guard let imageData = photo.fileDataRepresentation() else{return}
        
        self.picData = imageData
    }
    //ISSUE IS HERE
    func savePic(completion: @escaping (UIImage?) -> Void){
    
        self.isSaved = true
        
        
        self.sendMostRecentPhotoToFirebase()
        
        
        print("Saved Successfully....")
    
        guard let image = UIImage(data: self.picData) else{return}
        
        // saving Image...
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        //
        completion(image)
    }
    
    func uploadImageToFirebase(image: UIImage, completion: @escaping (String?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/post_images/\(filename)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("Failed to upload image \(error.localizedDescription)")
                return
            }

            ref.downloadURL { imageUrl, _ in
                        guard let imageUrl = imageUrl?.absoluteString else {
                            completion(nil)
                            return
                        }
                        print("Got image url ")
                        completion(imageUrl)
                    }
        }
    }
    func sendMostRecentPhotoToFirebase() {
        print("Started Uploaded Image")
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.fetchLimit = 1

        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)

        if let asset = fetchResult.firstObject {
            let manager = PHImageManager.default()
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true

            manager.requestImage(for: asset,
                                 targetSize: CGSize(width: 500, height: 500),
                                 contentMode: .aspectFill,
                                 options: requestOptions) { image, _ in
                if let image = image {
                    self.uploadImageToFirebase(image: image){ _ in }
                    print("Camera Image is stored")
                }
            }
        }
    }
    

    
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
                
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    
    func switchCamera() {
        // Begin configuring capture session
        session.beginConfiguration()
        
        
        // Get current input
        guard let currentInput = session.inputs.first as? AVCaptureDeviceInput else { return }
        
        // Remove current input
        session.removeInput(currentInput)
        
        // Get new device position
        let newPosition: AVCaptureDevice.Position = position == .back ? .front : .back
        
        // Get new device
        
        let newDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: newPosition)
        
        // Create new input
        do {
            let newInput = try AVCaptureDeviceInput(device: newDevice!)
            session.addInput(newInput)
            position = newPosition
            
            // Commit configuration changes
            session.commitConfiguration()
        } catch {
            print(error.localizedDescription)
        }
        
        if (newPosition == AVCaptureDevice.Position.back){
            self.backCamera = true
        }
        else if (newPosition == AVCaptureDevice.Position.front){
            self.backCamera = false
        }
        print("Back Camera = ")
        print(backCamera)
        
    }
    
    
    func frontCameraFlash(frontFlash: Bool) -> Bool {
        if(backCamera == false && torchStatus == true){
            return true
        }
        else
        {
            return false
            
        }
    }
    
    func dismiss() {
        // Do something to dismiss the screen
        print("Dismiss screen")
    }
    func buttonPressed(){
        if(!backCamera){
        self.takePicStatus.toggle()
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.takePicStatus.toggle()
        }
    }
    }
    
    
}


//scrapped

//    func uploadImageToDatabase(image: UIImage, completion: @escaping(String) -> Void){
//
////        guard let imageData = UIImage(data: self.picData) else{return}
//
//        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
//
//        let filename = NSUUID().uuidString
//
//        let ref = Storage.storage().reference(withPath: "/post_images/\(filename)")
//
//        ref.putData(imageData, metadata: nil) { _, error in
//            if let error = error{
//                print("Failed to upload image \(error.localizedDescription)")
//                return
//            }
//
//            ref.downloadURL {imageUrl, _ in
//                guard let imageUrl = imageUrl?.absoluteString else {return}
//                completion(imageUrl)
//            }
//        }
//        self.isPosted = true
//    }
