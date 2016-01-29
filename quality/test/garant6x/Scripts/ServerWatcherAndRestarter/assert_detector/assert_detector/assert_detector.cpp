// assert_detector.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"


struct PARAMS
{
	DWORD target_pid;
	FILE* res_file;
};

BOOL CALLBACK enum_proc(HWND hwnd, LPARAM lParam)
{
	PARAMS* params = (PARAMS*)lParam;

	_TCHAR buf[256];
	const size_t buf_size = sizeof(buf)/sizeof(buf[0]);
	int res;

	res = GetClassName(hwnd, buf, buf_size);
	if (res && (_tcscmp(buf,  _T("#32770")) == 0)) {		
		res = GetWindowText(hwnd, buf, buf_size);
		if (res  && (_tcscmp(buf, _T("Microsoft Visual C++ Debug Library")) == 0)) {
			DWORD wnd_pid;
			GetWindowThreadProcessId(hwnd, &wnd_pid);
			if (wnd_pid == params->target_pid)
				_ftprintf(params->res_file, _T("%X\r\n"), hwnd);
		}
	}

	return TRUE;
}



int _tmain(int argc, _TCHAR* argv[])
{
	if (argc != 3) {
		_tprintf(_T("Usage: %s cmd_file res_file"), argv[0]);
		return 1;
	}
	
	_TCHAR* cmd_file_path = argv[1];
	_TCHAR* res_file_path = argv[2];
	
	const _TCHAR* tmp_suffix = _T(".temp");
	_TCHAR* tmp_res_file_path = (_TCHAR*)calloc(_tcslen(res_file_path) + _tcslen(tmp_suffix) + 1, sizeof(_TCHAR));
	_tcscpy(tmp_res_file_path, res_file_path);
	_tcscat(tmp_res_file_path, tmp_suffix); 	

	char buf[1024];
	const size_t buf_size = sizeof(buf)/sizeof(buf[0]);

	while (true)
	{	
		FILE* cmd_file = _tfopen(cmd_file_path, _T("r"));
		
		if (cmd_file == NULL)
		{
			Sleep(250);
			continue;
		}		


		size_t read_count = fread(buf, 1, buf_size, cmd_file);
		fclose(cmd_file);
		_tremove(cmd_file_path);

		if (read_count == 0)
			continue;
		buf[read_count] = '\0';
	
		PARAMS params;
		params.target_pid = atoi(buf);
		params.res_file = _tfopen(tmp_res_file_path, _T("w"));
		
		EnumWindows(enum_proc, (LPARAM)&params);

		fclose(params.res_file);
		_tremove(res_file_path);
		_trename(tmp_res_file_path, res_file_path);
	}

	free(tmp_res_file_path);

	return 0;
}

