unit atChatWorker;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/AdapterHelpers/atChatWorker.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::AdapterHelpers::TatChatWorker
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  BaseTypesUnit,
  NotifyUnit,
  SysUtils,
  l3_Base,
  Classes,
  SyncObjs,
  ChatInterfacesUnit,
  atUserListHelper
  ;

type
 TatChatConversation = class(Tl3_Base)
 private
 // private fields
   f_HasNewMessages : Boolean;
   f_NewMessageCS : TCriticalSection;
   f_UserID : TUid;
    {* Поле для свойства UserID}
   f_MessagesReceived : Integer;
    {* Поле для свойства MessagesReceived}
   f_MessagesSent : Integer;
    {* Поле для свойства MessagesSent}
   f_MessagesManager : IMessagesManager;
    {* Поле для свойства MessagesManager}
 private
 // private methods
   procedure OnNewMessageReceived; virtual;
   constructor Create(anUserID: TUid); reintroduce;
   procedure ReadMessage(const aMessage: TMessage); virtual;
   procedure ReadMessages(const aMessages: IMessages); virtual;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   procedure SendMessage(const aMessage: AnsiString); virtual;
   procedure ProcessNewMessages; virtual;
 protected
 // protected properties
   property MessagesManager: IMessagesManager
     read f_MessagesManager;
 public
 // public properties
   property UserID: TUid
     read f_UserID;
   property MessagesReceived: Integer
     read f_MessagesReceived;
   property MessagesSent: Integer
     read f_MessagesSent;
 end;//TatChatConversation

 TatChatListenerFireFunction = procedure (const aNotification: INotification) of object;

 IatChatListener = interface(IListener)
   ['{5E6FDA1E-7A85-47AA-BA86-52ADA5B0BC69}']
   procedure Attach(aFunction: TatChatListenerFireFunction);
   procedure Detach;
 end;//IatChatListener

 TatChatWorker = class(Tl3_Base)
 private
 // private fields
   f_Conversations : TStringList;
   f_ChatListener : IatChatListener;
   f_UidsWithUnreadedMessages : TStringList;
   f_UWUMCS : TCriticalSection;
   f_NotifyCS : TCriticalSection;
   f_ChatManager : IChatManager;
    {* Поле для свойства ChatManager}
 private
 // private methods
   procedure OnChatNotification(const aNotification: INotification); virtual;
 protected
 // property methods
   function pm_GetConversationsCount: Integer;
   function pm_GetUIDsWithUnreadedMessages: TatArrayOfUID;
   function pm_GetConversationByIndex(anIndex: Integer): TatChatConversation; virtual;
   function pm_GetConversationByUID(anUID: TUid): TatChatConversation; virtual;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create; reintroduce;
   function StartConversation(anUserID: TUid): Boolean; virtual;
   procedure FinishConversation(anUserID: TUid); virtual;
   function GetContactListUIDs(isActiveOnly: Boolean = false;
    isAdapterTestsOnly: Boolean = false): TatArrayOfUID; virtual;
   procedure AddUser(anUserID: TUid); virtual;
   procedure DeleteUser(anUserID: TUid); virtual;
 protected
 // protected properties
   property ChatManager: IChatManager
     read f_ChatManager;
 public
 // public properties
   property ConversationsCount: Integer
     read pm_GetConversationsCount;
   property UIDsWithUnreadedMessages: TatArrayOfUID
     read pm_GetUIDsWithUnreadedMessages;
   property ConversationByIndex[anIndex: Integer]: TatChatConversation
     read pm_GetConversationByIndex;
   property ConversationByUID[anUID: TUid]: TatChatConversation
     read pm_GetConversationByUID;
 end;//TatChatWorker

implementation

uses
  atChatMessage,
  atUserComment,
  ActiveX,
  atLogger,
  atGblAdapterWorker,
  DynamicTreeUnit,
  SecurityUnit,
  atStringHelper
  ;

type
  TatChatListener = class(Tl3_Base, IatChatListener)
  private
  // private fields
   f_Func : TatChatListenerFireFunction;
   f_MREWS : TMultiReadExclusiveWriteSynchronizer;
  protected
  // realized methods
   procedure Fire(const aNotify: INotification); stdcall;
   procedure Attach(aFunction: TatChatListenerFireFunction);
   procedure Detach;
  protected
  // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
  protected
  // protected methods
   constructor Create; reintroduce;
  public
  // public methods
   class function Make: IatChatListener; reintroduce;
  end;//TatChatListener

// start class TatChatListener

class function TatChatListener.Make: IatChatListener;
var
 l_Inst : TatChatListener;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

constructor TatChatListener.Create;
//#UC START# *4B69384701C8_4B6937C20205_var*
//#UC END# *4B69384701C8_4B6937C20205_var*
begin
//#UC START# *4B69384701C8_4B6937C20205_impl*
  inherited Create();
  f_Func := nil;
  f_MREWS := TMultiReadExclusiveWriteSynchronizer.Create;
//#UC END# *4B69384701C8_4B6937C20205_impl*
end;//TatChatListener.Create

procedure TatChatListener.Fire(const aNotify: INotification);
//#UC START# *45EEDE9D01C5_4B6937C20205_var*
//#UC END# *45EEDE9D01C5_4B6937C20205_var*
begin
//#UC START# *45EEDE9D01C5_4B6937C20205_impl*
  f_MREWS.BeginRead;
  try
    if (@f_Func <> nil) then
      f_Func(aNotify);
  finally
    f_MREWS.EndRead;
  end;
//#UC END# *45EEDE9D01C5_4B6937C20205_impl*
end;//TatChatListener.Fire

procedure TatChatListener.Attach(aFunction: TatChatListenerFireFunction);
//#UC START# *4B69379E0046_4B6937C20205_var*
//#UC END# *4B69379E0046_4B6937C20205_var*
begin
//#UC START# *4B69379E0046_4B6937C20205_impl*
  f_MREWS.BeginWrite;
  try
    f_Func := aFunction;
  finally
    f_MREWS.EndWrite;
  end;
//#UC END# *4B69379E0046_4B6937C20205_impl*
end;//TatChatListener.Attach

procedure TatChatListener.Detach;
//#UC START# *4B6937B701C3_4B6937C20205_var*
//#UC END# *4B6937B701C3_4B6937C20205_var*
begin
//#UC START# *4B6937B701C3_4B6937C20205_impl*
  f_MREWS.BeginWrite;
  try
    f_Func := nil;
  finally
    f_MREWS.EndWrite;
  end;
//#UC END# *4B6937B701C3_4B6937C20205_impl*
end;//TatChatListener.Detach

procedure TatChatListener.Cleanup;
//#UC START# *479731C50290_4B6937C20205_var*
//#UC END# *479731C50290_4B6937C20205_var*
begin
//#UC START# *479731C50290_4B6937C20205_impl*
  Detach();
  FreeAndNil(f_MREWS);
  {$IFDEF DEBUG}
  WriteLn('TatChatListener.Cleanup');
  {$ENDIF}
  inherited;
//#UC END# *479731C50290_4B6937C20205_impl*
end;//TatChatListener.Cleanup
var
   f_ReadSendCS : TCriticalSection;

// start class TatChatConversation

procedure TatChatConversation.SendMessage(const aMessage: AnsiString);
//#UC START# *4B683C2B037C_4B683B6501EB_var*
  var
    l_ChatMessage : IatChatMessage;
    l_NewPos : Int64;
//#UC END# *4B683C2B037C_4B683B6501EB_var*
begin
//#UC START# *4B683C2B037C_4B683B6501EB_impl*
  {$IFDEF DEBUG}
  Logger.Info('Вызываем TatChatMessage.Make');
  {$ENDIF}
  l_ChatMessage := TatChatMessage.Make;
  {$IFDEF DEBUG}
  Logger.Info('Вызвали TatChatMessage.Make');
  {$ENDIF}

  {$IFDEF DEBUG}
  Logger.Info('Вызываем l_ChatMessage.ChatMessage = %s', [aMessage]);
  {$ENDIF}
  l_ChatMessage.ChatMessage := aMessage;
  {$IFDEF DEBUG}
  Logger.Info('Вызвали l_ChatMessage.ChatMessage =');
  {$ENDIF}
  //
  f_ReadSendCS.Enter;
  try
    {$IFDEF DEBUG}
    Logger.Info('Вызываем MessagesManager.SendMessage. f_UserID = %d', [f_UserID]);
    {$ENDIF}
    (l_ChatMessage as IStream).Seek(0, 0, l_NewPos);
    MessagesManager.SendMessage(l_ChatMessage as IStream, f_UserID);
    l_ChatMessage := nil;
    {$IFDEF DEBUG}
    Logger.Info('Вызвали MessagesManager.SendMessage');
    {$ENDIF}
  finally
    f_ReadSendCS.Leave;
  end;
  //
  Logger.Info('Послали сообщение пользователю с uid %d', [f_UserID]);
  Inc(f_MessagesSent);
//#UC END# *4B683C2B037C_4B683B6501EB_impl*
end;//TatChatConversation.SendMessage

procedure TatChatConversation.OnNewMessageReceived;
//#UC START# *4B683C7A01FC_4B683B6501EB_var*
//#UC END# *4B683C7A01FC_4B683B6501EB_var*
begin
//#UC START# *4B683C7A01FC_4B683B6501EB_impl*
  Logger.Info('Пришло новое сообщение от пользователя uid %d', [f_UserID]);
  f_HasNewMessages := true;
//#UC END# *4B683C7A01FC_4B683B6501EB_impl*
end;//TatChatConversation.OnNewMessageReceived

constructor TatChatConversation.Create(anUserID: TUid);
//#UC START# *4B6942E5032E_4B683B6501EB_var*
  var
    l_Messages : IMessages;
//#UC END# *4B6942E5032E_4B683B6501EB_var*
begin
//#UC START# *4B6942E5032E_4B683B6501EB_impl*
  inherited Create();
  //
  f_NewMessageCS := TCriticalSection.Create;
  f_HasNewMessages := false;
  f_UserID := anUserID;
  f_MessagesManager := TatGblAdapterWorker.Instance.GblAdapterDll.MakeMessagesManager;
  Assert(f_MessagesManager <> nil, 'f_MessagesManager <> nil');
  //
  f_ReadSendCS.Enter;
  try
    MessagesManager.GetHistoryForUser(20, true, f_UserID, l_Messages);
    Logger.Info('Получаем историю сообщений для разговора с пользователем с uid %d', [f_UserID]);
    ReadMessages(l_Messages);
    l_Messages := nil;
  finally
    f_ReadSendCS.Leave;
  end;
  //
  f_MessagesReceived := 0;
  f_MessagesSent := 0;
//#UC END# *4B6942E5032E_4B683B6501EB_impl*
end;//TatChatConversation.Create

procedure TatChatConversation.ReadMessage(const aMessage: TMessage);
//#UC START# *4B697BBC006C_4B683B6501EB_var*
  const
    BUF_SIZE = 4096;
  var
    l_Buf : array [0..BUF_SIZE-1] of Char;
    l_ReadBytes : Longint;
//#UC END# *4B697BBC006C_4B683B6501EB_var*
begin
//#UC START# *4B697BBC006C_4B683B6501EB_impl*
  repeat
    aMessage.rText.Read(@l_Buf[0], BUF_SIZE, @l_ReadBytes);
  until l_ReadBytes < BUF_SIZE;
//#UC END# *4B697BBC006C_4B683B6501EB_impl*
end;//TatChatConversation.ReadMessage

procedure TatChatConversation.ReadMessages(const aMessages: IMessages);
//#UC START# *4B69814903D2_4B683B6501EB_var*
  var
    i : Integer;
    l_Message : TMessage;
//#UC END# *4B69814903D2_4B683B6501EB_var*
begin
//#UC START# *4B69814903D2_4B683B6501EB_impl*
  if ((aMessages <> nil) AND (aMessages.Count > 0)) then
  begin
    for i := 0 to aMessages.Count-1 do
    begin
      {$IFDEF DEBUG}
      Logger.Info('Вызываем aMessages.pm_GetItem');
      {$ENDIF}
      aMessages.pm_GetItem(i, l_Message);
      {$IFDEF DEBUG}
      Logger.Info('Вызвали aMessages.pm_GetItem');
      {$ENDIF}
      ReadMessage(l_Message);
    end;
    Inc(f_MessagesReceived, aMessages.Count);
    Logger.Info('Прочитано %d сообщений от пользователя с uid %d', [aMessages.Count, f_UserID]);
  end;
//#UC END# *4B69814903D2_4B683B6501EB_impl*
end;//TatChatConversation.ReadMessages

procedure TatChatConversation.ProcessNewMessages;
//#UC START# *4B755B9800FD_4B683B6501EB_var*
  var
    l_Messages : IMessages;
//#UC END# *4B755B9800FD_4B683B6501EB_var*
begin
//#UC START# *4B755B9800FD_4B683B6501EB_impl*
  if f_HasNewMessages then
  begin
    f_ReadSendCS.Enter;
    try
      {$IFDEF DEBUG}
      Logger.Info('Вызываем MessagesManager.GetUnreadedMessages. f_UserID = %d', [f_UserID]);
      {$ENDIF}
      MessagesManager.GetUnreadedMessages(f_UserID, l_Messages);
      {$IFDEF DEBUG}
      Logger.Info('Вызвали MessagesManager.GetUnreadedMessages');
      {$ENDIF}
      //Assert(l_Messages <> nil, 'l_Messages <> nil');
      if (l_Messages <> nil) then
      begin
        Logger.Info('Читаем новые сообщения от пользователя с uid %d', [f_UserID]);
        ReadMessages(l_Messages);
        l_Messages := nil;
      end;
      f_HasNewMessages := false;
    finally
      f_ReadSendCS.Leave;
    end;
  end;
//#UC END# *4B755B9800FD_4B683B6501EB_impl*
end;//TatChatConversation.ProcessNewMessages

procedure TatChatConversation.Cleanup;
//#UC START# *479731C50290_4B683B6501EB_var*
//#UC END# *479731C50290_4B683B6501EB_var*
begin
//#UC START# *479731C50290_4B683B6501EB_impl*
  FreeAndNil(f_NewMessageCS);
  //
  inherited;
//#UC END# *479731C50290_4B683B6501EB_impl*
end;//TatChatConversation.Cleanup

procedure TatChatConversation.ClearFields;
 {-}
begin
 f_MessagesManager := nil;
 inherited;
end;//TatChatConversation.ClearFields

function TatChatWorker.pm_GetConversationsCount: Integer;
//#UC START# *4B6864970085_4B683B57028Dget_var*
//#UC END# *4B6864970085_4B683B57028Dget_var*
begin
//#UC START# *4B6864970085_4B683B57028Dget_impl*
  Result := f_Conversations.Count;
//#UC END# *4B6864970085_4B683B57028Dget_impl*
end;//TatChatWorker.pm_GetConversationsCount

function TatChatWorker.pm_GetUIDsWithUnreadedMessages: TatArrayOfUID;
//#UC START# *4B6BF44100E3_4B683B57028Dget_var*
  var
    i : Integer;
//#UC END# *4B6BF44100E3_4B683B57028Dget_var*
begin
//#UC START# *4B6BF44100E3_4B683B57028Dget_impl*
  f_UWUMCS.Enter;
  try
    SetLength(Result, f_UidsWithUnreadedMessages.Count);
    for i := Low(Result) to High(Result) do
      Result[i] := StrToInt(f_UidsWithUnreadedMessages.Strings[i]);
  finally
    f_UWUMCS.Leave;
  end;
//#UC END# *4B6BF44100E3_4B683B57028Dget_impl*
end;//TatChatWorker.pm_GetUIDsWithUnreadedMessages

function TatChatWorker.pm_GetConversationByIndex(anIndex: Integer): TatChatConversation;
//#UC START# *4B68676F0357_4B683B57028Dget_var*
//#UC END# *4B68676F0357_4B683B57028Dget_var*
begin
//#UC START# *4B68676F0357_4B683B57028Dget_impl*
  Result := TatChatConversation(f_Conversations.Objects[anIndex]);
//#UC END# *4B68676F0357_4B683B57028Dget_impl*
end;//TatChatWorker.pm_GetConversationByIndex

function TatChatWorker.pm_GetConversationByUID(anUID: TUid): TatChatConversation;
//#UC START# *4B6951380027_4B683B57028Dget_var*
  var
    l_Index : Integer;
//#UC END# *4B6951380027_4B683B57028Dget_var*
begin
//#UC START# *4B6951380027_4B683B57028Dget_impl*
  l_Index := f_Conversations.IndexOf(IntToStr(anUID));
  if (l_Index <> -1) then
    Result := ConversationByIndex[l_Index]
  else
    Result := nil
//#UC END# *4B6951380027_4B683B57028Dget_impl*
end;//TatChatWorker.pm_GetConversationByUID

constructor TatChatWorker.Create;
//#UC START# *4B6925110286_4B683B57028D_var*
//#UC END# *4B6925110286_4B683B57028D_var*
begin
//#UC START# *4B6925110286_4B683B57028D_impl*
  inherited Create();
  //
  f_Conversations := TStringList.Create;
  f_UidsWithUnreadedMessages := TStringList.Create;
  f_UWUMCS := TCriticalSection.Create;
  f_ChatManager := TatGblAdapterWorker.Instance.GblAdapterDll.MakeChatManager;
  Assert(f_ChatManager <> nil, 'f_ChatManager <> nil');
  f_ChatListener := TatChatListener.Make;
  f_NotifyCS := TCriticalSection.Create;
  //
  f_ReadSendCS := TCriticalSection.Create;
  //
  f_ChatListener.Attach(Self.OnChatNotification);
  ChatManager.RegisterListenerForNotify(f_ChatListener);
//#UC END# *4B6925110286_4B683B57028D_impl*
end;//TatChatWorker.Create

function TatChatWorker.StartConversation(anUserID: TUid): Boolean;
//#UC START# *4B69364B0327_4B683B57028D_var*
  var
    l_UnrIdx : Integer;
    l_UserInfo : TUserInfo;
//#UC END# *4B69364B0327_4B683B57028D_var*
begin
//#UC START# *4B69364B0327_4B683B57028D_impl*
  f_NotifyCS.Enter;
  try
    if ( ConversationByUID[anUserID] = nil ) then
    begin
      f_Conversations.AddObject(IntToStr(anUserID), TatChatConversation.Create(anUserID));
      //
      ChatManager.GetUserInfo(anUserID, l_UserInfo);
      Logger.Info(
        'Начали разговор с пользователем c логином "%s", именем "%s" и email "%s"',
        [ TatStringHelper.AStr2DStr(l_UserInfo.rLogin),
          TatStringHelper.AStr2DStr(l_UserInfo.rName),
          TatStringHelper.AStr2DStr(l_UserInfo.rEmail) ]
      );
      //
      f_UWUMCS.Enter;
      try
        l_UnrIdx := f_UidsWithUnreadedMessages.IndexOf(IntToStr(anUserID));
        if ( l_UnrIdx <> -1 ) then
          f_UidsWithUnreadedMessages.Delete(l_UnrIdx);
      finally
        f_UWUMCS.Leave;
      end;
      Result := true;
    end
    else
      Result := false;
  finally
    f_NotifyCS.Leave;
  end;
//#UC END# *4B69364B0327_4B683B57028D_impl*
end;//TatChatWorker.StartConversation

procedure TatChatWorker.FinishConversation(anUserID: TUid);
//#UC START# *4B6936590279_4B683B57028D_var*
  var
    l_Conversation : TatChatConversation;
    l_Index : Integer;
//#UC END# *4B6936590279_4B683B57028D_var*
begin
//#UC START# *4B6936590279_4B683B57028D_impl*
  f_NotifyCS.Enter;
  try
    l_Conversation := ConversationByUID[anUserID];
    if ( l_Conversation <> nil ) then
    begin
      l_Index := f_Conversations.IndexOfObject(l_Conversation);
      f_Conversations.Objects[l_Index].Free;
      f_Conversations.Delete(l_Index);
    end;
  finally
    f_NotifyCS.Leave;
  end;
//#UC END# *4B6936590279_4B683B57028D_impl*
end;//TatChatWorker.FinishConversation

procedure TatChatWorker.OnChatNotification(const aNotification: INotification);
//#UC START# *4B6938860170_4B683B57028D_var*
  var
    l_NotifyType : TNotifyType;
    l_Data : IVariant;
    l_UID : TUid;
    l_Conversation : TatChatConversation;
//#UC END# *4B6938860170_4B683B57028D_var*
begin
//#UC START# *4B6938860170_4B683B57028D_impl*
  f_NotifyCS.Enter;
  try
    l_NotifyType := aNotification.GetId;
    //
    Assert((l_NotifyType = NT_NEW_CHAT_MESSAGES_RECEIVED)
      or (l_NotifyType = NT_CHAT_CONTACT_ADDED)
      or (l_NotifyType = NT_CHAT_CONTACT_REMOVED),
      'Неизвестная нотификация');
    //
    case l_NotifyType of
      NT_CHAT_CONTACT_ADDED :
        Logger.Info('В контакт-лист добавился контакт');
      NT_CHAT_CONTACT_REMOVED :
        Logger.Info('Из контакт-листа удалился контакт');
      NT_NEW_CHAT_MESSAGES_RECEIVED :
        begin
          aNotification.GetData(l_Data);
          l_UID := l_Data.GetLong;
          //
          l_Conversation := ConversationByUID[l_UID];
          if (l_Conversation <> nil) then
            l_Conversation.OnNewMessageReceived()
          else
          begin
            f_UWUMCS.Enter;
            try
              if ( f_UidsWithUnreadedMessages.IndexOf(IntToStr(l_UID)) = -1 ) then
                f_UidsWithUnreadedMessages.Add(IntToStr(l_UID));
            finally
              f_UWUMCS.Leave;
            end;
            Logger.Info('Есть непрочитанные сообщения от пользователя с uid %d', [l_UID]);
          end;
        end;
    end; // case of
  finally
    f_NotifyCS.Leave;
  end;
//#UC END# *4B6938860170_4B683B57028D_impl*
end;//TatChatWorker.OnChatNotification

function TatChatWorker.GetContactListUIDs(isActiveOnly: Boolean = false;
  isAdapterTestsOnly: Boolean = false): TatArrayOfUID;
//#UC START# *4B7021A30255_4B683B57028D_var*
  var
    l_Node : INodeBase;
    l_Flags : Longword;
//#UC END# *4B7021A30255_4B683B57028D_var*
begin
//#UC START# *4B7021A30255_4B683B57028D_impl*
  ChatManager.GetContactsTree(l_Node);
  if (l_Node <> nil) then
  begin
    l_Flags := UFF_USER_NOT_SYSTEM or UFF_USER_NOT_CURRENT or UFF_CHAT_CONTACT_LIST_USERS;
    if (isActiveOnly) then
      l_Flags := l_Flags or UFF_USER_ACTIVE;
    l_Node := TatUserListHelper.GetFilteredUserTree(l_Node, l_Flags);
    if (l_Node <> nil) then
      if isAdapterTestsOnly then
        Result := TatUserListHelper.GetOnlyAdapterTestUIDs(l_Node)
      else
        Result := TatUserListHelper.UserTree2TatArrayOfUID(l_Node);
  end;
//#UC END# *4B7021A30255_4B683B57028D_impl*
end;//TatChatWorker.GetContactListUIDs

procedure TatChatWorker.AddUser(anUserID: TUid);
//#UC START# *4B7023B703C5_4B683B57028D_var*
//#UC END# *4B7023B703C5_4B683B57028D_var*
begin
//#UC START# *4B7023B703C5_4B683B57028D_impl*
  ChatManager.AddUser(anUserID);
//#UC END# *4B7023B703C5_4B683B57028D_impl*
end;//TatChatWorker.AddUser

procedure TatChatWorker.DeleteUser(anUserID: TUid);
//#UC START# *4B7023C7019B_4B683B57028D_var*
//#UC END# *4B7023C7019B_4B683B57028D_var*
begin
//#UC START# *4B7023C7019B_4B683B57028D_impl*
  ChatManager.DeleteUser(anUserID);
//#UC END# *4B7023C7019B_4B683B57028D_impl*
end;//TatChatWorker.DeleteUser

procedure TatChatWorker.Cleanup;
//#UC START# *479731C50290_4B683B57028D_var*
  var
    i : Integer;
//#UC END# *479731C50290_4B683B57028D_var*
begin
//#UC START# *479731C50290_4B683B57028D_impl*
  // выполняем сначала Detach чтобы гарантировать отсутствие вызова нотификаций
  f_ChatListener.Detach;
  f_ChatListener := nil;
  //
  for i := 0 to f_Conversations.Count-1 do
    f_Conversations.Objects[i].Free;
  FreeAndNil(f_Conversations);
  FreeAndNil(f_ReadSendCS);
  //
  FreeAndNil(f_UidsWithUnreadedMessages);
  FreeAndNil(f_UWUMCS);
  FreeAndNil(f_NotifyCS);
  f_ChatManager := nil;
  //
  inherited;
//#UC END# *479731C50290_4B683B57028D_impl*
end;//TatChatWorker.Cleanup

end.