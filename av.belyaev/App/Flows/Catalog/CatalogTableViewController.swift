/**
 * Контроллер каталога товара
 */

import UIKit

class CatalogTableViewController: UITableViewController {
    
    let catalogService: CatalogRequestFactory = RequestFactory().makeCatalogRequestFactory()
    var products: [ProductSimpleResult] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCatalog()
    }
    
    func updateCatalog() {
        catalogService.getCatalog(pageNumber: 1, categoryID: 2) { response in
            switch response.result {
            case .success(let result):
                self.products = result
            case .failure(let error):
                print( error.localizedDescription)
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
        ) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants().productCell, for: indexPath)
            cell.detailTextLabel?.text = String(products[indexPath.row].price)
            cell.textLabel?.text = products[indexPath.row].name
            return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstants().productSegue {
            let productVC = segue.destination as? ProductViewController
            guard let changedRow = tableView.indexPathForSelectedRow?.row
                else {
                    return
            }
            productVC?.productID = products[changedRow].productID
        }
    }
}
