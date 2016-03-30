unit ConsultingUnit;
 {* Интерфейсы для работы со службой ПП }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ConsultingUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "Consulting" MUID: (457007DB002E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , StartUnit
 , DynamicDocListUnit
 , FoldersUnit
 , DocumentUnit
 //#UC START# *457007DB002Eintf_uses*
 //#UC END# *457007DB002Eintf_uses*
;

type
 TEstimationValue = (
  {* Возможные оценки }
  EV_UNDEFINED
   {* оценка не выставлена }
  , EV_VERY_GOOD
   {* супер!!! }
  , EV_GOOD
   {* хорошо }
  , EV_NORMAL
   {* сойдёт }
  , EV_BAD
   {* полная фигня... }
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

 IEstimation = interface
  {* Оценка }
  ['{DD01B380-09FE-4476-8789-20B2291FE41B}']
  function GetValue: TEstimationValue; stdcall;
  procedure SetValue(aValue: TEstimationValue); stdcall;
  function GetText: IString; stdcall;
  procedure SetText(const aValue: IString); stdcall;
  property Value: TEstimationValue
   read GetValue
   write SetValue;
   {* оценка }
  property Text: IString
   read GetText
   write SetText;
   {* комментарий к оценке }
 end;//IEstimation

 OldFormatConsultation = class
  {* консультация старого формата }
 end;//OldFormatConsultation

 TConsultationStatus = Cardinal;

 IParasList = array of IString;

 IConsultation = interface(IEntityBase)
  {* Консультация }
  ['{69D87373-CAC1-4228-9F26-4E46D2A8CBE9}']
  function GetStatus: TConsultationStatus; stdcall; { can raise Deleted }
  function GetId: IString; stdcall; { can raise Deleted }
  function GetCreationDate: TDateTime; stdcall; { can raise Deleted }
  function GetModificationDate: TDateTime; stdcall; { can raise Deleted }
  function GetName: IString; stdcall; { can raise Deleted }
  function GetQueryData: IString; stdcall; { can raise Deleted }
  function GetUserName: IString; stdcall; { can raise Deleted }
  function GetExpertInfo: IParasList; stdcall; { can raise Deleted }
  function GetExpertName: IString; stdcall; { can raise Deleted }
  function GetReplyDate: TDate; stdcall; { can raise Deleted }
  procedure GetType; stdcall; { can raise Deleted }
  function GetAnswer: IDocument; stdcall; { can raise Deleted, OldFormatConsultation }
   {* Получить уведомление или ответ на запрос }
  function GetQuery: IDocument; stdcall; { can raise Deleted, OldFormatConsultation }
   {* Получить запрос }
  function GetDocumentList: IDynList; stdcall; { can raise NoDocumentList, Deleted, OldFormatConsultation }
   {* Получить список документов ответа }
  procedure SendEstimation(const value: IEstimation); stdcall; { can raise NoConnection, NoSubscription, Deleted }
   {* Отправить оценку }
  function CreateEstimation: IEstimation; stdcall;
   {* создать оценку }
  procedure PaymentConfirm(answer: Boolean); stdcall; { can raise NoConnection, PaymentForbidden }
   {* Подвердить (answer = true)/отказаться (false) от оплаты }
  procedure Read; stdcall; { can raise Deleted }
   {* Помечают консультацию как прочитанную }
  function HasList: ByteBool; stdcall; { can raise Deleted }
  function HasEstimation: ByteBool; stdcall; { can raise Deleted }
  function HasPaymentInformation: ByteBool; stdcall; { can raise Deleted }
  function GetQueryByParas: IParasList; stdcall;
   {* получить запрос в виде списка параграфов }
  function GetAnswerData(out is_evd: Boolean): IParasList; stdcall;
  property Status: TConsultationStatus
   read GetStatus;
   {* Статус консультации }
  property Id: IString
   read GetId;
   {* Идентификатор консультации }
  property CreationDate: TDateTime
   read GetCreationDate;
   {* Дата создания }
  property ModificationDate: TDateTime
   read GetModificationDate;
   {* Дата последнего изменения статуса }
  property Name: IString
   read GetName;
   {* Имя консультации (текст запроса) }
  property QueryData: IString
   read GetQueryData;
  property UserName: IString
   read GetUserName;
  property ExpertInfo: IParasList
   read GetExpertInfo;
  property ExpertName: IString
   read GetExpertName;
  property ReplyDate: TDate
   read GetReplyDate;
  property Type: 
   read GetType;
 end;//IConsultation

 TTemplateType = (
  {* тип шаблона }
  PREANSWER_TEMPLATE
   {* шаблон запроса об оплате }
  , ANSWER_TEMPLATE
   {* шаблон ответа }
  , QUERY_TEMPLATE
   {* шаблон запроса }
 );//TTemplateType

 IConsultationManager = interface
  {* Менеджер консультаций }
  ['{713794D3-0F90-4EE5-AF5D-644D9091DA0C}']
  function CheckInternetChannel: ByteBool; stdcall;
   {* Проверка интернет канала }
  function CheckConsultingAvailable: ByteBool; stdcall;
   {* Проверка досутпности консультационных услуг }
  procedure DeleteConsultation(var for_delete: IConsultation); stdcall; { can raise NotDeleted, Deleted }
   {* Удалить консультацию }
  function UpdateNotReadedConsultations: Cardinal; stdcall;
   {* Возвращает количество непрочитанных консультаций }
  procedure LoadFromXml(file_name: PAnsiChar); stdcall; { can raise AccessDenied, InvalidXMLType }
   {* загрузить консультацию из файла }
  function CantReceiveAnswer: ByteBool; stdcall;
   {* Сообщает о невозможности получать ответы (true - когда лампочку надо включать) }
  procedure CreateQueryWithNoticeUser; stdcall;
   {* Создание уведомления пользователя о консалтинге }
 end;//IConsultationManager

 IConsultingTemplateInfo = interface
  {* Информация для шаблонов консалтинга. Сейчас в базе есть 2 шаблона (preanswer и answer). Какой шаблон нужен для консультации спрашиваем у get_template_type }
  ['{3613E72E-8CD0-4D45-B517-BD45F9764A82}']
  function GetPreanswerTemplate: IStream; stdcall;
  function GetAnswerTemplate: IStream; stdcall;
  function GetDealerInfo: IString; stdcall;
   {* информация о комплекте, которая может быть нужна для шаблона. См. [$100008775] }
  function GetTemplateType(const consultation: IConsultation): TTemplateType; stdcall; { can raise Deleted }
   {* определяет какой шаблон нужен для отображения консультации }
  function GetQueryTemplate: IStream; stdcall;
   {* получить шаблон для запроса }
 end;//IConsultingTemplateInfo

const
 {* Статусы консультаций }
 CS_SENT: TConsultationStatus = 1024;
  {* Отправлена }
 CS_PAYMENT_REQUEST: TConsultationStatus = 1;
  {* Запрос на оплату }
 CS_ANSWER_RECEIVED: TConsultationStatus = 2;
  {* Получен ответ }
 CS_READ: TConsultationStatus = 4;
 CS_ESTIMATION_SENT: TConsultationStatus = 8;
  {* Отправлена оценка }
 CS_DRAFTS: TConsultationStatus = 16;
  {* Создана, но не отправлена }
 CS_PAYMENT_REFUSAL: TConsultationStatus = 32;
  {* Оплата отклонена }
 CS_PAYMENT_CONFIRM: TConsultationStatus = 64;
 CS_VALIDATION_FAILED: TConsultationStatus = 128;
 CS_ANSWER_NOT_CONFIRM: TConsultationStatus = 256;
 CS_READ_NOT_CONFIRM: TConsultationStatus = 512;

implementation

uses
 l3ImplUses
 //#UC START# *457007DB002Eimpl_uses*
 //#UC END# *457007DB002Eimpl_uses*
;

end.
