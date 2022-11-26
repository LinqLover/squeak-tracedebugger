updating
aspectDependencies

	^ Dictionary new
		"superclasses"
		at: #contents put: #(expression);
		at: #windowTitle put: #(#labelString);
		
		"model"
		at: #buildContents put: #(buildContextValueTreeWith: representationMode);
		at: #buildContextValueTreeWith: put: #(shouldShrinkColumns);
		at: #contextSliceLabelFor: put: #(contextLabelCompactionStrategy contextLabelTruncation);
		at: #detailsText put: #(selectedContextSlice);
		at: #filterResult: put: #(shouldHideErrors valueFilter);
		at: #representationLabel put: #(representationMode);
		at: #rootContextSlices put: #(contextTreeSlice);
		at: #selectedContextSlice put: #(contextTreeSlice);
		at: #updateMemorySlice put: #(cursor object);
		at: #updateContextTreeSlice put: #(filterResult: memorySlice shouldContractPaths);
		
		yourself