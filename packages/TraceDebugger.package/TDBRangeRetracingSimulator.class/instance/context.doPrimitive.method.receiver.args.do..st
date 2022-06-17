controlling
context: aContext doPrimitive: primitiveIndex method: aCompiledMethod receiver: receiver args: originalArguments do: aBlock
	"Redirect primitives that read any state. If the relevant object's slot is defined in the historic memory, use the recorded state from there instead of the current state for the object in  the image."

	| arguments |
	"Resolve proxy receiver/arguments for the same memory by replacing them with the original object. See TDBProxy>>#xxxtdbproxyForward: and senders."
	arguments := nil.
	originalArguments withIndexDo: [:argument :index |
		((aContext objectClass: argument) isTdbProxyClass
			and: [argument xxxtdbproxyMemory == memory])
				ifTrue: [(arguments ifNil: [arguments := originalArguments copy])
					at: index put: argument xxxtdbproxyObject]].
	arguments ifNil: [arguments := originalArguments].
	
	self flag: #todo. "Handle missing arguments gracefully"
	self flag: #todo. "Handle remaining primitives - should we fork for all vectors on spec?"
	self flag: #optimize. "Do not combine unused arguments (e.g., for mirror primitives)"
	self flag: #optimize. "Array lookup for primitives?"
	
	(PrimitiveHandlers at: primitiveIndex) ifNotNil: [:handler |
		^ self perform: handler withArguments: {aContext. primitiveIndex. aCompiledMethod. receiver. arguments. aBlock}].
	
	^ super
		context: aContext
		doPrimitive: primitiveIndex
		method: aCompiledMethod
		receiver: receiver
		args: arguments
		do: aBlock