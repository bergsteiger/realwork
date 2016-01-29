////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseTargetItem.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseTargetItem
//
// базовый класс для всех элементов, имеющих цель (атрибут, операция параметр)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseTargetItem.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/DispatchHelper.h"

namespace RoseInternal {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseTargetItem::~RoseTargetItem () {
	//#UC START# *4A35E2EA011A_DESTR_BODY*
	//#UC END# *4A35E2EA011A_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const std::string& RoseTargetItem::get_target () const {
	//#UC START# *4A35E3240269_GET_ACCESSOR*
	return m_target;
	//#UC END# *4A35E3240269_GET_ACCESSOR*
}

void RoseTargetItem::set_target (const std::string& target) {
	//#UC START# *4A35E3240269_SET_ACCESSOR*
	IRoseApplicationPtr app = this->get_application ();
	if (app) {
		IRoseClassPtr cls = app->CurrentModel->FindClassWithID (target.c_str ());
		if (cls) {
			this->set_target_class (cls);
		} else {
			m_target = target;
		}
	} else {
		m_target = target;
	}	
	//#UC END# *4A35E3240269_SET_ACCESSOR*
}

IRoseClassPtr RoseTargetItem::get_target_class () const {
	//#UC START# *4A35E32703B7_GET_ACCESSOR*
	return m_target_class;
	//#UC END# *4A35E32703B7_GET_ACCESSOR*
}

void RoseTargetItem::set_target_class (IRoseClassPtr target_class) {
	//#UC START# *4A35E32703B7_SET_ACCESSOR*
	m_target_class = target_class;
	if (m_target_class) {
		m_target = m_target_class->GetName ();
	}
	//#UC END# *4A35E32703B7_SET_ACCESSOR*
}


} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

