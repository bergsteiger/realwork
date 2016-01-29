////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryAttribute_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryAttribute_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryAttribute_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/TreeNameTranslator.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

QueryAttribute_i::QueryAttribute_i (QueryTagType tag_type, AttributeTag_const attribute_tag)
//#UC START# *45FFF7EE03BF_BASE_INIT*
	:	m_attribute_tag (GblAdapterLib::shell_to_adapter (attribute_tag))
	, m_tag_type (tag_type)
//#UC END# *45FFF7EE03BF_BASE_INIT*
{
	//#UC START# *45FFF7EE03BF_BODY*
	//#UC END# *45FFF7EE03BF_BODY*
}

QueryAttribute_i::~QueryAttribute_i () {
	//#UC START# *45FFEF1A01D3_DESTR_BODY*
	//#UC END# *45FFEF1A01D3_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from QueryAttribute
AttributeTag_const QueryAttribute_i::get_tag () const {
	//#UC START# *4767C8D803E1_45FFEF1A01D3*
	return m_attribute_tag.c_str ();
	//#UC END# *4767C8D803E1_45FFEF1A01D3*
}

// implemented method from QueryAttribute
QueryTagType QueryAttribute_i::get_type () const {
	//#UC START# *45F1180B00A3_45FFEF1A01D3_GET*
	return m_tag_type;
	//#UC END# *45F1180B00A3_45FFEF1A01D3_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

