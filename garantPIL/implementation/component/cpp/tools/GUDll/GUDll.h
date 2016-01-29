#include "Logger.h"
#include "pscreen.h"

#define GUDLL_API __declspec(dllexport)

class MfcTracer : public LogDevice
{
	virtual void Print( const char* str ) const;
};

extern "C"
{

GUDLL_API void DoGU( char*, ProgressScreen* );
//GUDLL_API void DoGL( char*, char*, ProgressScreen* );

}
