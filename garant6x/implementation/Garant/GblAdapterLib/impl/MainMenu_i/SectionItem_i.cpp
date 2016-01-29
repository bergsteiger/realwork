////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionItem_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::SectionItem_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionItem_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/QueryTypeTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/DocumentFactoryKeyHelper.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Rubricator_i/Rubricator_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DefaultNodeBase.h"

//#UC START# *4E36CB3C02C9_CUSTOM_INCLUDES*
#include "garantServer/src/Business/GblPilot/Home/Adapter.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/Start.h"
//#UC END# *4E36CB3C02C9_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *4E36CB3C02C9*
//#UC END# *4E36CB3C02C9*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SectionItem_i::SectionItem_i (const GblPilot::SectionItem& section_item)
//#UC START# *4E36C7D80396_4E36CAA4003F_4E36CB3C02C9_BASE_INIT*
: m_server_section_item (section_item)
//#UC END# *4E36C7D80396_4E36CAA4003F_4E36CB3C02C9_BASE_INIT*
{
	//#UC START# *4E36C7D80396_4E36CAA4003F_4E36CB3C02C9_BODY*
	//#UC END# *4E36C7D80396_4E36CAA4003F_4E36CB3C02C9_BODY*
}

SectionItem_i::~SectionItem_i () {
	//#UC START# *4E36CB3C02C9_DESTR_BODY*
	//#UC END# *4E36CB3C02C9_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from SectionItem
// Имя
const GCI::IO::String* SectionItem_i::get_caption () const {
	//#UC START# *4E36C7EB007C_4E36CB3C02C9_GET*
	return GCI::IO::StringFactory::make (m_server_section_item.caption.in ());
	//#UC END# *4E36C7EB007C_4E36CB3C02C9_GET*
}

GCI::IO::String* SectionItem_i::get_caption () {
	return const_cast<GCI::IO::String*>(((const SectionItem_i*)this)->get_caption ());
}

// implemented method from SectionItem
// Получить сущность элемента (может быть IQuery, IDocument, INodeBase, IString)
Core::IObject* SectionItem_i::open () const {
	//#UC START# *4E36C80302E6_4E36CB3C02C9*
	try {
		GblPilot::SectionItemEntity_var entity = m_server_section_item.data->get_entity ();
		// КЗ - IQuery с правильным типом запроса
		GblPilotQueryDef::QueryType query_type;
		if (*entity >>= query_type) {
			return QueryFactory::make (QueryTypeTranslatorSingleton::instance ()->get (query_type));
		} 
		// Документ - IDocument
		GCD::PID* pid;
		if (*entity >>= pid) {
			return DocumentFactory::make (*pid, true, 0, DocumentFactoryKeyHelper::PID_to_key (*pid));
		} 

		// Строка - тег дерева
		GblPilotQueryDef::AttributeTag tag;
		if (*entity >>= tag) {
			return GCI::IO::StringFactory::make (Defines::AttributeTagTranslator::translate (tag));
		} 
		
		// Список
		GblDocList::DocListTree* server_list;
		if (*entity >>= server_list) {
			return Core::TypeTraits<DynList>::Factory::make (server_list);
		}

		// Ветка дерева рубрикатора
		GTree::NodePath* node_path;
		if (*entity >>= node_path) {
			NodeBase_var node_base = Core::TypeTraits <NodeBase>::Factory::make ("MainMenu");
			return dynamic_cast <DefaultNodeBase*>(node_base.in ())->find_node_by_path (*node_path);
		}
		// Скрипт 
		const char* script;
		if (*entity >>= script) {
			GDS_ASSERT (script);
			return Core::TypeTraits<ExternalLink>::Factory::make (script);
		}
		GDS_ASSERT (false);
	} catch (GblPilot::NoEntity&) {
	} catch (GCD::CanNotFindData&) {
	} catch (CORBA::TRANSIENT&) {
		throw GblAdapterLib::NoServer ();
	} catch (...) {
		GDS_ASSERT (false);
	}
	throw NoEntity ();
	//#UC END# *4E36C80302E6_4E36CB3C02C9*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

