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
 , DynamicTreeUnit
 , BaseTypesUnit
 , NotifyUnit
;

type
 TUserInfo = record
  {* информация о пользователе }
  email: IString;
   {* email пользователя }
  login: IString;
   {* регистрационное имя пользователя }
  name: IString;
   {* имя пользователя }
 end;//TUserInfo

 UnknownUser = class
  {* задан идентификатор неизвестного пользователя }
 end;//UnknownUser

 IChatManager = interface
  {* управление чатом }
  ['{F9DEFC6A-0DF4-4DC4-B863-62E0A7D8E68A}']
  function is_embed_chat_enabled: Boolean;
   {* возвращает true, если на сервере обеспечена поддержка чата }
  function get_contacts_tree: INodeBase;
   {* получить список пользователей, добавленных в контакты }
  function get_user_info(uid: TUid): TUserInfo; { can raise UnknownUser }
   {* информация о пользователе с заданным идентификатором }
  procedure add_user(uid: TUid); { can raise UnknownUser }
   {* добавить пользователя в список контактов }
  procedure delete_user(uid: TUid); { can raise UnknownUser }
   {* удалить пользователя из списка контактов }
  procedure register_listener_for_notify(var listener: IListener);
   {* зарегестрировать слушателя }
  procedure receive_message(const message);
   {* получить сообщение с сервера }
  procedure take_unreaded_messages(uid: TUid);
   {* выбрать все непрочитанные сообщения }
  procedure logout;
   {* вызывается при выходе из системы }
 end;//IChatManager

 TMessage = record
  {* данные сообщения }
  text: IStream;
   {* сообщение (предполагается, что в evd формате) }
  time: TDateTime;
   {* время создания сообщения }
  my: Boolean;
   {* true, если сообщение послано текущим пользователем, иначе это сообщение для него }
 end;//TMessage

 IMessages = array of TMessage;
  {* список сообщений }

 IMessagesManager = interface
  {* работа с сообщениями }
  ['{7D3435F1-68A4-4CBE-A547-240E45D9FAE4}']
  function get_unreaded_messages(uid: TUid): IMessages; overload; { can raise UnknownUser }
   {* получить непрочитанные сообщения от пользователя с заданным uid }
  procedure send_message(var message: IStream;
   uid: TUid); { can raise UnknownUser }
   {* послать сообщение заданному пользователю }
  function get_history_for_user(count: Cardinal;
   all_new: Boolean;
   uid: TUid): IMessages; { can raise UnknownUser }
   {* получить count последних сообщений переписки с пользователем uid. Если count = 0, получить полную историю переписки. Если all_new = true, будут получены все непрочитанные сообщения, даже если их количество превышает count. }
  procedure clean_history(uid: TUid); { can raise UnknownUser }
   {* очистить историю сообщений с заданным пользователем }
  procedure get_unreaded_messages; overload;
   {* получить непрочитанные сообщения с сервера }
 end;//IMessagesManager

class function make: BadFactoryType;
 {* фабрика }
class function make: BadFactoryType;
 {* фабрика }

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
 {* фабрика }
var
 l_Inst : IChatManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
 {* фабрика }
var
 l_Inst : IMessagesManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
