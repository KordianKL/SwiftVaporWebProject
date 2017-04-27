import Vapor
import HTTP
import VaporPostgreSQL

final class BasicController{
    
    func addRoutes(drop: Droplet){
        drop.get("dbversion", handler: dbversion)
        drop.get("main", handler: mainView)
        drop.post("main", handler: addExpert)
        drop.post("main", Ekspert.self, "delete", handler: deleteExpert)
        drop.post("main", Int.self, "update", handler: updateExpert)
    }
    
    func dbversion(request: Request) throws -> ResponseRepresentable{
        if let db = drop.database?.driver as? PostgreSQLDriver{
            let version = try db.raw("SELECT version()")
            return try JSON(node: version)
        } else{
            return "Brak polaczenia"
        }
    }
    
    func mainView(request: Request) throws -> ResponseRepresentable{
        let experts = try Ekspert.all().makeNode()
        let parameters = try Node(node: [
            "experts": experts,
            ])
        return try drop.view.make("main", parameters)
    }
    
    func addExpert(request: Request) throws -> ResponseRepresentable{
        guard let imie = request.data["imie"]?.string, let nazwisko = request.data["nazwisko"]?.string, let miasto = request.data["miasto"]?.string, let jo = request.data["jo"]?.string
            else{
                throw Abort.badRequest
        }
        
        var ekspert = Ekspert(imie: imie, nazwisko: nazwisko, miasto: miasto, jo: jo)
        try ekspert.save()
        
        return Response(redirect: "/main")
    }
    
    func deleteExpert(request: Request, ekspert: Ekspert) throws -> ResponseRepresentable{
        try ekspert.delete()
        return Response(redirect: "/main")
    }
    
    func updateExpert(request: Request, expert: Int) throws -> ResponseRepresentable{
        var ekspert = try Ekspert.find(expert)!
        ekspert.imie = request.data["imie"]!.string!
        ekspert.nazwisko = request.data["nazwisko"]!.string!
        ekspert.miasto = request.data["miasto"]!.string!
        ekspert.jo = request.data["jo"]!.string!
        //ekspert.czyAktywny = request.data["czyAktywny"]!.bool!
        //ekspert.czyZweryfikowaneDane = request.data["czyZweryfikowaneDane"]!.bool!
        try ekspert.save()
        return Response(redirect: "/main")
    }
}
