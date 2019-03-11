//Useful link for preparing No SQL Queries
https://docs.mongodb.com/manual/tutorial/query-documents/

https://docs.mongodb.com/manual/reference/glossary/#term-index


Commands for import and export - 

Import - 
mongoimport --db yelp_db --collection review --file ‘review.json’
mongoimport --db yelp_db --collection tip --file 'tip.json' —jsonArray - For importing a JSON array


Export - 
mongoexport --db yelp_db --collection review --out review.json


##### 1 #####

Select all rows in a table or collection and display execution statistics

NoSQL:

db.review.find().explain("executionStats”);

Output:

{
 	"queryPlanner" : {
 		"plannerVersion" : 1,
 		"namespace" : "yelp_db.review",
 		"indexFilterSet" : false,
 		"parsedQuery" : {
 			
 		},
 		"winningPlan" : {
 			"stage" : "COLLSCAN",
 			"direction" : "forward"
 		},
 		"rejectedPlans" : [ ]
 	},
 	"executionStats" : {
 		"executionSuccess" : true,
 		"nReturned" : 5261669,
 		"executionTimeMillis" : 82479,
 		"totalKeysExamined" : 0,
 		"totalDocsExamined" : 5261669,
 		"executionStages" : {
 			"stage" : "COLLSCAN",
 			"nReturned" : 5261669,
 			"executionTimeMillisEstimate" : 81818,
 			"works" : 5261671,
 			"advanced" : 5261669,
 			"needTime" : 1,
 			"needYield" : 0,
 			"saveState" : 42848,
 			"restoreState" : 42848,
 			"isEOF" : 1,
 			"invalidates" : 0,
 			"direction" : "forward",
 			"docsExamined" : 5261669
 		}
 	},
 	"serverInfo" : {
 		"host" : "Vamsis-MacBook-Pro.local",
 		"port" : 27017,
 		"version" : "3.6.2",
 		"gitVersion" : "489d177dbd0f0420a8ca04d39fd78d0a2c539420"
 	},
 	"ok" : 1
}


SQL:

SELECT * FROM yelp_db.review;


Count number of rows in a collection/table and other aggregate functions

NoSQL:

db.review.count();

SQL:

SELECT COUNT(*) FROM yelp_db.review;


##### 2 #####

AND, OR , AND plus OR


AND

NoSQL:
db.review.find( {business_id: "TFd5t6QXqzZzAjVNXQCypA", user_id : "7u9HymKeOteWRx-NMBlALw"});
db.review.find( {business_id: "TFd5t6QXqzZzAjVNXQCypA", user_id : "7u9HymKeOteWRx-NMBlALw"}).explain("executionStats”);

Output:

{
 	"queryPlanner" : {
 		"plannerVersion" : 1,
 		"namespace" : "yelp_db.review",
 		"indexFilterSet" : false,
 		"parsedQuery" : {
 			"$and" : [
 				{
 					"business_id" : {
 						"$eq" : "TFd5t6QXqzZzAjVNXQCypA"
 					}
 				},
 				{
 					"user_id" : {
 						"$eq" : "7u9HymKeOteWRx-NMBlALw"
 					}
 				}
 			]
 		},
 		"winningPlan" : {
 			"stage" : "COLLSCAN",
 			"filter" : {
 				"$and" : [
 					{
 						"business_id" : {
 							"$eq" : "TFd5t6QXqzZzAjVNXQCypA"
 						}
 					},
 					{
 						"user_id" : {
 							"$eq" : "7u9HymKeOteWRx-NMBlALw"
 						}
 					}
 				]
 			},
 			"direction" : "forward"
 		},
 		"rejectedPlans" : [ ]
 	},
 	"executionStats" : {
 		"executionSuccess" : true,
 		"nReturned" : 1,
 		"executionTimeMillis" : 2023,
 		"totalKeysExamined" : 0,
 		"totalDocsExamined" : 5261669,
 		"executionStages" : {
 			"stage" : "COLLSCAN",
 			"filter" : {
 				"$and" : [
 					{
 						"business_id" : {
 							"$eq" : "TFd5t6QXqzZzAjVNXQCypA"
 						}
 					},
 					{
 						"user_id" : {
 							"$eq" : "7u9HymKeOteWRx-NMBlALw"
 						}
 					}
 				]
 			},
 			"nReturned" : 1,
 			"executionTimeMillisEstimate" : 1730,
 			"works" : 5261671,
 			"advanced" : 1,
 			"needTime" : 5261669,
 			"needYield" : 0,
 			"saveState" : 41163,
 			"restoreState" : 41163,
 			"isEOF" : 1,
 			"invalidates" : 0,
 			"direction" : "forward",
 			"docsExamined" : 5261669
 		}
 	},
 	"serverInfo" : {
 		"host" : "Vamsis-MBP.home",
 		"port" : 27017,
 		"version" : "3.6.2",
 		"gitVersion" : "489d177dbd0f0420a8ca04d39fd78d0a2c539420"
 	},
 	"ok" : 1
}

SQL:

SELECT id 
FROM yelp_db.review 
WHERE business_id = 'TFd5t6QXqzZzAjVNXQCypA' AND user_id = '7u9HymKeOteWRx-NMBlALw';


OR


NoSQL:

db.review.find( { $or: [ { business_id: "TFd5t6QXqzZzAjVNXQCypA" }, { user_id : "7u9HymKeOteWRx-NMBlALw" } ] } );
db.review.find( { $or: [ { business_id: "TFd5t6QXqzZzAjVNXQCypA" }, { user_id : "7u9HymKeOteWRx-NMBlALw" } ] } ).explain("executionStats");


Output:

{
 	"queryPlanner" : {
 		"plannerVersion" : 1,
 		"namespace" : "yelp_db.review",
 		"indexFilterSet" : false,
 		"parsedQuery" : {
 			"$or" : [
 				{
 					"business_id" : {
 						"$eq" : "TFd5t6QXqzZzAjVNXQCypA"
 					}
 				},
 				{
 					"user_id" : {
 						"$eq" : "7u9HymKeOteWRx-NMBlALw"
 					}
 				}
 			]
 		},
 		"winningPlan" : {
 			"stage" : "SUBPLAN",
 			"inputStage" : {
 				"stage" : "COLLSCAN",
 				"filter" : {
 					"$or" : [
 						{
 							"business_id" : {
 								"$eq" : "TFd5t6QXqzZzAjVNXQCypA"
 							}
 						},
 						{
 							"user_id" : {
 								"$eq" : "7u9HymKeOteWRx-NMBlALw"
 							}
 						}
 					]
 				},
 				"direction" : "forward"
 			}
 		},
 		"rejectedPlans" : [ ]
 	},
 	"executionStats" : {
 		"executionSuccess" : true,
 		"nReturned" : 18,
 		"executionTimeMillis" : 3041,
 		"totalKeysExamined" : 0,
 		"totalDocsExamined" : 5261669,
 		"executionStages" : {
 			"stage" : "SUBPLAN",
 			"nReturned" : 18,
 			"executionTimeMillisEstimate" : 2903,
 			"works" : 5261671,
 			"advanced" : 18,
 			"needTime" : 5261652,
 			"needYield" : 0,
 			"saveState" : 41202,
 			"restoreState" : 41202,
 			"isEOF" : 1,
 			"invalidates" : 0,
 			"inputStage" : {
 				"stage" : "COLLSCAN",
 				"filter" : {
 					"$or" : [
 						{
 							"business_id" : {
 								"$eq" : "TFd5t6QXqzZzAjVNXQCypA"
 							}
 						},
 						{
 							"user_id" : {
 								"$eq" : "7u9HymKeOteWRx-NMBlALw"
 							}
 						}
 					]
 				},
 				"nReturned" : 18,
 				"executionTimeMillisEstimate" : 2810,
 				"works" : 5261671,
 				"advanced" : 18,
 				"needTime" : 5261652,
 				"needYield" : 0,
 				"saveState" : 41202,
 				"restoreState" : 41202,
 				"isEOF" : 1,
 				"invalidates" : 0,
 				"direction" : "forward",
 				"docsExamined" : 5261669
 			}
 		}
 	},
 	"serverInfo" : {
 		"host" : "Vamsis-MBP.home",
 		"port" : 27017,
 		"version" : "3.6.2",
 		"gitVersion" : "489d177dbd0f0420a8ca04d39fd78d0a2c539420"
 	},
 	"ok" : 1
}

SQL:

SELECT id 
FROM yelp_db.review 
WHERE business_id = 'TFd5t6QXqzZzAjVNXQCypA' OR user_id = '7u9HymKeOteWRx-NMBlALw’;


AND plus OR


No SQL:

db.review.find( {
     stars: 4,
     $or: [ { business_id: "TFd5t6QXqzZzAjVNXQCypA" }, { user_id : "7u9HymKeOteWRx-NMBlALw" } ]
} );


SQL:

SELECT id 
FROM yelp_db.review 
WHERE stars = 4 AND ( business_id = 'TFd5t6QXqzZzAjVNXQCypA' OR user_id = '7u9HymKeOteWRx-NMBlALw’);




##### 3 #####

https://docs.mongodb.com/manual/geospatial-queries/
Geospatial queries and indexes

mongoimport --db yelp_db restaurants.json -c restaurants

https://docs.mongodb.com/manual/tutorial/geospatial-tutorial/

db.restaurants.createIndex({ location: "2dsphere" })
db.neighborhoods.createIndex({ geometry: "2dsphere" })

db.restaurants.findOne()

db.neighborhoods.findOne()

#Find current neighborhood

db.neighborhoods.findOne({ geometry: { $geoIntersects: { $geometry: { type: "Point", coordinates: [ -73.93414657, 40.82302903 ] } } } })

#  Find all restraints in the neighbourhood - 

var neighborhood = db.neighborhoods.findOne( { geometry: { $geoIntersects: { $geometry: { type: "Point", coordinates: [ -73.93414657, 40.82302903 ] } } } } )
db.restaurants.find( { location: { $geoWithin: { $geometry: neighborhood.geometry } } } ).count()


#  Find Restaurants within a Distance

#  Find all restaurants within five miles of the user:

#  Unsorted with $geoWithin

db.restaurants.find({ location:
   { $geoWithin:
      { $centerSphere: [ [ -73.93414657, 40.82302903 ], 5 / 3963.2 ] } } })

#  Sorted with $nearSphere

#  All restaurants within five miles of the user in sorted order from nearest to farthest:

var METERS_PER_MILE = 1609.34
db.restaurants.find({ location: { $nearSphere: { $geometry: { type: "Point", coordinates: [ -73.93414657, 40.82302903 ] }, $maxDistance: 5 * METERS_PER_MILE } } })



##### 4 #####


With out text search and indexes:

# Similar to LIKE operator in SQL
db.review.find({“text": /money/}).explain(“executionStats”);

Output:

{
 	"queryPlanner" : {
 		"plannerVersion" : 1,
 		"namespace" : "yelp_db.review",
 		"indexFilterSet" : false,
 		"parsedQuery" : {
 			"text" : {
 				"$regex" : "money"
 			}
 		},
 		"winningPlan" : {
 			"stage" : "COLLSCAN",
 			"filter" : {
 				"text" : {
 					"$regex" : "money"
 				}
 			},
 			"direction" : "forward"
 		},
 		"rejectedPlans" : [ ]
 	},
 	"executionStats" : {
 		"executionSuccess" : true,
 		"nReturned" : 211386,
 		"executionTimeMillis" : 8776,
 		"totalKeysExamined" : 0,
 		"totalDocsExamined" : 5261669,
 		"executionStages" : {
 			"stage" : "COLLSCAN",
 			"filter" : {
 				"text" : {
 					"$regex" : "money"
 				}
 			},
 			"nReturned" : 211386,
 			"executionTimeMillisEstimate" : 8536,
 			"works" : 5261671,
 			"advanced" : 211386,
 			"needTime" : 5050284,
 			"needYield" : 0,
 			"saveState" : 41376,
 			"restoreState" : 41376,
 			"isEOF" : 1,
 			"invalidates" : 0,
 			"direction" : "forward",
 			"docsExamined" : 5261669
 		}
 	},
 	"serverInfo" : {
 		"host" : "Vamsis-MBP.home",
 		"port" : 27017,
 		"version" : "3.6.2",
 		"gitVersion" : "489d177dbd0f0420a8ca04d39fd78d0a2c539420"
 	},
 	"ok" : 1
}


Text search

https://docs.mongodb.com/manual/text-search/

Create text index:
db.review.createIndex({text: "text" });

db.review.find({$text: {$search: "money"}}).explain(“executionStats”);

Output:

{
 	"queryPlanner" : {
 		"plannerVersion" : 1,
 		"namespace" : "yelp_db.review",
 		"indexFilterSet" : false,
 		"parsedQuery" : {
 			"$text" : {
 				"$search" : "money",
 				"$language" : "english",
 				"$caseSensitive" : false,
 				"$diacriticSensitive" : false
 			}
 		},
 		"winningPlan" : {
 			"stage" : "TEXT",
 			"indexPrefix" : {
 				
 			},
 			"indexName" : "text_text",
 			"parsedTextQuery" : {
 				"terms" : [
 					"money"
 				],
 				"negatedTerms" : [ ],
 				"phrases" : [ ],
 				"negatedPhrases" : [ ]
 			},
 			"textIndexVersion" : 3,
 			"inputStage" : {
 				"stage" : "TEXT_MATCH",
 				"inputStage" : {
 					"stage" : "FETCH",
 					"inputStage" : {
 						"stage" : "OR",
 						"inputStage" : {
 							"stage" : "IXSCAN",
 							"keyPattern" : {
 								"_fts" : "text",
 								"_ftsx" : 1
 							},
 							"indexName" : "text_text",
 							"isMultiKey" : true,
 							"isUnique" : false,
 							"isSparse" : false,
 							"isPartial" : false,
 							"indexVersion" : 2,
 							"direction" : "backward",
 							"indexBounds" : {
 								
 							}
 						}
 					}
 				}
 			}
 		},
 		"rejectedPlans" : [ ]
 	},
 	"executionStats" : {
 		"executionSuccess" : true,
 		"nReturned" : 214787,
 		"executionTimeMillis" : 775,
 		"totalKeysExamined" : 214787,
 		"totalDocsExamined" : 214787,
 		"executionStages" : {
 			"stage" : "TEXT",
 			"nReturned" : 214787,
 			"executionTimeMillisEstimate" : 733,
 			"works" : 214788,
 			"advanced" : 214787,
 			"needTime" : 0,
 			"needYield" : 0,
 			"saveState" : 1696,
 			"restoreState" : 1696,
 			"isEOF" : 1,
 			"invalidates" : 0,
 			"indexPrefix" : {
 				
 			},
 			"indexName" : "text_text",
 			"parsedTextQuery" : {
 				"terms" : [
 					"money"
 				],
 				"negatedTerms" : [ ],
 				"phrases" : [ ],
 				"negatedPhrases" : [ ]
 			},
 			"textIndexVersion" : 3,
 			"inputStage" : {
 				"stage" : "TEXT_MATCH",
 				"nReturned" : 214787,
 				"executionTimeMillisEstimate" : 721,
 				"works" : 214788,
 				"advanced" : 214787,
 				"needTime" : 0,
 				"needYield" : 0,
 				"saveState" : 1696,
 				"restoreState" : 1696,
 				"isEOF" : 1,
 				"invalidates" : 0,
 				"docsRejected" : 0,
 				"inputStage" : {
 					"stage" : "FETCH",
 					"nReturned" : 214787,
 					"executionTimeMillisEstimate" : 721,
 					"works" : 214788,
 					"advanced" : 214787,
 					"needTime" : 0,
 					"needYield" : 0,
 					"saveState" : 1696,
 					"restoreState" : 1696,
 					"isEOF" : 1,
 					"invalidates" : 0,
 					"docsExamined" : 214787,
 					"alreadyHasObj" : 0,
 					"inputStage" : {
 						"stage" : "OR",
 						"nReturned" : 214787,
 						"executionTimeMillisEstimate" : 399,
 						"works" : 214788,
 						"advanced" : 214787,
 						"needTime" : 0,
 						"needYield" : 0,
 						"saveState" : 1696,
 						"restoreState" : 1696,
 						"isEOF" : 1,
 						"invalidates" : 0,
 						"dupsTested" : 214787,
 						"dupsDropped" : 0,
 						"recordIdsForgotten" : 0,
 						"inputStage" : {
 							"stage" : "IXSCAN",
 							"nReturned" : 214787,
 							"executionTimeMillisEstimate" : 316,
 							"works" : 214788,
 							"advanced" : 214787,
 							"needTime" : 0,
 							"needYield" : 0,
 							"saveState" : 1696,
 							"restoreState" : 1696,
 							"isEOF" : 1,
 							"invalidates" : 0,
 							"keyPattern" : {
 								"_fts" : "text",
 								"_ftsx" : 1
 							},
 							"indexName" : "text_text",
 							"isMultiKey" : true,
 							"isUnique" : false,
 							"isSparse" : false,
 							"isPartial" : false,
 							"indexVersion" : 2,
 							"direction" : "backward",
 							"indexBounds" : {
 								
 							},
 							"keysExamined" : 214787,
 							"seeks" : 1,
 							"dupsTested" : 214787,
 							"dupsDropped" : 0,
 							"seenInvalidated" : 0
 						}
 					}
 				}
 			}
 		}
 	},
 	"serverInfo" : {
 		"host" : "Vamsis-MBP.home",
 		"port" : 27017,
 		"version" : "3.6.2",
 		"gitVersion" : "489d177dbd0f0420a8ca04d39fd78d0a2c539420"
 	},
 	"ok" : 1
}




##### 5 #####

Indexes

https://docs.mongodb.com/manual/indexes/


#Multi key indexes
db.review.createIndex({ "business_id" : 1, "user_id" : -1 })

{
 	"createdCollectionAutomatically" : false,
 	"numIndexesBefore" : 2,
 	"numIndexesAfter" : 3,
 	"ok" : 1
}

# Single key indexes

db.review.createIndex({ "business_id" : -1 })

{
 	"createdCollectionAutomatically" : false,
 	"numIndexesBefore" : 3,
 	"numIndexesAfter" : 4,
 	"ok" : 1
}

db.review.createIndex({ "user_id" : -1 })

{
 	"createdCollectionAutomatically" : false,
 	"numIndexesBefore" : 4,
 	"numIndexesAfter" : 5,
 	"ok" : 1
}


db.review.find( {business_id: "TFd5t6QXqzZzAjVNXQCypA", user_id : "7u9HymKeOteWRx-NMBlALw"}).explain("executionStats”);

Output:

{
 	"queryPlanner" : {
 		"plannerVersion" : 1,
 		"namespace" : "yelp_db.review",
 		"indexFilterSet" : false,
 		"parsedQuery" : {
 			"$and" : [
 				{
 					"business_id" : {
 						"$eq" : "TFd5t6QXqzZzAjVNXQCypA"
 					}
 				},
 				{
 					"user_id" : {
 						"$eq" : "7u9HymKeOteWRx-NMBlALw"
 					}
 				}
 			]
 		},
 		"winningPlan" : {
 			"stage" : "FETCH",
 			"inputStage" : {
 				"stage" : "IXSCAN",
 				"keyPattern" : {
 					"business_id" : 1,
 					"user_id" : -1
 				},
 				"indexName" : "business_id_1_user_id_-1",
 				"isMultiKey" : false,
 				"multiKeyPaths" : {
 					"business_id" : [ ],
 					"user_id" : [ ]
 				},
 				"isUnique" : false,
 				"isSparse" : false,
 				"isPartial" : false,
 				"indexVersion" : 2,
 				"direction" : "forward",
 				"indexBounds" : {
 					"business_id" : [
 						"[\"TFd5t6QXqzZzAjVNXQCypA\", \"TFd5t6QXqzZzAjVNXQCypA\"]"
 					],
 					"user_id" : [
 						"[\"7u9HymKeOteWRx-NMBlALw\", \"7u9HymKeOteWRx-NMBlALw\"]"
 					]
 				}
 			}
 		},
 		"rejectedPlans" : [ ]
 	},
 	"executionStats" : {
 		"executionSuccess" : true,
 		"nReturned" : 1,
 		"executionTimeMillis" : 4,
 		"totalKeysExamined" : 1,
 		"totalDocsExamined" : 1,
 		"executionStages" : {
 			"stage" : "FETCH",
 			"nReturned" : 1,
 			"executionTimeMillisEstimate" : 0,
 			"works" : 2,
 			"advanced" : 1,
 			"needTime" : 0,
 			"needYield" : 0,
 			"saveState" : 0,
 			"restoreState" : 0,
 			"isEOF" : 1,
 			"invalidates" : 0,
 			"docsExamined" : 1,
 			"alreadyHasObj" : 0,
 			"inputStage" : {
 				"stage" : "IXSCAN",
 				"nReturned" : 1,
 				"executionTimeMillisEstimate" : 0,
 				"works" : 2,
 				"advanced" : 1,
 				"needTime" : 0,
 				"needYield" : 0,
 				"saveState" : 0,
 				"restoreState" : 0,
 				"isEOF" : 1,
 				"invalidates" : 0,
 				"keyPattern" : {
 					"business_id" : 1,
 					"user_id" : -1
 				},
 				"indexName" : "business_id_1_user_id_-1",
 				"isMultiKey" : false,
 				"multiKeyPaths" : {
 					"business_id" : [ ],
 					"user_id" : [ ]
 				},
 				"isUnique" : false,
 				"isSparse" : false,
 				"isPartial" : false,
 				"indexVersion" : 2,
 				"direction" : "forward",
 				"indexBounds" : {
 					"business_id" : [
 						"[\"TFd5t6QXqzZzAjVNXQCypA\", \"TFd5t6QXqzZzAjVNXQCypA\"]"
 					],
 					"user_id" : [
 						"[\"7u9HymKeOteWRx-NMBlALw\", \"7u9HymKeOteWRx-NMBlALw\"]"
 					]
 				},
 				"keysExamined" : 1,
 				"seeks" : 1,
 				"dupsTested" : 0,
 				"dupsDropped" : 0,
 				"seenInvalidated" : 0
 			}
 		}
 	},
 	"serverInfo" : {
 		"host" : "Vamsis-MBP.home",
 		"port" : 27017,
 		"version" : "3.6.2",
 		"gitVersion" : "489d177dbd0f0420a8ca04d39fd78d0a2c539420"
 	},
 	"ok" : 1
}


db.review.find( { $or: [ { business_id: "TFd5t6QXqzZzAjVNXQCypA" }, { user_id : "7u9HymKeOteWRx-NMBlALw" } ] } ).explain("executionStats”);

Output:

{
 	"queryPlanner" : {
 		"plannerVersion" : 1,
 		"namespace" : "yelp_db.review",
 		"indexFilterSet" : false,
 		"parsedQuery" : {
 			"$or" : [
 				{
 					"business_id" : {
 						"$eq" : "TFd5t6QXqzZzAjVNXQCypA"
 					}
 				},
 				{
 					"user_id" : {
 						"$eq" : "7u9HymKeOteWRx-NMBlALw"
 					}
 				}
 			]
 		},
 		"winningPlan" : {
 			"stage" : "SUBPLAN",
 			"inputStage" : {
 				"stage" : "FETCH",
 				"inputStage" : {
 					"stage" : "OR",
 					"inputStages" : [
 						{
 							"stage" : "IXSCAN",
 							"keyPattern" : {
 								"business_id" : 1,
 								"user_id" : -1
 							},
 							"indexName" : "business_id_1_user_id_-1",
 							"isMultiKey" : false,
 							"multiKeyPaths" : {
 								"business_id" : [ ],
 								"user_id" : [ ]
 							},
 							"isUnique" : false,
 							"isSparse" : false,
 							"isPartial" : false,
 							"indexVersion" : 2,
 							"direction" : "forward",
 							"indexBounds" : {
 								"business_id" : [
 									"[\"TFd5t6QXqzZzAjVNXQCypA\", \"TFd5t6QXqzZzAjVNXQCypA\"]"
 								],
 								"user_id" : [
 									"[MaxKey, MinKey]"
 								]
 							}
 						},
 						{
 							"stage" : "IXSCAN",
 							"keyPattern" : {
 								"user_id" : -1
 							},
 							"indexName" : "user_id_-1",
 							"isMultiKey" : false,
 							"multiKeyPaths" : {
 								"user_id" : [ ]
 							},
 							"isUnique" : false,
 							"isSparse" : false,
 							"isPartial" : false,
 							"indexVersion" : 2,
 							"direction" : "forward",
 							"indexBounds" : {
 								"user_id" : [
 									"[\"7u9HymKeOteWRx-NMBlALw\", \"7u9HymKeOteWRx-NMBlALw\"]"
 								]
 							}
 						}
 					]
 				}
 			}
 		},
 		"rejectedPlans" : [ ]
 	},
 	"executionStats" : {
 		"executionSuccess" : true,
 		"nReturned" : 18,
 		"executionTimeMillis" : 3,
 		"totalKeysExamined" : 19,
 		"totalDocsExamined" : 18,
 		"executionStages" : {
 			"stage" : "SUBPLAN",
 			"nReturned" : 18,
 			"executionTimeMillisEstimate" : 0,
 			"works" : 21,
 			"advanced" : 18,
 			"needTime" : 2,
 			"needYield" : 0,
 			"saveState" : 0,
 			"restoreState" : 0,
 			"isEOF" : 1,
 			"invalidates" : 0,
 			"inputStage" : {
 				"stage" : "FETCH",
 				"nReturned" : 18,
 				"executionTimeMillisEstimate" : 0,
 				"works" : 21,
 				"advanced" : 18,
 				"needTime" : 2,
 				"needYield" : 0,
 				"saveState" : 0,
 				"restoreState" : 0,
 				"isEOF" : 1,
 				"invalidates" : 0,
 				"docsExamined" : 18,
 				"alreadyHasObj" : 0,
 				"inputStage" : {
 					"stage" : "OR",
 					"nReturned" : 18,
 					"executionTimeMillisEstimate" : 0,
 					"works" : 21,
 					"advanced" : 18,
 					"needTime" : 2,
 					"needYield" : 0,
 					"saveState" : 0,
 					"restoreState" : 0,
 					"isEOF" : 1,
 					"invalidates" : 0,
 					"dupsTested" : 19,
 					"dupsDropped" : 1,
 					"recordIdsForgotten" : 0,
 					"inputStages" : [
 						{
 							"stage" : "IXSCAN",
 							"nReturned" : 14,
 							"executionTimeMillisEstimate" : 0,
 							"works" : 15,
 							"advanced" : 14,
 							"needTime" : 0,
 							"needYield" : 0,
 							"saveState" : 0,
 							"restoreState" : 0,
 							"isEOF" : 1,
 							"invalidates" : 0,
 							"keyPattern" : {
 								"business_id" : 1,
 								"user_id" : -1
 							},
 							"indexName" : "business_id_1_user_id_-1",
 							"isMultiKey" : false,
 							"multiKeyPaths" : {
 								"business_id" : [ ],
 								"user_id" : [ ]
 							},
 							"isUnique" : false,
 							"isSparse" : false,
 							"isPartial" : false,
 							"indexVersion" : 2,
 							"direction" : "forward",
 							"indexBounds" : {
 								"business_id" : [
 									"[\"TFd5t6QXqzZzAjVNXQCypA\", \"TFd5t6QXqzZzAjVNXQCypA\"]"
 								],
 								"user_id" : [
 									"[MaxKey, MinKey]"
 								]
 							},
 							"keysExamined" : 14,
 							"seeks" : 1,
 							"dupsTested" : 0,
 							"dupsDropped" : 0,
 							"seenInvalidated" : 0
 						},
 						{
 							"stage" : "IXSCAN",
 							"nReturned" : 5,
 							"executionTimeMillisEstimate" : 0,
 							"works" : 6,
 							"advanced" : 5,
 							"needTime" : 0,
 							"needYield" : 0,
 							"saveState" : 0,
 							"restoreState" : 0,
 							"isEOF" : 1,
 							"invalidates" : 0,
 							"keyPattern" : {
 								"user_id" : -1
 							},
 							"indexName" : "user_id_-1",
 							"isMultiKey" : false,
 							"multiKeyPaths" : {
 								"user_id" : [ ]
 							},
 							"isUnique" : false,
 							"isSparse" : false,
 							"isPartial" : false,
 							"indexVersion" : 2,
 							"direction" : "forward",
 							"indexBounds" : {
 								"user_id" : [
 									"[\"7u9HymKeOteWRx-NMBlALw\", \"7u9HymKeOteWRx-NMBlALw\"]"
 								]
 							},
 							"keysExamined" : 5,
 							"seeks" : 1,
 							"dupsTested" : 0,
 							"dupsDropped" : 0,
 							"seenInvalidated" : 0
 						}
 					]
 				}
 			}
 		}
 	},
 	"serverInfo" : {
 		"host" : "Vamsis-MBP.home",
 		"port" : 27017,
 		"version" : "3.6.2",
 		"gitVersion" : "489d177dbd0f0420a8ca04d39fd78d0a2c539420"
 	},
 	"ok" : 1
}


##### 6 #####

Map reduce

# https://docs.mongodb.com/manual/tutorial/perform-incremental-map-reduce/


var mapFunction1 = function() {
                       emit(this.user_id, this.stars);
                   };


var reduceFunction1 = function(keyUserId, valuesStars) {
                          return Array.sum(valuesStars);
                      };


db.review.mapReduce(
                     mapFunction1,
                     reduceFunction1,
                     { out: "map_reduce_user_id_to_stars" }
                   );

We can also do incremental map reduce operations


##### 7 #####

Aggregation:


NoSQL:
db.review.aggregate([ { $match: { user_id : "7u9HymKeOteWRx-NMBlALw" }}, { $group: { _id: "$user_id", total: { $sum: “$useful"}}} ])

SQL:

SELECT user_id, SUM(useful) as likes
    FROM yelp_db.review
    GROUP BY user_id
    WHERE user_id = ‘7u9HymKeOteWRx-NMBlALw‘;


NoSQL:

db.review.aggregate([ { $match: { $or: [ { business_id: "TFd5t6QXqzZzAjVNXQCypA" }, { user_id : "7u9HymKeOteWRx-NMBlALw" } ] }}, { $group: { _id: "$user_id", total: { $sum: “$useful"}}} ])


SQL:

SELECT user_id, SUM(useful) as likes
    FROM yelp_db.review
    GROUP BY user_id
    WHERE user_id = ‘7u9HymKeOteWRx-NMBlALw‘ AND business_id = ‘TFd5t6QXqzZzAjVNXQCypA’;



##### 8 #####

Joins

# https://docs.mongodb.com/manual/reference/operator/aggregation/lookup/

# https://www.mongodb.com/blog/post/joins-and-other-aggregation-enhancements-coming-in-mongodb-3-2-part-1-of-3-introduction

# Joining user and review tables
db.review.aggregate([
   {
     $lookup:
       {
         from: "user",
         localField: "user_id",
         foreignField: "user_id",
         as: "Review_User_Aggregate"
       }
  }
])
