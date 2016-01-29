unit nscStatusBarItemDef;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , nscNewInterfaces
 , l3Interfaces
 , nscStatusBarOperationDefsList
;

type
 TnscStatusBarItemDef = class(Tl3CacheableBase, InscStatusBarItemDef)
  procedure Create(aShowCaption: Boolean;
   const aCaption: Il3CString;
   aUseTooltip: Boolean;
   aRequireAutoPopup: Boolean;
   anAutoPopupTimeout: Cardinal;
   aToolTipKind: TnscToolTipKind);
  procedure Make(aShowCaption: Boolean;
   const aCaption: Il3CString;
   aUseTooltip: Boolean;
   aRequireAutoPopup: Boolean;
   anAutoPopupTimeout: Cardinal;
   aToolTipKind: TnscToolTipKind);
  function Caption: Il3CString;
  function UseToolTip: Boolean;
  function RequireAutoPopup: Boolean;
  function AutoPopupTimeout: Cardinal;
  function TootTipKind: TnscToolTipKind;
  function ShowCaption: Boolean;
  function Enabled: Boolean;
  function SubscribedList: InscStatusBarItemDefsList;
  procedure SubscribeOnNotification(const aServer: InscStatusBarItemDef);
 end;//TnscStatusBarItemDef
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
