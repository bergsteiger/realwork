#include "Logger.h"
#include "pscreen.h"

#define GLDLL_API __declspec(dllexport)

class MfcTracer : public LogDevice
{
	virtual void Print( const char* str ) const;
};

extern "C"
{

GLDLL_API void DoGL( char*, char*, ProgressScreen* );
GLDLL_API void DoGL_language( char*, char*, ProgressScreen*, int );

}
