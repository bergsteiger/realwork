unit vtSaveDialog;

{------------------------------------------------------------------------------}
{ ����������� : VT                                                             }
{ �����       : �. �������                                                     }
{ ������      : 25.05.2006 �.                                                  }
{ ����������  : ������ ���������� �������� �������� ����� ���������� ����� �   }
{               ������ FileName ������� ��� ������ ������� ���������� � ������ }
{               Filters.                                                       }
{------------------------------------------------------------------------------}

// $Id: vtSaveDialog.pas,v 1.13 2013/04/24 09:35:37 lulin Exp $
// $Log: vtSaveDialog.pas,v $
// Revision 1.13  2013/04/24 09:35:37  lulin
// - ���������.
//
// Revision 1.12  2013/04/17 14:20:20  lulin
// - ���������.
//
// Revision 1.11  2007/08/14 19:31:40  lulin
// - ������������ ������� ������.
//
// Revision 1.10  2007/04/03 13:34:17  oman
// - new: ��������� ���� ����� ��� ������ � ������ ����� (cq24791)
//
// Revision 1.9  2007/03/20 13:10:24  lulin
// - �� ���� ����� ��������� ������ ���.
//
// Revision 1.8  2007/03/20 13:04:57  lulin
// - cleanup.
//
// Revision 1.7  2007/03/20 13:01:31  lulin
// - bug fix: �� ��� �������� ���������.
//
// Revision 1.6  2007/03/20 12:28:48  lulin
// - ���������� ������ ������ �����.
//
// Revision 1.5  2007/03/20 12:17:30  lulin
// - cleanup.
//
// Revision 1.4  2006/07/24 15:02:19  mmorozov
// - new behaviour: ������������� ���������� �����, ���� � ������������ ����� ����� ���������� ���������� ��� ��������� ������;
// - new: �� ������ ��� � �������, ������� ����� ���������� � ���������, ��� ���������� ����� ���������� ��� ����� �������;
//
// Revision 1.3  2006/06/26 12:52:12  mmorozov
// - optimization: ������ �������� ����������� ������ ���� ���;
//
// Revision 1.2  2006/05/30 07:49:34  mmorozov
// - bugfix: �������� ���������� � ����� �����, ���� ��� ����������, � ������������ ������ ��� �����, � ���������� ���������� �� ���������� ���������� (CQ: OIT500020954);
//
// Revision 1.1  2006/05/25 14:25:18  mmorozov
// - new: ������ ����������;
//

interface

uses
  Classes,
  Types,
  Dialogs,
  ShlObj,

  l3VCLStrings
  ;

type
  TvtSaveDialog = class(TSaveDialog)
  {* ������ ����������. }
  private
  // internal fields
    f_CurrentFilter : String;
    f_Filters       : Tl3Strings;
    f_Init          : Boolean;
  private
  // internal methods
    function DefineCurrentFilter: String;
      {* - �������� ������� ������. }
    procedure ChangeExtension;
      {-}
    function DialogHandle: THandle;
      {-}
  private
  // property methods
    function pm_GetFilters: Tl3Strings;
      {* - ������ �������� � ������� '.txt'. }
  protected
  // properties
    property Filters: Tl3Strings
      read pm_GetFilters;
      {* - ������ �������� � ������� '.txt'. }
  protected
  // protected methods
    function GetFileNameEditHandle: THandle;
      {-}
    function GetFileNameForAdjust: AnsiString;
      virtual;
      {* - �������� ��� ����� ��� ������������� ���������� }
    procedure SetAdjustedFileName(const aFileName: AnsiString);
      virtual;
      {* - ���������� ������������������ ��� �����}
    procedure FirstCorrectFileName;
      virtual;
      {-}
    procedure DoTypeChange;
      override;
      {* - ������ ��� ����� ��� ����� �������. }
    procedure DoSelectionChange;
      override;
      {-}
    procedure DoShow;
      override;
      {-}
  public
  // methods
    destructor Destroy;
      override;
      {-}
  end;//TvtSaveDialog

function vtNeedShowExtentions: Boolean;
  {* - ���������� ����� �� ���������� ���������� ��� ��������� ������� ������. }

implementation

uses
  Windows,
  SysUtils,
  StrUtils,

  l3Base
  ;

const
 c_fnSHGetSettings = 'SHGetSettings';
 c_shell32         = 'shell32.dll';

var
 g_GetSettingsProc: Pointer = nil;

procedure vtSHGetSettings(var lpss: TShellFlagState; dwMask: DWORD); stdcall;
begin
 if (g_GetSettingsProc = nil) then
  g_GetSettingsProc := GetProcAddress(GetModuleHandle(c_shell32), c_fnSHGetSettings);
 if (g_GetSettingsProc <> nil) then
 asm
  mov esp, ebp
  pop ebp
  jmp [g_GetSettingsProc]
 end//asm
 else
  l3FillChar(lpss, SizeOf(lpss), 0);
end;//vtSHGetSettings

function vtNeedShowExtentions: Boolean;
  {* - ���������� ����� �� ���������� ���������� ��� ��������� ������� ������. }
var
 l_ShellFlag: TShellFlagState;
begin
 vtSHGetSettings(l_ShellFlag, SSF_SHOWEXTENSIONS);
 Result := l_ShellFlag.Data > 0;
end;//vtNeedShowExtentions

var
 g_FileNameDlgCtlId: Integer = 0;
   // - ������������� ���� "��� �����" � ������� ����������, ������������ ���
   //   ������ ���������;

function FindFileNameDlgCtlId(aCtrl: HWND; aParam: LPARAM): Bool; stdcall;
  {* - aParam - ��������� �� Integer, � ������� ����� ������� ���������. }
const
 c_BufferSize    = 80;
 c_FileNameClass = 'EDIT';
var
 l_ClassName : array [0..80] of Char;
 l_Temp      : String;
begin
 Result := True;
 // ������� ��� ������:
 Windows.GetClassName(aCtrl, l_ClassName, c_BufferSize);
 l_Temp := l_ClassName;
 // ���  ���� ��� �����:
 if AnsiUpperCase(l_Temp) = c_FileNameClass then
 begin
  PInteger(aParam)^ := Windows.GetDlgCtrlID(aCtrl);
  // ������ ����������� �� �����:
  Result := False;
 end;//if AnsiUpperCase(l_Temp) = c_FileNameClass then
end;//EnumChildProc

function vtFileNameDlgCtlId(const aHandle: HWND): Integer;
  {* - ��. g_FileNameDlgCtlId. }
begin
 if g_FileNameDlgCtlId = 0 then
  EnumChildWindows(Windows.GetParent(aHandle), @FindFileNameDlgCtlId,
   Integer(@g_FileNameDlgCtlId));
 Assert(g_FileNameDlgCtlId <> 0, 'FileName dialog control id wasn`t define.');
 Result := g_FileNameDlgCtlId;
end;//vtFileNameDlgCtlId

{ TvtSaveDialog }

function TvtSaveDialog.pm_GetFilters: Tl3Strings;
  {* - ������ �������� � ������� '.txt'. }
begin
 if (f_Filters = nil) then
  f_Filters := Tl3Strings.Create;
 Result := f_Filters;
end;

function TvtSaveDialog.DefineCurrentFilter: String;

  procedure DoAdd(const aStr: String);
  begin
   f_Filters.Add(AnsiReplaceStr(aStr, '*', ''))
  end;

var
 l_Index       : Integer;
 l_DisplayName : Boolean;
 l_Temp        : String;
begin
 Result := DefaultExt;
 if (Filter <> '') and (Filters.Count = 0) then
 begin
  l_Temp := Filter;
  l_DisplayName := True;
  while (l_Temp <> '') do
  begin
   l_Index := Pos('|', l_Temp);
   if not l_DisplayName then
    if (l_Index = 0) then
     DoAdd(l_Temp)
    else
     DoAdd(Copy(l_Temp, 1, Pred(l_Index)));
   if (l_Index = 0) then
    l_Temp := ''
   else
    l_Temp := Copy(l_Temp, Succ(l_Index), Length(l_Temp));
   l_DisplayName := not l_DisplayName;
  end;//l_Temp <> ''
 end;//if Filter <> '' then
 if (FilterIndex <= Filters.Count) then
  Result := Filters[Pred(FilterIndex)].AsString;
end;//DefineCurrentFilter

destructor TvtSaveDialog.Destroy;
  // override;
  {-}
begin
 FreeAndNil(f_Filters);
 inherited;
end;

procedure TvtSaveDialog.DoShow;
  // override;
  {-}
begin
 f_Init := False;
 inherited;
end;

procedure TvtSaveDialog.DoSelectionChange;
  // override;
  {-}
begin
 // ������� ���������� � �����, ���� � ������������ ����� ����� ����������
 // ���������� ��� ��������� ������:
 if not f_Init then
 begin                       
  FirstCorrectFileName;
  f_Init := True;
 end;
 inherited;
end;

procedure TvtSaveDialog.ChangeExtension;
  {-}
var
 l_FileName: String;

 function lp_IsValidExtension: Boolean;
   {-}
 begin//lp_IsValidExtension
  Result := (f_Filters.IndexOf(ExtractFileExt(l_FileName)) >= 0);
 end;//lp_IsValidExtension

var
 l_Temp: String;
begin
 f_CurrentFilter := DefineCurrentFilter;
 if (f_CurrentFilter <> '') then
 begin
  l_FileName := GetFileNameForAdjust;
  if vtNeedShowExtentions then
   // � ������������ ����� ���� ������ ��� � ������� (�������� "������ 13.
   // ����� ��������� ����������������� ������") �� ����� ������ ��� �
   // ���������:
   if lp_IsValidExtension then
    l_Temp := ChangeFileExt(l_FileName, f_CurrentFilter)
   else
    l_Temp := l_FileName + f_CurrentFilter
  else
  begin
   // � ������������ ����� ���� ������ ��� � ������� (�������� "������ 13.
   // ����� ��������� ����������������� ������") �� ����� ������ ��� �
   // ���������:
   if lp_IsValidExtension then
    l_Temp := ChangeFileExt(l_FileName, '')
   else
    l_Temp := l_FileName;
  end;
  SetAdjustedFileName(l_Temp);
 end;//if f_CurrentFilter <> '' then
end;

procedure TvtSaveDialog.DoTypeChange;
begin
 ChangeExtension;
 inherited;
end;

procedure TvtSaveDialog.FirstCorrectFileName;
begin
 ChangeExtension;
end;

function TvtSaveDialog.GetFileNameEditHandle: THandle;
begin
 Result := Windows.GetDlgItem(DialogHandle, vtFileNameDlgCtlId(Handle));
end;

function TvtSaveDialog.GetFileNameForAdjust: AnsiString;
const
 c_BufferSize = 255;
var
 l_FileName : array [0..c_BufferSize] of AnsiChar;
begin
 l3FillChar(l_FileName, SizeOf(l_FileName));
 Windows.GetDlgItemTextA(DialogHandle, vtFileNameDlgCtlId(Handle), l_FileName, c_BufferSize);
 Result := StrPas(l_FileName);
end;

procedure TvtSaveDialog.SetAdjustedFileName(const aFileName: AnsiString);
begin
 Windows.SetDlgItemTextA(DialogHandle, vtFileNameDlgCtlId(Handle), PAnsiChar(aFileName));
end;

function TvtSaveDialog.DialogHandle: THandle;
begin
 Result := Windows.GetParent(Handle);
end;

end.
