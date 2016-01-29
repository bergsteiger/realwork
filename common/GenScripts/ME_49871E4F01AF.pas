unit nscStatusBarOperationDef;

interface

uses
 l3IntfUses
 , nscStatusBarItemDef
 , nscNewInterfaces
 , vcmExternalInterfaces
 , l3Interfaces
 , vcmInterfaces
;

type
 TnscStatusBarOperationDef = class(TnscStatusBarItemDef, InscStatusBarOperationDef)
  procedure Create(const anOperation: TvcmOpSelector;
   aShowCaption: Boolean;
   const aCaption: Il3CString;
   aUseToolTip: Boolean;
   aRequireAutoPopup: Boolean;
   anAutoPopupTimeout: Cardinal;
   aToolTipKind: TnscToolTipKind);
  procedure Make(const anOperation: TvcmOpSelector;
   aShowCaption: Boolean;
   const aCaption: Il3CString;
   aUseToolTip: Boolean;
   aRequireAutoPopup: Boolean;
   anAutoPopupTimeout: Cardinal;
   aToolTipKind: TnscToolTipKind);
  function MakeS(const anOperation: TvcmOPID;
   aShowCaption: Boolean;
   const aCaption: TvcmStringID;
   aUseToolTip: Boolean;
   aRequireAutoPopup: Boolean;
   anAutoPopupTimeout: Cardinal;
   aToolTipKind: TnscToolTipKind): InscStatusBarOperationDef;
  function MakeSDefaultCaption(const anOperation: TvcmOPID;
   aUseToolTip: Boolean;
   aRequireAutoPopup: Boolean;
   anAutoPopupTimeout: Cardinal;
   aToolTipKind: TnscToolTipKind): InscStatusBarOperationDef;
  function MakeSNoCaption(const anOperation: TvcmOPID;
   aUseToolTip: Boolean;
   aRequireAutoPopup: Boolean;
   anAutoPopupTimeout: Cardinal;
   aToolTipKind: TnscToolTipKind): InscStatusBarOperationDef;
  function Operation: TvcmOpSelector;
 end;//TnscStatusBarOperationDef
 
implementation

uses
 l3ImplUses
 , vcmBase
;

end.
