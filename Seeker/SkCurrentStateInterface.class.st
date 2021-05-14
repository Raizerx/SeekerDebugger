Class {
	#name : #SkCurrentStateInterface,
	#superclass : #Object,
	#instVars : [
		'tracer',
		'cachedValues'
	],
	#category : #'Seeker-Components-Experimental'
}

{ #category : #accessing }
SkCurrentStateInterface >> bytecodeIndex [

	^ tracer byteCountCounter
]

{ #category : #'as yet unclassified' }
SkCurrentStateInterface >> cached: aSymbol orGet: aBlock [
"Use this in cases where the returned value is not directly accessible. Specially if it needs to be calculated. By using this, the value will be cached for the current bytecode step"
"Follow usage example of sequenceNode and sequenceStatementCount of this class"
	| val bc |
	bc := tracer byteCountCounter.
	val := cachedValues at: aSymbol.
	(cachedValues at: aSymbol) key = bc
		ifTrue: [ val value ]
		ifFalse: [ 
			val key: bc.
			val value: aBlock value ]
]

{ #category : #accessing }
SkCurrentStateInterface >> compiledCode [

	^ tracer currentContext compiledCode
]

{ #category : #accessing }
SkCurrentStateInterface >> compiledMethod [
	^tracer currentContext compiledMethod
]

{ #category : #accessing }
SkCurrentStateInterface >> context [
	^tracer currentContext
]

{ #category : #accessing }
SkCurrentStateInterface >> contextPC [
	^tracer currentContext pc
]

{ #category : #'as yet unclassified' }
SkCurrentStateInterface >> contextTop [ 
	^(tracer currentContext stackPtr > 0
					  ifTrue: [ tracer currentContext top ]
					  ifFalse: [ #contextTopUnavailable ]) 
]

{ #category : #accessing }
SkCurrentStateInterface >> endPC [

	^ tracer currentContext compiledCode endPC
]

{ #category : #'as yet unclassified' }
SkCurrentStateInterface >> initialPC [

	^ tracer currentContext compiledCode initialPC
]

{ #category : #initialization }
SkCurrentStateInterface >> initialize [

	"initialize a dictionary with all the accessors(getters only) of this class"

	cachedValues := Dictionary new.
	self class methodDictionary keysDo: [ :selector | 
		cachedValues at: selector put: -1 -> nil ]
]

{ #category : #accessing }
SkCurrentStateInterface >> methodClass [
	^tracer currentContext methodClass
]

{ #category : #'as yet unclassified' }
SkCurrentStateInterface >> methodNotation [
	^tracer currentContext method asSeekerOfflineExpressionString
]

{ #category : #'as yet unclassified' }
SkCurrentStateInterface >> methodReturnValue [

	"Alias for context top"

	^ self contextTop
]

{ #category : #accessing }
SkCurrentStateInterface >> methodSelector [
	^tracer currentContext methodSelector
]

{ #category : #accessing }
SkCurrentStateInterface >> node [
	^tracer currentNode
]

{ #category : #accessing }
SkCurrentStateInterface >> receiverClass [
	^tracer currentContext receiver class
]

{ #category : #accessing }
SkCurrentStateInterface >> sequenceNode [

	^ self
		  cached: thisContext methodSelector
		  orGet: [ 
		  SkNodeHelpers sequenceNodeOf: tracer currentStatementNode ]
]

{ #category : #'as yet unclassified' }
SkCurrentStateInterface >> sequenceStatementCount [

	^ self
		  cached: thisContext methodSelector
		  orGet: [ SkNodeHelpers statementCountOfSequenceNode: self sequenceNode ]
]

{ #category : #accessing }
SkCurrentStateInterface >> statementIndex [
	^tracer currentStepDescriptor topStatementID indexInSequence
]

{ #category : #accessing }
SkCurrentStateInterface >> statementNode [

	^ tracer currentStatementNode
]

{ #category : #'as yet unclassified' }
SkCurrentStateInterface >> statementNotation [
	^tracer currentContext method @ tracer currentStepDescriptor topStatementID indexInSequence
]

{ #category : #accessing }
SkCurrentStateInterface >> tracedStatementStepIndex [
	^tracer currentStepDescriptor executionIndex
]

{ #category : #accessing }
SkCurrentStateInterface >> tracer [

	^ tracer
]

{ #category : #accessing }
SkCurrentStateInterface >> tracer: anObject [

	tracer := anObject
]