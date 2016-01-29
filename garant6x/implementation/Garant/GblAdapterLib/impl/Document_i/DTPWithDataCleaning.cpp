////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithDataCleaning.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DTPWithDataCleaning
//
// провайдер очищает данные о стиле и тексте после того, как прокидывает их оболочке
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithDataCleaning.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DTPWithDataCleaning::DTPWithDataCleaning (
	GblPilot::Document* server_doc
	, const GblPilot::HighlightHandle& handle
	, bool all_at_once
) :
	DocumentTextProvider_i(
		server_doc
		, handle
		, all_at_once
	)
//#UC START# *4C5AA5CA02DF_4C5ABE960168_504DD6120317_BASE_INIT*
//#UC END# *4C5AA5CA02DF_4C5ABE960168_504DD6120317_BASE_INIT*
{
	//#UC START# *4C5AA5CA02DF_4C5ABE960168_504DD6120317_BODY*
	//#UC END# *4C5AA5CA02DF_4C5ABE960168_504DD6120317_BODY*
}

DTPWithDataCleaning::DTPWithDataCleaning (
	GblPilot::Document* server_doc
	, unsigned long handle
	, bool all_at_once
) :
	DocumentTextProvider_i(
		server_doc
		, handle
		, all_at_once
	)
//#UC START# *4C5AA5CA02DF_4CED497B0316_504DD6120317_BASE_INIT*
//#UC END# *4C5AA5CA02DF_4CED497B0316_504DD6120317_BASE_INIT*
{
	//#UC START# *4C5AA5CA02DF_4CED497B0316_504DD6120317_BODY*
	//#UC END# *4C5AA5CA02DF_4CED497B0316_504DD6120317_BODY*
}

DTPWithDataCleaning::~DTPWithDataCleaning () {
	//#UC START# *504DD6120317_DESTR_BODY*
	//#UC END# *504DD6120317_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DocumentTextProvider
const EVDStream* DTPWithDataCleaning::get_child_evd_style (const EntryPoint& id) /*throw (InvalidEntryPoint)*/ {
	//#UC START# *4C5AB80A00E4_504DD6120317*
	const EVDStream* ret = this->get_item (id).style ();
	GDS_ASSERT (ret && "style must be called only once");
	this->kill_style (id);
	return ret;
	//#UC END# *4C5AB80A00E4_504DD6120317*
}

// implemented method from DocumentTextProvider
const GCI::IO::String* DTPWithDataCleaning::get_child_text (const EntryPoint& id) /*throw (InvalidEntryPoint)*/ {
	//#UC START# *4C5AB9ED0306_504DD6120317*
	const GCI::IO::String* ret = this->get_item (id).text ();
	if (ret) {
		this->kill_text (id);
	}
	return ret;
	//#UC END# *4C5AB9ED0306_504DD6120317*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

