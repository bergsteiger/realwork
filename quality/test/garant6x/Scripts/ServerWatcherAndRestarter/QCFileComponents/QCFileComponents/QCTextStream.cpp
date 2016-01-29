// QCTextStream.cpp : Implementation of CQCTextStream

#include "stdafx.h"
#include "QCTextStream.h"

#include <fstream>
#include <memory>
#include <strstream>
#include <io.h>

#include "convutil.h"


bool operator==(
   const LARGE_INTEGER left,
   const LARGE_INTEGER right
)
{
	return left.QuadPart == right.QuadPart;
}


static const char* END_OF_LINE = "\r\n";
static const int END_OF_LINE_LENGTH = strlen(END_OF_LINE);

// CQCTextStream

void CQCTextStream::FinalRelease()
{
	if (m_file != INVALID_HANDLE_VALUE) {
		CloseHandle(m_file);
	}
}
	

HRESULT CQCTextStream::Initialize(
	BSTR in_path_to_file,
	IOMode in_iomode,
	VARIANT_BOOL in_is_create
	)
{
	m_path_to_file.assign(in_path_to_file);
	m_iomode = in_iomode;
	m_is_create = in_is_create;
	//
	// проверяем что файл существует
	bool is_file_exists = _waccess(m_path_to_file.c_str(), 0) == 0;
	// если файл не существует и нельзя создавать то ругаемся
	if (!is_file_exists)
		if (m_is_create == VARIANT_FALSE) {
			return Error("Файл не найден по указанному пути!");
		} else if (m_iomode == ForReading) {
			return Error("Файл не найден по указанному пути! Файл открываемый для чтения нельзя создавать!");
		}

	if (m_iomode != ForReading) {
		if (!OpenFile()) {
			return Error("Не удается открыть файл!");
		}
	}
	
	
	if (m_iomode == ForAppending) {	
		DWORD fptr = SetFilePointer(m_file, 0, NULL, FILE_END);
		if (fptr == INVALID_SET_FILE_POINTER) {
			return Error("Не могу встать в конец файла!");
		}
	}
	//
	return S_OK;
}

STDMETHODIMP CQCTextStream::InterfaceSupportsErrorInfo(REFIID riid)
{
	static const IID* arr[] = 
	{
		&IID_IQCTextStream,
		&IID_ITextStream
	};

	for (int i=0; i < sizeof(arr) / sizeof(arr[0]); i++)
	{
		if (InlineIsEqualGUID(*arr[i],riid))
			return S_OK;
	}
	return S_FALSE;
}

// ITextStream Methods

// Данный метод всегда возвращает -1, потому что стиль работы с потоком предполагаемый мной не поддерживает вычитку файла с самого начала
STDMETHODIMP CQCTextStream::get_Line(long * Line)
{
	*Line = -1;
	return S_OK;
}
	
// Данный метод всегда возвращает -1, потому что стиль работы с потоком предполагаемый мной не поддерживает вычитку файла с самого начала
STDMETHODIMP CQCTextStream::get_Column(long * Column)
{
	*Column = -1;
	return S_OK;
}

STDMETHODIMP CQCTextStream::get_AtEndOfStream(VARIANT_BOOL * EOS)
{	
	*EOS = IsEOF() ? VARIANT_TRUE : VARIANT_FALSE;
	return S_OK;
}

STDMETHODIMP CQCTextStream::get_AtEndOfLine(VARIANT_BOOL * EOL)
{
	if (OpenFile())
	{
		LARGE_INTEGER old_pos = GetCurrPos();
		DWORD bytes_read;
		char buf[2];
		buf[0] = 0; buf[1] = 0;
		ReadFile(m_file, &buf, sizeof(buf), &bytes_read, NULL);
		SetCurrPos(old_pos, FILE_BEGIN);
		*EOL = (strcmp(buf, END_OF_LINE) == 0) ? VARIANT_TRUE : VARIANT_FALSE;
		CloseFile();
	}
	//
	return S_OK;
}

STDMETHODIMP CQCTextStream::Read(long Characters, BSTR * Text)
{
	if (m_iomode != ForReading) {
		return Error("Операция недопустима т.к. файл открыт для записи!");
	}
	//
	if ( (Characters > 0) && (!IsEOF()) )
	{
		const int arr_len = Characters+1;
		char* buf = new char[arr_len];
		//
		DWORD bytes_read;
		if (OpenFile()) {
			ReadFile(m_file, buf, Characters, &bytes_read, NULL);
			CloseFile();
		}
		buf[bytes_read] = '\0';
		//
		wchar_t* conv_str = qc_mbs_to_wcs(buf, bytes_read);
		delete[] buf;
		if (conv_str) {
			SysReAllocString(Text, conv_str);
			delete[] conv_str;
		}
	} else if (Characters == 0) {
		SysReAllocString(Text, _T(""));
	}
	return S_OK;
}

STDMETHODIMP CQCTextStream::ReadLine(BSTR * Text)
{
	if (m_iomode != ForReading) {
		return Error("Операция недопустима т.к. файл открыт для записи!");
	}

	const int to_read = 256;
	const int buf_len = to_read + 1;
	char buf[buf_len];
	std::string res;
	//	
	if (OpenFile())
		while (!IsEOF())
		{	
			DWORD bytes_read;		
			ReadFile(m_file, buf, to_read, &bytes_read, NULL);
			buf[bytes_read] = '\0';
			// ищем конец строки в том что прочитали
			char* eol_pos = strstr(buf, END_OF_LINE);
			if (eol_pos) {
				*eol_pos = '\0';
			}
			res.append(buf);
			//
			if (eol_pos) {			
				int diff = eol_pos - buf + END_OF_LINE_LENGTH - bytes_read;
				// отодвигаем указатель файла на начало строки
				LARGE_INTEGER new_pos;
				new_pos.QuadPart = diff;
				SetCurrPos(new_pos, FILE_CURRENT);
				CloseFile();
				break;
			} else if (bytes_read < to_read) { // прочитали меньше чен надо - файл кончился
				break;
			}
		}

	wchar_t* converted = qc_mbs_to_wcs(res.c_str(), res.size());
	SysReAllocString(Text, converted);
	delete[] converted;
	
	return S_OK;
}

STDMETHODIMP CQCTextStream::ReadAll(BSTR * Text)
{
	if (m_iomode != ForReading) {
		return Error("Операция недопустима т.к. файл открыт для записи!");
	}

	LARGE_INTEGER file_size = GetFileSize();
	if (file_size.HighPart !=0) {
		return Error("Файл слишком большой!");
	}
	//
	LARGE_INTEGER new_pos;
	new_pos.QuadPart = 0;
	SetCurrPos(new_pos, FILE_BEGIN);
	//
	return Read(file_size.LowPart, Text);
}

STDMETHODIMP CQCTextStream::Write(BSTR Text)
{
	if (m_iomode == ForReading) {
		return Error("Операция недопустима т.к. файл открыт для чтения!");
	}
	//
	std::string str = qc_wcs_to_mbs(Text, SysStringLen(Text));
	WriteToFile(str);

	return S_OK;
}

STDMETHODIMP CQCTextStream::WriteLine(BSTR Text)
{
	if (m_iomode == ForReading) {
		return Error("Операция недопустима т.к. файл открыт для чтения!");
	}
	//
	std::string str = qc_wcs_to_mbs(Text, SysStringLen(Text));
	str.append(END_OF_LINE);
	WriteToFile(str);
	
	return S_OK;
}

STDMETHODIMP CQCTextStream::WriteBlankLines(long Lines)
{
	if (m_iomode == ForReading) {
		return Error("Операция недопустима т.к. файл открыт для чтения!");
	}
	//
	std::string str;
	for (int i=0; i < Lines; i++) {
		str.append(END_OF_LINE);
	}
	WriteToFile(str);

	return S_OK;
}

STDMETHODIMP CQCTextStream::Skip(long Characters)
{
	if (m_iomode != ForReading) {
		return Error("Операция недопустима т.к. файл открыт не для чтения!");
	}
	//
	if (OpenFile())
	{
		LARGE_INTEGER file_size = GetFileSize();
		LARGE_INTEGER curr_pos = GetCurrPos();
		LARGE_INTEGER new_pos;
		if (Characters > (file_size.QuadPart - 1 - curr_pos.QuadPart)) { // если вышли за границу файла
			new_pos.QuadPart = 0;
			SetCurrPos(new_pos, FILE_END);
		} else if (curr_pos.QuadPart + Characters < 0) { // если перед началом
			new_pos.QuadPart = 0;
			SetCurrPos(new_pos, FILE_BEGIN);
		} else {
			new_pos.LowPart = Characters;
			new_pos.HighPart = 0;
			SetCurrPos(new_pos, FILE_CURRENT);
		}
		CloseFile();
	}
	//
	return S_OK;
}

STDMETHODIMP CQCTextStream::SkipLine()
{
	BSTR tmp = SysAllocString(NULL);
	ReadLine(&tmp);
	SysFreeString(tmp);
	return S_OK;
}

STDMETHODIMP CQCTextStream::Close()
{
	m_num_of_opens = 1;
	CloseFile();
	m_saved_pos.QuadPart = 0;
	return S_OK;
}

// Private members
LARGE_INTEGER CQCTextStream::GetCurrPos()
{	
	LARGE_INTEGER file_pos;
	file_pos.QuadPart = 0;
	if (OpenFile()) {
		file_pos.LowPart = ::SetFilePointer(m_file, 0, &file_pos.HighPart, FILE_CURRENT);
		CloseFile();
	}
	return file_pos;
}

LARGE_INTEGER CQCTextStream::GetFileSize()
{
	LARGE_INTEGER file_size;
	file_size.QuadPart = 0;
	DWORD size_high;
	if (OpenFile()) {
		file_size.LowPart = ::GetFileSize(m_file, &size_high);
		CloseFile();
	}
	file_size.HighPart = size_high;
	return file_size;
}

void CQCTextStream::SetCurrPos(LARGE_INTEGER new_pos, DWORD move_method)
{
	LARGE_INTEGER real_pos = new_pos;
	if (OpenFile()) {
		real_pos.LowPart = ::SetFilePointer(m_file,
			real_pos.LowPart,
			real_pos.HighPart == 0 ? NULL : &real_pos.HighPart,
			move_method
		); 
		CloseFile();
	}
}

bool CQCTextStream::IsEOF()
{
	bool res;
	if (OpenFile()) {
		res = GetCurrPos() == GetFileSize();
		CloseFile();
	}
	return res;
}

bool CQCTextStream::OpenFile()
{	
	++m_num_of_opens;
	if ((m_num_of_opens == 1) && (m_file == INVALID_HANDLE_VALUE)) {
		DWORD desired_access;
		DWORD creation_disposition;
		
		switch(m_iomode)
		{
		case ForReading:
			desired_access = GENERIC_READ;
			creation_disposition = OPEN_EXISTING;
			break;
		case ForWriting:
			desired_access = GENERIC_WRITE;
			creation_disposition = CREATE_ALWAYS;
			break;
		case ForAppending:
			desired_access = GENERIC_WRITE;
			creation_disposition = OPEN_ALWAYS ;
		}
		
		// открываем файл
		m_file = ::CreateFile(
			m_path_to_file.c_str(), 
			desired_access,
			FILE_SHARE_DELETE | FILE_SHARE_READ | FILE_SHARE_WRITE,
			NULL,
			creation_disposition,
			FILE_ATTRIBUTE_NORMAL,
			NULL);

		if (m_file != INVALID_HANDLE_VALUE) {
			SetCurrPos(m_saved_pos, FILE_BEGIN);
		}
	}

	return (m_file != INVALID_HANDLE_VALUE);
}

void CQCTextStream::CloseFile()
{
	if ((m_num_of_opens == 1) && (m_file != INVALID_HANDLE_VALUE)) {
		m_saved_pos	= GetCurrPos();
		::CloseHandle(m_file);
		m_file = INVALID_HANDLE_VALUE;
	}
	--m_num_of_opens;
}

void CQCTextStream::WriteToFile(const std::string& str)
{
	if (OpenFile())
	{
		DWORD bytes_write;
		WriteFile(m_file, str.c_str(), str.size(), &bytes_write, NULL);
		CloseFile();
	}	
}