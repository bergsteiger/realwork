unit vtReminderUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$Rem"
// Модуль: "w:/common/components/gui/Garant/VT/vtReminderUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VT$Rem::vtRemindersUtils::vtReminderUtils
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  Types,
  Classes,
  Graphics,
  Controls,
  Windows
  ;

type
 IvtRemindersLine = interface(IUnknown)
   ['{2CD75168-5AD6-4E9B-AF4A-CF338F6BC17A}']
   function Get_PosX: integer;
   procedure Set_PosX(aValue: integer);
   function Get_PosY: integer;
   procedure Set_PosY(aValue: integer);
   function Get_Bounds: TRect;
   function Get_IsMoving: Boolean;
   function Get_PopupFormRect: TRect;
   procedure CloseBaloons;
   procedure UpdatePositions;
     {* при появлении очередного напоминания корректирует позиции }
   procedure MoveLine(dX: Integer;
    dY: Integer;
    RememberRatio: Boolean);
   procedure PlaceReminders;
   procedure RestoreRatio;
   procedure CheckBounds(var aBounds: TRect);
   procedure CloseBaloonsPrim;
   property PosX: integer
     read Get_PosX
     write Set_PosX;
   property PosY: integer
     read Get_PosY
     write Set_PosY;
   property Bounds: TRect
     read Get_Bounds;
     {* прямоугольник который занимают предупреждения }
   property IsMoving: Boolean
     read Get_IsMoving;
     {* в данный момент напоминания перемещаются }
   property PopupFormRect: TRect
     read Get_PopupFormRect;
     {* координаты Popup баллона, если он открыт }
 end;//IvtRemindersLine

 TBitmap = Graphics.TBitmap;

 IvtReminder = interface(IUnknown)
   ['{82B509EC-33E5-4143-8836-D35BBD25387B}']
   procedure BringReminderToFront;
   function IsOverControl(aControl: TControl): Boolean;
 end;//IvtReminder
procedure BringRemindersToFront;
function VtCorrectBounds(const aParent: TRect;
  var aChild: TRect): Boolean;
procedure CloseAllReminderBaloons(aForm: TComponent);
function VtBitmapToRgn(anImage: TBitmap): hRgn;
function VtFindRemindersOverControl(aControl: TControl): Boolean;

implementation

uses
  Forms,
  SysUtils
  ;

// unit methods

procedure BringRemindersToFront;
//#UC START# *4F8C0AF603E4_4F8BFA0101D5_var*
  procedure DoIt(aControl: TWinControl);
  var
   l_Index: Integer;
   l_C: TComponent;
   l_Rem: IvtReminder;
  begin//CloseInner
   for l_Index := 0 to Pred(aControl.ComponentCount) do
   begin
    l_C := aControl.Components[l_Index];
    if Supports(l_C, IvtReminder, l_Rem) then
     l_Rem.BringReminderToFront;
    if (l_C is TWinControl) then
     DoIt(TWinControl(l_C));
   end;//for l_Index
  end;//CloseInner

var
 l_Form : TForm;
//#UC END# *4F8C0AF603E4_4F8BFA0101D5_var*
begin
//#UC START# *4F8C0AF603E4_4F8BFA0101D5_impl*
 l_Form := Application.MainForm;
 if (l_Form <> nil) then
  DoIt(l_Form);
//#UC END# *4F8C0AF603E4_4F8BFA0101D5_impl*
end;//BringRemindersToFront

function VtCorrectBounds(const aParent: TRect;
  var aChild: TRect): Boolean;
//#UC START# *4F8C1012020D_4F8BFA0101D5_var*
var
 l_Height  : Integer;
 l_Width   : Integer;
 l_Source  : TRect;
//#UC END# *4F8C1012020D_4F8BFA0101D5_var*
begin
//#UC START# *4F8C1012020D_4F8BFA0101D5_impl*
 l_Source := aChild;
 // Высота и ширина предупреждений
 with aChild do
 begin
  l_Height := Bottom - Top;
  l_Width := Right - Left;
 end;
 // 0-й размер, ничего не делаем
 if (l_Height > 0) and (l_Width > 0) then
 begin
  if aChild.Left < aParent.Left then
   aChild.Left := aParent.Left;
  if aChild.Top < aParent.Top then
   aChild.Top := aParent.Top;
  if aChild.Top + l_Height > aParent.Bottom then
   aChild.Top := aParent.Bottom - l_Height;
  if aChild.Left + l_Width > aParent.Right then
   aChild.Left := aParent.Right - l_Width;
  aChild.Right := aChild.Left + l_Width;
  aChild.Bottom := aChild.Top + l_Height;
 end;
 Result := not EqualRect(l_Source, aChild);
//#UC END# *4F8C1012020D_4F8BFA0101D5_impl*
end;//VtCorrectBounds

procedure CloseAllReminderBaloons(aForm: TComponent);
//#UC START# *4F8D207D0050_4F8BFA0101D5_var*
  procedure CloseInner(aControl : TWinControl);
  var
   l_Index: Integer;
   l_C: TComponent;
   l_Line: IvtRemindersLine;
  begin//CloseInner
   for l_Index := 0 to Pred(aControl.ComponentCount) do
   begin
    l_C := aControl.Components[l_Index];
    if Supports(l_C, IvtRemindersLine, l_Line) and ((aForm = nil) or (l_C <> aForm)) then
     l_Line.CloseBaloonsPrim;
    if (l_C Is TWinControl) then
     CloseInner(TWinControl(l_C));
   end;//for l_Index
  end;//CloseInner
var
 l_Form : TForm;
//#UC END# *4F8D207D0050_4F8BFA0101D5_var*
begin
//#UC START# *4F8D207D0050_4F8BFA0101D5_impl*
 l_Form := Application.MainForm;
 if (l_Form <> nil) then
  CloseInner(l_Form);
//#UC END# *4F8D207D0050_4F8BFA0101D5_impl*
end;//CloseAllReminderBaloons

function VtBitmapToRgn(anImage: TBitmap): hRgn;
//#UC START# *4F8C151C01F6_4F8BFA0101D5_var*
var
 lTmpRgn: HRGN;
 lX, lY: Integer;
 lConsecutivePixels: Integer;
 lCurrentPixel: TColor;
 lCurrentColor: TColor;
 lTransparentColor: TColor;
//#UC END# *4F8C151C01F6_4F8BFA0101D5_var*
begin
//#UC START# *4F8C151C01F6_4F8BFA0101D5_impl*
 Result := CreateRectRgn(0, 0, anImage.Width, anImage.Height);
 lTransparentColor := anImage.Canvas.Pixels[0, 0];

 if (anImage.Width = 0) or (anImage.Height = 0) then
  Exit;

 for lY := 0 to anImage.Height - 1 do
 begin
  lCurrentColor := anImage.Canvas.Pixels[0, lY];
  lConsecutivePixels := 1;
  lX := 0;
  while lX < anImage.Width do
  begin
   lCurrentPixel := anImage.Canvas.Pixels[lX, lY];

   if lCurrentColor = lCurrentPixel then
    Inc(lConsecutivePixels)
   else
   begin
    // Входим в новую зону
    if (lCurrentColor = lTransparentColor) then
    begin
     lTmpRgn := CreateRectRgn(lX - lConsecutivePixels, lY, lX, lY + 1);
     try
      CombineRgn(Result, Result, lTmpRgn, RGN_DIFF);
     finally
      DeleteObject(lTmpRgn);
     end;//try..finally
    end;//lCurrentColor = lTransparentColor
    lCurrentColor := lCurrentPixel;
    lConsecutivePixels := 1;
   end;
   Inc(lX);
  end;

  if (lCurrentColor = lTransparentColor) and (lConsecutivePixels > 0) then
  begin
   lTmpRgn := CreateRectRgn(lX - lConsecutivePixels, lY, lX, lY + 1);
   try
    CombineRgn(Result, Result, lTmpRgn, RGN_DIFF);
   finally
    DeleteObject(lTmpRgn);
   end;//try..finally
  end;//lCurrentColor = lTransparentColor
 end; //for
//#UC END# *4F8C151C01F6_4F8BFA0101D5_impl*
end;//VtBitmapToRgn

function VtFindRemindersOverControl(aControl: TControl): Boolean;
//#UC START# *527CAF6D03AB_4F8BFA0101D5_var*

//http://mdp.garant.ru/pages/viewpage.action?pageId=488604061

  function lp_DoFindReminders(aWinControl: TWinControl): Boolean;
  var
   l_Index: Integer;
   l_C: TComponent;
   l_Rem: IvtReminder;
  begin//CloseInner
   Result := False;
   for l_Index := 0 to Pred(aWinControl.ComponentCount) do
   begin
    l_C := aWinControl.Components[l_Index];
    if Supports(l_C, IvtReminder, l_Rem) then
     Result := l_Rem.IsOverControl(aControl);
    if (l_C is TWinControl) then
     Result := lp_DoFindReminders(TWinControl(l_C));
   end;//for l_Index
  end;//lp_DoFindReminders

var
 l_Form: TCustomForm;
//#UC END# *527CAF6D03AB_4F8BFA0101D5_var*
begin
//#UC START# *527CAF6D03AB_4F8BFA0101D5_impl*
 Result := False;
 l_Form := Application.MainForm;
 if (l_Form <> nil) then
  Result := lp_DoFindReminders(l_Form);
//#UC END# *527CAF6D03AB_4F8BFA0101D5_impl*
end;//VtFindRemindersOverControl

end.