"
Only tables(or queries) based on execution are supported to be joined at the moment. and the queries, in theory, must have a where:[:row| true] condition (untested).
The reason for the limitation is that the table traversing simulation for the execution steps needs to advance only once, and always has currentRow available (which will always contain the same bytecodeIndex in all tables based on execution
"
Class {
	#name : #SkJointDataTable,
	#superclass : #SkIterableDataTableBase,
	#instVars : [
		'leftTable',
		'rightTable'
	],
	#category : #'Seeker-Components-Experimental'
}

{ #category : #'as yet unclassified' }
SkJointDataTable >> advanceToNextRow [

	"advances to the next row. returns false if the end of the table (there are no more rows) was reached before trying to advance."

	^ leftTable advanceToNextRow
]

{ #category : #'as yet unclassified' }
SkJointDataTable >> currentRow [

	"returns the object that represents the current row"

	^ leftTable currentRow mergeWith: rightTable currentRow
]

{ #category : #'as yet unclassified' }
SkJointDataTable >> dataSourceIsTracedExecution [

	^ leftTable dataSourceIsTracedExecution and: [ 
		  rightTable dataSourceIsTracedExecution ]
]

{ #category : #enumerating }
SkJointDataTable >> do: aBlock [

	"A specilized version of do:, made specifically to be used with queries"

	leftTable do: [ :row | 
		aBlock value: (rightTable currentRow mergeWith: row) ]
]

{ #category : #'as yet unclassified' }
SkJointDataTable >> endOfTableReached [

	"returns true if the table has no more rows (and advanceToNextRow will return false)"

	^ leftTable endOfTableReached
]

{ #category : #accessing }
SkJointDataTable >> leftTable [

	^ leftTable
]

{ #category : #accessing }
SkJointDataTable >> leftTable: anObject [

	leftTable := anObject
]

{ #category : #'as yet unclassified' }
SkJointDataTable >> resetTableTraversing [

	^leftTable resetTableTraversing
]

{ #category : #accessing }
SkJointDataTable >> rightTable [

	^ rightTable
]

{ #category : #accessing }
SkJointDataTable >> rightTable: anObject [

	rightTable := anObject
]