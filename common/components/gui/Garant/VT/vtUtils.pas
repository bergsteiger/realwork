unit vtUtils;

// $Id: vtUtils.pas,v 1.11 2010/02/05 19:10:45 lulin Exp $

// $Log: vtUtils.pas,v $
// Revision 1.11  2010/02/05 19:10:45  lulin
// - ��������� StaticObject � SimpleClass.
// - ������� �� ��� ���� ����� - [$187006977].
//
// Revision 1.10  2010/02/04 13:36:23  oman
// - fix: ������ ����� ��� W2k {RequestLink:185831125}
//
// Revision 1.9  2010/01/29 10:27:43  oman
// - fix: {RequestLink:183796183}
//
// Revision 1.8  2007/05/14 10:51:10  oman
// - fix: ������� �������� �����������
//
// Revision 1.7  2007/03/23 13:36:23  oman
// - fix: �������������� �������� ��� �������� ��������
//
// Revision 1.6  2007/03/23 12:52:16  oman
// - fix: ��� ������� ������������� ������� TabOrder/ActiveControl, �
//   �� ��������� �� ������� ���������� ���������
//
// Revision 1.5  2006/09/06 12:17:32  oman
// - fix: �� ����� ����� ������������� ���� (cq22494)
//
// Revision 1.4  2006/06/06 13:06:50  mmorozov
// - new behaviour: ��� ��������� �������� ������������� � ��� ����� (CQ: OIT500021234);
//
// Revision 1.3  2006/05/30 15:17:50  dinishev
// New procedure vtMakeImageListWrapper
//
// Revision 1.2  2004/11/09 11:54:19  mmorozov
// change: ��������� FocusWinControlEx;
//
// Revision 1.1  2004/09/29 14:26:35  fireton
// - new: ����� ����
//

interface

uses     
 Controls,
 ImgList,

 l3InternalInterfaces
 ;

procedure vtFocusWinControlEx(const aControl               : TWinControl;
                              const aSetFocusIfNotControls : Boolean = True);
  {* - ������� ����� ������� WinControl � �������� � ������ ��� �����. }
function vtMakeImageListWrapper(const aList: TCustomImageList): Il3ImageList;
  {-}

implementation

uses
 Forms,
 Windows,
 SysUtils,

 l3ImageList,

 vtPngImgList,
 vtImageListWrapper
 ;

var
 g_IsWin2000: Boolean = False;

type
 THackControl = class(TWinControl);

procedure vtFocusWinControlEx(const aControl               : TWinControl;
                              const aSetFocusIfNotControls : Boolean = True);
var
 l_Form: TCustomForm;

 function lp_ControlParentedFrom(const aControl, aParent: TWinControl): Boolean;
 var l_Control: TWinControl;
 begin
  Result := False;
  l_Control := aControl;
  while l_Control <> nil do
  begin
   Result := l_Control.Parent = aParent;
   if Result then
    Break
   else
    l_Control := l_Control.Parent;
  end;
 end;

 function lp_FindOnlyOneForm(const aControl: TWinControl): TCustomForm;
 var
  l_IDX: Integer;
 begin
  Result := nil;
  for l_IDX := 0 to aControl.ControlCount - 1 do
   if aControl.Controls[l_IDX] is TCustomForm then
   begin
    if Result = nil then
     Result := TCustomForm(aControl.Controls[l_IDX])
    else
    begin
     // �� �� ����������� => �������
     Result := nil;
     Break;
    end;
   end;
 end;

begin
 // ���� �� ���� ����� - ����� vcl �����������
 if Assigned(aControl) then
 begin
  if aControl is TCustomForm then
   aControl.SetFocus
  else
  begin
   l_Form := lp_FindOnlyOneForm(aControl);
   if Assigned(l_Form) then
   begin
    if Assigned(l_Form.ActiveControl) then
    begin
     l_Form.SetFocus;
     if lp_ControlParentedFrom(l_Form.ActiveControl.Parent, l_Form) then
      vtFocusWinControlEx(l_Form.ActiveControl, True);
    end
    else
     THackControl(aControl).SelectFirst
   end
   else
    if aControl.ControlCount > 0 then
     THackControl(aControl).SelectFirst
    else
     if aSetFocusIfNotControls and aControl.CanFocus then
      aControl.SetFocus
  end;
 end
 else
  Assert(False);
end;

function vtMakeImageListWrapper(const aList: TCustomImageList): Il3ImageList;
begin
 if aList is TvtPngImageList then
  Result := TvtImageList.Make(aList)
 else
  if aList is TvtFixedSizeProxyPngImageList then
   Result := TvtProxyImageList.Make(aList)
  else
   Result := Tl3ImageList.Make(aList);
end;

end.
