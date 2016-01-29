////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Banner_i/Banner_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Banner_i::Banner_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Banner_i/Banner_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Banner_i::Banner_i ()
//#UC START# *4ACC6DD00230_4ACC72770345_4ACC724901BC_BASE_INIT*
//#UC END# *4ACC6DD00230_4ACC72770345_4ACC724901BC_BASE_INIT*
{
	//#UC START# *4ACC6DD00230_4ACC72770345_4ACC724901BC_BODY*
	try {
		m_server_banner = ApplicationHelper::instance ()->get_cached_banner_manager ()->get_banner ();
	} catch (GCD::CanNotFindData&) {
		throw CanNotFindData ();
	} catch (...) {
		GDS_ASSERT (false);
		throw CanNotFindData ();
	}
	//#UC END# *4ACC6DD00230_4ACC72770345_4ACC724901BC_BODY*
}

Banner_i::~Banner_i () {
	//#UC START# *4ACC724901BC_DESTR_BODY*
	try {
		if (!CORBA::is_nil (m_server_banner)) {
			ApplicationHelper::instance ()->get_cached_life_cycle_manager()->release_object (m_server_banner.in ());
		}
	} catch (CORBA::TRANSIENT&) {
	} catch (...) {
		GDS_ASSERT ((false, "Unknown exception catched"));
	}
	//#UC END# *4ACC724901BC_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Banner
// Картинка
ExternalObject* Banner_i::get_picture () const {
	//#UC START# *4ACC85A303E1_4ACC724901BC*
	GDS_ASSERT (!CORBA::is_nil (m_server_banner.in ()));
	GblPilot::InternalObj_var internal_obj = m_server_banner->get_picture ();
	if (!CORBA::is_nil (internal_obj.in ())) {
		try {
			ExternalObject_var external_object = ExternalObjectFactory::make (internal_obj.in ());
			ApplicationHelper::instance ()->get_cached_life_cycle_manager ()->release_object (internal_obj.in ());
			return external_object._retn ();
		} catch (CORBA::BAD_OPERATION& ex) {
			LOG_CEX ((ex, GDS_CURRENT_FUNCTION));
			ApplicationHelper::instance ()->get_cached_life_cycle_manager ()->release_object (internal_obj.in ());
			GDS_ASSERT (false);
		} catch (GCD::CanNotFindData& ex) {
			LOG_CEX ((ex, GDS_CURRENT_FUNCTION));
			ApplicationHelper::instance ()->get_cached_life_cycle_manager ()->release_object (internal_obj.in ());
			GDS_ASSERT (false);
		}
	}
	GDS_ASSERT (false);
	return 0;
	//#UC END# *4ACC85A303E1_4ACC724901BC*
}

// implemented method from Banner
// Открыть ссылку баннера (возвращает или IDocument или ExternalLink)
Core::IObject* Banner_i::open_link () const /*throw (CanNotFindData)*/ {
	//#UC START# *4ACC6E5F00E5_4ACC724901BC*
	GDS_ASSERT (!CORBA::is_nil (m_server_banner.in ()));
	GblPilotDef::BannerEntity_var banner_entity = m_server_banner->open ();
	GblPilotDef::Bookmark* server_bookmark;
	if ((*banner_entity >>= server_bookmark)) {
		return BookmarkFactory::make (*server_bookmark, 0, 0);
	}
	const char* server_url;
	if ((*banner_entity >>= server_url)) {
		return ExternalLinkFactory::make (server_url);		
	}
	GDS_ASSERT (false);
	return 0;
	//#UC END# *4ACC6E5F00E5_4ACC724901BC*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

