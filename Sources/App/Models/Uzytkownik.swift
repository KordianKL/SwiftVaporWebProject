//import Vapor
//
//final class Uzytkownik: Model{
//    
//    var id:Node?
//    var exists: Bool = false
//    
//    var czyAktywny = false
//    var imie: String
//    var nazwisko: String
//    var miasto: String
//    var czyZweryfikowaneDane = false
//    
//    init(imie: String, nazwisko: String, miasto: String){
//        self.id = nil
//        self.imie = imie
//        self.nazwisko = nazwisko
//        self.miasto = miasto
//    }
//    
//    init(node: Node, in context: Context) throws{
//        id = try node.extract("id")
//        imie = try node.extract("imie")
//        nazwisko = try node.extract("nazwisko")
//        miasto = try node.extract("miasto")
//        //czyAktywny = try node.extract("czyAktywny")
//        //czyZweryfikowaneDane = try node.extract("czyZweryfikowaneDane")
//    }
//    
//    func makeNode(context: Context) throws -> Node{
//        return try Node(node: [
//            "id": id,
//            "imie": imie,
//            "nazwisko": nazwisko,
//            "miasto": miasto,
//            "czyAktywny": czyAktywny,
//            "czyZweryfikowaneDane": czyZweryfikowaneDane
//            ])
//    }
//    
//    static func prepare(_ database: Database) throws {
//        try database.create("users") { users in
//            users.id()
//            users.string("imie")
//            users.string("nazwisko")
//            users.string("miasto")
//            users.bool("czyAktywny")
//            users.bool("czyZweryfikowaneDane")
//        }
//    }
//    
//    static func revert(_ database: Database) throws {
//        try database.delete("users")
//    }
//}
