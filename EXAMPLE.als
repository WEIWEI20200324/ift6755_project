sig FM { features: set Name, 
		 root: features, 
  		 relations: set Relation, 
		 forms: set Formula } 
sig Name {}
sig Relation { parent: Name, 
				child: set Name, 
				type: Type } 
abstract sig Type {} 
one sig Optional, Mandatory, OrFeature, Alternative extends Type {}
abstract sig Formula { satisfy: Configuration -> one Bool, 
wt: FM -> one Bool }
sig NameF extends Formula { n: Name } 
sig Form extends Formula { f: Formula, g: Formula, op: Op } 
abstract sig Op {} 
one sig AndF, OrF, ImpliesF, NotF extends Op {}
pred wellFormed(fm:FM) { wellFormedRel(fm) all f:fm.forms | f.wt[fm] = True }
pred wellFormedRel(fm:FM) { all r:fm.relations {  r.parent+r.child in fm.features  r.type in Optional+Mandatory => #r.child=1  r.type in Alternative+OrFeature => #r.child>1 } }

