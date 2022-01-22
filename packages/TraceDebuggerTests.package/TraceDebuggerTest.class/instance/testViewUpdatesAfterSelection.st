tests
testViewUpdatesAfterSelection

	self
		runDebuggerFrom: (Context
			sender: nil
			receiver: TDBTestLogic new
			method: TDBTestLogic >> #griffle
			arguments: #())
		assertionsAndSteps:
			{#(griffle nil (griffle ())).
			#(stepOver stepThrough).
			#(griffle 'wiffy1' (griffle (griffle:with: (griffle ())))).
			#(stepThrough stepThrough).
			#(griffle 'wiffy2' (griffle (griffle:with: (griffle ()) (griffle ())))).
			#(stepInto).
			#(wiffy2 '^ 3' (griffle (griffle:with: (griffle ()) (griffle (wiffy2 ()))))).
			{[:debugger | debugger
				selectContext: (debugger contextStack
					detect: [:ctx | ctx selector = #griffle:with:]);
				stepInto]}.
			#(griffle:with: '* anotherBlock value' (griffle (griffle:with: (griffle ()) (griffle (wiffy2 ()))))).
			{[:debugger | debugger
				selectContext: (debugger contextStack
					detect: [:ctx | ctx selector = #griffle]);
				stepThrough]}.
			#(griffle '^ self griffle: [self wiffy1] with: [self wiffy2]' (griffle (griffle:with: (griffle ()) (griffle (wiffy2 ())))))}.