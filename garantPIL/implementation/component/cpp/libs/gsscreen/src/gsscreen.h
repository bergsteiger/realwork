#ifndef __GSSCREEN_H__
#define __GSSCREEN_H__

#if defined(BRDR) || defined(BRDR32)
	#include "pagefile.h"
#endif

#include "pscreen.h"

class GSScreen : public ProgressScreen {
	protected:
    virtual void RealInitScreen(const char *title);
		virtual void ShowMessage(const char *, int sub=0);
		virtual void ShowProgress(void);
	public:
		virtual int ShowQuestionYesOrNo(const char *, int RetryAbort= 0);
		void OtherShowMessage(const char *pStr, int sub= 0){
			ShowMessage(pStr, sub);
		}
		GSScreen(code_t i, code_t o) : ProgressScreen(i, o) {};
		~GSScreen() {};
		virtual void CloseScreen();
#if defined(BRDR) || defined(BRDR32)
		LPPF_PARAM lastReaded;
		void *pBase, *pUpdatedBase;
		char *pFileNameError;
		const char *pReadErrorMsg, *pWriteErrorMsg;
		int isNT, notSplit, AllCpd, rdStats, wrStats
#ifdef INC_OLD_FAST_CPY
			, not_Cache
#endif
			;
#endif
};

#endif  // __GSSCREEN_H__
