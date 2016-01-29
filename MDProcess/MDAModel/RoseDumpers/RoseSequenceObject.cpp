////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseSequenceObject.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseSequenceObject
//
// Дампер Розовских объектов сиквенс диаграмм
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseSequenceObject.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *4571D2F502EE_CUSTOM_INCLUDES*
//#UC END# *4571D2F502EE_CUSTOM_INCLUDES*


//#UC START# *4571D2F502EE*
//#UC END# *4571D2F502EE*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// создает дампер на основе соответствующего КОМ-объекта
RoseSequenceObject::RoseSequenceObject (IRoseObjectInstancePtr obj)
//#UC START# *4571E4BC031C_BASE_INIT*
//#UC END# *4571E4BC031C_BASE_INIT*
{
	//#UC START# *4571E4BC031C_BODY*
	try {
		IRoseClassPtr cls = obj->GetClass();	
		m_class = RoseAbstractDumper::find_in_tree (cls);
		m_name = (char*) obj->Name;
	} catch (std::exception& ex) {
		std::string str = "Exception in RoseSequenceObject ctor: ";
		str += ex.what ();
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error (str.data());
	} catch (...) {
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error ("Unknown exception in RoseSequenceObject ctor");
	}
	//#UC END# *4571E4BC031C_BODY*
}

RoseSequenceObject::~RoseSequenceObject () {
	//#UC START# *4571D2F502EE_DESTR_BODY*
	//#UC END# *4571D2F502EE_DESTR_BODY*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

