////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::SectionBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionBase.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionTypeConverter.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SectionBase::SectionBase ()
//#UC START# *4E36C7590390_4E36CAC7035A_4E36CE18019E_BASE_INIT*
//#UC END# *4E36C7590390_4E36CAC7035A_4E36CE18019E_BASE_INIT*
{
	//#UC START# *4E36C7590390_4E36CAC7035A_4E36CE18019E_BODY*
	GDS_ASSERT (false);
	//#UC END# *4E36C7590390_4E36CAC7035A_4E36CE18019E_BODY*
}

SectionBase::SectionBase (SectionType type)
//#UC START# *4E3771BC0164_BASE_INIT*
: m_type (SectionTypeConverterSingleton::instance ()->get (type))
//#UC END# *4E3771BC0164_BASE_INIT*
{
	//#UC START# *4E3771BC0164_BODY*
	m_server_section = ApplicationHelper::instance ()->get_cached_main_menu ()->get_section (m_type);
	//#UC END# *4E3771BC0164_BODY*
}

SectionBase::~SectionBase () {
	//#UC START# *4E36CE18019E_DESTR_BODY*
	//#UC END# *4E36CE18019E_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseUpdateChecker_i
void SectionBase::clear_cache () {
	//#UC START# *45702DA9037A_4E36CE18019E*
	m_server_section = ApplicationHelper::instance ()->get_cached_main_menu ()->get_section (m_type);
	//#UC END# *45702DA9037A_4E36CE18019E*
}

// implemented method from Section
// имя
const GCI::IO::String* SectionBase::get_caption () const {
	//#UC START# *4E37CA2A034B_4E36CE18019E_GET*
	this->check_update_and_clear_cache ();
	return GCI::IO::StringFactory::make (m_server_section->caption.in ());
	//#UC END# *4E37CA2A034B_4E36CE18019E_GET*
}

GCI::IO::String* SectionBase::get_caption () {
	return const_cast<GCI::IO::String*>(((const SectionBase*)this)->get_caption ());
}

// implemented method from Section
// Получить элементы раздела ОМ
SectionItemList* SectionBase::get_items () const {
	//#UC START# *4E37CA4300B7_4E36CE18019E*
	this->check_update_and_clear_cache ();
	Core::Aptr<SectionItemList> result = new SectionItemList ();
	for (size_t i = 0; i < m_server_section->items.length (); ++i) {
		result->push_back (SectionItemFactory::make (m_server_section->items [i]));
	}
	return result.forget ();
	//#UC END# *4E37CA4300B7_4E36CE18019E*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

