"
Should have only one coordinator.
Remember to set the reference to the StDebugger
"
Class {
	#name : #DebuggerUpdateCoordinator,
	#superclass : #Object,
	#instVars : [
		'stDebugger',
		'preventUpdate'
	],
	#category : #'Seeker-Helpers'
}

{ #category : #accessing }
DebuggerUpdateCoordinator >> coordinateUpdatesFor: aBlock [

	| oldFlagValue caughtException |
	caughtException := nil.
	preventUpdate ifFalse: [ stDebugger removeSessionHolderSubscriptions ].
	oldFlagValue := preventUpdate.
	preventUpdate := true.
	"aBlock value."
	"aBlock
		on: Exception
		do: [ :e | caughtException:=e ]."
	aBlock ensure: [ 
		preventUpdate := oldFlagValue.
		preventUpdate ifFalse: [ 
			stDebugger session updateContextTo:
				stDebugger interruptedProcess suspendedContext.
			stDebugger debuggerActionModel updateTopContext.
			stDebugger updateStep.
			stDebugger setSessionHolderSubscriptions.
			stDebugger forceSessionUpdate.
			stDebugger triggerEvent: #stepInto ] ]
	"caughtException ifNotNil: [ caughtException signal ]"
]

{ #category : #initialization }
DebuggerUpdateCoordinator >> initialize [

	preventUpdate := false
]

{ #category : #accessing }
DebuggerUpdateCoordinator >> stDebugger [

	^ stDebugger
]

{ #category : #accessing }
DebuggerUpdateCoordinator >> stDebugger: anObject [

	stDebugger := anObject
]