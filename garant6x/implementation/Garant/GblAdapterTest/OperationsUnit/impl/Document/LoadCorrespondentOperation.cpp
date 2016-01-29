////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/LoadCorrespondentOperation.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::Document::LoadCorrespondentOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/Document/LoadCorrespondentOperation.h"

//#UC START# *445B3BD200CB_CUSTOM_INCLUDES*
#include "Garant/GblAdapterTest/Common/autotest.h"
//#UC END# *445B3BD200CB_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace Document {

//#UC START# *445B3BD200CB*
//#UC END# *445B3BD200CB*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

LoadCorrespondentOperation::~LoadCorrespondentOperation () {
	//#UC START# *445B3BD200CB_DESTR_BODY*
	//#UC END# *445B3BD200CB_DESTR_BODY*
}	



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from IOperation
void LoadCorrespondentOperation::execute (OperationInterfaces::IOperationParam* param) {
	//#UC START# *445B049B003E_445B3BD200CB*
	if (param->document ()) {
		OperationInterfaces::IAttributeManager_var attributes;
		this->get_attribute_manager (attributes.out ());
		
		std::string skr_type = attributes->get_string ("skr_type");
		DocumentHelper::load_skr (
			param->document (), param->common_interface (), skr_type.c_str (), false, true
		);

		this->execute_child_operations (param);		
	}
	//#UC END# *445B049B003E_445B3BD200CB*
}

} // namespace Document
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////