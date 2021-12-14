Class {
	#name : #QSCollection,
	#superclass : #QuerySolver,
	#category : #'Seeker-Query'
}

{ #category : #navigating }
QSCollection >> resolve [

	"Triggers the solution of the query"

	| resultsCollection |
	resultsCollection := OrderedCollection new.

	query do: [ :item | resultsCollection add: query currentRow ].
	^ resultsCollection
]