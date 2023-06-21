//
//  ViewController.swift
//  MusicPlayerApp
//
//  Created by Malik A. Aziz Lubis on 20/06/23.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtFieldSearch: UITextField!
    @IBOutlet weak var ctrlPanel: UIView!
    @IBOutlet weak var btnPlay: UIButton!
    
    var selectedIndexPath: IndexPath?
    let viewModel = SongViewModel()
    var selectedSongName = ""
    var isPlay = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        loadData(searchString: "")
        txtFieldSearch.delegate = self
        
        
        // MARK: Inisialisasi gesture recognizer untuk mendeteksi tap pada UIButton
        let tapPlayBtn = UITapGestureRecognizer(target: self, action: #selector(playOrPause))
        btnPlay.addGestureRecognizer(tapPlayBtn)
        btnPlay.isUserInteractionEnabled = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // MARK: Menyembunyikan UIView saat aplikasi baru dijalankan
        ctrlPanel.isHidden = true
    }
    
    private func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SongTableViewCell", bundle: nil), forCellReuseIdentifier: "SongTableViewCell")
    }
    
    private func loadData(searchString: String) {
        viewModel.getSong(searchString: searchString) {
            DispatchQueue.main.async {
                self.selectedIndexPath = nil
                self.tableView.reloadData()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        // MARK: Jalankan kode searchSong jika tombol Return ditekan
        searchSong(text: textField.text ?? "")
        return true
    }
    
    private func searchSong(text: String) {
        loadData(searchString: text)
    }
    
    @objc func showCtrlPanel() {
        ctrlPanel.isHidden = !ctrlPanel.isHidden
    }
    
    @objc func playOrPause() {
        if isPlay {
            btnPlay.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            btnPlay.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        
        isPlay.toggle()
        print(isPlay)
        if let selectedIndexPath = selectedIndexPath {
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cSong = viewModel.songs.first?.tracks.items.count ?? 0
        return cSong
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell") as? SongTableViewCell {
            cell.loadCellData(model: viewModel.songs.first!.tracks.items[indexPath.row])
            
            if selectedIndexPath == indexPath {
                // Show the image view
                cell.backgroundColor = .systemGray4
                if isPlay {
                    btnPlay.setImage(UIImage(systemName: "play.fill"), for: .normal)
                    cell.imgSongSelected.isHidden = true
                } else {
                    btnPlay.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                    cell.imgSongSelected.isHidden = false
                }
                
                if ctrlPanel.isHidden {
                    showCtrlPanel()
                }
            } else {
                // Hide the image view
                cell.imgSongSelected.isHidden = true
                cell.backgroundColor = .white
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previouslySelectedIndexPath = selectedIndexPath
        selectedIndexPath = indexPath
        tableView.reloadRows(at: [indexPath, previouslySelectedIndexPath].compactMap({ $0 }), with: .none)
    }
}



