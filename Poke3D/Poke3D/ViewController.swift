//
//  ViewController.swift
//  Poke3D
//
//  Created by Rafael Carvalho on 12/08/22.
//

import UIKit
import SceneKit
import ARKit


class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Acionar a luz
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Criar a referência para o seu .png
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) {
            
            configuration.detectionImages = imageToTrack
            
            //O valor máximo é 4.
            configuration.maximumNumberOfTrackedImages = 2
            
            print("IMGs Armazendos...")
        }else{
            print("erro....")
        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    // renderes vai ser chamado quando alguma img do AR Resource Group for detectada
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor{
            
            //Identificar a imagem
            //print(imageAnchor.referenceImage.name)
            
            let plane = SCNPlane(
                width: imageAnchor.referenceImage.physicalSize.width,
                height: imageAnchor.referenceImage.physicalSize.height
            )
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.8)
            
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -Float.pi / 2
            
            node.addChildNode(planeNode)
            
            //VULPIX
            if imageAnchor.referenceImage.name == "vulpix" {
                //Criar o node do objeto 3d do vulpix
                if let pokeScene = SCNScene(named: "art.scnassets/Vulpix/Vulpix.scn"){
                    
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        
                        //Rotaciona o nó do pokemom (pois o node do lano "já está rotacionado também"...)
                        pokeNode.eulerAngles.x = Float.pi / 1
                        
                        //Adiciona esse node criado com o objeto 3d, no node da cena
                        planeNode.addChildNode(pokeNode)
                        
                    }else{
                        print("Não foi encontrado o primeiro node do objeto Vulpix.scn")
                    }
                    
                }else{
                    print("Não foi encontrado o modelo 3d Vulpix.scn")
                }
            }
            
            //LAMPENT
            if imageAnchor.referenceImage.name == "lampent" {
                //Criar o node do objeto 3d do vulpix
                if let pokeScene = SCNScene(named: "art.scnassets/Gengar/Gengar.scn"){
                    
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        
                        //Rotaciona o nó do pokemom (pois o node do lano "já está rotacionado também"...)
                        pokeNode.eulerAngles.x = Float.pi / 2
                        
                        //Adiciona esse node criado com o objeto 3d, no node da cena
                        planeNode.addChildNode(pokeNode)
                        
                    }else{
                        print("Não foi encontrado o primeiro node do objeto Gengar.scn")
                    }
                    
                }else{
                    print("Não foi encontrado o modelo 3d Gengar.scn")
                }
            }
            
            
            
        }
        
        return node
    }
    
}
