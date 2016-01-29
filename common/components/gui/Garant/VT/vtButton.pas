unit vtButton;

interface

{$Include vtDefine.inc}

uses
 Windows,
 Messages,
 Classes,
 Controls,
 StdCtrls,
 eeButton;

type
 _UnicodeButtonControlParent_ = TeeButton;
 {$Include w:\common\components\gui\Garant\VT\vtUnicodeButtonControl.inc}
 TvtButton = class(_UnicodeButtonControl_)
 protected
  {$IfNDef XE}
  procedure CreateParams(var Params: TCreateParams); override;
  {$EndIf   XE}
 end;

implementation
uses
 Graphics,
 SysUtils,
 CommCtrl,
 Consts;

{ TvtButton }

{$Include w:\common\components\gui\Garant\VT\vtUnicodeButtonControl.inc}

{$IfNDef XE}
procedure TvtButton.CreateParams(var Params: TCreateParams);
const
 lc_ButtonStyles: array[Boolean] of DWORD = (BS_PUSHBUTTON, BS_DEFPUSHBUTTON);
begin
 inherited CreateParams(Params);
 CreateSubClass(Params, 'BUTTON');
 Params.Style := Params.Style or lc_ButtonStyles[Default];
end;
{$EndIf  XE}

end.