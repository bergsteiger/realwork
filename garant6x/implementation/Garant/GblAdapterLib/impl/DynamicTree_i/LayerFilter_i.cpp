////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/LayerFilter_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::LayerFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/LayerFilter_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

LayerFilter_i::LayerFilter_i ()
//#UC START# *45EEBB9B01F4_45F6A01A007D_45F6A96700BB_BASE_INIT*
//#UC END# *45EEBB9B01F4_45F6A01A007D_45F6A96700BB_BASE_INIT*
{
	//#UC START# *45EEBB9B01F4_45F6A01A007D_45F6A96700BB_BODY*
	//#UC END# *45EEBB9B01F4_45F6A01A007D_45F6A96700BB_BODY*
}

LayerFilter_i::~LayerFilter_i () {
	//#UC START# *45F6A96700BB_DESTR_BODY*
	//#UC END# *45F6A96700BB_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from LayerFilter
LayerId LayerFilter_i::get_layer () const {
	//#UC START# *45F6A928038A_45F6A96700BB_GET*
	return m_layer;
	//#UC END# *45F6A928038A_45F6A96700BB_GET*
}

void LayerFilter_i::set_layer (LayerId layer) {
	//#UC START# *45F6A928038A_45F6A96700BB_SET*
	m_layer = layer;
	//#UC END# *45F6A928038A_45F6A96700BB_SET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

