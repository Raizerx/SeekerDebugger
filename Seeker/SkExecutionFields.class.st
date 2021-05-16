Class {
	#name : #SkExecutionFields,
	#superclass : #Object,
	#category : #'Seeker-Components-Experimental'
}

{ #category : #'as yet unclassified' }
SkExecutionFields class >> nonCsvFriendlyFields [

	^ { #node. #statementNode. #sequenceNode. #sourceCodeOfNode.
	  #sourceCodeOfStatementNode }
]