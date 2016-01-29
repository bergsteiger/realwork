////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/ShowOnModelSrv.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::ShowOnModelSrv
//
// реализация фасета ShowOnModel
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/ShowOnModelSrv.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CmdHandler.h"


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ShowOnModelSrv::~ShowOnModelSrv () {
	//#UC START# *468BA19A0000_DESTR_BODY*
	//#UC END# *468BA19A0000_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from LinkSupport::ConfModelLinks::ShowOnModel
// показать элемент в розе, возвращает 0 - если удалось, 1 - если открыта не та модель
CORBA::Long ShowOnModelSrv::show (const char* project_name, const char* elem_guid) throw (CORBA::SystemException) {
	//#UC START# *468B9F5B037A_468BA19A0000*
	char* msg = new char[strlen(elem_guid)+1];
	strcpy (msg, elem_guid);
	CmdHandler::instance ()->PostMessage (CmdHandler::WM_BROWSE_IN_DIAG, 0, (LPARAM)msg);
	return 0;
	//#UC END# *468B9F5B037A_468BA19A0000*
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

