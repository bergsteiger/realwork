unit vcmGUI;
 {* Интерфейсы представления }

// Модуль: "w:\common\components\gui\Garant\VCM\vcmGUI.pas"
// Стереотип: "Interfaces"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
;

type
 PvcmMessageID = ^TvcmMessageID;

 TvcmMessageID = record
  rM: Integer;
 end;//TvcmMessageID

 IvcmUserInteraction = interface(IvcmBase)
  ['{7F0D0E1A-63B7-4AC9-8382-341711A72F7C}']
  function MessageDlg(const aMsg: Tl3MessageID;
   const aData: array of const): Integer; overload;
  function MessageDlg(const aMsg: Tl3MessageID): Integer; overload;
  function MessageDlg(const aMsg: IvcmCString;
   const aKey: AnsiString;
   aDlgType: TMsgDlgType = Dialogs.mtCustom;
   aButtons: TMsgDlgButtons = Dialogs.[mbOK]): Integer; overload;
  function MessageDlg(const aMsg: TvcmMessageID): Integer; overload;
  procedure Say(const aMsg: TvcmMessageID); overload;
  procedure Say(const aMsg: TvcmMessageID;
   const aData: array of const); overload;
  function Ask(const aMsg: TvcmMessageID): Boolean; overload;
  function Ask(const aMsg: TvcmMessageID;
   const aData: array of const): Boolean; overload;
  function Ask(const aMsg: Tl3MessageID;
   const aData: array of const): Boolean; overload;
 end;//IvcmUserInteraction
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
