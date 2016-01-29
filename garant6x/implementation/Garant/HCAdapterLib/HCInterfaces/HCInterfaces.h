////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfaces.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::HCAdapterLib::HCInterfaces
//
// Интерфейсы для взаимодействия с отделом Пащака
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_HCADAPTERLIB_HCINTERFACES_H__
#define __GARANT6X_HCADAPTERLIB_HCINTERFACES_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "garantServer/src/Business/GblConsulting/GblConsultingC.h"
#include "garantServer/src/Business/GblConsulting/GblConsultingDefC.h"
#include "shared/GCI/IO/IO.h"
// forward decls for friend interface's servants

namespace HCAdapterLib {
namespace HCInterfaces_i {
	class ConsultingRequests_i;
} // namespace HCInterfaces_i
} // namespace HCAdapterLib


namespace HCAdapterLib {
namespace HCInterfaces {

class ConsultingData;
typedef ::Core::Var<ConsultingData> ConsultingData_var;
typedef ::Core::Var<const ConsultingData> ConsultingData_cvar;
// Интерфейс для получения и подтверждения факта получения запроса.
class ConsultingData
	: virtual public ::Core::IObject
{
public:
	// Получение данных запроса. Возвращается запрос (оценка) в XML формате (описание см в реквизите).
	virtual GCI::IO::Stream* get_data () = 0;

	// Подтверждение получения данных текущего запроса. При вызове этого метода запрос помечается как
	// переданный на обработку (при получении оценки, как полностью обработанный).
	virtual void data_received () const = 0;
};

// Возможные значения возвращаемых значений функций
enum ResultValue {
	RV_SUCCESS // функция отработала успешно
	, RV_DUPLICATED // запрос в базе уже помечен, как отвеченный.
	, RV_EMPTY // на данный момент нет запросов данного типа
	, RV_ERROR // серверу не удалось прочесть ответ, или положить его в базу, или произошел еще какой-то внутренний сбой. В этом случае необходимо повторить попытку отдачи ответа.
	, RV_BAD_XML // формат ответа не соответствует "ожиданиям" сервера.
	, RV_COMPLECT_REMOVED_ERROR // комплект был удалён из АРМ-а (http://mdp.garant.ru/pages/viewpage.action?pageId=118982402)
	, RV_INVALID_QUERY_ID // данного идентификатора нет в базе
};

typedef char* QueryID;
typedef const char* QueryID_const;


// Не смогли загрузить библиотеку для работы с XML
class CantFindXerces : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class OnlineData;
typedef ::Core::Var<OnlineData> OnlineData_var;
typedef ::Core::Var<const OnlineData> OnlineData_cvar;
// Консультации, проходящие через СК. Имеют уникальный идентификатор.
class OnlineData
	: virtual public ConsultingData
{

	// forward decls for friend interface's servant
	friend class HCInterfaces_i::ConsultingRequests_i;
};

/// factory interface for OnlineData
class OnlineDataFactory {
	friend class HCInterfaces_i::ConsultingRequests_i; //friend's servants

public:
	typedef std::vector<std::string> KeySet;
	
	static KeySet* keys ();
protected:
	// фабрика для получения интерфейса
	static OnlineData* make (
		GCI::IO::Stream* xml_stream
		, const GblConsultingDef::ConsultationID& consultation_id
	, const char* key
	) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Константы для адаптера консультаций.
static const char* STATISTIC_PACKET_SIZE_PARAMETER = "-StatisticPacketSize"; // Параметр командной строки, задающий максимальное количество консультаций, которые могут быть спрошены за раз у СК (не накладывает ограничений на количество консультаций, передаваемых в метод GetStatusStatistic)
static const size_t STATISTIC_PACKET_SIZE = 500; // Значение по-умолчанию для максимального количества консультаций, которые могут быть спрошены за раз у СК (не накладывает ограничений на количество консультаций, передаваемых в метод GetStatusStatistic)
static const char* STATISTIC_SLEEP_TIME_PARAMETER = "-StatisticSleepTime"; // Параметр командной строки, задающий время ожидания между посылкой запросов на статистику при большом числе консультаций.
static const unsigned int STATISTIC_SLEEP_TIME = 1; // Время ожидания в секундах между посылкой запросов на статистику при большом числе консультаций.

class BusinessLogicLifeCycle;
typedef ::Core::Var<BusinessLogicLifeCycle> BusinessLogicLifeCycle_var;
typedef ::Core::Var<const BusinessLogicLifeCycle> BusinessLogicLifeCycle_cvar;
// Интерфейс для управления жизненным циклом бизнес-объектов адаптера
class BusinessLogicLifeCycle
	: virtual public ::Core::IObject
{
public:
	// метод должен быть вызван первым после загрузки dll библиотеки
	virtual void start () = 0;

	// метод должен быть вызван перед завершением работы библиотеки
	virtual void stop () = 0;

	// получить интерфейс к СК  версии 7
	virtual GblConsulting::ConsultationManager70& get_consultation_manager70 () const = 0;
};

/// factory interface for BusinessLogicLifeCycle
class BusinessLogicLifeCycleFactory {
public:
	// кешированная фабрика объекта
	static BusinessLogicLifeCycle* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// текстовые значения ошибок в xml при удалении запросов из базы.
static const char* EES_INVALID_STATUS = "INVALID_STATUS"; // консультация с текущим статусом не может быть удалена (чтобы её удалить необходимо указать атрибут force="yes")
static const char* EES_NOT_FOUND = "NOT_FOUND"; // консультация с заданным идентификатором не найдена (например переехала из базы 6-ки в базу 7-ки)
static const char* EES_UNKNOWN = "UNKNOWN"; // внутренняя ошибка СК

// ключи мульти фабрик для интерфейса консультации
static const char* QUERY70 = "QUERY70";
static const char* MARK70 = "MARK70";

class ConsultingRequests;
typedef ::Core::Var<ConsultingRequests> ConsultingRequests_var;
typedef ::Core::Var<const ConsultingRequests> ConsultingRequests_cvar;
// Интерфейс для получения запросов от пользователей и их оценок.
class ConsultingRequests
	: virtual public ::Core::IObject
{
public:
	// получить следующий запрос для обработки
	virtual ResultValue get_query_by_id (QueryID_const query_id, ConsultingData*& data) const = 0;

	// Получение очередной оценки на запрос.
	// При вызове этой операции происходит передача объекта "Оценка" для получения данных. До тех пор
	// пока не будет проведен вызов DataRecieved, эта операция будет возвращать этот запрос.
	// Если нет ни одного нового запроса, получившего оценку пользователя, возвращается нулевой объект.
	virtual ResultValue get_next_mark (ConsultingData*& data) const = 0;

	// Ответ на запрос или предварительное уведомление о сроках обработки запроса.
	// Ответ оформлен в XML формате (описание cм. в реквизите).
	// Варианты возвращаемых значений:
	// [0] - если ответ успешно помещен в базу.
	// [1] - если запрос в базе уже помечен, как отвеченный.
	// [-1] - если серверу не удалось прочесть ответ, или положить его в базу, или произошел еще какой-
	// то внутренний сбой. В этом случае необходимо повторить попытку отдачи ответа.
	// [-2] - если формат ответа не соответствует "ожиданиям" сервера.
	virtual ResultValue set_answer (GCI::IO::Stream* answer) const = 0;

	// функция выдаёт статусы консультаций и даты их последней модификации по их идентификаторам.
	virtual ResultValue get_status_statistic (GCI::IO::Stream* query, GCI::IO::Stream*& result) const = 0;

	// удалить запросы из базы СК
	virtual ResultValue erase_queries_by_id (GCI::IO::Stream* query, GCI::IO::Stream*& result) const = 0;

	// добавить в xml контрольную сумму
	virtual ResultValue sign_query (GCI::IO::Stream* query, GCI::IO::Stream*& signed_query) const = 0;

	// получить список идентификаторов консультаций, которые нужно забрать на обработку в ППО
	virtual ResultValue get_list_of_new_queries (GCI::IO::Stream*& result) const = 0;
};

/// factory interface for ConsultingRequests
class ConsultingRequestsFactory {
public:
	// получить интерфейс работы  с запросами консультационной услуги
	static ConsultingRequests* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace HCInterfaces
} // namespace HCAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <HCAdapterLib::HCInterfaces::OnlineData> {
	typedef HCAdapterLib::HCInterfaces::OnlineDataFactory Factory;
};
template <>
struct TypeTraits <HCAdapterLib::HCInterfaces::BusinessLogicLifeCycle> {
	typedef HCAdapterLib::HCInterfaces::BusinessLogicLifeCycleFactory Factory;
};
template <>
struct TypeTraits <HCAdapterLib::HCInterfaces::ConsultingRequests> {
	typedef HCAdapterLib::HCInterfaces::ConsultingRequestsFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_HCADAPTERLIB_HCINTERFACES_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
