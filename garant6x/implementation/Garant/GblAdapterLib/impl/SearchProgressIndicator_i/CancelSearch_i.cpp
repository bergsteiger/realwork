////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/SearchProgressIndicator_i/CancelSearch_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::SearchProgressIndicator_i::CancelSearch_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/SearchProgressIndicator_i/CancelSearch_i.h"

namespace GblAdapterLib {
namespace SearchProgressIndicator_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CancelSearch_i::CancelSearch_i (GblPilot::SearchManager* search_manager)
//#UC START# *462748CD01A4_46274948003B_462750B0005C_BASE_INIT*
	: m_search_manager (GblPilot::SearchManager::_duplicate (search_manager))
//#UC END# *462748CD01A4_46274948003B_462750B0005C_BASE_INIT*
{
	//#UC START# *462748CD01A4_46274948003B_462750B0005C_BODY*
	//#UC END# *462748CD01A4_46274948003B_462750B0005C_BODY*
}

CancelSearch_i::~CancelSearch_i () {
	//#UC START# *462750B0005C_DESTR_BODY*
	//#UC END# *462750B0005C_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from CancelLongProcess
// Вызывается для прерывания длительного процесса.
void CancelSearch_i::cancel_process () const {
	//#UC START# *45EEE00D032A_462750B0005C*
	m_search_manager->stop_search ();
	//#UC END# *45EEE00D032A_462750B0005C*
}
} // namespace SearchProgressIndicator_i
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

