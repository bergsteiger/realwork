unit ChatInterfacesUnit;
 {* интерфейсы для поддержки чата }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ChatInterfacesUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "ChatInterfaces" MUID: (4A40991F003F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , DynamicTreeUnit
 , NotifyUnit
 , SecurityUnit
;

type
 TUserInfo = record
  {* информация о пользователе }
  email: ;
   {* email пользователя }
  login: ;
   {* регистрационное имя пользователя }
  name: ;
   {* имя пользователя }
 end;//TUserInfo

 UnknownUser = class
  {* задан идентификатор неизвестного пользователя }
 end;//UnknownUser

 IChatManager = interface
  {* управление чатом }
  ['{F9DEFC6A-0DF4-4DC4-B863-62E0A7D8E68A}']
  function IsEmbedChatEnabled: ByteBool; stdcall;
   {* возвращает true, если на сервере обеспечена поддержка чата }
  procedure GetContactsTree(out aRet
   {* INodeBase }); stdcall;
   {* получить список пользователей, добавленных в контакты }
  procedure GetUserInfo(uid: TUid;
   out aRet
   {* TUserInfo }); stdcall; { can raise UnknownUser }
   {* информация о пользователе с заданным идентификатором }
  procedure AddUser(uid: TUid); stdcall; { can raise UnknownUser }
   {* добавить пользователя в список контактов }
  procedure DeleteUser(uid: TUid); stdcall; { can raise UnknownUser }
   {* удалить пользователя из списка контактов }
  procedure RegisterListenerForNotify(var listener: IListener); stdcall;
   {* зарегестрировать слушателя }
  procedure ReceiveMessage(const message); stdcall;
   {* получить сообщение с сервера }
  procedure TakeUnreadedMessages(uid: TUid); stdcall;
   {* выбрать все непрочитанные сообщения }
  procedure Logout; stdcall;
   {* вызывается при выходе из системы }
 end;//IChatManager

 TMessage = record
  {* данные сообщения }
  text: ;
   {* сообщение (предполагается, что в evd формате) }
  time: ;
   {* время создания сообщения }
  my: ByteBool;
   {* true, если сообщение послано текущим пользователем, иначе это сообщение для него }
 end;//TMessage

 IMessages = array of TMessage;
  {* список сообщений }

 IMessagesManager = interface
  {* работа с сообщениями }
  ['{7D3435F1-68A4-4CBE-A547-240E45D9FAE4}']
  procedure GetUnreadedMessages(uid: TUid;
   out aRet
   {* IMessages }); overload; stdcall; { can raise UnknownUser }
   {* получить непрочитанные сообщения от пользователя с заданным uid }
  procedure SendMessage(var message: IStream;
   uid: TUid); stdcall; { can raise UnknownUser }
   {* послать сообщение заданному пользователю }
  procedure GetHistoryForUser(count: Cardinal;
   all_new: Boolean;
   uid: TUid;
   out aRet
   {* IMessages }); stdcall; { can raise UnknownUser }
   {* получить count последних сообщений переписки с пользователем uid. Если count = 0, получить полную историю переписки. Если all_new = true, будут получены все непрочитанные сообщения, даже если их количество превышает count. }
  procedure CleanHistory(uid: TUid); stdcall; { can raise UnknownUser }
   {* очистить историю сообщений с заданным пользователем }
  procedure GetUnreadedMessages; overload; stdcall;
   {* получить непрочитанные сообщения с сервера }
 end;//IMessagesManager

implementation

uses
 l3ImplUses
;

end.
