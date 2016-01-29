#include "shared/Core/fix/mpcxc.h"
#include <cstdlib>
#include <cstring>
#include "pscreen.h"

ProgressScreen::ProgressScreen(code_t c_in, code_t c_out)
{
	in = c_in; out = c_out;
}

void ProgressScreen::InitScreen(const char *title)
{
	progress = 0;
	char *s = Recoding(in, out, strdup(title));
	RealInitScreen(s);
	free(s);
	ShowMessage("", 0);
	ShowMessage("", 1);
	ShowProgress();
}

void ProgressScreen::SetMessage(const char *msg)
{
	char *s = Recoding(in, out, strdup(msg));
	ShowMessage(s, 0);
	free(s);
}

void ProgressScreen::SetSubMessage(const char *msg)
{
	char *s = Recoding(in, out, strdup(msg));
	ShowMessage(s, 1);
	free(s);
}

int ProgressScreen::SetProgress(int value)
{
	progress = (value > 100) ? 100 : value;
	ShowProgress();
	return progress;
}

int ProgressScreen::IncProgress(int by)
{
	by += progress;
	return SetProgress(by);
}

