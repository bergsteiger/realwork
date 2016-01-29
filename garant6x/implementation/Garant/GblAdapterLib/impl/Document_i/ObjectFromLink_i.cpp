////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ObjectFromLink_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ObjectFromLink_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ObjectFromLink_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ObjectFromLink_i::ObjectFromLink_i (GblPilot::Link* server_link)
//#UC START# *559E9DF3002D_559EA10A018E_559EA17000D3_BASE_INIT*
	: m_server_link (GblPilot::Link::_duplicate (server_link))
//#UC END# *559E9DF3002D_559EA10A018E_559EA17000D3_BASE_INIT*
{
	//#UC START# *559E9DF3002D_559EA10A018E_559EA17000D3_BODY*
	//#UC END# *559E9DF3002D_559EA10A018E_559EA17000D3_BODY*
}

ObjectFromLink_i::~ObjectFromLink_i () {
	//#UC START# *559EA17000D3_DESTR_BODY*
	//#UC END# *559EA17000D3_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

GblPilot::Link* ObjectFromLink_i::get_server_link () const {
	//#UC START# *559F7F5F0051*
	return this->m_server_link;
	//#UC END# *559F7F5F0051*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

