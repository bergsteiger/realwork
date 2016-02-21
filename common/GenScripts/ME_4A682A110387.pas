unit bsChatDispatcherPrim;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Chat\bsChatDispatcherPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3SimpleObject
 , ChatInterfaces
 , nsChatWindowList
 , nsUserIDList
 , nsChatHistoryList
 , nsContactListNotifiers
 , l3Interfaces
 , ChatTypes
 , l3TreeInterfaces
 , nsCounterEvent
 , LoggingUnit
;

type
 TnsChatWindowOpensCountEvent = class(TnsCounterEvent)
  protected
   function EventID: TLogEvent; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TnsChatWindowOpensCountEvent;
    {* Метод получения экземпляра синглетона TnsChatWindowOpensCountEvent }
 end;//TnsChatWindowOpensCountEvent

 TbsChatDispatcherPrim = class(Tl3SimpleObject, IbsChatDispatcher)
  private
   f_Processing: Boolean;
   f_ChatList: TnsChatWindowList;
   f_Unreaded: TnsUserIDList;
   f_HistoryList: TnsChatHistoryList;
   f_ContactLists: TnsContactListNotifiers;
  private
   procedure DoOpenChatWindow(anUID: TbsUserID);
   function MakeTitle(anUID: TbsUserID;
    aDate: TDateTime): IStream;
   function GetUserID(const aNode: Il3SimpleNode): TbsUserID;
  protected
   function Get_ChatSupported: Boolean;
   function MakeContactList(ForAdd: Boolean): Il3SimpleTree;
   procedure OpenChatWindow(const aNode: Il3SimpleNode);
   function GetContactType(const aNode: Il3SimpleNode): TnsContactType;
   function SendMessage(Recip: TbsUserID;
    const aMessage: IStream): InsChatMessage;
   function GetMessages(anUID: TbsUserID;
    MinCount: Integer): InsChatMessages;
   procedure StartProcessing;
   procedure MessagesReceived(anUID: TbsUserID);
   procedure AddUser(const aNode: Il3SimpleNode);
   procedure DeleteUser(const aNode: Il3SimpleNode);
   procedure ShowAddUserDialog;
   procedure RegisterChatWindow(const aWindow: IbsChatWindow);
   procedure UnRegisterChatWindow(const aWindow: IbsChatWindow);
   function Get_HasUnreadedMessages: Boolean;
   procedure OpenAllUnreaded;
   procedure OpenChatHistory(const aNode: Il3SimpleNode);
   procedure RegisterChatHistory(const aWindow: IbsChatHistoryWindow);
   procedure UnRegisterChatHistory(const aWindow: IbsChatHistoryWindow);
   procedure OpenChatHistoryByID(anUID: TbsUserID);
   procedure ClearHistory(anUID: TbsUserID);
   procedure ContactListChanged;
   procedure RegisterContactList(const aList: IbsContactList);
   procedure UnRegisterContactList(const aList: IbsContactList);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   class function Make: IbsChatDispatcher; reintroduce;
 end;//TbsChatDispatcherPrim
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , ComObj
 , ChatInterfacesUnit
 , DataAdapter
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsChatTreeStruct
 , l3Memory
 , nsChatMessages
 , nsChatMessage
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , nsConst
 , nsTypes
 , SecurityUnit
 , DynamicTreeUnit
 , l3Types
 , l3String
 , nsNotifiers
 , afwFacade
 , evdStyles
 , l3Base
;

var g_TnsChatWindowOpensCountEvent: TnsChatWindowOpensCountEvent = nil;
 {* Экземпляр синглетона TnsChatWindowOpensCountEvent }

procedure TnsChatWindowOpensCountEventFree;
 {* Метод освобождения экземпляра синглетона TnsChatWindowOpensCountEvent }
begin
 l3Free(g_TnsChatWindowOpensCountEvent);
end;//TnsChatWindowOpensCountEventFree

class function TnsChatWindowOpensCountEvent.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsChatWindowOpensCountEvent <> nil;
end;//TnsChatWindowOpensCountEvent.Exists

function TnsChatWindowOpensCountEvent.EventID: TLogEvent;
//#UC START# *4B13A26203DB_4B13BC920384_var*
//#UC END# *4B13A26203DB_4B13BC920384_var*
begin
//#UC START# *4B13A26203DB_4B13BC920384_impl*
 Result := LE_CHAT_WINDOW_OPENS_COUNT;
//#UC END# *4B13A26203DB_4B13BC920384_impl*
end;//TnsChatWindowOpensCountEvent.EventID

class function TnsChatWindowOpensCountEvent.Instance: TnsChatWindowOpensCountEvent;
 {* Метод получения экземпляра синглетона TnsChatWindowOpensCountEvent }
begin
 if (g_TnsChatWindowOpensCountEvent = nil) then
 begin
  l3System.AddExitProc(TnsChatWindowOpensCountEventFree);
  g_TnsChatWindowOpensCountEvent := Create;
 end;
 Result := g_TnsChatWindowOpensCountEvent;
end;//TnsChatWindowOpensCountEvent.Instance

procedure TbsChatDispatcherPrim.DoOpenChatWindow(anUID: TbsUserID);
//#UC START# *4A682A8303CA_4A682A110387_var*
var
 l_UserInfo: TUserInfo;
 l_Name: Il3CString;
//#UC END# *4A682A8303CA_4A682A110387_var*
begin
//#UC START# *4A682A8303CA_4A682A110387_impl*
 try
  defDataAdapter.ChatManager.GetUserInfo(anUID, l_UserInfo);
  l_Name := vcmFmt(nsCStr('%s (%s)'), [nsCStr(l_UserInfo.rName), nsCStr(l_UserInfo.rLogin)]);
 except
  on EUnknownUser do
  begin
   l_Name := nil;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=305957894
   ClearHistory(anUID); // пользователя нет, его история не нужна
  end;
 end;
 TdmStdRes.OpenChatWindow(anUID, l_Name);
 f_Unreaded.Remove(anUID);
//#UC END# *4A682A8303CA_4A682A110387_impl*
end;//TbsChatDispatcherPrim.DoOpenChatWindow

class function TbsChatDispatcherPrim.Make: IbsChatDispatcher;
var
 l_Inst : TbsChatDispatcherPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TbsChatDispatcherPrim.Make

function TbsChatDispatcherPrim.MakeTitle(anUID: TbsUserID;
 aDate: TDateTime): IStream;
//#UC START# *4A685BF20264_4A682A110387_var*
var
 l_UserInfo: TUserInfo;
 l_Name: Il3CString;
const
 c_StyleMap: array [Boolean] of Integer = (ev_saChatHeaderRecipient, ev_saChatHeaderSender);
//#UC END# *4A685BF20264_4A682A110387_var*
begin
//#UC START# *4A685BF20264_4A682A110387_impl*
 defDataAdapter.ChatManager.GetUserInfo(anUID, l_UserInfo);
 l_Name := vcmFmt(str_ChatTitle, [c_StyleMap[defDataAdapter.CurrentUserID = anUID], nsCStr(l_UserInfo.rName),
  nsCStr(l_UserInfo.rLogin), nsCStr(FormatDateTime('hh:nn, dd/mm/yyyy', aDate))]);
 Result := Tl3StringStream.Make(l3PCharLen(l_Name));
//#UC END# *4A685BF20264_4A682A110387_impl*
end;//TbsChatDispatcherPrim.MakeTitle

function TbsChatDispatcherPrim.GetUserID(const aNode: Il3SimpleNode): TbsUserID;
//#UC START# *4A69A53F0275_4A682A110387_var*
var
 l_Node: IProfileNode;
//#UC END# *4A69A53F0275_4A682A110387_var*
begin
//#UC START# *4A69A53F0275_4A682A110387_impl*
 if Supports(aNode, IProfileNode, l_Node) then
  Result := l_Node.GetUid
 else
  Result := cBadUID;
//#UC END# *4A69A53F0275_4A682A110387_impl*
end;//TbsChatDispatcherPrim.GetUserID

function TbsChatDispatcherPrim.Get_ChatSupported: Boolean;
//#UC START# *4A66DF0603DC_4A682A110387get_var*
//#UC END# *4A66DF0603DC_4A682A110387get_var*
begin
//#UC START# *4A66DF0603DC_4A682A110387get_impl*
 Result := defDataAdapter.ChatManager.IsEmbedChatEnabled;
//#UC END# *4A66DF0603DC_4A682A110387get_impl*
end;//TbsChatDispatcherPrim.Get_ChatSupported

function TbsChatDispatcherPrim.MakeContactList(ForAdd: Boolean): Il3SimpleTree;
//#UC START# *4A66DF2101AE_4A682A110387_var*
//#UC END# *4A66DF2101AE_4A682A110387_var*
begin
//#UC START# *4A66DF2101AE_4A682A110387_impl*
 if Get_ChatSupported then
  Result := TnsChatTreeStruct.Make(ForAdd)
 else
  Result := nil;
//#UC END# *4A66DF2101AE_4A682A110387_impl*
end;//TbsChatDispatcherPrim.MakeContactList

procedure TbsChatDispatcherPrim.OpenChatWindow(const aNode: Il3SimpleNode);
//#UC START# *4A66DF2D03BC_4A682A110387_var*
var
 l_Window: IbsChatWindow;
 l_UID: TbsUserID;
//#UC END# *4A66DF2D03BC_4A682A110387_var*
begin
//#UC START# *4A66DF2D03BC_4A682A110387_impl*
 if Assigned(aNode) then
 begin
  l_UID := GetUserID(aNode);
  l_Window := f_ChatList.FindChatWindow(l_UID);
  if Assigned(l_Window) then
   l_Window.ActivateChatWindow
  else
   DoOpenChatWindow(l_UID);
 end;
//#UC END# *4A66DF2D03BC_4A682A110387_impl*
end;//TbsChatDispatcherPrim.OpenChatWindow

function TbsChatDispatcherPrim.GetContactType(const aNode: Il3SimpleNode): TnsContactType;
//#UC START# *4A66DF3E0086_4A682A110387_var*
var
 l_Node: INodeBase;
 l_Type: TNodeType;
//#UC END# *4A66DF3E0086_4A682A110387_var*
begin
//#UC START# *4A66DF3E0086_4A682A110387_impl*
 if Supports(aNode, INodeBase, l_Node) then
 begin
  l_Type := l_Node.GetType;
  if (l_Type and PNT_LOGGED_FLAG) <> 0 then
   Result := ctActive
  else
   Result := ctInActive;
 end
 else
  Result := ctActive;
//#UC END# *4A66DF3E0086_4A682A110387_impl*
end;//TbsChatDispatcherPrim.GetContactType

function TbsChatDispatcherPrim.SendMessage(Recip: TbsUserID;
 const aMessage: IStream): InsChatMessage;
//#UC START# *4A66DF64023C_4A682A110387_var*
var
 l_Memory: Tl3MemoryStream;
 l_Size: Int64;
 l_Fake: Int64;
 l_Fake2: Int64;
//#UC END# *4A66DF64023C_4A682A110387_var*
begin
//#UC START# *4A66DF64023C_4A682A110387_impl*
 l_Memory := Tl3MemoryStream.Make;
 try
  OleCheck(aMessage.Seek(0, STREAM_SEEK_END, l_Fake));
  OleCheck(aMessage.Seek(0, STREAM_SEEK_CUR, l_Size));
  OleCheck(aMessage.Seek(0, STREAM_SEEK_SET, l_Fake));
  OleCheck(aMessage.CopyTo(l_Memory, l_Size, l_Fake, l_Fake2));
  OleCheck(aMessage.Seek(0, STREAM_SEEK_SET, l_Fake));
  Result := TnsChatMessage.Make(MakeTitle(defDataAdapter.CurrentUserID, Now), l_Memory);
 finally
  FreeAndNil(l_Memory);
 end;
 try
  defDataAdapter.MessagesManager.SendMessage(aMessage, Recip);
 except
  on EUnknownUser do
   raise EnsUnknownChatUser.Create('');
 end;
//#UC END# *4A66DF64023C_4A682A110387_impl*
end;//TbsChatDispatcherPrim.SendMessage

function TbsChatDispatcherPrim.GetMessages(anUID: TbsUserID;
 MinCount: Integer): InsChatMessages;
//#UC START# *4A66DF74032C_4A682A110387_var*
var
 l_Inst: TnsChatMessages;
 l_Messages: IMessages;
 l_Message: TMessage;
 l_IDX: Integer;
 l_UID: TbsUserID;
 l_Date: System.TDateTime;
//#UC END# *4A66DF74032C_4A682A110387_var*
begin
//#UC START# *4A66DF74032C_4A682A110387_impl*
 l_Inst := TnsChatMessages.Create;
 try
  try
   if MinCount = -1 then
    defDataAdapter.MessagesManager.GetUnreadedMessages(anUID, l_Messages)
   else
    defDataAdapter.MessagesManager.GetHistoryForUser(MinCount, True, anUID, l_Messages);
  except
   on EUnknownUser do
   begin
    Result := nil;
    Exit;
   end;
  end;
  if Assigned(l_Messages) then
   for l_IDX := 0 to l_Messages.Count - 1 do
   begin
    l_Messages.pm_GetItem(l_IDX, l_Message);
    with l_Message.rTime do
     l_Date := EncodeDate(rDate.rYear, rDate.rMonth, rDate.rDay) +
      EncodeTime(rTime.rHour, rTime.rMin, rTime.rSec, 0);
    if l_Message.rMy then
     l_UID := defDataAdapter.CurrentUserID
    else
     l_UID := anUID;
    l_Inst.Add(TnsChatMessage.Make(MakeTitle(l_UID, l_Date), l_Message.rText));
   end;
  Result := l_Inst;
 finally
  FreeAndNil(l_Inst);
 end;
//#UC END# *4A66DF74032C_4A682A110387_impl*
end;//TbsChatDispatcherPrim.GetMessages

procedure TbsChatDispatcherPrim.StartProcessing;
//#UC START# *4A66DF820028_4A682A110387_var*
var
 l_Notiffier: TnsChatNotifier;
//#UC END# *4A66DF820028_4A682A110387_var*
begin
//#UC START# *4A66DF820028_4A682A110387_impl*
 if Get_ChatSupported and not f_Processing then
 begin
  f_Processing := True;
  l_Notiffier := TnsChatNotifier.Create;
  try
   defDataAdapter.ChatManager.RegisterListenerForNotify(l_Notiffier);
  finally
   FreeAndNil(l_Notiffier); 
  end;
 end;
//#UC END# *4A66DF820028_4A682A110387_impl*
end;//TbsChatDispatcherPrim.StartProcessing

procedure TbsChatDispatcherPrim.MessagesReceived(anUID: TbsUserID);
//#UC START# *4A66DF8F036E_4A682A110387_var*
var
 l_Window: IbsChatWindow;
//#UC END# *4A66DF8F036E_4A682A110387_var*
begin
//#UC START# *4A66DF8F036E_4A682A110387_impl*
 l_Window := f_ChatList.FindChatWindow(anUID);
 if Assigned(l_Window) then
  l_Window.NewMessagesReceived
 else
 begin
  if afw.Settings.LoadBoolean(pi_NotifyNewChatMesages, dv_NotifyNewChatMesages) then
   f_Unreaded.Add(anUID)
  else
   DoOpenChatWindow(anUID);
 end;
//#UC END# *4A66DF8F036E_4A682A110387_impl*
end;//TbsChatDispatcherPrim.MessagesReceived

procedure TbsChatDispatcherPrim.AddUser(const aNode: Il3SimpleNode);
//#UC START# *4A69981E0203_4A682A110387_var*
//#UC END# *4A69981E0203_4A682A110387_var*
begin
//#UC START# *4A69981E0203_4A682A110387_impl*
 defDataAdapter.ChatManager.AddUser(GetUserID(aNode));
//#UC END# *4A69981E0203_4A682A110387_impl*
end;//TbsChatDispatcherPrim.AddUser

procedure TbsChatDispatcherPrim.DeleteUser(const aNode: Il3SimpleNode);
//#UC START# *4A6998430245_4A682A110387_var*
//#UC END# *4A6998430245_4A682A110387_var*
begin
//#UC START# *4A6998430245_4A682A110387_impl*
 defDataAdapter.ChatManager.DeleteUser(GetUserID(aNode));
//#UC END# *4A6998430245_4A682A110387_impl*
end;//TbsChatDispatcherPrim.DeleteUser

procedure TbsChatDispatcherPrim.ShowAddUserDialog;
//#UC START# *4A69985B00A8_4A682A110387_var*
//#UC END# *4A69985B00A8_4A682A110387_var*
begin
//#UC START# *4A69985B00A8_4A682A110387_impl*
 TdmStdRes.OpenAddUserDialog;
//#UC END# *4A69985B00A8_4A682A110387_impl*
end;//TbsChatDispatcherPrim.ShowAddUserDialog

procedure TbsChatDispatcherPrim.RegisterChatWindow(const aWindow: IbsChatWindow);
//#UC START# *4A6D7187013A_4A682A110387_var*
//#UC END# *4A6D7187013A_4A682A110387_var*
begin
//#UC START# *4A6D7187013A_4A682A110387_impl*
 f_ChatList.Add(aWindow);
 TnsChatWindowOpensCountEvent.Instance.Log;
//#UC END# *4A6D7187013A_4A682A110387_impl*
end;//TbsChatDispatcherPrim.RegisterChatWindow

procedure TbsChatDispatcherPrim.UnRegisterChatWindow(const aWindow: IbsChatWindow);
//#UC START# *4A6D71A600F9_4A682A110387_var*
//#UC END# *4A6D71A600F9_4A682A110387_var*
begin
//#UC START# *4A6D71A600F9_4A682A110387_impl*
 f_ChatList.Remove(aWindow);
//#UC END# *4A6D71A600F9_4A682A110387_impl*
end;//TbsChatDispatcherPrim.UnRegisterChatWindow

function TbsChatDispatcherPrim.Get_HasUnreadedMessages: Boolean;
//#UC START# *4A6D94A501CE_4A682A110387get_var*
//#UC END# *4A6D94A501CE_4A682A110387get_var*
begin
//#UC START# *4A6D94A501CE_4A682A110387get_impl*
 Result := f_Unreaded.Count > 0;
//#UC END# *4A6D94A501CE_4A682A110387get_impl*
end;//TbsChatDispatcherPrim.Get_HasUnreadedMessages

procedure TbsChatDispatcherPrim.OpenAllUnreaded;
//#UC START# *4A6D988D034B_4A682A110387_var*
var
 l_IDX: Integer;
//#UC END# *4A6D988D034B_4A682A110387_var*
begin
//#UC START# *4A6D988D034B_4A682A110387_impl*
 for l_IDX := f_Unreaded.Count - 1 downto 0 do
  DoOpenChatWindow(f_Unreaded.Items[l_IDX]);
//#UC END# *4A6D988D034B_4A682A110387_impl*
end;//TbsChatDispatcherPrim.OpenAllUnreaded

procedure TbsChatDispatcherPrim.OpenChatHistory(const aNode: Il3SimpleNode);
//#UC START# *4A6EAC57017D_4A682A110387_var*
var
 l_Window: IbsChatHistoryWindow;
 l_UID: TbsUserID;
//#UC END# *4A6EAC57017D_4A682A110387_var*
begin
//#UC START# *4A6EAC57017D_4A682A110387_impl*
 if Assigned(aNode) then
 begin
  l_UID := GetUserID(aNode);
  l_Window := f_HistoryList.FindChatWindow(l_UID);
  if Assigned(l_Window) then
   l_Window.ActivateChatWindow
  else
   OpenChatHistoryByID(l_UID);
 end;
//#UC END# *4A6EAC57017D_4A682A110387_impl*
end;//TbsChatDispatcherPrim.OpenChatHistory

procedure TbsChatDispatcherPrim.RegisterChatHistory(const aWindow: IbsChatHistoryWindow);
//#UC START# *4A6EAC6C0043_4A682A110387_var*
//#UC END# *4A6EAC6C0043_4A682A110387_var*
begin
//#UC START# *4A6EAC6C0043_4A682A110387_impl*
 f_HistoryList.Add(aWindow);
//#UC END# *4A6EAC6C0043_4A682A110387_impl*
end;//TbsChatDispatcherPrim.RegisterChatHistory

procedure TbsChatDispatcherPrim.UnRegisterChatHistory(const aWindow: IbsChatHistoryWindow);
//#UC START# *4A6EAC80032F_4A682A110387_var*
//#UC END# *4A6EAC80032F_4A682A110387_var*
begin
//#UC START# *4A6EAC80032F_4A682A110387_impl*
 f_HistoryList.Remove(aWindow);
//#UC END# *4A6EAC80032F_4A682A110387_impl*
end;//TbsChatDispatcherPrim.UnRegisterChatHistory

procedure TbsChatDispatcherPrim.OpenChatHistoryByID(anUID: TbsUserID);
//#UC START# *4A6EBE8E030F_4A682A110387_var*
var
 l_UserInfo: TUserInfo;
 l_Name: Il3CString;
 l_Window: IbsChatHistoryWindow;
//#UC END# *4A6EBE8E030F_4A682A110387_var*
begin
//#UC START# *4A6EBE8E030F_4A682A110387_impl*
 l_Window := f_HistoryList.FindChatWindow(anUID);
 if Assigned(l_Window) then
 begin
  l_Window.ActivateChatWindow;
  Exit;
 end;
 try
  defDataAdapter.ChatManager.GetUserInfo(anUID, l_UserInfo);
  l_Name := vcmFmt(nsCStr('%s (%s)'), [nsCStr(l_UserInfo.rName), nsCStr(l_UserInfo.rLogin)]);
 except
  on EUnknownUser do
   l_Name := nil;
 end;
 TdmStdRes.OpenHistoryWindow(anUID, l_Name);
 f_Unreaded.Remove(anUID);
//#UC END# *4A6EBE8E030F_4A682A110387_impl*
end;//TbsChatDispatcherPrim.OpenChatHistoryByID

procedure TbsChatDispatcherPrim.ClearHistory(anUID: TbsUserID);
//#UC START# *4A6FFBF30190_4A682A110387_var*
var
 l_Window: IbsChatWindow;
//#UC END# *4A6FFBF30190_4A682A110387_var*
begin
//#UC START# *4A6FFBF30190_4A682A110387_impl*
 defDataAdapter.MessagesManager.CleanHistory(anUID);
 l_Window := f_ChatList.FindChatWindow(anUID);
 if Assigned(l_Window) then
  l_Window.HistoryCleaned;
//#UC END# *4A6FFBF30190_4A682A110387_impl*
end;//TbsChatDispatcherPrim.ClearHistory

procedure TbsChatDispatcherPrim.ContactListChanged;
//#UC START# *4A728A25029E_4A682A110387_var*
var
 l_IDX: Integer;
//#UC END# *4A728A25029E_4A682A110387_var*
begin
//#UC START# *4A728A25029E_4A682A110387_impl*
 for l_IDX := 0 to f_ContactLists.Count - 1 do
  f_ContactLists.Items[l_IDX].NotifyContactListChanged;
//#UC END# *4A728A25029E_4A682A110387_impl*
end;//TbsChatDispatcherPrim.ContactListChanged

procedure TbsChatDispatcherPrim.RegisterContactList(const aList: IbsContactList);
//#UC START# *4A728A620307_4A682A110387_var*
//#UC END# *4A728A620307_4A682A110387_var*
begin
//#UC START# *4A728A620307_4A682A110387_impl*
 f_ContactLists.Add(aList);
//#UC END# *4A728A620307_4A682A110387_impl*
end;//TbsChatDispatcherPrim.RegisterContactList

procedure TbsChatDispatcherPrim.UnRegisterContactList(const aList: IbsContactList);
//#UC START# *4A728A7D031A_4A682A110387_var*
//#UC END# *4A728A7D031A_4A682A110387_var*
begin
//#UC START# *4A728A7D031A_4A682A110387_impl*
 f_ContactLists.Remove(aList);
//#UC END# *4A728A7D031A_4A682A110387_impl*
end;//TbsChatDispatcherPrim.UnRegisterContactList

procedure TbsChatDispatcherPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A682A110387_var*
//#UC END# *479731C50290_4A682A110387_var*
begin
//#UC START# *479731C50290_4A682A110387_impl*
 FreeAndNil(f_ChatList);
 FreeAndNil(f_Unreaded);
 FreeAndNil(f_HistoryList);
 FreeAndNil(f_ContactLists);
 inherited Cleanup;
//#UC END# *479731C50290_4A682A110387_impl*
end;//TbsChatDispatcherPrim.Cleanup

procedure TbsChatDispatcherPrim.InitFields;
//#UC START# *47A042E100E2_4A682A110387_var*
//#UC END# *47A042E100E2_4A682A110387_var*
begin
//#UC START# *47A042E100E2_4A682A110387_impl*
 inherited InitFields;
 f_ChatList := TnsChatWindowList.MakeSorted;
 f_Unreaded := TnsUserIDList.MakeSorted;
 f_HistoryList := TnsChatHistoryList.MakeSorted;
 f_ContactLists := TnsContactListNotifiers.MakeSorted;
//#UC END# *47A042E100E2_4A682A110387_impl*
end;//TbsChatDispatcherPrim.InitFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
