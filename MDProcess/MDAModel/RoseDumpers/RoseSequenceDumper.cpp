////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseSequenceDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseSequenceDumper
//
// Дампер Розовских сиквенс-диаграмм
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseSequenceDumper.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseSequenceObject.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *4571D2DD0196_CUSTOM_INCLUDES*
//#UC END# *4571D2DD0196_CUSTOM_INCLUDES*


//#UC START# *4571D2DD0196*
//#UC END# *4571D2DD0196*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// создает дампер на основе соответствующего КОМ-объекта
RoseSequenceDumper::RoseSequenceDumper (IRoseMessagePtr mess)
//#UC START# *4571E5130213_BASE_INIT*
//#UC END# *4571E5130213_BASE_INIT*
{
	//#UC START# *4571E5130213_BODY*
	try {
		m_reciver = new RoseSequenceObject (mess->GetReceiverObject());
		m_sender = new RoseSequenceObject (mess->GetSenderObject());
		m_message = (char*) mess->Name;
	} catch (std::exception& ex) {
		std::string str = "Exception in RoseSequenceDumper ctor: ";
		str += ex.what ();
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error (str.data());
	} catch (...) {
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error ("Unknown exception in RoseSequenceDumper ctor");
	}
	//#UC END# *4571E5130213_BODY*
}

RoseSequenceDumper::~RoseSequenceDumper () {
	//#UC START# *4571D2DD0196_DESTR_BODY*
	delete m_reciver;
	delete m_sender;
	//#UC END# *4571D2DD0196_DESTR_BODY*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

