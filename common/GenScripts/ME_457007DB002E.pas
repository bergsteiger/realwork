unit ConsultingUnit;
 {* Интерфейсы для работы со службой ПП }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ConsultingUnit.pas"
// Стереотип: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , DocumentUnit
 , DynamicDocListUnit
 , FoldersUnit
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
  function Get_value: TEstimationValue;
  procedure Set_value(aValue: TEstimationValue);
  function Get_text: IString;
  procedure Set_text(const aValue: IString);
  property value: TEstimationValue
   read Get_value
   write Set_value;
   {* оценка }
  property text: IString
   read Get_text
   write Set_text;
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
  function Get_status: TConsultationStatus; { can raise Deleted }
  function Get_id: IString; { can raise Deleted }
  function Get_creation_date: TDateTime; { can raise Deleted }
  function Get_modification_date: TDateTime; { can raise Deleted }
  function Get_name: IString; { can raise Deleted }
  function Get_query_data: IString; { can raise Deleted }
  function Get_user_name: IString; { can raise Deleted }
  function Get_expert_info: IParasList; { can raise Deleted }
  function Get_expert_name: IString; { can raise Deleted }
  function Get_reply_date: TDate; { can raise Deleted }
  procedure Get_type; { can raise Deleted }
  function get_answer: IDocument; { can raise Deleted, OldFormatConsultation }
   {* Получить уведомление или ответ на запрос }
  function get_query: IDocument; { can raise Deleted, OldFormatConsultation }
   {* Получить запрос }
  function get_document_list: IDynList; { can raise NoDocumentList, Deleted, OldFormatConsultation }
   {* Получить список документов ответа }
  procedure send_estimation(const value: IEstimation); { can raise NoConnection, NoSubscription, Deleted }
   {* Отправить оценку }
  function create_estimation: IEstimation;
   {* создать оценку }
  procedure payment_confirm(answer: Boolean); { can raise NoConnection, PaymentForbidden }
   {* Подвердить (answer = true)/отказаться (false) от оплаты }
  procedure read; { can raise Deleted }
   {* Помечают консультацию как прочитанную }
  function has_list: Boolean; { can raise Deleted }
  function has_estimation: Boolean; { can raise Deleted }
  function has_payment_information: Boolean; { can raise Deleted }
  function get_query_by_paras: IParasList;
   {* получить запрос в виде списка параграфов }
  function get_answer_data(out is_evd: Boolean): IParasList;
  property status: TConsultationStatus
   read Get_status;
   {* Статус консультации }
  property id: IString
   read Get_id;
   {* Идентификатор консультации }
  property creation_date: TDateTime
   read Get_creation_date;
   {* Дата создания }
  property modification_date: TDateTime
   read Get_modification_date;
   {* Дата последнего изменения статуса }
  property name: IString
   read Get_name;
   {* Имя консультации (текст запроса) }
  property query_data: IString
   read Get_query_data;
  property user_name: IString
   read Get_user_name;
  property expert_info: IParasList
   read Get_expert_info;
  property expert_name: IString
   read Get_expert_name;
  property reply_date: TDate
   read Get_reply_date;
  property type: 
   read Get_type;
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
  function check_internet_channel: Boolean;
   {* Проверка интернет канала }
  function check_consulting_available: Boolean;
   {* Проверка досутпности консультационных услуг }
  procedure delete_consultation(var for_delete: IConsultation); { can raise NotDeleted, Deleted }
   {* Удалить консультацию }
  function update_not_readed_consultations: Cardinal;
   {* Возвращает количество непрочитанных консультаций }
  procedure load_from_xml(file_name: PAnsiChar); { can raise AccessDenied, InvalidXMLType }
   {* загрузить консультацию из файла }
  function cant_receive_answer: Boolean;
   {* Сообщает о невозможности получать ответы (true - когда лампочку надо включать) }
  procedure create_query_with_notice_user;
   {* Создание уведомления пользователя о консалтинге }
 end;//IConsultationManager

 IConsultingTemplateInfo = interface
  {* Информация для шаблонов консалтинга. Сейчас в базе есть 2 шаблона (preanswer и answer). Какой шаблон нужен для консультации спрашиваем у get_template_type }
  ['{3613E72E-8CD0-4D45-B517-BD45F9764A82}']
  function get_preanswer_template: IStream;
  function get_answer_template: IStream;
  function get_dealer_info: IString;
   {* информация о комплекте, которая может быть нужна для шаблона. См. [$100008775] }
  function get_template_type(const consultation: IConsultation): TTemplateType; { can raise Deleted }
   {* определяет какой шаблон нужен для отображения консультации }
  function get_query_template: IStream;
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

class function make: BadFactoryType;
 {* фабрика }
class function make(const server_consultation;
 var folders_node: IFoldersNode): BadFactoryType;
 {* фабрика }
class function make: BadFactoryType;
 {* фабрика }
class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
 {* фабрика }
var
 l_Inst : IEstimation;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const server_consultation;
 var folders_node: IFoldersNode): BadFactoryType;
 {* фабрика }
var
 l_Inst : IConsultation;
begin
 l_Inst := Create(server_consultation, folders_node);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
 {* фабрика }
var
 l_Inst : IConsultationManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IConsultingTemplateInfo;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
