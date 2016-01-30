unit afwVCL;

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\Visual\afwVCL.pas"
// Стереотип: "UtilityPack"

{$Include afwDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , afwFont
 , Graphics
 , Classes
;

procedure afwHackControlFont(aControl: TControl;
 aFont: RafwFont = nil);
procedure afwHackFont(var aFont: TFont;
 aNewFont: RafwFont = nil);
procedure afwSetBoundsWin2kFix(aControl: TWinControl;
 aLeft: Integer;
 aTop: Integer;
 aWidth: integer;
 aHeight: Integer);

implementation

uses
 l3ImplUses
 , SysUtils
 , Windows
 , Messages
;

type
 TafwHackControl = class(TComponent)
  private
   FParent: TWinControl;
   FWindowProc: TWndMethod;
   FLeft: Integer;
   FTop: Integer;
   FWidth: Integer;
   FHeight: Integer;
   FControlStyle: TControlStyle;
   FControlState: TControlState;
   FDesktopFont: Boolean;
   FVisible: Boolean;
   FEnabled: Boolean;
   FParentFont: Boolean;
   FParentColor: Boolean;
   FAlign: TAlign;
   FAutoSize: Boolean;
   FDragMode: TDragMode;
   FIsControl: Boolean;
   FBiDiMode: TBiDiMode;
   FParentBiDiMode: Boolean;
   FAnchors: TAnchors;
   FAnchorMove: Boolean;
   FText: PAnsiChar;
   FFont: TFont;
 end;//TafwHackControl

procedure afwHackControlFont(aControl: TControl;
 aFont: RafwFont = nil);
//#UC START# *47E122A2014B_47E1227902E1_var*
//#UC END# *47E122A2014B_47E1227902E1_var*
begin
//#UC START# *47E122A2014B_47E1227902E1_impl*
 {$IfDef l3HackedVCL}
 TafwHackControl(aControl).FParentFont := false;
 // - чтобы родительский умолчательный шрифт не забил наш
 afwHackFont(TafwHackControl(aControl).FFont, aFont);
 {$EndIf l3HackedVCL}
//#UC END# *47E122A2014B_47E1227902E1_impl*
end;//afwHackControlFont

procedure afwHackFont(var aFont: TFont;
 aNewFont: RafwFont = nil);
//#UC START# *47E122B30072_47E1227902E1_var*
var
 l_OC : TNotifyEvent;
//#UC END# *47E122B30072_47E1227902E1_var*
begin
//#UC START# *47E122B30072_47E1227902E1_impl*
 if (aNewFont = nil) then
  aNewFont := TafwFont;
 Assert(aFont <> nil); 
 l_OC := aFont.OnChange;
 FreeAndNil(aFont);
 aFont := aNewFont.Create;
 aFont.OnChange := l_OC;
//#UC END# *47E122B30072_47E1227902E1_impl*
end;//afwHackFont

procedure afwSetBoundsWin2kFix(aControl: TWinControl;
 aLeft: Integer;
 aTop: Integer;
 aWidth: integer;
 aHeight: Integer);
//#UC START# *4B9F9A9603C4_47E1227902E1_var*
var
 l_Pos: TWindowPos;
//#UC END# *4B9F9A9603C4_47E1227902E1_var*
begin
//#UC START# *4B9F9A9603C4_47E1227902E1_impl*
 aControl.SetBounds(aLeft, aTop, aWidth, aHeight);
 if (Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion = 5) and
  (Win32MinorVersion = 0) and aControl.HandleAllocated then
 begin
  with l_Pos do
  begin
   hwnd := aControl.Handle;
   hwndInsertAfter := 0;
   x := aLeft;
   y := aTop;
   cx := aWidth;
   cy := aHeight;
   flags := SWP_NOZORDER or SWP_NOACTIVATE;
  end;
  aControl.Perform(WM_WINDOWPOSCHANGING, 0, Integer(@l_Pos));
  aControl.Perform(WM_WINDOWPOSCHANGED, 0, Integer(@l_Pos));
 end;
//#UC END# *4B9F9A9603C4_47E1227902E1_impl*
end;//afwSetBoundsWin2kFix

end.
