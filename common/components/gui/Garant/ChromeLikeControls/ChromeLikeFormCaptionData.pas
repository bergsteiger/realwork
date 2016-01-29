unit ChromeLikeFormCaptionData;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ChromeLikeControls"
// ������: "w:/common/components/gui/Garant/ChromeLikeControls/ChromeLikeFormCaptionData.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::ChromeLikeControls::ChromeLikeWindowCaptionButtons::TChromeLikeFormCaptionData
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Types,
  Windows,
  l3ProtoObject
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
type
 TChromeLikeFormCaptionButtonKind = (
   cbkMinimize
 , cbkMaximizeRestore
 , cbkClose
 );//TChromeLikeFormCaptionButtonKind

const
  { WindowCaptionConsts }
 cWindowCaptionButtonPadding = 2;

type
 TChromeLikeFormCaptionData = class(Tl3ProtoObject)
 private
 // private fields
   f_CloseButtonRect : TRect;
    {* ������������� ������ "�������" � ����������� �� ������� �������� ���� ����}
   f_MaximizeButtonRect : TRect;
    {* ������������� ������ "����������" / "������������" � ����������� �� ������� �������� ���� ����}
   f_MinimizeButtonRect : TRect;
    {* ������������� ������ "��������" � ����������� �� ������� �������� ���� ����}
   f_WasPopulatedThemed : Boolean;
    {* ������� ����, ��� ������ �������� � ������ ���� Windows}
 private
 // private methods
   function MakeRelativeRect(const aWndRect: TRect;
     const aButtonRect: TRect): TRect;
   procedure InitTitleBarInfo;
 protected
 // overridden protected methods
   procedure InitFields; override;
 public
 // public methods
   procedure UpdateTitleBarInfo(aHwnd: hWnd);
   function MakeButtonRect(aRight: Integer;
     aButtonKind: TChromeLikeFormCaptionButtonKind): TRect;
 end;//TChromeLikeFormCaptionData
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  ChromeLikeWinUtils,
  l3Base,
  ChromeLikeTypes
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}

// start class TChromeLikeFormCaptionData

function TChromeLikeFormCaptionData.MakeRelativeRect(const aWndRect: TRect;
  const aButtonRect: TRect): TRect;
//#UC START# *533D3553015B_533D343C02FF_var*
//#UC END# *533D3553015B_533D343C02FF_var*
begin
//#UC START# *533D3553015B_533D343C02FF_impl*
 with Result do
 begin
  Right := aWndRect.Right - aButtonRect.Right;
  Top := aButtonRect.Top;
  Left := aWndRect.Right - aButtonRect.Left;
  Bottom := aButtonRect.Bottom;
 end;
//#UC END# *533D3553015B_533D343C02FF_impl*
end;//TChromeLikeFormCaptionData.MakeRelativeRect

procedure TChromeLikeFormCaptionData.InitTitleBarInfo;
//#UC START# *533D358C033A_533D343C02FF_var*
const
 cBugFixButtonSizeDecrease = 3;
 // - �������� ���������� ������� ������
var
 l_ButtonWidth: Integer;
 l_ButtonHeight: Integer;

 function lp_MakeButtonRect(aRight: Integer; aTop: Integer): TRect;
 begin
  with Result do
  begin
   Right := aRight + cWindowCaptionButtonPadding;
   Top := aTop + cWindowCaptionButtonPadding;
   Bottom := Top + l_ButtonHeight - cBugFixButtonSizeDecrease;
   Left := Right + l_ButtonWidth - cBugFixButtonSizeDecrease;
  end;//with Result
 end;//lp_MakeButtonRect

var
 l_BorderHeight: Integer;
 l_BorderWidth: Integer;
//#UC END# *533D358C033A_533D343C02FF_var*
begin
//#UC START# *533D358C033A_533D343C02FF_impl*
 // �������� ������� �������������� �� GetSystemMetrics. ��� ���� �� �������������
 // ������� ����, �� ��� ���� �� ��������� ������
 l_ButtonWidth := GetSystemMetrics(SM_CXSIZE);
 l_ButtonHeight := GetSystemMetrics(SM_CYSIZE);
 l_BorderWidth := GetSystemMetrics(SM_CXSIZEFRAME);
 l_BorderHeight := GetSystemMetrics(SM_CYSIZEFRAME);

 // ��������� ����: �� XP ����� WM_THEMECHANGED, ���� ������������ �� ������ ����
 // ���������� ��� ��� �������� ������������ SM_CXSIZE (cx = 18; cy = 25 ������
 // (cx = 25; cy = 25), ������� ���������� ������ � ������
 if (IsWindowsXP and (l_ButtonWidth <> l_ButtonHeight)) then
  l_ButtonWidth := l_ButtonHeight;

 // �������������� ������ ������� ������������ ������� �������� ���� ����
 f_CloseButtonRect := lp_MakeButtonRect(l_BorderWidth, l_BorderHeight);
 f_MaximizeButtonRect := lp_MakeButtonRect(f_CloseButtonRect.Left, l_BorderHeight);
 f_MinimizeButtonRect := lp_MakeButtonRect(f_MaximizeButtonRect.Left, l_BorderHeight);

 // ���� �� - ���� �����, ��������� ��� �������� � �� ����� �� �������������.
 // ���� Vista � ����� - ����������� �����
 f_WasPopulatedThemed := not IsWindowsVistaOrLater;
//#UC END# *533D358C033A_533D343C02FF_impl*
end;//TChromeLikeFormCaptionData.InitTitleBarInfo

procedure TChromeLikeFormCaptionData.UpdateTitleBarInfo(aHwnd: hWnd);
//#UC START# *533D35BB0292_533D343C02FF_var*
var
 l_Info: TTitleBarInfoEx;
 l_WndRect: TRect;
 l_VistaMetrics: TVistaWindowCaptionMetrics;
//#UC END# *533D35BB0292_533D343C02FF_var*
begin
//#UC START# *533D35BB0292_533D343C02FF_impl*
 // ��� ��� ����� ������, ��� ��-������� ���������� �� W7 ������ ������� ������.
 // GetSystemMetrics ���������� ����� ��������, � �������� ���� WM_GETTITLEBARINFOEX
 // ��� ������ - ��������� ������ ��������� � W7 ������ �������� �����.
 if f_WasPopulatedThemed then
  Exit;

 l_VistaMetrics := GetVistaWindowCaptionMetrics(aHwnd);
 l_Info := l_VistaMetrics.rTitleBarInfo;
 l_WndRect := l_VistaMetrics.rWindowRect;

 with l_Info do
 begin
  // ����� ������ �������������� ������, ���������� ������������
  // ������� �������� ���� ����.
  f_CloseButtonRect := MakeRelativeRect(l_WndRect, rgrect[5]);
  f_MaximizeButtonRect := MakeRelativeRect(l_WndRect, rgrect[3]);
  f_MinimizeButtonRect := MakeRelativeRect(l_WndRect, rgrect[2]);
 end;
 f_WasPopulatedThemed := True;
//#UC END# *533D35BB0292_533D343C02FF_impl*
end;//TChromeLikeFormCaptionData.UpdateTitleBarInfo

function TChromeLikeFormCaptionData.MakeButtonRect(aRight: Integer;
  aButtonKind: TChromeLikeFormCaptionButtonKind): TRect;
//#UC START# *533D3681003B_533D343C02FF_var*
var
 l_RelativeRect: TRect;
//#UC END# *533D3681003B_533D343C02FF_var*
begin
//#UC START# *533D3681003B_533D343C02FF_impl*
 l3FillChar(Result, SizeOf(Result), 0);
 case aButtonKind of
  cbkMinimize:
   l_RelativeRect := f_MinimizeButtonRect;
  cbkMaximizeRestore:
   l_RelativeRect := f_MaximizeButtonRect;
  cbkClose:
   l_RelativeRect := f_CloseButtonRect;
 end;
 // �� ������������ "��������������" �������������� � ������ ����������
 // ������� ���� ���� ������ "���������" �������������� ������
 with Result do
 begin
  Right := aRight - l_RelativeRect.Right;
  Top := l_RelativeRect.Top;
  Bottom := l_RelativeRect.Bottom;
  Left := aRight - l_RelativeRect.Left;
 end;//with Result
//#UC END# *533D3681003B_533D343C02FF_impl*
end;//TChromeLikeFormCaptionData.MakeButtonRect

procedure TChromeLikeFormCaptionData.InitFields;
//#UC START# *47A042E100E2_533D343C02FF_var*
//#UC END# *47A042E100E2_533D343C02FF_var*
begin
//#UC START# *47A042E100E2_533D343C02FF_impl*
 l3FillChar(f_CloseButtonRect, SizeOf(f_CloseButtonRect), 0);
 l3FillChar(f_MaximizeButtonRect, SizeOf(f_MaximizeButtonRect), 0);
 l3FillChar(f_MinimizeButtonRect, SizeOf(f_MinimizeButtonRect), 0);
 f_WasPopulatedThemed := False;
 InitTitleBarInfo;
//#UC END# *47A042E100E2_533D343C02FF_impl*
end;//TChromeLikeFormCaptionData.InitFields

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.