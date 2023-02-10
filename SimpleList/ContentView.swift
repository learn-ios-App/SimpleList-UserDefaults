
import SwiftUI

struct ContentView: View {
    let userDefaults = UserDefaults.standard
    @State var itemList = ["k"]
    var body: some View {
        NavigationStack {
            List {
                ForEach(itemList, id: \.self) { item in
                    Text(item)
                }
                .onDelete(perform: delete)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        add()
                    }) {
                        Image(systemName: "plus")
                    }
                })
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button(action: {
                        print(itemList)
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                })
            }
        }
        .onAppear() {
            let getItems: [String] = userDefaults.array(forKey: "itemsKey") as! [String]
            itemList = getItems
        }
    }
    func delete(offset: IndexSet) {
        itemList.remove(atOffsets: offset)
        userDefaults.set(itemList, forKey: "itemsKey")
        update()
    }
    func add() {
        itemList.append("NewItem")
        userDefaults.set(itemList, forKey: "itemsKey")
        update()
    }
    func update() {
        let getItems: [String] = userDefaults.array(forKey: "itemsKey") as! [String]
        itemList = getItems
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
