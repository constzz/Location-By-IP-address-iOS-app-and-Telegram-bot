import UIKit

class MainScreenViewController: UIViewController {
    
    private var mainScreenPresenter: MainScreenPreseneterProtocol
    
    private lazy var programDesciptionLabel = makeProgramDesciptionLabel()
    private lazy var getLocationButton = makeGetLocationButton()
    
    init(mainScreenPresenter: MainScreenPreseneterProtocol) {
        self.mainScreenPresenter = mainScreenPresenter
        super.init(nibName: nil, bundle: nil)
        self.mainScreenPresenter.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupAutolayout()
    }
    
    @objc private func onGetLocationButtonClicked() {
        mainScreenPresenter.getLocationData()
    }
}

//MARK: UI Setups
extension MainScreenViewController {
    
    private func makeProgramDesciptionLabel() -> UILabel {
        let label = UILabel()
        label.text = "When you press the button: \n1. It determines your IP adress \n2. It gets your approxiamte location \n3. It sends it to telegram bot :)"
        label.textColor = .darkText
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }
    
    private func makeGetLocationButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Get location", for: .normal)
        button.backgroundColor = .systemTeal
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        button.titleLabel?.numberOfLines = 0
        button.layer.cornerRadius = CGFloat(16)
        return button
    }
    
    private func setupViews() {
        view.addSubview(programDesciptionLabel)
        view.addSubview(getLocationButton)
        getLocationButton.addTarget(self, action: #selector(onGetLocationButtonClicked), for: .touchUpInside)
    }
    
    private func setupAutolayout() {
        programDesciptionLabel.translatesAutoresizingMaskIntoConstraints = false
        getLocationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            programDesciptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            programDesciptionLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            programDesciptionLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            programDesciptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: getLocationButton.topAnchor, constant: 0),
            
            getLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            getLocationButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            getLocationButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            getLocationButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)
        ])
    }
}

//MARK: Implementing presenter's view protocol
extension MainScreenViewController: MainScreenView {
    
    func showLocationData(_ locationData: LocationData) {
        let alert = UIAlertController(title: "Show location?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Show", style: .default, handler: {
            [weak self] UIAlertAction in
            self?.openMap(destinationName: "This is the approximate location of the device", latitude: locationData.loc.latitude, longitude: locationData.loc.longitude)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { UIAlertAction in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showInfoDialog(title: String, message: String, canBeCancelled: Bool = true) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        if canBeCancelled {
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        }
        self.present(alert, animated: true, completion: nil)
    }
}

