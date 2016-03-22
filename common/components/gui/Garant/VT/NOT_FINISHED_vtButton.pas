unit NOT_FINISHED_vtButton;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtButton.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtButton" MUID: (517941310082)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , eeButton
;

type
 _vtUnicodeButtonControl_Parent_ = TeeButton;
 {$Include w:\common\components\gui\Garant\VT\vtUnicodeButtonControl.imp.pas}
 TvtButton = class(_vtUnicodeButtonControl_)
 end;//TvtButton

implementation

uses
 l3ImplUses
;

{$Include w:\common\components\gui\Garant\VT\vtUnicodeButtonControl.imp.pas}

end.
