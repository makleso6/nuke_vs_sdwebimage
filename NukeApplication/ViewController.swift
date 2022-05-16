//
//  ViewController.swift
//  NukeApplication
//
//  Created by Maksim Kolesnik on 13.05.2022.
//

import UIKit
import Nuke
import NukeWebPBasic
import NukeWebPAdvanced
import NukeWebP
import Pulse
import PulseCore

class ViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var imageData: Data!
    var webpData: Data!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
//        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        WebPImageDecoder.enable(closure: {
            var options = WebPDecoderOptions()
            options.useThreads = false
//            return AdvancesWebPDecoder(options: options)
//            return BasicWebPDecoder()
            return ObjcWebPDecoder()
        })
        
        let pipeline = ImagePipeline {
            $0.isProgressiveDecodingEnabled = true
        }
        
        ImagePipeline.shared = pipeline
//        (ImagePipeline.shared.configuration.dataLoader as? DataLoader)?.session.configuration.urlCache?.removeAllCachedResponses()

//        let url = "https://yastatic.net/s3/edadeal-public-static/makleso/big.webp"
        let url = "https://leonardo.edadeal.io/dyn/re/icons/tabbar/v1/catalog-off-EDADEALAPPS-143.png?res=l"
        let holder = Holder(value: AnyIterator([url].makeIterator()))
//        let holder = Holder(value: AnyIterator([images[10]].makeIterator()))
//        let holder = Holder(value: AnyIterator([images[10]].makeIterator()))
//        let holder = Holder(value: AnyIterator(images.makeIterator()))
        if let next = holder.value.next() {
            load(url: next, holder: holder)
        }
    }
    
    func load(url: String, holder: Holder<AnyIterator<String>>) {
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.setValue("image/webp,image/*,*/*;q=0.8", forHTTPHeaderField: "Accept")
        
        let request = ImageRequest(urlRequest: urlRequest)
        Nuke.loadImage(
            with: request,
            options: ImageLoadingOptions.shared,
            into: imageView,
            progress: { intermediateResponse, completedUnitCount, totalUnitCount in
                print("completedUnitCount", completedUnitCount)
                print("totalUnitCount", totalUnitCount)
//                sleep(1)
            }, completion: { [weak self] result in
                switch result {
                case .success(let imageResponse):
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250), execute: {
                        if let next = holder.value.next() {
                            self?.load(url: next, holder: holder)
                        }
                    })
//                    print(imageResponse.urlResponse ?? "")
                    
                    
                case .failure(let error):
                    print(error)
                }
                
//                print("result", result)
            }
        )
    }
}

class Holder<T> {
    var value: T
    init(value: T) {
        self.value = value
    }
}

var images: [String] = [
    "https://leonardo.edadeal.io/dyn/re/icons/tabbar/v1/catalog-off-EDADEALAPPS-143.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/icons/tabbar/v1/cashback-off-EDADEALAPPS-143.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/icons/tabbar/v1/coupon-off-EDADEALAPPS-143.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/icons/tabbar/v1/spisok-off-EDADEALAPPS-143.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/icons/tabbar/v1/profile-off-EDADEALAPPS-143.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/icons/tabbar/v1/catalog-on-EDADEALAPPS-143.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/icons/tabbar/v1/cashback-on-EDADEALAPPS-143.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/icons/tabbar/v1/coupon-on-EDADEALAPPS-143.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/icons/tabbar/v1/spisok-on-EDADEALAPPS-143.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/icons/tabbar/v1/profile-on-EDADEALAPPS-143.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/djrzrkbzgrgdh466q6orvbepr4.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/5e2c8b28e2a04eb29e528dfbf006a4d2.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/d54hmaruotlxc7aibodovv4diq.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/fjpxm45nsaq2nwfw6xdbzwbkkm.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/pdf-pages/wzhkhs3e6egarfa4f7d3tyzr3a/0.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/a867309952814362af7d5d987c2bf1e7.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/4ghsfh6fdd4nt2kconirtjaqmy.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/o3qpiwhhwv3dchai3prz2q5hii.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/0f379ad944934e3f8b572198ae09bed7.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/catalogs/feedonyanya_img/vkusvill_offline/1874/vv_edadeal.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/l7wupe76haflzrajiea6sjjne4.png?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/bbd16a9de3c44be0808cc9436dd283d4.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/urgxh5ifv26uzyf2tx4bsqjq4q.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/pdf-pages/b2cvghiboqvlww2aep2kn6ua4u/0.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/kfiqid7ekzbhd72wsthjkxtrsm.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/7746764eed2e485cb3776c6a2e1d3fc4.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/minzuryveemw2uexouo2oscvge.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/rect/ret_11.png?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/1d10e1a0ff964aa7976e663dc64d13fe.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/7koj4jsm4cb5ubxjopnl4qwvnu.png?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalogs/feedonyanya_img/magnolia/509/9.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/cbb848d205f64abd96764b8e23252e0f.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/j4ureiqv6ibjfh47525jkyhyqi.png?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalogs/feedonyanya_img/lenta_supermarket/415/microsoftteams-image-3.png?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/pdf-pages/qoqphjpwpxnk2adiuwsznrbcqi/0.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/2a3ab9607a4b47ccb32f1283856ebf3b.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/rect/c48728707d8746a380511beed76960b7.png?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/pdf-pages/lkt35wfnuiu5olaqvuuzq4v4ku/0.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/71b90b41799243f0b9c78b0197282a5f.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/zdzi5ronjl7rhhafcl4pfxhccy.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/i55pcwmapmaryfi744mtemtwv4.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/7ec8dff920d345ad8f80f225259eea97.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/upketi65ccskke4uiiipkxk5ai.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/3cgc5ua646qff3i2g722tg6up4.png?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/2ssswsjpxi5hrngo4snov3vjsy.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/ff755badd7494218a01e1730ef19cd76.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/42d6gs42dtu24c5tuyxdelvwgy.png?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/pdf-pages/6toy7thdfvmqp5f7d7b4aktcea/0.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/ddaca88c708d4087a07419512c71ffa2.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/rect/ret_32.png?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalogs/feedonyanya_img/korablik/694/7b8f6ead4f978e5e8212880697018412.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/545e8a187ec74cdd9765eff39301c29d.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/jumycfc2c5gqzwc55ugr5u66em.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/f4m5cqkuuf76ui4xq5eqjssqru.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/60442be8efe24bfaadba7c485886adca.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/tsdlhubz6a5rzsmmtiboorqdki.png?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/pdf-pages/7jupikm67rhtujsyjqg4mtftga/0.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/vackw7ydtny52zrmrssqz6do3m.png?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/7705f08a0cd64af98d18d3a85b250d0e.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/tsdlhubz6a5rzsmmtiboorqdki.png?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/pdf-pages/jvmb3dkiac7vcumugj3vuxzkju/0.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/6945d169071a420d822f181ed2a4d92f.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/5eqkv7eota2h3pojrpv3frru6u.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalogs/feedonyanya_img/lenta_gipermarket/428/microsoftteams-image-7.png?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/uwfwrss7gxzdmbcfponk4reaeu.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/e9ae6fd320c646958517dcf025d64f3e.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/vm4vefwdb3c7vqpfcxiphmduwa.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/e4vfvszpc5gw4bv75n2v3toyme.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/70489a7ea89e476b8392d3c02cb00ff1.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/b72kcol6fttodolu6sso2am4o4.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/h6zve53eixieoxnsxbjvwtease.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/cc55d57229e2487a8602e1c2e6a3f3ef.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/tsdlhubz6a5rzsmmtiboorqdki.png?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/pdf-pages/64e3z6uicrghl5ypmszrasd3we/0.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/catalyst/covers/tiaavrwm3qjhbjjlpgujivdjvu.jpg?ex=edadeal-leonardo&res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/8260036bace34369954f2147862d6dad.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/a99b356ffcb24bd7a40c99ff8ad45eec.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/dc1b8e19af8b4a16b6485c379c4d68ac.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/c1a8f23e789543f0944447fe54ef8e22.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/8f9ffd7cb16148f2bfb6b8b0cd649066.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/40a311afdf8b4ed19b5b639d95b863d0.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/7a88eb626d8e478e84644dc700d4787f.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/b10b9eece924441b9b8cd46fa8c3634d.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/6717352a758842469d1baf8d39c93308.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/380c2678b4ad44cdbe0c91c289caaff9.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/06774320123d41829ea6882cf17abb79.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/679df56f68e2489cbf2e5bd3d5f3e6b1.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/bddfb454d88b477285750aeaee64a7fd.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/256ca199592546919f69ab5c77f9495f.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/2b3f56830eef49bfa908906a99b73fc2.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/e4bb1f07de89470495434e869bce2603.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/709408c3cd934294a3a8a71fcc99fdb2.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/cc6bb292616b439286670bd15c1923c2.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/5582f72308974124ba9d5107ab44e4f7.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/95b8486c9af943ca9f9917dc350d186c.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/42792250bd964a3492289c1b13b23bba.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/0520303eb83b41d7a523e2cb285e1e45.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/6b174ba17d414718a6a3926e45ac4e60.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/a608bdda184d43d4ac2a2408aafa012c.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/713e5e0b317e4390a91d4568f01d4307.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/b6094e51645b4cb595f682546ce55dfb.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/194846b6c2c84973abaa99ef34436cb2.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/2ccf64f3c7c44613ba3d0b3939f15b5e.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/f5a51c397ff548a3bc47c32b03906fbf.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/2c7fa02e4ae741e6bc834bf2660676e7.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/c4141e441597405ca3183c291cd76922.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/1154b0e3b4a748bdaf54723525ea3c09.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/1a22b8cdcdd6496d899dc8da1cb2ce36.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/ret_871.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/ret_158.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/30fe2322ed93432884afb06e581f53b1.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/d4639b22db304b2d95c603547beb77d8.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/ret_618.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/ret_417.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/ret_54.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/ret_704.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/d92dc71be3c64f50847a2eb6cc3bcfd5.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/75960103ad1b4db2a5147fa40fbdf563.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/74e9f2458d704c8191001e66660f928c.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/ret_16.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/ret_864.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/ret_1129.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/a5393137b6814e2e90424d346de6d179.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/bc64c86ec5f44307b9e25691b7828d47.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/ret_844.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/ret_92.png?res=l",
    "https://leonardo.edadeal.io/dyn/re/retailers/images/logos/sq/ret_981.png?res=l"
]

public final class ObjcWebPDecoder: WebPDecoding {
    lazy var decoder: WebPDataDecoder = {

        return WebPDataDecoder()
    }()

    public func decode(data: Data) throws -> NukeWebP.ImageType {
        if let image = decoder.decode(data) {
            return image
        } else {
            throw WebPDecodingError.unknownError
        }
    }

    public func decodei(data: Data) throws -> NukeWebP.ImageType {
        print("[decodei] 1")
        if let image = decoder.incrementallyDecode(data) {
            print("[decodei] 2")
            return image
        } else {
            throw WebPDecodingError.unknownError
        }
    }
}
