//
//  TasksViewController.swift
//  Tasky
//
//  Created by Giovanna Moeller on 28/05/24.
//

import UIKit

protocol TaskDelegate: AnyObject {
    func didAddTask()
}

class TasksViewController: UIViewController {
        
    private lazy var tasksTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 24.0
        let header = TasksTableViewHeader(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64.0))
        tableView.tableHeaderView = header
        header.delegate = self
        return tableView
    }()
    
    private lazy var taskIllustrationImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: AssetsConstants.tasksIllustration))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        addGradientBackground()
        addSubviews()
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
    }
    
    private func addSubviews() {
        view.addSubview(taskIllustrationImageView)
        view.addSubview(tasksTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            taskIllustrationImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            taskIllustrationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tasksTableView.topAnchor.constraint(equalTo: taskIllustrationImageView.bottomAnchor),
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tasksTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = tasks[indexPath.row].title
        content.secondaryText = tasks[indexPath.row].description ?? ""
        cell.contentConfiguration = content
        cell.accessoryView = createTaskCheckmarkButton()
        return cell
    }
    
    private func createTaskCheckmarkButton() -> UIButton {
        let completeButton = UIButton(type: .system)
        let symbolName = "checkmark.circle"
        let configuration = UIImage.SymbolConfiguration(pointSize: 24)
        let image = UIImage(systemName: symbolName, withConfiguration: configuration)
        completeButton.setImage(image, for: .normal)
        completeButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        return completeButton
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tasksTableView.reloadData()
        }
    }
}

extension TasksViewController: TasksTableViewHeaderDelegate {
    func didTapAddTaskButton() {
        let addTaskVC = AddTaskViewController()
        addTaskVC.delegate = self
        navigationController?.present(addTaskVC, animated: true)
    }
}

extension TasksViewController: TaskDelegate {
    func didAddTask() {
        tasksTableView.reloadData()
    }
}
