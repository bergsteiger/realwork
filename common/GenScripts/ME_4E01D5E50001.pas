unit vcmUserInteractiveForm.imp;

interface

uses
 l3IntfUses
 , vcmGUI
 , vcmExternalInterfaces
 , Dialogs
 , l3MessageID
;

type
 _vcmUserInteractiveForm_ = class(IvcmUserInteraction)
  function MessageDlg(const aMsg: IvcmCString;
   const aKey: AnsiString;
   aDlgType: TMsgDlgType;
   aButtons: TMsgDlgButtons): Integer; overload;
  function MessageDlg(const aMsg: TvcmMessageID): Integer; overload;
  procedure Say(const aMsg: TvcmMessageID); overload;
  procedure Say(const aMsg: TvcmMessageID;
   const aData: array of const); overload;
  function Ask(const aMsg: TvcmMessageID): Boolean; overload;
  function Ask(const aMsg: TvcmMessageID;
   const aData: array of const): Boolean; overload;
  function Ask(const aMsg: Tl3MessageID;
   const aData: array of const): Boolean; overload;
  function MessageDlg(const aMsg: Tl3MessageID;
   const aData: array of const): Integer; overload;
  function MessageDlg(const aMsg: Tl3MessageID): Integer; overload;
 end;//_vcmUserInteractiveForm_
 
implementation

uses
 l3ImplUses
 , vcmDialogs
 , vcmMessagesSupport
;

end.
