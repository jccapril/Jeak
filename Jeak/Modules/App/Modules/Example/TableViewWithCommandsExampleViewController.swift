//
//  File.swift
//  App
//
//  Created by Flutter on 2021/3/12.
//

import UICore
import RxDataSources

class TableViewWithCommandsExampleViewController: ViewController {

    static let reuseId = "TableViewWithCommandsExampleViewControllerCell"
    lazy var tableView: UITableView = {
        let lazy = UITableView(frame: .zero, style: .plain)
        lazy.backgroundColor = .white
        lazy.register(UITableViewCell.self, forCellReuseIdentifier: TableViewWithCommandsExampleViewController.reuseId)
        return lazy
    }()
    
    let dataSource = TableViewWithCommandsExampleViewController.configureDataSource()
}



// MARK: - Override

extension TableViewWithCommandsExampleViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        
//        let superMan =  User(
//            firstName: "Super",
//            lastName: "Man",
//            imageURL: "http://nerdreactor.com/wp-content/uploads/2015/02/Superman1.jpg"
//        )
//
//        let watMan = User(firstName: "Wat",
//            lastName: "Man",
//            imageURL: "http://www.iri.upc.edu/files/project/98/main.GIF"
//        )
//        
//        let loadFavoriteUsers = RandomUserAPI.sharedAPI
//            .getExampleUserResultSet()
//            .map(TableViewCommand.setUsers)
//            .catchAndReturn(TableViewCommand.setUsers(users: []))
        
        
//        let initialLoadCommand = Observable.just(TableViewCommand.setFavoriteUsers(favoriteUsers: [superMan, watMan]))
//                .concat(loadFavoriteUsers)
//                .observe(on:MainScheduler.instance)
        
    
        
    }
    
}

// MARK: - Private

private extension TableViewWithCommandsExampleViewController {
    
    /// UI
    func setup() {
        
        self.title = "TableViewWithCommands"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        
        
    }
    
}

extension TableViewWithCommandsExampleViewController: UITableViewDelegate {
    // MARK: Work over Variable
    
    static func configureDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel<String, User>> {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, User>>(
            configureCell: { (_, tv, ip, user: User) in
                let cell = tv.dequeueReusableCell(withIdentifier: reuseId)!
                cell.textLabel?.text = user.firstName + " " + user.lastName
                return cell
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].model
            },
            canEditRowAtIndexPath: { (ds, ip) in
                return true
            },
            canMoveRowAtIndexPath: { _, _ in
                return true
            }
        )

        return dataSource
    }
}






struct User: Equatable, CustomDebugStringConvertible{

    var firstName: String
    var lastName: String
    var imageURL: String
    
}

extension User {
    var debugDescription: String {
        firstName + " " + lastName
    }
}


struct TableViewWithCommandsViewModel {
    let favouriteUsers: [User]
    let users: [User]
    
    static func executeCommand(state: TableViewWithCommandsViewModel, _ command: TableViewCommand) -> TableViewWithCommandsViewModel {
        switch command {
        case let .setUsers(users):
            return TableViewWithCommandsViewModel(favouriteUsers: state.favouriteUsers, users: users)
        case let .setFavoriteUsers(favoriteUsers):
            return  TableViewWithCommandsViewModel(favouriteUsers: favoriteUsers, users: state.users)
        case let .deleteUser(indexPath):
            var all = [state.favouriteUsers,state.users]
            all[indexPath.section].remove(at: indexPath.row)
            return TableViewWithCommandsViewModel(favouriteUsers: all[0], users: all[1])
        case let .moveUser(from, to):
            var all = [state.favouriteUsers,state.users]
            let user = all[from.section][from.row]
            all[from.section].remove(at: from.row)
            all[to.section].insert(user, at: to.section)
            return TableViewWithCommandsViewModel(favouriteUsers: all[0], users: all[1])
        }
    }
}

enum TableViewCommand {
    case setUsers(users: [User])
    case setFavoriteUsers(favoriteUsers: [User])
    case deleteUser(indexPath: IndexPath)
    case moveUser(from: IndexPath, to: IndexPath)
}
