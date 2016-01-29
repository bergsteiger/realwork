////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodesClipboard_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::NodesClipboard_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodesClipboard_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocal.h"

//#UC START# *4600E3C501E4_CUSTOM_INCLUDES*
//#UC END# *4600E3C501E4_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *4600E3C501E4*
//#UC END# *4600E3C501E4*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

NodesClipboard_i::NodesClipboard_i ()
//#UC START# *45EECAA0007D_4600E43B0232_4600E3C501E4_BASE_INIT*
//#UC END# *45EECAA0007D_4600E43B0232_4600E3C501E4_BASE_INIT*
{
	//#UC START# *45EECAA0007D_4600E43B0232_4600E3C501E4_BODY*
	//#UC END# *45EECAA0007D_4600E43B0232_4600E3C501E4_BODY*
}

NodesClipboard_i::NodesClipboard_i (GTree::NodeHolder* node_holder)
//#UC START# *45EECAA0007D_4600E5140157_4600E3C501E4_BASE_INIT*
: m_server_node_holder (GTree::NodeHolder::_duplicate (node_holder))
//#UC END# *45EECAA0007D_4600E5140157_4600E3C501E4_BASE_INIT*
{
	//#UC START# *45EECAA0007D_4600E5140157_4600E3C501E4_BODY*
	//#UC END# *45EECAA0007D_4600E5140157_4600E3C501E4_BODY*
}

NodesClipboard_i::~NodesClipboard_i () {
	//#UC START# *4600E3C501E4_DESTR_BODY*
	//#UC END# *4600E3C501E4_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

GTree::NodeHolder* NodesClipboard_i::node_holder () {
	//#UC START# *4600E6B10157*
	return m_server_node_holder.ptr();
	//#UC END# *4600E6B10157*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from NodesClipboard
GCI::IO::Stream* NodesClipboard_i::as_evd (EVDGeneratorStyle style) const {
	//#UC START# *45EECAA0007E_4600E3C501E4*
	GslDataPipe::DataReading_var data_reading = m_server_node_holder->as_evd (
		style == GS_FULL_TREE
		, style == GS_TOPIC_AS_NAME
	);
	return DataReadingStreamFactory::make (data_reading.in ());
	//#UC END# *45EECAA0007E_4600E3C501E4*
}

// implemented method from NodesClipboard
unsigned long NodesClipboard_i::get_count () const {
	//#UC START# *45EECAA0007F_4600E3C501E4_GET*
	return m_server_node_holder->count ();
	//#UC END# *45EECAA0007F_4600E3C501E4_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

