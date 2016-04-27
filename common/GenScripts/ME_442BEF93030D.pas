unit HCInterfacesUnit;
 {* Интерфейсы для взаимодействия с отделом Пащака }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\HCAdapterLib\HCInterfacesUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "HCInterfaces" MUID: (442BEF93030D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
;

const
 {* Константы для адаптера консультаций. }
 STATISTIC_PACKET_SIZE_PARAMETER: PAnsiChar = -StatisticPacketSize;
  {* Параметр командной строки, задающий максимальное количество консультаций, которые могут быть спрошены за раз у СК (не накладывает ограничений на количество консультаций, передаваемых в метод GetStatusStatistic) }
 STATISTIC_PACKET_SIZE: size = 500;
  {* Значение по-умолчанию для максимального количества консультаций, которые могут быть спрошены за раз у СК (не накладывает ограничений на количество консультаций, передаваемых в метод GetStatusStatistic) }
 STATISTIC_SLEEP_TIME_PARAMETER: PAnsiChar = -StatisticSleepTime;
  {* Параметр командной строки, задающий время ожидания между посылкой запросов на статистику при большом числе консультаций. }
 STATISTIC_SLEEP_TIME: unsigned integer = 1;
  {* Время ожидания в секундах между посылкой запросов на статистику при большом числе консультаций. }
 {* текстовые значения ошибок в xml при удалении запросов из базы. }
 EES_INVALID_STATUS: PAnsiChar = INVALID_STATUS;
  {* консультация с текущим статусом не может быть удалена (чтобы её удалить необходимо указать атрибут force="yes") }
 EES_NOT_FOUND: PAnsiChar = NOT_FOUND;
  {* консультация с заданным идентификатором не найдена (например переехала из базы 6-ки в базу 7-ки) }
 EES_UNKNOWN: PAnsiChar = UNKNOWN;
  {* внутренняя ошибка СК }
 {* ключи мульти фабрик для интерфейса консультации }
 QUERY70: PAnsiChar = QUERY70;
 MARK70: PAnsiChar = MARK70;

type
 IConsultingData = interface
  {* Интерфейс для получения и подтверждения факта получения запроса. }
  ['{E92828ED-9B9A-4302-8D42-37E413C6F434}']
  function GetData: IStream; stdcall;
   {* Получение данных запроса. Возвращается запрос (оценка) в XML формате (описание см в реквизите). }
  procedure DataReceived; stdcall;
   {* Подтверждение получения данных текущего запроса. При вызове этого метода запрос помечается как переданный на обработку (при получении оценки, как полностью обработанный). }
 end;//IConsultingData

 TResultValue = (
  {* Возможные значения возвращаемых значений функций }
  RV_SUCCESS = 0
   {* функция отработала успешно }
  , RV_DUPLICATED = 1
   {* запрос в базе уже помечен, как отвеченный. }
  , RV_EMPTY = 2
   {* на данный момент нет запросов данного типа }
  , RV_ERROR = -1
   {* серверу не удалось прочесть ответ, или положить его в базу, или произошел еще какой-то внутренний сбой. В этом случае необходимо повторить попытку отдачи ответа. }
  , RV_BAD_XML = -2
   {* формат ответа не соответствует "ожиданиям" сервера. }
  , RV_COMPLECT_REMOVED_ERROR = -3
   {* комплект был удалён из АРМ-а (http://mdp.garant.ru/pages/viewpage.action?pageId=118982402) }
  , RV_INVALID_QUERY_ID = -4
   {* данного идентификатора нет в базе }
 );//TResultValue

 TQueryID = PAnsiChar;

 CantFindXerces = class
  {* Не смогли загрузить библиотеку для работы с XML }
 end;//CantFindXerces

 IOnlineData = interface(IConsultingData)
  {* Консультации, проходящие через СК. Имеют уникальный идентификатор. }
  ['{43387100-5C41-4CCB-83EB-4EE5BB99C443}']
  class function Make(var xml_stream: IStream;
   const consultation_id): BadFactoryType; stdcall;
   {* фабрика для получения интерфейса }
 end;//IOnlineData

 IBusinessLogicLifeCycle = interface
  {* Интерфейс для управления жизненным циклом бизнес-объектов адаптера }
  ['{AC92D75F-442C-4FFE-897D-23499B1BBC34}']
  procedure Start; stdcall;
   {* метод должен быть вызван первым после загрузки dll библиотеки }
  procedure Stop; stdcall;
   {* метод должен быть вызван перед завершением работы библиотеки }
  procedure GetConsultationManager70; stdcall;
   {* получить интерфейс к СК  версии 7 }
 end;//IBusinessLogicLifeCycle

 IConsultingRequests = interface
  {* Интерфейс для получения запросов от пользователей и их оценок. }
  ['{EB5AE11E-74DA-4DFE-950B-CE68586C28F1}']
  function GetQueryById(query_id: TQueryID;
   out data: IConsultingData): TResultValue; stdcall;
   {* получить следующий запрос для обработки }
  function GetNextMark(out data: IConsultingData): TResultValue; stdcall;
   {* Получение очередной оценки на запрос.
При вызове этой операции происходит передача объекта "Оценка" для получения данных. До тех пор пока не будет проведен вызов DataRecieved, эта операция будет возвращать этот запрос.
Если нет ни одного нового запроса, получившего оценку пользователя, возвращается нулевой объект. }
  function SetAnswer(var answer: IStream): TResultValue; stdcall;
   {* Ответ на запрос или предварительное уведомление о сроках обработки запроса.
Ответ оформлен в XML формате (описание cм. в реквизите).
Варианты возвращаемых значений:
[0] - если ответ успешно помещен в базу.
[1] - если запрос в базе уже помечен, как отвеченный.
[-1] - если серверу не удалось прочесть ответ, или положить его в базу, или произошел еще какой-то внутренний сбой. В этом случае необходимо повторить попытку отдачи ответа.
[-2] - если формат ответа не соответствует "ожиданиям" сервера. }
  function GetStatusStatistic(var query: IStream;
   out result: IStream): TResultValue; stdcall;
   {* функция выдаёт статусы консультаций и даты их последней модификации по их идентификаторам. }
  function EraseQueriesById(var query: IStream;
   out result: IStream): TResultValue; stdcall;
   {* удалить запросы из базы СК }
  function SignQuery(var query: IStream;
   out signed_query: IStream): TResultValue; stdcall;
   {* добавить в xml контрольную сумму }
  function GetListOfNewQueries(out result: IStream): TResultValue; stdcall;
   {* получить список идентификаторов консультаций, которые нужно забрать на обработку в ППО }
 end;//IConsultingRequests

implementation

uses
 l3ImplUses
;

type
 IOnlineDataFriend = {abstract} class(IOnlineData)
  {* Друг к классу IOnlineData }
 end;//IOnlineDataFriend

end.
