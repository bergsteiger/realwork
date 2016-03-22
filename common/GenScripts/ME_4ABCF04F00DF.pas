unit ConsultationDomainInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\ConsultationDomainInterfaces.pas"
// Стереотип: "ControllerInterfaces"
// Элемент модели: "ConsultationDomainInterfaces" MUID: (4ABCF04F00DF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , bsTypes
 , ConsultingUnit
 , l3Interfaces
 , DocumentUnit
 , SysUtils
 , DocumentAndListInterfaces
 , nevTools
 , DocumentInterfaces
 , afwInterfaces
 , FoldersDomainInterfaces
 , bsTypesNew
;

type
 SysDateTime = TDateTime;

 IbsConsultation = interface
  {* Консультация. Обертка сделана для удобства работы с удаленной консультацией, при работе с методами которой летит исключение EDeleted }
  ['{0E7541E5-05E6-4A9C-A10B-71A3253B3E8E}']
  function pm_GetStatus: TbsConsultationStatuses;
  function pm_GetIsStatusChached: Boolean;
  procedure pm_SetIsStatusChached(aValue: Boolean);
  function pm_GetData: IConsultation;
  function pm_GetWasDeleted: Boolean;
  function pm_GetId: Il3CString;
  function pm_GetWasCreated: SysDateTime;
  function pm_GetWasModified: SysDateTime;
  function pm_GetCaption: Il3CString;
  function pm_GetText: IDocument;
  procedure RefreshText;
   {* обновить текст. Необхоидимо при изменении состояния консультации }
  property Status: TbsConsultationStatuses
   read pm_GetStatus;
   {* статус консультации }
  property IsStatusChached: Boolean
   read pm_GetIsStatusChached
   write pm_SetIsStatusChached;
   {* является ли статус кешированным. Нужно чтобы при открытии
             консультации снизить кол-во обращений к серверу }
  property Data: IConsultation
   read pm_GetData;
   {* консультация }
  property WasDeleted: Boolean
   read pm_GetWasDeleted;
   {* консультация была удалена }
  property Id: Il3CString
   read pm_GetId;
   {* идентификатор консультации }
  property WasCreated: SysDateTime
   read pm_GetWasCreated;
   {* дата создания }
  property WasModified: SysDateTime
   read pm_GetWasModified;
   {* дата изменения (устанавливается в момента изменения статуса
             консультации) }
  property Caption: Il3CString
   read pm_GetCaption;
   {* название консультации }
  property Text: IDocument
   read pm_GetText;
   {* текст консультации отображаемый пользователю. Если у консультации
             есть ответ, то показывается ответ, если нет, то показывается текст
             запроса }
 end;//IbsConsultation

 EbsConsultationAlreadyConfirmed = class(Exception)
  {* Оплата консультации уже подтверждена/отвергнута }
 end;//EbsConsultationAlreadyConfirmed

 EbsConsultationAlreadyMark = class(Exception)
  {* Консультация уже была оценена }
 end;//EbsConsultationAlreadyMark

 EbsConsultationWasDeleted = class(Exception)
  {* Консультация была удалена }
 end;//EbsConsultationWasDeleted

 EbsPaymentForbidden = class(Exception)
  {* Платные консультации для пользователя запрещены }
 end;//EbsPaymentForbidden

 IdsConsultation = interface(IdsBaseDocument)
  {* БОС консультации }
  ['{2BA5B54E-CFAD-47B8-9DAC-04914173BFD8}']
  function pm_GetShowingStatus: TbsConsultationStatuses;
  property ShowingStatus: TbsConsultationStatuses
   read pm_GetShowingStatus;
   {* отображаемый на экране статус консультации. Чтобы понять текст для
             какого состояния консультации на экране отображается нельзя
             получать статус у самой консультации, т.к. он на консультации не
             кешируется и может поменяться пока консультация отображается на
             экране. Например, открываем запрос на просмотр, далее приходит
             уведомление, при этом статус консультации меняется }
 end;//IdsConsultation

 IdsConsultationMark = interface
  {* БОС оценка консультации }
  ['{20808CC0-584C-48C5-A167-7DEDB7D3C1BF}']
  function pm_GetMark: TbsConsultationMark;
  procedure pm_SetMark(aValue: TbsConsultationMark);
  function pm_GetComment: Tl3WString;
  procedure pm_SetComment(const aValue: Tl3WString);
  function pm_GetCanSend: Boolean;
  procedure Send;
   {* послать оценку }
  property Mark: TbsConsultationMark
   read pm_GetMark
   write pm_SetMark;
   {* оценка }
  property Comment: Tl3WString
   read pm_GetComment
   write pm_SetComment;
   {* комментарий }
  property CanSend: Boolean
   read pm_GetCanSend;
   {* можно ли отправить оценку }
 end;//IdsConsultationMark

 IsdsConsultation = interface
  {* Бизнес объект прецедента "Консультация" }
  ['{005BCE3D-3D26-4B47-80B4-BB7580EE147F}']
  function pm_GetdsConsultation: IdsConsultation;
  function pm_GetdsList: IdsDocumentList;
  function pm_GetDSConsultationMark(aForce: Boolean): IdsConsultationMark;
  function Get_bsConsultation: IbsConsultation;
  procedure GiveMark; { can raise EbsConsultationAlreadyMark, EbsConsultationWasDeleted }
   {* дать оценку.
           Возможные исключения:
           - EbsConsultationAlreadyMark }
  function NeedGiveMark: Boolean;
  procedure ConfirmPayment(anAccept: Boolean); { can raise EbsPaymentForbidden, EbsConsultationWasDeleted, EbsConsultationAlreadyConfirmed }
   {* Подтвердить оплату консультации. Да/Нет;
           Исключения:
             - EbsPaymentForbidden }
  procedure UpdateAnswer;
   {* перечитать ответ }
  procedure ListChanged;
   {* список документов консультации изменен пользователем. Используется
           при перезагрузке консультации }
  procedure ConsultationWasMarked(const aConsultation: IsdsConsultation);
   {* консультация была оценена. Для случая когда консультацию оценили в
           дереве, при этом эта же консультация открыта на экране и ее нужно
           перечитать, чтобы ссылка оценить пропала }
  procedure MarkSended;
  function As_IsdsGotoPointDataMaker: IsdsGotoPointDataMaker;
   {* Метод приведения нашего интерфейса к IsdsGotoPointDataMaker }
  property dsConsultation: IdsConsultation
   read pm_GetdsConsultation;
   {* БО консультация }
  property dsList: IdsDocumentList
   read pm_GetdsList;
   {* БО список консультации }
  property DSConsultationMark[aForce: Boolean]: IdsConsultationMark
   read pm_GetDSConsultationMark;
   {* БО оценка консультации }
  property bsConsultation: IbsConsultation
   read Get_bsConsultation;
 end;//IsdsConsultation
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
