#include "convutil.h"

#include <stdlib.h>

#include <locale.h>

static const _locale_t loc = _create_locale(LC_ALL, "");

wchar_t* qc_mbs_to_wcs(
	const char* in_buf, 
	const size_t size 
)
{
	// создаем буфер для выхода
	const size_t buf_size = size + 1;
	wchar_t* out_buf = new wchar_t[buf_size];
	// онвертируем
	size_t converted;
	errno_t conv_err = _mbstowcs_s_l(&converted, out_buf, buf_size, in_buf, size, loc);
	if (conv_err !=0) {
		delete[] out_buf;
		out_buf = NULL;
	}
	// возвращаем
	return out_buf;
}

const std::wstring qc_mbs_to_wcs(
	const std::string& in
)
{
	// конвертим
	wchar_t* conv_buf = qc_mbs_to_wcs(in.c_str(), in.size());
	//
	if (conv_buf != NULL) {
		std::wstring out(conv_buf);
		delete[] conv_buf;
		return out;
	} else {
		return NULL;
	}
}

char* qc_wcs_to_mbs(
	const wchar_t* in_buf, 
	const size_t size
)
{
	// создаем буфер для выхода
	const size_t buf_size = size + 1;
	char* out_buf = new char[buf_size];
	// онвертируем
	size_t converted;
	errno_t conv_err = _wcstombs_s_l(&converted, out_buf, buf_size, in_buf, size, loc);
	if (conv_err !=0) {
		delete[] out_buf;
		out_buf = NULL;
	}
	// возвращаем
	return out_buf;
}


const std::string qc_wcs_to_mbs(
	const std::wstring& in
)
{
	// конвертим
	char* conv_buf = qc_wcs_to_mbs(in.c_str(), in.size());
	//
	if (conv_buf != NULL) {
		std::string out(conv_buf);
		delete[] conv_buf;
		return out;
	} else {
		return NULL;
	}
}