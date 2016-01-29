unit HCInterfacesUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "HCAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/HCInterfacesUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::HCAdapterLib::HCInterfaces
//
// Интерфейсы для взаимодействия с отделом Пащака
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	//#UC START# *4423F94903C8_442BEF93030D_UNIT_FOR_Stream*
        , ActiveX 
	//#UC END# *4423F94903C8_442BEF93030D_UNIT_FOR_Stream*
	;

type

IConsultingData = interface;
{ - предварительное описание IConsultingData. }

IOnlineData = interface;
{ - предварительное описание IOnlineData. }

IBusinessLogicLifeCycle = interface;
{ - предварительное описание IBusinessLogicLifeCycle. }

IConsultingRequests = interface;
{ - предварительное описание IConsultingRequests. }


// Возможные значения возвращаемых значений функций
PResultValue = ^TResultValue;
TResultValue = (
	RV_SUCCESS // функция отработала успешно
	, RV_DUPLICATED // запрос в базе уже помечен, как отвеченный.
	, RV_EMPTY // на данный момент нет запросов данного типа
	, RV_ERROR // серверу не удалось прочесть ответ, или положить его в базу, или произошел еще какой-то внутренний сбой. В этом случае необходимо повторить попытку отдачи ответа.
	, RV_BAD_XML // формат ответа не соответствует "ожиданиям" сервера.
	, RV_COMPLECT_REMOVED_ERROR // комплект был удалён из АРМ-а (http://mdp.garant.ru/pages/viewpage.action?pageId=118982402)
	, RV_INVALID_QUERY_ID // данного идентификатора нет в базе
);

PQueryID = ^TQueryID;
TQueryID = PAnsiChar;

// Не смогли загрузить библиотеку для работы с XML
ECantFindXerces = class (Exception);

// Интерфейс для получения и подтверждения факта получения запроса.
IConsultingData = interface (IInterface) ['{E92828ED-9B9A-4302-8D42-37E413C6F434}']
	function DontUseMe: Pointer;
	// Подтверждение получения данных текущего запроса. При вызове этого метода запрос помечается как
	// переданный на обработку (при получении оценки, как полностью обработанный).
	procedure DataReceived (); stdcall;

	// Получение данных запроса. Возвращается запрос (оценка) в XML формате (описание см в реквизите).
	procedure GetData (
		out aRet {: IStream}
	); stdcall;
end;

// Консультации, проходящие через СК. Имеют уникальный идентификатор.
IOnlineData = interface (IConsultingData) ['{43387100-5C41-4CCB-83EB-4EE5BB99C443}']

end;

// Интерфейс для управления жизненным циклом бизнес-объектов адаптера
IBusinessLogicLifeCycle = interface (IInterface) ['{AC92D75F-442C-4FFE-897D-23499B1BBC34}']
	function DontUseMe: Pointer;
	// метод должен быть вызван первым после загрузки dll библиотеки
	procedure Start (); stdcall;

	// метод должен быть вызван перед завершением работы библиотеки
	procedure Stop (); stdcall;
end;

// Интерфейс для получения запросов от пользователей и их оценок.
IConsultingRequests = interface (IInterface) ['{EB5AE11E-74DA-4DFE-950B-CE68586C28F1}']
	function DontUseMe: Pointer;
	// удалить запросы из базы СК
	function EraseQueriesById (
		const aQuery: IStream;
		out aResult {: IStream}
	): TResultValue; stdcall;

	// получить список идентификаторов консультаций, которые нужно забрать на обработку в ППО
	function GetListOfNewQueries (
		out aResult {: IStream}
	): TResultValue; stdcall;

	// Получение очередной оценки на запрос.
	// При вызове этой операции происходит передача объекта "Оценка" для получения данных. До тех пор
	// пока не будет проведен вызов DataRecieved, эта операция будет возвращать этот запрос.
	// Если нет ни одного нового запроса, получившего оценку пользователя, возвращается нулевой объект.
	function GetNextMark (
		out aData {: IConsultingData}
	): TResultValue; stdcall;

	// получить следующий запрос для обработки
	function GetQueryById (
		const aQueryId: TQueryID;
		out aData {: IConsultingData}
	): TResultValue; stdcall;

	// функция выдаёт статусы консультаций и даты их последней модификации по их идентификаторам.
	function GetStatusStatistic (
		const aQuery: IStream;
		out aResult {: IStream}
	): TResultValue; stdcall;

	// Ответ на запрос или предварительное уведомление о сроках обработки запроса.
	// Ответ оформлен в XML формате (описание cм. в реквизите).
	// Варианты возвращаемых значений:
	// [0] - если ответ успешно помещен в базу.
	// [1] - если запрос в базе уже помечен, как отвеченный.
	// [-1] - если серверу не удалось прочесть ответ, или положить его в базу, или произошел еще какой-
	// то внутренний сбой. В этом случае необходимо повторить попытку отдачи ответа.
	// [-2] - если формат ответа не соответствует "ожиданиям" сервера.
	function SetAnswer (
		const aAnswer: IStream
	): TResultValue; stdcall;

	// добавить в xml контрольную сумму
	function SignQuery (
		const aQuery: IStream;
		out aSignedQuery {: IStream}
	): TResultValue; stdcall;
end;

const

 { Константы для адаптера консультаций. }
	STATISTIC_PACKET_SIZE_PARAMETER = '-StatisticPacketSize';
 { Параметр командной строки, задающий максимальное количество консультаций, которые могут быть спрошены за раз у СК (не накладывает ограничений на количество консультаций, передаваемых в метод GetStatusStatistic) }
	STATISTIC_PACKET_SIZE = Cardinal(500);
 { Значение по-умолчанию для максимального количества консультаций, которые могут быть спрошены за раз у СК (не накладывает ограничений на количество консультаций, передаваемых в метод GetStatusStatistic) }
	STATISTIC_SLEEP_TIME_PARAMETER = '-StatisticSleepTime';
 { Параметр командной строки, задающий время ожидания между посылкой запросов на статистику при большом числе консультаций. }
	STATISTIC_SLEEP_TIME = Longint(1);
 { Время ожидания в секундах между посылкой запросов на статистику при большом числе консультаций. }

 { текстовые значения ошибок в xml при удалении запросов из базы. }
	EES_INVALID_STATUS = 'INVALID_STATUS';
 { консультация с текущим статусом не может быть удалена (чтобы её удалить необходимо указать атрибут force="yes") }
	EES_NOT_FOUND = 'NOT_FOUND';
 { консультация с заданным идентификатором не найдена (например переехала из базы 6-ки в базу 7-ки) }
	EES_UNKNOWN = 'UNKNOWN';
 { внутренняя ошибка СК }

 { ключи мульти фабрик для интерфейса консультации }
	QUERY70 = 'QUERY70';
	MARK70 = 'MARK70';

implementation
end.