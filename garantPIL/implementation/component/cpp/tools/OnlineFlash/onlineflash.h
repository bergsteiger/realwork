#include "Logger.h"
#include "pscreen.h"

#define OFDLL_API __declspec(dllexport)

class MfcTracer : public LogDevice
{
	virtual void Print( const char* str ) const;
};

extern "C"
{

OFDLL_API int DoWrite (char flash_letter, char* archive_name, char* ininame, char* login, char* data);

}