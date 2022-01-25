message list
selectedMessage

	contents ifNotNil: [^ contents copy].
	
	self selectedContext ifNil: [^ self emptyContents].
	
	self showingDecompile ifTrue: [^ self decompiledSourceIntoContents].
	
	^ contents := (self showingDocumentation
		ifFalse: [self sourceStringPrettifiedAndDiffed]
		ifTrue: [self commentContents])
			copy asText makeSelectorBoldIn: self selectedClassOrMetaClass