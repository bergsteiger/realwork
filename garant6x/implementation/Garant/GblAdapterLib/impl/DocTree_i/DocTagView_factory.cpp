////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/DocTagView_factory.cpp"
// C++ Interface Factories implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DocTree_i::DocTagView
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/DocTagView_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/DocTagView.h"

namespace GblAdapterLib {

DocTagView* DocTagViewServantFactory::make (bool optimize_for_everest) {
	DocTagView_var ret = new DocTagView (optimize_for_everest);
	
	return ret._retn ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

