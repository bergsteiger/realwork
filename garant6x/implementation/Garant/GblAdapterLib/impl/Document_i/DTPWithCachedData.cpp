////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithCachedData.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DTPWithCachedData
//
// Провайдер кеширует стиль и текст на адаптере
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithCachedData.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DTPWithCachedData::DTPWithCachedData (
	GblPilot::Document* server_doc
	, const GblPilot::HighlightHandle& handle
	, bool all_at_once
) :
	DocumentTextProvider_i(
		server_doc
		, handle
		, all_at_once
	)
//#UC START# *4C5AA5CA02DF_4C5ABE960168_504DD5C20166_BASE_INIT*
//#UC END# *4C5AA5CA02DF_4C5ABE960168_504DD5C20166_BASE_INIT*
{
	//#UC START# *4C5AA5CA02DF_4C5ABE960168_504DD5C20166_BODY*
	//#UC END# *4C5AA5CA02DF_4C5ABE960168_504DD5C20166_BODY*
}

DTPWithCachedData::DTPWithCachedData (
	GblPilot::Document* server_doc
	, unsigned long handle
	, bool all_at_once
) :
	DocumentTextProvider_i(
		server_doc
		, handle
		, all_at_once
	)
//#UC START# *4C5AA5CA02DF_4CED497B0316_504DD5C20166_BASE_INIT*
//#UC END# *4C5AA5CA02DF_4CED497B0316_504DD5C20166_BASE_INIT*
{
	//#UC START# *4C5AA5CA02DF_4CED497B0316_504DD5C20166_BODY*
	//#UC END# *4C5AA5CA02DF_4CED497B0316_504DD5C20166_BODY*
}

DTPWithCachedData::~DTPWithCachedData () {
	//#UC START# *504DD5C20166_DESTR_BODY*
	//#UC END# *504DD5C20166_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DocumentTextProvider
const EVDStream* DTPWithCachedData::get_child_evd_style (const EntryPoint& id) /*throw (InvalidEntryPoint)*/ {
	//#UC START# *4C5AB80A00E4_504DD5C20166*
	const EVDStream* result = this->get_item (id).style ();
	GDS_ASSERT (result);
	const_cast<EVDStream*> (result)->seek (0, 0);
	return result;
	//#UC END# *4C5AB80A00E4_504DD5C20166*
}

// implemented method from DocumentTextProvider
const GCI::IO::String* DTPWithCachedData::get_child_text (const EntryPoint& id) /*throw (InvalidEntryPoint)*/ {
	//#UC START# *4C5AB9ED0306_504DD5C20166*
	return this->get_item (id).text ();
	//#UC END# *4C5AB9ED0306_504DD5C20166*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

