unit ChatInterfacesUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Ѕиблиотека "GblAdapterLib"
// ћодуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/ChatInterfacesUnit.pas"
// –одные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ChatInterfaces
//
// интерфейсы дл€ поддержки чата
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ѕолностью генерируетс€ с модели. ѕравить руками - нельз€. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  BaseTypesUnit,
  DynamicTreeUnit,
  NotifyUnit,
  SecurityUnit
  ;

type
 TUserInfo = record
  {* информаци€ о пользователе }
   email : IString; // email пользовател€
   login : IString; // регистрационное им€ пользовател€
   name : IString; // им€ пользовател€
 end;//TUserInfo

 UnknownUser = class
  {* задан идентификатор неизвестного пользовател€ }
 end;//UnknownUser

 IChatManager = interface(IUnknown)
  {* управление чатом }
   ['{F9DEFC6A-0DF4-4DC4-B863-62E0A7D8E68A}']
   function IsEmbedChatEnabled: ByteBool; stdcall;
     {* возвращает true, если на сервере обеспечена поддержка чата }
   procedure GetContactsTree(out aRet {: INodeBase}); stdcall;
     {* получить список пользователей, добавленных в контакты }
   function GetUserInfo(aUid: TUid): TUserInfo; stdcall; // can raise UnknownUser
     {* информаци€ о пользователе с заданным идентификатором }
   procedure AddUser(aUid: TUid); stdcall; // can raise UnknownUser
     {* добавить пользовател€ в список контактов }
   procedure DeleteUser(aUid: TUid); stdcall; // can raise UnknownUser
     {* удалить пользовател€ из списка контактов }
   procedure RegisterListenerForNotify(var aListener: IListener); stdcall;
     {* зарегестрировать слушател€ }
   procedure ReceiveMessage(aMessage); stdcall;
     {* получить сообщение с сервера }
   procedure TakeUnreadedMessages(aUid: TUid); stdcall;
     {* выбрать все непрочитанные сообщени€ }
   procedure Logout; stdcall;
     {* вызываетс€ при выходе из системы }
 end;//IChatManager

 TMessage = record
  {* данные сообщени€ }
   text : IStream; // сообщение (предполагаетс€, что в evd формате)
   time : TDateTime; // врем€ создани€ сообщени€
   my : Boolean; // true, если сообщение послано текущим пользователем, иначе это сообщение дл€ него
 end;//TMessage

 IMessages = array of TMessage;
  {* список сообщений }

 IMessagesManager = interface(IUnknown)
  {* работа с сообщени€ми }
   ['{7D3435F1-68A4-4CBE-A547-240E45D9FAE4}']
   procedure GetUnreadedMessages(aUid: TUid; out aRet {: IMessages}); overload;  stdcall; // can raise UnknownUser
     {* получить непрочитанные сообщени€ от пользовател€ с заданным uid }
   procedure SendMessage(var aMessage: IStream;
    aUid: TUid); stdcall; // can raise UnknownUser
     {* послать сообщение заданному пользователю }
   procedure GetHistoryForUser(aCount: Cardinal;
    aAllNew: Boolean;
    aUid: TUid; out aRet {: IMessages}); stdcall; // can raise UnknownUser
     {* получить count последних сообщений переписки с пользователем uid. ≈сли count = 0, получить полную историю переписки. ≈сли all_new = true, будут получены все непрочитанные сообщени€, даже если их количество превышает count. }
   procedure CleanHistory(aUid: TUid); stdcall; // can raise UnknownUser
     {* очистить историю сообщений с заданным пользователем }
   procedure GetUnreadedMessages; overload;  stdcall;
     {* получить непрочитанные сообщени€ с сервера }
 end;//IMessagesManager

implementation

end.