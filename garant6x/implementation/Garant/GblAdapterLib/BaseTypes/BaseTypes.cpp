////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTypes
//
// Базовые типы, используемые в адаптере
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypesFactories.h"

namespace GblAdapterLib {


// создать нулевую дату
Date::Date ()
//#UC START# *462C9BE5030D_INIT_CTOR_BASE_INIT*
: year (0), month (0), day (0)
//#UC END# *462C9BE5030D_INIT_CTOR_BASE_INIT*
{
	//#UC START# *462C9BE5030D_CTOR_BODY*
	//#UC END# *462C9BE5030D_CTOR_BODY*
}

// создать заданную дату
Date::Date (unsigned short y, unsigned short m, unsigned short d)
//#UC START# *462C9BF10128_INIT_CTOR_BASE_INIT*
: year (y), month (m), day (d)
//#UC END# *462C9BF10128_INIT_CTOR_BASE_INIT*
{
	//#UC START# *462C9BF10128_CTOR_BODY*
	//#UC END# *462C9BF10128_CTOR_BODY*
}

const char* ConstantModify::uid () const /*throw ()*/ {
	return "7EB3FB32-CFDF-4978-BD77-B2EBEEE93F0B";
}

const char* ConstantModify::what () const throw () {
	//#UC START# *456EB4540177_WHAT_IMPL*
	return "ConstantModify (Исключение возникает при попытке изменить константный параметер.)";
	//#UC END# *456EB4540177_WHAT_IMPL*
}


const char* AccessDenied::uid () const /*throw ()*/ {
	return "1DCBD6AE-98D5-4ED8-BC92-A8C6666102A4";
}

const char* AccessDenied::what () const throw () {
	//#UC START# *456EB4540188_WHAT_IMPL*
	return "AccessDenied (Возбуждается в случае нарушения прав доступа.)";
	//#UC END# *456EB4540188_WHAT_IMPL*
}


const char* InvalidTimeStamp::uid () const /*throw ()*/ {
	return "53CFA0CF-AAC4-4F98-9A23-3F88BB96E993";
}

const char* InvalidTimeStamp::what () const throw () {
	//#UC START# *456EB4540179_WHAT_IMPL*
	return "InvalidTimeStamp (Исключение возбуждается в случае если запрошенная операция не может быть выполнена на сервер, по причине неверной метки синхронизации. Возможно необходимо повторить вызов.)";
	//#UC END# *456EB4540179_WHAT_IMPL*
}


const char* StorageLocked::uid () const /*throw ()*/ {
	return "3AC52720-20FF-488A-9F39-D3C749B0BEB5";
}

const char* StorageLocked::what () const throw () {
	//#UC START# *456EB4540186_WHAT_IMPL*
	return "StorageLocked (База блокирована)";
	//#UC END# *456EB4540186_WHAT_IMPL*
}


const char* Unsupported::uid () const /*throw ()*/ {
	return "6A74F86E-2B29-442C-B0F4-08E06801742A";
}

const char* Unsupported::what () const throw () {
	//#UC START# *456EB454018A_WHAT_IMPL*
	return "Unsupported (Возвращается в случае если вызванная опреация не поддеоживается объектом.)";
	//#UC END# *456EB454018A_WHAT_IMPL*
}


const char* NotSaved::uid () const /*throw ()*/ {
	return "683A63D1-5A5A-46FC-80BB-5CFAAE4F3BE3";
}

const char* NotSaved::what () const throw () {
	//#UC START# *456EB4540190_WHAT_IMPL*
	return "NotSaved (Возвращается при попытке сохранить/восстановить изменения в несохраненном (т.е не привязанном к месту хранения, например к папкам) объекте)";
	//#UC END# *456EB4540190_WHAT_IMPL*
}


const char* FoldersNotAvailable::uid () const /*throw ()*/ {
	return "D5150C42-106F-4472-9A79-7A551CDE39AF";
}

const char* FoldersNotAvailable::what () const throw () {
	//#UC START# *456EB454018C_WHAT_IMPL*
	return "FoldersNotAvailable (Папки недоступны. Возвращается в случае, если у пользователя нет доступа к папкам.)";
	//#UC END# *456EB454018C_WHAT_IMPL*
}


const char* CanNotFindData::uid () const /*throw ()*/ {
	return "F5DA2B69-E229-477B-9DA8-40AD92596FBD";
}

const char* CanNotFindData::what () const throw () {
	//#UC START# *456EB454018E_WHAT_IMPL*
	return "CanNotFindData (Запрошенные данные не найдены. Возвращается в случае, если данные запрошенные по операции get_<something> отсутствуют.)";
	//#UC END# *456EB454018E_WHAT_IMPL*
}


const char* DuplicateNode::uid () const /*throw ()*/ {
	return "B8270401-B309-46E1-A462-7BBDE523B246";
}

const char* DuplicateNode::what () const throw () {
	//#UC START# *456EB4540194_WHAT_IMPL*
	return "DuplicateNode (Возникает в случае добавления узла в дерево, где уже есть такой же узел. При этом уникальность определяется самим узлом.)";
	//#UC END# *456EB4540194_WHAT_IMPL*
}


const char* InvalidType::uid () const /*throw ()*/ {
	return "A53D3084-67B0-4755-A936-94EC07D0ABF1";
}

const char* InvalidType::what () const throw () {
	//#UC START# *456EB4540192_WHAT_IMPL*
	return "InvalidType (Плохой тип данных)";
	//#UC END# *456EB4540192_WHAT_IMPL*
}


const char* CanNotSave::uid () const /*throw ()*/ {
	return "3BC3C183-4FC4-45E3-B00F-EB9BCEDDAAF7";
}

const char* CanNotSave::what () const throw () {
	//#UC START# *456EC75801B5_WHAT_IMPL*
	return "CanNotSave (объект не может быть сохранён)";
	//#UC END# *456EC75801B5_WHAT_IMPL*
}


const char* InvalidXMLType::uid () const /*throw ()*/ {
	return "520D7669-08ED-481A-A9B1-AB62DF14D847";
}

const char* InvalidXMLType::what () const throw () {
	//#UC START# *456EB4540197_WHAT_IMPL*
	return "InvalidXMLType (Ошибка при разборе XML)";
	//#UC END# *456EB4540197_WHAT_IMPL*
}


const char* AllContentIsFiltered::uid () const /*throw ()*/ {
	return "A93E2E23-A7C0-4031-97C4-95A9D7BF9006";
}

const char* AllContentIsFiltered::what () const throw () {
	//#UC START# *456EB7430222_WHAT_IMPL*
	return "AllContentIsFiltered (Всё сожержимое отфильтровано, что противоречит бизнес-логике)";
	//#UC END# *456EB7430222_WHAT_IMPL*
}


const char* EmptyResult::uid () const /*throw ()*/ {
	return "97952A97-16EC-4EA4-B6D9-C7125136BA04";
}

const char* EmptyResult::what () const throw () {
	//#UC START# *456EC825009C_WHAT_IMPL*
	return "EmptyResult (Возвращается при операции по изменению дерева в случае, если результат получается пустой, и это запрещенно логикой конкретеного дерева.)";
	//#UC END# *456EC825009C_WHAT_IMPL*
}

// factory interface wrapper for SearchEntity
SearchEntity* SearchEntityFactory::make (
	SearchResultType result_type
	, size_t document_count
	, size_t entry_count
	, size_t edition_count
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return SearchEntityFactoryManager::Singleton::instance ()->make (result_type, document_count, entry_count, edition_count);
}

SearchEntity* SearchEntityFactory::make (
	GblPilotQueryDef::SearchEntity* search_entity
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return SearchEntityFactoryManager::Singleton::instance ()->make (search_entity);
}

// factory interface wrapper for Variant
Variant* VariantFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return VariantFactoryManager::Singleton::instance ()->make ();
}

Variant* VariantFactory::make_long (
	long value
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return VariantFactoryManager::Singleton::instance ()->make_long (value);
}

Variant* VariantFactory::make_bool (
	bool value
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return VariantFactoryManager::Singleton::instance ()->make_bool (value);
}

Variant* VariantFactory::make_string (
	GCI::IO::String* value
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return VariantFactoryManager::Singleton::instance ()->make_string (value);
}

Variant* VariantFactory::make_object (
	Core::IObject* value
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return VariantFactoryManager::Singleton::instance ()->make_object (value);
}


const char* InternalDatabaseError::uid () const /*throw ()*/ {
	return "6BB3CE98-12F6-4458-B37B-4A6E98A23FE9";
}

const char* InternalDatabaseError::what () const throw () {
	//#UC START# *462F037A0337_WHAT_IMPL*
	return "InternalDatabaseError (Произошла внутреняя ошибка при обращении к базе)";
	//#UC END# *462F037A0337_WHAT_IMPL*
}


const char* NoSession::uid () const /*throw ()*/ {
	return "DC1511BC-35F7-4A94-BDAD-991A6C77A698";
}

const char* NoSession::what () const throw () {
	//#UC START# *478B818E0072_WHAT_IMPL*
	return "NoSession (выбрасывается из методов, которые могут дергаться только в контексте сессии, т.е. после логина)";
	//#UC END# *478B818E0072_WHAT_IMPL*
}


const char* DuplicateName::uid () const /*throw ()*/ {
	return "B44C2074-426C-4390-BB43-CE1778893D70";
}

const char* DuplicateName::what () const throw () {
	//#UC START# *47C80D8E019B_WHAT_IMPL*
	return "DuplicateName (Элемент с таким именем уже существует, а два и более созадвать нельзя)";
	//#UC END# *47C80D8E019B_WHAT_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

