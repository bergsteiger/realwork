////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/OptionTreeControls/CPreciseTimer.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::OptionTreeControls::CPreciseTimer
//
// таймер
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_OPTIONTREECONTROLS_CPRECISETIMER_H__
#define __SHARED_WINGUI_OPTIONTREECONTROLS_CPRECISETIMER_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *470B1253003E_CUSTOM_INCLUDES*
#include <algorithm>
#include <string>

std::string  Int64ToString(__int64 const& ri64, __int64 const& iRadix=10);
CString Int64ToDurationString(__int64 const& ri64);
//#UC END# *470B1253003E_CUSTOM_INCLUDES*

namespace WinGUI {

// таймер
class CPreciseTimer {
	SET_OBJECT_COUNTER (CPreciseTimer)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~CPreciseTimer ();


//#UC START# *470B1253003E*
public:
	//CONSTRUCTOR
	CPreciseTimer(const bool& bstart=true);

	inline bool CPreciseTimer::SupportsHighResCounter()
	{
		return sm_bPerformanceCounter;
	}

	void StartTimer();
	CPreciseTimer& StopTimer();
	__int64 GetTime();

  CString GetDurationString(void) const;
#ifdef _DEBUG
  void DumpDuration(const CString& stitel) const;
#endif
private:
	//Auxiliary Function
	inline void CPreciseTimer::UpdateElapsed()
	{
		if(true == sm_bPerformanceCounter)
		{
			QueryPerformanceCounter(&m_liCount);
			m_i64Counts = ((__int64)m_liCount.HighPart << 32) + (__int64)m_liCount.LowPart;
			//Transform in microseconds
			(m_i64Counts *= 1000000) /= sm_i64Freq;
		}
		else
			//Transform milliseconds to microseconds
			m_i64Counts = (__int64)GetTickCount() * 1000;
		if(m_i64Counts > m_i64Start)
			m_i64Elapsed = m_i64Counts - m_i64Start;
		else
			//Eliminate possible number overflow (0x7fffffffffffffff is the maximal __int64 positive number)
			m_i64Elapsed = (0x7fffffffffffffff - m_i64Start) + m_i64Counts;
	}

	//Member variables
	bool m_bRunning;	
	__int64 m_i64Start;
	__int64 m_i64Elapsed;

	//Some auxiliary variables
	__int64 m_i64Counts;
	LARGE_INTEGER m_liCount;

	//Static Variables
	static bool sm_bInit;
	static bool sm_bPerformanceCounter;
	static __int64 sm_i64Freq;
//#UC END# *470B1253003E*
}; // class CPreciseTimer

} // namespace WinGUI


#endif //__SHARED_WINGUI_OPTIONTREECONTROLS_CPRECISETIMER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

