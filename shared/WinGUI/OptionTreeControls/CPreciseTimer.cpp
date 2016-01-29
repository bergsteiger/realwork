////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/CPreciseTimer.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::OptionTreeControls::CPreciseTimer
//
// таймер
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/OptionTreeControls/CPreciseTimer.h"

//#UC START# *470B1253003E_CUSTOM_INCLUDES*
std::string Int64ToString(__int64 const& ri64, __int64 const& iRadix)
{
    bool bNeg = (ri64 < 0);
    __int64 i64 = ri64;
	std::string ostrRes;
    bool bSpecial = false;
    if(true == bNeg)
    {
        i64 = -i64;
        if(i64 < 0)
        // Special case number -9223372036854775808 or 
        // 0x8000000000000000
        bSpecial = true;
        ostrRes.append(1, '-');
    }
    int iR;
    do
    {
        iR = (int) (i64 % iRadix);
        if(true == bSpecial)
            iR = -iR;
        if(iR < 10)
            ostrRes.append(1, '0' + iR);
        else
            ostrRes.append(1, 'A' + iR - 10);
        i64 /= iRadix;
    }
    while(i64 != 0);
    //Reverse the string
	std::string::iterator it = ostrRes.begin();
    if(bNeg)
        it++;
	std::reverse(it, ostrRes.end());
    return ostrRes;
}

CString Int64ToDurationString(__int64 const& ri64){
  // duration in microseconds

  const __int64 mcsDay  = 24 * 60 * 60 * (__int64) 1000000;
  const __int64 mcsHour = 60 * 60 * (__int64) 1000000;
  const __int64 mcsMinute = 60 * 1000000;
  const __int64 mcsSecond = 1000000;
  const __int64 mcsMilliSecond = 1000;

  __int64 days=0;
  __int64 Hours=0;
  __int64 Minutes=0;
  __int64 Seconds=0;
  __int64 MilliSeconds=0;
  __int64 MicroSeconds=0;

  days          = ri64 / mcsDay;
  Hours         = (ri64 - (days * mcsDay)) / mcsHour;
  Minutes       = (ri64 - (days * mcsDay) - (Hours * mcsHour)) / mcsMinute;
  Seconds       = (ri64 - (days * mcsDay) - (Hours * mcsHour) -  Minutes * mcsMinute) / mcsSecond;
  MilliSeconds  = (ri64 - (days * mcsDay) - (Hours * mcsHour) -  Minutes * mcsMinute - Seconds * mcsSecond) / mcsMilliSecond;
  MicroSeconds  = ri64 - (days * mcsDay) - (Hours * mcsHour) -  Minutes * mcsMinute - Seconds * mcsSecond - MilliSeconds * mcsMilliSecond;


  CString mcsString("");
  mcsString.Format("%2d:%2d:%2d:%2d:%3d:%3d",(long) days,(long) Hours,(long) Minutes,(long) Seconds,(long) MilliSeconds,(long) MicroSeconds);    
  return mcsString;
}

//#UC END# *470B1253003E_CUSTOM_INCLUDES*

namespace WinGUI {

//#UC START# *470B1253003E*
bool CPreciseTimer::sm_bInit = false;
bool CPreciseTimer::sm_bPerformanceCounter;
__int64 CPreciseTimer::sm_i64Freq;

//CONSTRUCTOR
CPreciseTimer::CPreciseTimer(const bool& bstart) : m_i64Start(0), m_i64Elapsed(0), m_bRunning(false)
{
	//Only if not already initialized
	if(false == sm_bInit)
	{
		//Initializing some static variables dependent on the system just once
		LARGE_INTEGER liFreq;
		if(TRUE == QueryPerformanceFrequency(&liFreq))
		{
			//Only if the system is supporting High Performance
			sm_i64Freq = ((__int64)liFreq.HighPart << 32) + (__int64)liFreq.LowPart;
			sm_bPerformanceCounter = true;
		}
		else
			sm_bPerformanceCounter = false;
		sm_bInit = true;
	}
  if(bstart == true)
    this->StartTimer();
}

void CPreciseTimer::StartTimer()
{
	if(true == sm_bPerformanceCounter)
	{
		QueryPerformanceCounter(&m_liCount);
		m_i64Start = ((__int64)m_liCount.HighPart << 32) + (__int64)m_liCount.LowPart;
		//Transform in microseconds
		(m_i64Start *= 1000000) /= sm_i64Freq;
	}
	else
		//Transform milliseconds to microseconds
		m_i64Start = (__int64)GetTickCount() * 1000;
	m_bRunning = true;
}

CPreciseTimer& CPreciseTimer::StopTimer()
{
	UpdateElapsed();
	m_bRunning = false;
  return *this;
}

__int64 CPreciseTimer::GetTime()
{
	if(true == m_bRunning)
		UpdateElapsed();
	return m_i64Elapsed;
}

CString CPreciseTimer::GetDurationString(void) const{
  return Int64ToDurationString(m_i64Elapsed);
}
#ifdef _DEBUG
void CPreciseTimer::DumpDuration(const CString& stitel) const
{
  afxDump<<"\n "<<stitel<<"  "<<this->GetDurationString();
}
#endif
//#UC END# *470B1253003E*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CPreciseTimer::~CPreciseTimer () {
	//#UC START# *470B1253003E_DESTR_BODY*
	//#UC END# *470B1253003E_DESTR_BODY*
}


} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

