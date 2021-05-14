Class {
	#name : #SkTableForCollection,
	#superclass : #SkIterableDataSetBase,
	#instVars : [
		'traversingCursorIndex',
		'underlyingCollection'
	],
	#category : #'Seeker-Components-Experimental'
}

{ #category : #'instance creation' }
SkTableForCollection class >> newFromCollection: aCollection [

	| table |
	table := self new.
	table collectionToIterateOver: aCollection.
	^ table
]

{ #category : #'as yet unclassified' }
SkTableForCollection >> advanceToNextRow [

	"advances to the next row. returns false if the end of the table (there are no more rows) was reached before trying to advance."

	traversingCursorIndex > underlyingCollection size ifTrue: [ 
		^ false ].
	traversingCursorIndex := traversingCursorIndex + 1.
	^ traversingCursorIndex > underlyingCollection size
]

{ #category : #accessing }
SkTableForCollection >> collectionToIterateOver: aCollection [
	underlyingCollection := aCollection.
]

{ #category : #'as yet unclassified' }
SkTableForCollection >> currentRow [

	"returns the object that represents the current row"

	traversingCursorIndex = 0 ifTrue: [ ^ nil ].
	^ underlyingCollection at: traversingCursorIndex
]

{ #category : #enumerating }
SkTableForCollection >> do: aBlock [

	underlyingCollection do: aBlock
]

{ #category : #'as yet unclassified' }
SkTableForCollection >> endOfTableReached [

	"returns true if the table has no more rows (and advanceToNextRow will return false)"

	^ traversingCursorIndex > underlyingCollection size
]

{ #category : #initialization }
SkTableForCollection >> initialize [ 
	traversingCursorIndex := 0.
	
]

{ #category : #'as yet unclassified' }
SkTableForCollection >> resetTableTraversing [

	"Puts the table traversing cursor 'before the first row'. one advanceToNextRow is necessary to enter the first row. A reseted table should reply currentRow nil always."

	traversingCursorIndex := 0
]