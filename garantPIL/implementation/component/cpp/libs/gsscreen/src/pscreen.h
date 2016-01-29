/*
	Usage.
	At start, derive your own class from "class ProgressScreen".
	Then, construct the object and call InitScreen(title);
	You screen must be ready now. Then You can use any subsequent calls
	of SetProgress(), IncProgress(), SetMessage() and SetSubMessage() (if
	two messages are used to explain the progress). To reuse screen, You can make
	two calls: SetSourceEncoding() (if needed) and InitScreen(). At the end You
	call CloseScreen() that does all cleanup.
	
	Notes.

	All charset recoding are done by base class methods.
	You must implement the following methods in derived class:

	Deriving your own class.

	void RealInitScreen(const char *title);
		This method initializes the visual screen and draws the title.
		You should not call ShowMessage() or ShowProgress() from your implementation,
		because it will be done by base class InitScreen() method.
	void ShowMessage(const char *, int sub=0);
		This method shows the primary message by default and secondary message
		if parameter "sub" is not zero.
	void ShowProgress(void);
		This method visualizes the current progress bar value, stored in
		member called "progress".
	void CloseScreen();
		This method does all cleanup and used at the end of screen life cycle.

*/

#ifndef __PROGRESS_SCREEN_H__
#define __PROGRESS_SCREEN_H__

#include "shared/Core/fix/mpcxc.h"

#include "recode.h"

class ProgressScreen {
	protected:
		code_t in;
		code_t out;
		int progress;
		
		// Pure virtual part: visualization
		virtual void RealInitScreen(const char *title) =0;
		virtual void ShowMessage(const char *, int sub=0) =0;
		virtual void ShowProgress(void) =0;
	public:
		ProgressScreen(code_t in, code_t out = mpcxc_cd_cursys());
		virtual ~ProgressScreen() {};
		// Initialization / cleanup
		void InitScreen(const char *title);
		virtual void CloseScreen() =0;

		// run-time encoding change
		void SetSourceEncoding(code_t i) { in = i; };

		// Functionality
		int GetProgress() { return progress; } ;
		virtual int SetProgress(int value);
		int IncProgress(int by);
		void SetMessage(const char *);
		void SetSubMessage(const char *);
};

#endif  // __PROGRESS_SCREEN_H__

