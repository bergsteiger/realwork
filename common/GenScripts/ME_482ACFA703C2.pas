unit elCustomButtonEdit;

interface

uses
 l3IntfUses
 , elCustomEdit
 , Classes
 , CustomElGraphicButton
 , Messages
 , l3Core
;

type
 TelCustomButtonEdit = class(TelCustomEdit)
  procedure AdjustWidth;
  procedure WMKeyDown(var Message: TWMKey);
  procedure CMEnabledChanged(var Msg: TMessage);
  procedure ButtonClickTransfer(Sender: TObject);
   {* TNotifyEvent. }
  procedure WMWindowPosChanged(var Message: TWMWindowPosChanged);
 end;//TelCustomButtonEdit
 
implementation

uses
 l3ImplUses
 , SysUtils
 , Windows
 , Forms
 , Graphics
 , afwFacade
 , TtfwClassRef_Proxy
;

type
 TElEditBtn = class(TCustomElGraphicButton)
 end;//TElEditBtn
 
end.
