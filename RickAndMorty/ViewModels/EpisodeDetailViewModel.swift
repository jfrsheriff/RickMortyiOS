//
//  EpisodeDetailViewModel.swift
//  RickAndMorty
//
//  Created by Jaffer Sheriff U on 25/02/23.
//

import Foundation

protocol EpisodeDetailViewModelDelegate : AnyObject {
    func didFetchEpisodeDetails()
}

final class EpisodeDetailViewModel{
    
    private let episodeEndPointUrl : URL?
    
    public weak var delegate : EpisodeDetailViewModelDelegate?
    
    private var dataTuple : (RMEpisode,[RMCharacter.RMCharacterResult])? {
        didSet{
            createCellViewModel()
            delegate?.didFetchEpisodeDetails()
        }
    }
    
    enum SectionType{
        case information(viewModel : [EpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel : [RMCollectionViewCellViewModel])
    }
    
    public private(set) var cellViewModel : [SectionType] = []
    
    init(episodeURL : URL?) {
        self.episodeEndPointUrl = episodeURL
    }
    
    public func fetchEpisodeData(){
        guard let url = episodeEndPointUrl, let request = Request(with: url) else {return}
        Service.shared.execute(request,
                               expection: RMEpisode.self) {[weak self] result in
            switch result {
            case .success(let success):
                print("Sucess")
                self?.fetchCharactersData(episode: success)
            case .failure(let failure):
                print("Failure : \(failure)")
            }
        }
    }
    
    
    private func fetchCharactersData(episode : RMEpisode){
        let episodeRequests : [Request] = episode.characters.compactMap{URL(string: $0)}.compactMap { Request(with: $0) }
        let group = DispatchGroup()
        
        var characters : [RMCharacter.RMCharacterResult] = []
        
        episodeRequests.forEach { request in
            group.enter()
            Service.shared.execute(request, expection: RMCharacter.RMCharacterResult.self){ result in
                defer{
                    group.leave()
                }
                switch result{
                case .success(let success):
                    characters.append(success)
                    print(success)
                    print("Success")
                case .failure(let failure):
                    print("Failure : \(failure)")
                }
            }
        }
        group.notify(queue: .main){[weak self] in
            print(episodeRequests.count)
            self?.dataTuple = (episode,characters)
        }
    }
    
    
    private func createCellViewModel(){
        guard let data = dataTuple else {return}
        let episode = data.0
        let characters = data.1
        
        cellViewModel = [
            .information(viewModel: [
                EpisodeInfoCollectionViewCellViewModel(title: "Episode Name", value: episode.name),
                EpisodeInfoCollectionViewCellViewModel(title: "Aired On", value: episode.air_date),
                EpisodeInfoCollectionViewCellViewModel(title: "Episode", value: episode.episode),
            ]),
            .characters(viewModel: characters.compactMap({ character in
                return RMCollectionViewCellViewModel(characterName: character.name,
                                                     characterStatus: character.status,
                                                     characterImgUrl: URL(string: character.image) )
            }))
        ]
    }
    
}
