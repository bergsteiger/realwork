unit ConsultingUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/ConsultingUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Consulting
//
// Интерфейсы для работы со службой ПП
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  BaseTypesUnit,
  StartUnit,
  DynamicDocListUnit,
  FoldersUnit,
  DocumentUnit
  ;

type
 TEstimationValue = (
  {* Возможные оценки }
   EV_UNDEFINED // оценка не выставлена
 , EV_VERY_GOOD // супер!!!
 , EV_GOOD // хорошо
 , EV_NORMAL // сойдёт
 , EV_BAD // полная фигня...
 );//TEstimationValue

 NoDocumentList = class
  {* Нет списка документов в ответе }
 end;//NoDocumentList

 NoConnection = class
  {* Нет связи с сервером консультаций }
 end;//NoConnection

 NoSubscription = class
  {* Нет доступа с сервису - вы не подписаны на услугу }
 end;//NoSubscription

 PaymentForbidden = class
  {* У пользователя нет прав оплачивать консультации }
 end;//PaymentForbidden

 NotDeleted = class
  {* Нельзя удалить консультацию }
 end;//NotDeleted

 Deleted = class
  {* Консультация удалена - все операции запрещены }
 end;//Deleted

 IEstimation = interface(IUnknown)
  {* Оценка }
   ['{DD01B380-09FE-4476-8789-20B2291FE41B}']
   function GetValue: TEstimationValue; stdcall;
   procedure SetValue(aValue: TEstimationValue); stdcall;
   function GetText: IString; stdcall;
   procedure SetText(const aValue: IString); stdcall;
   property value: TEstimationValue
     read GetValue
     write SetValue;
     {* оценка }
   property text: IString
     read GetText
     write SetText;
     {* комментарий к оценке }
 end;//IEstimation

 OldFormatConsultation = class
  {* консультация старого формата }
 end;//OldFormatConsultation

 TConsultationStatus = Cardinal;

 IParasList = array of IString;

const
  { Статусы консультаций }
 CS_SENT : TConsultationStatus = 1024;
  { Отправлена }
 CS_PAYMENT_REQUEST : TConsultationStatus = 1;
  { Запрос на оплату }
 CS_ANSWER_RECEIVED : TConsultationStatus = 2;
  { Получен ответ }
 CS_READ : TConsultationStatus = 4;
 CS_ESTIMATION_SENT : TConsultationStatus = 8;
  { Отправлена оценка }
 CS_DRAFTS : TConsultationStatus = 16;
  { Создана, но не отправлена }
 CS_PAYMENT_REFUSAL : TConsultationStatus = 32;
  { Оплата отклонена }
 CS_PAYMENT_CONFIRM : TConsultationStatus = 64;
 CS_VALIDATION_FAILED : TConsultationStatus = 128;
 CS_ANSWER_NOT_CONFIRM : TConsultationStatus = 256;
 CS_READ_NOT_CONFIRM : TConsultationStatus = 512;

type
 IConsultation = interface(IEntityBase)
  {* Консультация }
   ['{69D87373-CAC1-4228-9F26-4E46D2A8CBE9}']
   function GetStatus: TConsultationStatus; stdcall;
   function GetId: IString; stdcall;
   function GetCreationDate: TDateTime; stdcall;
   function GetModificationDate: TDateTime; stdcall;
   function GetName: IString; stdcall;
   function GetQueryData: IString; stdcall;
   function GetUserName: IString; stdcall;
   function GetExpertInfo: IParasList; stdcall;
   function GetExpertName: IString; stdcall;
   function GetReplyDate: TDate; stdcall;
   function GetType: ; stdcall;
   procedure GetAnswer(out aRet {: IDocument}); stdcall; // can raise Deleted, OldFormatConsultation
     {* Получить уведомление или ответ на запрос }
   procedure GetQuery(out aRet {: IDocument}); stdcall; // can raise Deleted, OldFormatConsultation
     {* Получить запрос }
   procedure GetDocumentList(out aRet {: IDynList}); stdcall; // can raise NoDocumentList, Deleted, OldFormatConsultation
     {* Получить список документов ответа }
   procedure SendEstimation(const aValue: IEstimation); stdcall; // can raise NoConnection, NoSubscription, Deleted
     {* Отправить оценку }
   procedure CreateEstimation(out aRet {: IEstimation}); stdcall;
     {* создать оценку }
   procedure PaymentConfirm(aAnswer: Boolean); stdcall; // can raise NoConnection, PaymentForbidden
     {* Подвердить (answer = true)/отказаться (false) от оплаты }
   procedure Read; stdcall; // can raise Deleted
     {* Помечают консультацию как прочитанную }
   function HasList: ByteBool; stdcall; // can raise Deleted
   function HasEstimation: ByteBool; stdcall; // can raise Deleted
   function HasPaymentInformation: ByteBool; stdcall; // can raise Deleted
   procedure GetQueryByParas(out aRet {: IParasList}); stdcall;
     {* получить запрос в виде списка параграфов }
   procedure GetAnswerData(out aIsEvd: Boolean; out aRet {: IParasList}); stdcall;
   property status: TConsultationStatus
     read GetStatus;
     {* Статус консультации }
   property id: IString
     read GetId;
     {* Идентификатор консультации }
   property creation_date: TDateTime
     read GetCreationDate;
     {* Дата создания }
   property modification_date: TDateTime
     read GetModificationDate;
     {* Дата последнего изменения статуса }
   property name: IString
     read GetName;
     {* Имя консультации (текст запроса) }
   property query_data: IString
     read GetQueryData;
   property user_name: IString
     read GetUserName;
   property expert_info: IParasList
     read GetExpertInfo;
   property expert_name: IString
     read GetExpertName;
   property reply_date: TDate
     read GetReplyDate;
   property type: 
     read GetType;
 end;//IConsultation

 TTemplateType = (
  {* тип шаблона }
   PREANSWER_TEMPLATE // шаблон запроса об оплате
 , ANSWER_TEMPLATE // шаблон ответа
 , QUERY_TEMPLATE // шаблон запроса
 );//TTemplateType

 IConsultationManager = interface(IUnknown)
  {* Менеджер консультаций }
   ['{713794D3-0F90-4EE5-AF5D-644D9091DA0C}']
   function CheckInternetChannel: ByteBool; stdcall;
     {* Проверка интернет канала }
   function CheckConsultingAvailable: ByteBool; stdcall;
     {* Проверка досутпности консультационных услуг }
   procedure DeleteConsultation(var aForDelete: IConsultation); stdcall; // can raise NotDeleted, Deleted
     {* Удалить консультацию }
   function UpdateNotReadedConsultations: Cardinal; stdcall;
     {* Возвращает количество непрочитанных консультаций }
   procedure LoadFromXml(aFileName: PAnsiChar); stdcall; // can raise AccessDenied, InvalidXMLType
     {* загрузить консультацию из файла }
   function CantReceiveAnswer: ByteBool; stdcall;
     {* Сообщает о невозможности получать ответы (true - когда лампочку надо включать) }
   procedure CreateQueryWithNoticeUser; stdcall;
     {* Создание уведомления пользователя о консалтинге }
 end;//IConsultationManager

 IConsultingTemplateInfo = interface(IUnknown)
  {* Информация для шаблонов консалтинга. Сейчас в базе есть 2 шаблона (preanswer и answer). Какой шаблон нужен для консультации спрашиваем у get_template_type }
   ['{3613E72E-8CD0-4D45-B517-BD45F9764A82}']
   procedure GetPreanswerTemplate(out aRet {: IStream}); stdcall;
   procedure GetAnswerTemplate(out aRet {: IStream}); stdcall;
   procedure GetDealerInfo(out aRet {: IString}); stdcall;
     {* информация о комплекте, которая может быть нужна для шаблона. См. [$100008775] }
   function GetTemplateType(const aConsultation: IConsultation): TTemplateType; stdcall; // can raise Deleted
     {* определяет какой шаблон нужен для отображения консультации }
   procedure GetQueryTemplate(out aRet {: IStream}); stdcall;
     {* получить шаблон для запроса }
 end;//IConsultingTemplateInfo

//#UC START# *457007DB002Eunit_intf*
//#UC END# *457007DB002Eunit_intf*

implementation

end.