unit ChatInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Chat"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Chat/ChatInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Встроенные продукты::Chat::Chat::ChatInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces,
  l3TreeInterfaces,
  ChatTypes,
  SysUtils
  ;

type
 InsChatMessage = interface(IUnknown)
   ['{795E7D5F-7571-4B33-992D-6720A0129530}']
   function Get_Title: IStream;
   function Get_Body: IStream;
   property Title: IStream
     read Get_Title;
   property Body: IStream
     read Get_Body;
 end;//InsChatMessage

 InsChatMessages = interface(IUnknown)
   ['{39935DF7-B2B9-45A2-BD4E-F5BE19488806}']
   function Get_MessagesCount: Integer;
   function Get_Message(anIndex: Integer): InsChatMessage;
   property MessagesCount: Integer
     read Get_MessagesCount;
   property Message[anIndex: Integer]: InsChatMessage
     read Get_Message;
 end;//InsChatMessages

 IbsAbstractChatWindow = interface(IUnknown)
   ['{2CEA751B-9081-4CFF-81D9-175E6ECF3BE5}']
   function Get_UserID: TbsUserID;
   procedure ActivateChatWindow;
   property UserID: TbsUserID
     read Get_UserID;
 end;//IbsAbstractChatWindow

 IbsChatWindow = interface(IbsAbstractChatWindow)
   ['{491B359B-0B9B-4C41-8CE8-E1F45F26003D}']
   procedure NewMessagesReceived;
   procedure HistoryCleaned;
 end;//IbsChatWindow

 IbsChatHistoryWindow = interface(IbsAbstractChatWindow)
   ['{A1DF16AD-AA8B-4783-9EF1-5F0FAB51B62E}']
 end;//IbsChatHistoryWindow

 IbsContactList = interface(IUnknown)
   ['{F1F0F5CE-0323-471A-8D8A-96888AB8208F}']
   procedure NotifyContactListChanged;
 end;//IbsContactList

 IbsChatDispatcher = interface(IUnknown)
   ['{FACFDBC2-7E48-4189-BC96-3BF0BF577378}']
   function Get_ChatSupported: Boolean;
   function Get_HasUnreadedMessages: Boolean;
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
   procedure OpenAllUnreaded;
   procedure OpenChatHistory(const aNode: Il3SimpleNode);
   procedure RegisterChatHistory(const aWindow: IbsChatHistoryWindow);
   procedure UnRegisterChatHistory(const aWindow: IbsChatHistoryWindow);
   procedure OpenChatHistoryByID(anUID: TbsUserID);
   procedure ClearHistory(anUID: TbsUserID);
   procedure ContactListChanged;
   procedure RegisterContactList(const aList: IbsContactList);
   procedure UnRegisterContactList(const aList: IbsContactList);
   property ChatSupported: Boolean
     read Get_ChatSupported;
   property HasUnreadedMessages: Boolean
     read Get_HasUnreadedMessages;
 end;//IbsChatDispatcher

 EnsUnknownChatUser = class(Exception)
 end;//EnsUnknownChatUser
{$IfEnd} //not Admin AND not Monitorings

implementation

end.