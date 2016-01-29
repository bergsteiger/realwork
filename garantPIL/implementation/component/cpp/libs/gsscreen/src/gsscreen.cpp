#include "shared/Core/fix/mpcxc.h"

#include <cstddef>

#include "gsscreen.h"
#include "toys.h"
#include "osdep.h"

#include <cstdlib> 

void GSScreen::RealInitScreen(const char *title)
{
	garant_scr(0, title, tr_none);
}

void GSScreen::CloseScreen()
{
	clear_video();
}

int GSScreen::ShowQuestionYesOrNo(const char *pText, int RetryAbort)
{
//#if defined(__Solaris__) || defined(__GO32__) || defined(__FreeBSD__) // GARANT_FREEBSD
//	return 0;
//#else
	int ch;
	ShowMessage(pText);
	do
	{
	  ch = getch();
	  ch = toupper( ch );
	} while( (char)ch != 'Y' && (char)ch != 'N');
	if((char)ch == 'Y')
		return 0;
//#endif
	return 1;
}

void GSScreen::ShowMessage(const char *msg, int sub)
{
	if(sub) {
		hide_message2();
		show_message2(msg);
	}
	else {
		hide_message();
		show_message(msg);
	}
}

void GSScreen::ShowProgress(void)
{
	set_progress(progress);
}

