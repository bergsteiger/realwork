#include "shared/Core/fix/mpcxc.h"
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "pscreen.h"
#include "garver.h"

static int progress=0;

static ProgressScreen *screen =0;

// Use "C" linkage and naming...

/* Dual languages support... */

static char *rus_msg[] = {
	"Объединение баз системы ГАРАНТ",
	"Версия ",
	"Проверка баз на совместимость",
	"Создание объединенной базы данных",
	"Построение поисковых индексов",
	"Обновление дополнительной информации о базе данных",
	"Базы объединены успешно"
};

static char *eng_msg[] = {
	"GARANT databases joining",
	"Version ",
	"Checking source bases for compatibility",
	"Joining databases...",
	"Creating search indexes",
	"Updating system iinformation in database",
	"Bases joined successfully"
};

static char **msg_tbl = rus_msg;

void init_screen(ProgressScreen *ps)
{
	//int len, ver;
	char *msg;

	screen = ps;
	msg = (char *)alloca(256);
#ifndef OLD_CODE
	memset(msg, 0, 256);
#else
	bzero(msg, 256);
#endif
	strcpy(msg, msg_tbl[0]);
	/*len = strlen(msg);
	ver = strlen(msg_tbl[1]);
	ver += strlen(GARANT_VERSION);
	memset(msg + len, ' ', 76-len-ver);
	strcpy(msg + 76 - ver, msg_tbl[1]);
	strcat(msg, GARANT_VERSION);*/
	screen->InitScreen(msg);
}

extern "C" {

void set_message(int mn)
{
	screen->SetMessage(msg_tbl[mn]);
}

void show_progress(int p)
{
	screen->SetProgress(p);
}

void inc_progress(void)
{
	screen->IncProgress(1);
}

void gm_set_language(int lang)
{
	msg_tbl = (lang) ? eng_msg : rus_msg;
}

}
