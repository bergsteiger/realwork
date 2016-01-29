////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/FoundContext_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::FoundContext_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/FoundContext_i.h"

//#UC START# *4C8F301F031C_CUSTOM_INCLUDES*
//#UC END# *4C8F301F031C_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *4C8F301F031C*
//#UC END# *4C8F301F031C*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FoundContext_i::FoundContext_i (const GblPilot::ContextList& list)
//#UC START# *4C8E37620115_4C8F31830221_4C8F301F031C_BASE_INIT*
//#UC END# *4C8E37620115_4C8F31830221_4C8F301F031C_BASE_INIT*
{
	//#UC START# *4C8E37620115_4C8F31830221_4C8F301F031C_BODY*
	CORBA::ULong length = list.length ();
	m_list.resize (length);
	
	for (CORBA::ULong i = 0; i < length; ++i) {
		const GblPilot::FragmentList& server_fragment_list = list [i];
		CORBA::ULong server_fragment_length = server_fragment_list.length ();
		
		FragmentList& fragment_list = m_list [i];
		fragment_list.resize (server_fragment_length);
		
		for (CORBA::ULong j = 0; j < server_fragment_length; ++j) {
			
			NodeIndexPath& path = fragment_list [j].path;
			path.insert (
				path.begin ()
				, server_fragment_list [j].path.get_buffer ()
				, server_fragment_list [j].path.get_buffer () + server_fragment_list [j].path.length ()
			);
			
			fragment_list [j].start  = server_fragment_list [j].start;
			fragment_list [j].finish = server_fragment_list [j].end;
		}
	}
	//#UC END# *4C8E37620115_4C8F31830221_4C8F301F031C_BODY*
}

FoundContext_i::~FoundContext_i () {
	//#UC START# *4C8F301F031C_DESTR_BODY*
	//#UC END# *4C8F301F031C_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from FoundContext
const ContextList& FoundContext_i::get_list () const {
	//#UC START# *4C8E37750112_4C8F301F031C_GET*
	return m_list;
	//#UC END# *4C8E37750112_4C8F301F031C_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

