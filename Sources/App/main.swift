import Vapor
import VaporPostgreSQL

let drop = Droplet()
try drop.addProvider(VaporPostgreSQL.Provider)
drop.preparations += Ekspert.self

let basic = BasicController()
basic.addRoutes(drop: drop)

drop.run()
