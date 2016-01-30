unit NOT_FINISHED_vtButton;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtButton.pas"
// Стереотип: "GuiControl"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
 , eeButton
;

type
 _vtUnicodeButtonControl_Parent_ = TeeButton;
 {$Include vtUnicodeButtonControl.imp.pas}
 TvtButton = class(_vtUnicodeButtonControl_)
 end;//TvtButton

implementation

uses
 l3ImplUses
;

{$Include vtUnicodeButtonControl.imp.pas}

end.
