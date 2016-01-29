////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ExternalOperation/ExternalOperation.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ExternalOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_EXTERNALOPERATION_H__
#define __GARANT6X_GBLADAPTERLIB_EXTERNALOPERATION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"

namespace GblAdapterLib {

class ExternalOperation;
typedef ::Core::Var<ExternalOperation> ExternalOperation_var;
typedef ::Core::Var<const ExternalOperation> ExternalOperation_cvar;
// Ссылки на операции
class ExternalOperation
	: virtual public ::Core::IObject
{
public:
	virtual ObjectId get_id () const = 0;
};

/// factory interface for ExternalOperation
class ExternalOperationFactory {
public:
	static ExternalOperation* make (ObjectId id)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

static const unsigned long EOI_ESTIMATION = 1; // Оценить ответ
static const unsigned long EOI_PAYMENT_CONFIRM = 2; // Подтверждение оплаты
static const unsigned long EOI_PAYMENT_REFUSAL = 3; // Оплата отклонена
static const unsigned long EOI_OPEN_ATTRIBUTE_CARD = 4;
static const unsigned long EOI_SHOW_HELP_TOPIC = 5;
static const unsigned long EOI_CHANGE_COLLAPSED = 6;
static const unsigned long EOI_CHECK_LEGAL_ADVISE_AVAILABLE = 7;
static const unsigned long EOI_CONSULTATION_CALL_GARANT = 8; // Ссылка на www.garant.ru в уведомлении о консалтинге
static const unsigned long EOI_SHOW_CONSULTATION_LIST = 9; // показать список к консультации
static const unsigned long EOI_SHOW_LC_HELP = 10; // Ссылка на Справка-описание Правового календаря
static const unsigned long EOI_CHANGES_INSIDE_TABLE = 11;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::ExternalOperation> {
	typedef GblAdapterLib::ExternalOperationFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_EXTERNALOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
