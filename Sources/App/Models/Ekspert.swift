import Vapor

final class Ekspert: Model{
    
    var id:Node?
    var exists: Bool = false
    
    var czyAktywny = false
    var imie: String
    var nazwisko: String
    var miasto: String
    var czyZweryfikowaneDane = false
    var jo: String
    
    init(imie: String, nazwisko: String, miasto: String, jo:String){
        self.id = nil
        self.imie = imie
        self.nazwisko = nazwisko
        self.miasto = miasto
        self.jo = jo
    }
    
    init(node: Node, in context: Context) throws{
        id = try node.extract("id")
        imie = try node.extract("imie")
        nazwisko = try node.extract("nazwisko")
        miasto = try node.extract("miasto")
        jo = try node.extract("jo")
        //czyAktywny = try node.extract("czyAktywny")
        //czyZweryfikowaneDane = try node.extract("czyZweryfikowaneDane")
    }
    
    func makeNode(context: Context) throws -> Node{
        return try Node(node: [
                "id": id,
                "imie": imie,
                "nazwisko": nazwisko,
                "miasto": miasto,
                "jo": jo,
                "czyAktywny": czyAktywny,
                "czyZweryfikowaneDane": czyZweryfikowaneDane
            ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("eksperts") { users in
            users.id()
            users.string("imie")
            users.string("nazwisko")
            users.string("miasto")
            users.string("jo")
            users.bool("czyAktywny")
            users.bool("czyZweryfikowaneDane")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("eksperts")
    }
}
