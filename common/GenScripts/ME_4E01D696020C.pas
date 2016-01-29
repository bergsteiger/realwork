unit vcmMessagesSupport;

interface

uses
 l3IntfUses
 , l3StringIDEx
 , Dialogs
 , l3MessageID
 , Pl3StringIDExList
 , evCustomEditorWindow
 , vcmGUI
 , vcmMessagesCollectionItem
 , l3Interfaces
 , SysUtils
 , l3ProtoObject
 , l3HugeMessageDlgWithWikiHelper
 , afwInterfaces
 , afwNavigation
;

type
 EvcmDialogHasChoices = class(Exception)
 end;//EvcmDialogHasChoices
 
 EvcmInvalidWaitedButton = class(Exception)
 end;//EvcmInvalidWaitedButton
 
 EvcmUnwaitedDialog = class(Exception)
 end;//EvcmUnwaitedDialog
 
 TvcmHugeMessageDlgWithWikiImpl = class(Tl3ProtoObject, Il3HugeMessageDlgWithWikiHelper)
  function OnJumpTo(Sender: TObject;
   anEffects: TafwJumpToEffects;
   const aMoniker: IevMoniker): Boolean;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure Say(const aText: AnsiString;
   aClickCallback: Tl3WikiLinkClicked);
  function FormatCloak(const aCaption: AnsiString;
   const aText: AnsiString): AnsiString;
  function FormatLink(const aLinkText: AnsiString;
   const aLinkData: AnsiString): AnsiString;
  function CanUseWiki: Boolean;
 end;//TvcmHugeMessageDlgWithWikiImpl
 
implementation

uses
 l3ImplUses
 , vcmMessageQueue
 , vcmDialogs
 , l3BatchService
 , vcmInterfaces
 , Forms
 , vcmBase
 , l3VCLFormPtrList
 , l3String
 , Controls
 , vtDialogsResEx
 , vcmBaseMenuManager
 , vcmSettings
 , l3Bits
 , Classes
 , afwAnswer
 , l3Base
 , vcmMessageQueuePrim
;

end.
