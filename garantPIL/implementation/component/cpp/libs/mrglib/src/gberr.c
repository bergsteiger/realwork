#include <stdlib.h>
#include <errno.h>
#include <stdarg.h>
#include <stdio.h>

#include "gdbapi.h"

static int _gb_last_error=0;
static char *gb_err_internal_buff = NULL;

static char *err4[] = {		"Error opening file %s for reading\n",
							"Paged file %s corrupted\n",
							"Error creating file %s\n",
							"Invalid data version info in file %s\n", 
							"Missing base state info in base %s\n",
							NULL, NULL, NULL,
							NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
							"Can't locate page %d in paged file %s\n",
							"Error reading paged file %s\n",
							"Error writing paged file %s\n",
							"Can't extend or truncate paged file %s\n",
							NULL, NULL, NULL, NULL,
							NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL	};

static char *err5[] = {		NULL,
							"Program is running out of memory. Check the system limits.\n",
							NULL	};

static char *file_name;

static int page;

static char *gb_syserr_msg = "System error! The system reported: ";

int gb_last_error(void)
{
	return _gb_last_error;
}

int gb_set_last_error(int err, ...) // TODO : check for err and obtain parameters
{
	int gb_prev_err;
	va_list eargs;

	gb_prev_err = _gb_last_error;
	_gb_last_error = err;
	va_start(eargs, err);
	if(err >= 0x400 && err < 0x500) {
		file_name = va_arg(eargs, char*);
		if(err == 0x410) page = va_arg(eargs, u_int32_t);
	}
	return gb_prev_err;
}

// TODO : sprintf err msg with parameters into buff of len bytes length
char *gb_err_msg(int err, char *buf, int len)
{
	char *arg, *msg;

	if(!gb_err_internal_buff)
		gb_err_internal_buff = (char *)ml_malloc(256);

	if(err >= 0x400 && err < 0x500) {
		msg = err4[err-0x400];
		arg = file_name;
	}
	else if(err >= 0x500 && err < 0x600) {
		msg = err5[err-0x500];
		arg = file_name;
	}
	else if(err >= 0x700 && err < 0x800) {
		msg = gb_syserr_msg;
		arg = strerror(errno);
	}
	else {
		*buf = '\0';
		return buf;
	}
	if (err != 0x410) sprintf(buf, msg, arg);
	else sprintf(buf, msg, arg, page);
	return buf;
}

int _gb_log_state_ = 0;

int gb_enable_log(int enable)
{
	int old_state;

	old_state = _gb_log_state_;
	_gb_log_state_ = enable;
	return old_state;
}

void gb_log_error()
{
	char *buf;
	int err;

	if (!_gb_log_state_) return;
	buf = (char *)ml_malloc(2048);
	bzero(buf, 2048);
	err = gb_last_error();
	m_log(gb_err_msg(err, buf, 2048));
}
