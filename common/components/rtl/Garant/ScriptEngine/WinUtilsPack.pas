unit WinUtilsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$RTLandVCL"
// ������: "WinUtilsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$RTLandVCL::WinUtils::WinUtilsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoWindows)}
uses
  Types,
  Windows,
  tfwScriptingInterfaces,
  tfwTypeInfo,
  tfwGlobalKeyWord
  ;

function IterateWindowsMethod(hWindow: THandle;
  aData: PtfwWordCallContext): Boolean; stdcall;
procedure MakeScreenshot(aWnd: THandle;
  const aRect: TRect;
  const aFileName: AnsiString;
  aWithCheck: Boolean;
  const aCtx: TtfwContext;
  aCaller: TtfwWord);
{$IfEnd} //not NoScripts AND not NoWindows

implementation

{$If not defined(NoScripts) AND not defined(NoWindows)}
uses
  SysUtils,
  Messages,
  CommCtrl,
  l3ImageUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  l3CloseFormHelper
  {$IfEnd} //not NoVCL
  ,
  Graphics,
  l3PicturePathService,
  tfwScriptingTypes,
  TypInfo,
  tfwTypeRegistrator
  ;

type
 TkwWndIsVisible = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� wnd:IsVisible
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aWnd wnd:IsVisible >>> l_Boolean
[code]  }
 private
 // private methods
   function WndIsVisible(const aCtx: TtfwContext;
    aWnd: THandle): Boolean;
     {* ���������� ����� ������� wnd:IsVisible }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWndIsVisible

// start class TkwWndIsVisible

function TkwWndIsVisible.WndIsVisible(const aCtx: TtfwContext;
  aWnd: THandle): Boolean;
//#UC START# *51F7DBC755B8_CB65D7FF1E6C_var*
//#UC END# *51F7DBC755B8_CB65D7FF1E6C_var*
begin
//#UC START# *51F7DBC755B8_CB65D7FF1E6C_impl*
 Result := Windows.IsWindowVisible(aWnd);
//#UC END# *51F7DBC755B8_CB65D7FF1E6C_impl*
end;//TkwWndIsVisible.WndIsVisible

procedure TkwWndIsVisible.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWnd : THandle;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((WndIsVisible(aCtx, l_aWnd)));
end;//TkwWndIsVisible.DoDoIt

class function TkwWndIsVisible.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'wnd:IsVisible';
end;//TkwWndIsVisible.GetWordNameForRegister

function TkwWndIsVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwWndIsVisible.GetResultTypeInfo

function TkwWndIsVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwWndIsVisible.GetAllParamsCount

function TkwWndIsVisible.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(THandle)]);
end;//TkwWndIsVisible.ParamsTypes

type
 TkwWndGetClassName = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� wnd:GetClassName
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aWnd wnd:GetClassName >>> l_String
[code]  }
 private
 // private methods
   function WndGetClassName(const aCtx: TtfwContext;
    aWnd: THandle): AnsiString;
     {* ���������� ����� ������� wnd:GetClassName }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWndGetClassName

// start class TkwWndGetClassName

function TkwWndGetClassName.WndGetClassName(const aCtx: TtfwContext;
  aWnd: THandle): AnsiString;
//#UC START# *E554A2B1DE10_455E9214E4B7_var*
var
 l_Buffer: array[Byte] of Char;
//#UC END# *E554A2B1DE10_455E9214E4B7_var*
begin
//#UC START# *E554A2B1DE10_455E9214E4B7_impl*
 GetClassName(aWnd, l_Buffer, SizeOf(l_Buffer));
 Result := l_Buffer;
//#UC END# *E554A2B1DE10_455E9214E4B7_impl*
end;//TkwWndGetClassName.WndGetClassName

procedure TkwWndGetClassName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWnd : THandle;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((WndGetClassName(aCtx, l_aWnd)));
end;//TkwWndGetClassName.DoDoIt

class function TkwWndGetClassName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'wnd:GetClassName';
end;//TkwWndGetClassName.GetWordNameForRegister

function TkwWndGetClassName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwWndGetClassName.GetResultTypeInfo

function TkwWndGetClassName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwWndGetClassName.GetAllParamsCount

function TkwWndGetClassName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(THandle)]);
end;//TkwWndGetClassName.ParamsTypes

type
 TkwWndGetWindowText = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� wnd:GetWindowText
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aWnd wnd:GetWindowText >>> l_String
[code]  }
 private
 // private methods
   function WndGetWindowText(const aCtx: TtfwContext;
    aWnd: THandle): AnsiString;
     {* ���������� ����� ������� wnd:GetWindowText }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWndGetWindowText

// start class TkwWndGetWindowText

function TkwWndGetWindowText.WndGetWindowText(const aCtx: TtfwContext;
  aWnd: THandle): AnsiString;
//#UC START# *38FB07665775_6ECBEE6894B8_var*
var
 l_Buffer: array[Byte] of Char;
//#UC END# *38FB07665775_6ECBEE6894B8_var*
begin
//#UC START# *38FB07665775_6ECBEE6894B8_impl*
 GetWindowText(aWnd, l_Buffer, SizeOf(l_Buffer));
 Result := l_Buffer;
//#UC END# *38FB07665775_6ECBEE6894B8_impl*
end;//TkwWndGetWindowText.WndGetWindowText

procedure TkwWndGetWindowText.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWnd : THandle;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((WndGetWindowText(aCtx, l_aWnd)));
end;//TkwWndGetWindowText.DoDoIt

class function TkwWndGetWindowText.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'wnd:GetWindowText';
end;//TkwWndGetWindowText.GetWordNameForRegister

function TkwWndGetWindowText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwWndGetWindowText.GetResultTypeInfo

function TkwWndGetWindowText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwWndGetWindowText.GetAllParamsCount

function TkwWndGetWindowText.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(THandle)]);
end;//TkwWndGetWindowText.ParamsTypes

type
 TkwWndCloseWindow = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� wnd:CloseWindow
*������:*
[code]
 aWnd wnd:CloseWindow
[code]  }
 private
 // private methods
   procedure WndCloseWindow(const aCtx: TtfwContext;
    aWnd: THandle);
     {* ���������� ����� ������� wnd:CloseWindow }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWndCloseWindow

// start class TkwWndCloseWindow

procedure TkwWndCloseWindow.WndCloseWindow(const aCtx: TtfwContext;
  aWnd: THandle);
//#UC START# *EF73ED47DC1E_B3B5EA3F1514_var*
//#UC END# *EF73ED47DC1E_B3B5EA3F1514_var*
begin
//#UC START# *EF73ED47DC1E_B3B5EA3F1514_impl*
 SendMessage(aWnd, WM_CLOSE, 0, 0);
//#UC END# *EF73ED47DC1E_B3B5EA3F1514_impl*
end;//TkwWndCloseWindow.WndCloseWindow

procedure TkwWndCloseWindow.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWnd : THandle;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 WndCloseWindow(aCtx, l_aWnd);
end;//TkwWndCloseWindow.DoDoIt

class function TkwWndCloseWindow.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'wnd:CloseWindow';
end;//TkwWndCloseWindow.GetWordNameForRegister

function TkwWndCloseWindow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwWndCloseWindow.GetResultTypeInfo

function TkwWndCloseWindow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwWndCloseWindow.GetAllParamsCount

function TkwWndCloseWindow.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(THandle)]);
end;//TkwWndCloseWindow.ParamsTypes

type
 TkwWndWindowIsMine = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� wnd:WindowIsMine
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aWnd wnd:WindowIsMine >>> l_Boolean
[code]  }
 private
 // private methods
   function WndWindowIsMine(const aCtx: TtfwContext;
    aWnd: THandle): Boolean;
     {* ���������� ����� ������� wnd:WindowIsMine }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWndWindowIsMine

// start class TkwWndWindowIsMine

function TkwWndWindowIsMine.WndWindowIsMine(const aCtx: TtfwContext;
  aWnd: THandle): Boolean;
//#UC START# *7F8BF12C6C7F_C09FEECC1053_var*
var
 l_Process: DWORD;
//#UC END# *7F8BF12C6C7F_C09FEECC1053_var*
begin
//#UC START# *7F8BF12C6C7F_C09FEECC1053_impl*
 GetWindowThreadProcessId(aWnd, l_Process);
 Result := (l_Process = GetCurrentProcessId);
//#UC END# *7F8BF12C6C7F_C09FEECC1053_impl*
end;//TkwWndWindowIsMine.WndWindowIsMine

procedure TkwWndWindowIsMine.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWnd : THandle;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((WndWindowIsMine(aCtx, l_aWnd)));
end;//TkwWndWindowIsMine.DoDoIt

class function TkwWndWindowIsMine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'wnd:WindowIsMine';
end;//TkwWndWindowIsMine.GetWordNameForRegister

function TkwWndWindowIsMine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwWndWindowIsMine.GetResultTypeInfo

function TkwWndWindowIsMine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwWndWindowIsMine.GetAllParamsCount

function TkwWndWindowIsMine.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(THandle)]);
end;//TkwWndWindowIsMine.ParamsTypes

type
 TkwWndSetForeground = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� wnd:SetForeground
*������:*
[code]
 aWnd wnd:SetForeground
[code]  }
 private
 // private methods
   procedure WndSetForeground(const aCtx: TtfwContext;
    aWnd: THandle);
     {* ���������� ����� ������� wnd:SetForeground }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWndSetForeground

// start class TkwWndSetForeground

procedure TkwWndSetForeground.WndSetForeground(const aCtx: TtfwContext;
  aWnd: THandle);
//#UC START# *D113CC850E0F_1C5511E4225D_var*
//#UC END# *D113CC850E0F_1C5511E4225D_var*
begin
//#UC START# *D113CC850E0F_1C5511E4225D_impl*
 Windows.SetForegroundWindow(aWnd);
//#UC END# *D113CC850E0F_1C5511E4225D_impl*
end;//TkwWndSetForeground.WndSetForeground

procedure TkwWndSetForeground.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWnd : THandle;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 WndSetForeground(aCtx, l_aWnd);
end;//TkwWndSetForeground.DoDoIt

class function TkwWndSetForeground.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'wnd:SetForeground';
end;//TkwWndSetForeground.GetWordNameForRegister

function TkwWndSetForeground.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwWndSetForeground.GetResultTypeInfo

function TkwWndSetForeground.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwWndSetForeground.GetAllParamsCount

function TkwWndSetForeground.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(THandle)]);
end;//TkwWndSetForeground.ParamsTypes

type
 TkwWinTreeGetCurrentText = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� WinTreeGetCurrentText
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aWnd WinTreeGetCurrentText >>> l_String
[code]  }
 private
 // private methods
   function WinTreeGetCurrentText(const aCtx: TtfwContext;
    aWnd: THandle): AnsiString;
     {* ���������� ����� ������� WinTreeGetCurrentText }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWinTreeGetCurrentText

// start class TkwWinTreeGetCurrentText

function TkwWinTreeGetCurrentText.WinTreeGetCurrentText(const aCtx: TtfwContext;
  aWnd: THandle): AnsiString;
//#UC START# *38530DA9DB57_A893626FB9A5_var*
var
 l_Current: TTVItemA;
 l_Res: Boolean;
 l_Text: array[1..255] of AnsiChar;
//#UC END# *38530DA9DB57_A893626FB9A5_var*
begin
//#UC START# *38530DA9DB57_A893626FB9A5_impl*
 System.FillChar(l_Current, SizeOf(l_Current), 0);
 l_Current.hItem := TreeView_GetSelection(aWnd);
 l_Current.mask := TVIF_TEXT;
 l_Current.cchTextMax := 255;
 l_Current.pszText := @l_Text;

 l_Res := TreeView_GetItemA(aWnd, l_Current);
 if l_Res then
  Result := l_Current.pszText
 else
  Result := '';
//#UC END# *38530DA9DB57_A893626FB9A5_impl*
end;//TkwWinTreeGetCurrentText.WinTreeGetCurrentText

procedure TkwWinTreeGetCurrentText.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWnd : THandle;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((WinTreeGetCurrentText(aCtx, l_aWnd)));
end;//TkwWinTreeGetCurrentText.DoDoIt

class function TkwWinTreeGetCurrentText.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'WinTreeGetCurrentText';
end;//TkwWinTreeGetCurrentText.GetWordNameForRegister

function TkwWinTreeGetCurrentText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwWinTreeGetCurrentText.GetResultTypeInfo

function TkwWinTreeGetCurrentText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwWinTreeGetCurrentText.GetAllParamsCount

function TkwWinTreeGetCurrentText.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(THandle)]);
end;//TkwWinTreeGetCurrentText.ParamsTypes

type
 TkwIterateChildWindows = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� IterateChildWindows
*������:*
[code]
 aLambda aWnd IterateChildWindows
[code]  }
 private
 // private methods
   procedure IterateChildWindows(const aCtx: TtfwContext;
    aWnd: THandle;
    aLambda: TtfwWord);
     {* ���������� ����� ������� IterateChildWindows }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIterateChildWindows

// start class TkwIterateChildWindows

procedure TkwIterateChildWindows.IterateChildWindows(const aCtx: TtfwContext;
  aWnd: THandle;
  aLambda: TtfwWord);
//#UC START# *885E0A0E618E_BB2233135443_var*
var
 l_Data: TtfwWordCallContext;
//#UC END# *885E0A0E618E_BB2233135443_var*
begin
//#UC START# *885E0A0E618E_BB2233135443_impl*
 l_Data.rWord := aLambda;
 l_Data.rCtx := @aCtx;
 
 EnumChildWindows(aWnd, @IterateWindowsMethod, LongInt(@l_Data));
//#UC END# *885E0A0E618E_BB2233135443_impl*
end;//TkwIterateChildWindows.IterateChildWindows

procedure TkwIterateChildWindows.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWnd : THandle;
 l_aLambda : TtfwWord;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aLambda := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLambda: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 IterateChildWindows(aCtx, l_aWnd, l_aLambda);
end;//TkwIterateChildWindows.DoDoIt

class function TkwIterateChildWindows.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IterateChildWindows';
end;//TkwIterateChildWindows.GetWordNameForRegister

function TkwIterateChildWindows.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwIterateChildWindows.GetResultTypeInfo

function TkwIterateChildWindows.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2;
end;//TkwIterateChildWindows.GetAllParamsCount

function TkwIterateChildWindows.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(THandle), TypeInfo(TtfwWord)]);
end;//TkwIterateChildWindows.ParamsTypes

type
 TkwIterateWindows = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� IterateWindows
*������:*
[code]
 aLambda IterateWindows
[code]  }
 private
 // private methods
   procedure IterateWindows(const aCtx: TtfwContext;
    aLambda: TtfwWord);
     {* ���������� ����� ������� IterateWindows }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIterateWindows

// start class TkwIterateWindows

procedure TkwIterateWindows.IterateWindows(const aCtx: TtfwContext;
  aLambda: TtfwWord);
//#UC START# *0BC1915B6BEB_2EB6B5E4913F_var*
var
 l_Data: TtfwWordCallContext;
//#UC END# *0BC1915B6BEB_2EB6B5E4913F_var*
begin
//#UC START# *0BC1915B6BEB_2EB6B5E4913F_impl*
 l_Data.rWord := aLambda;
 l_Data.rCtx := @aCtx;
 
 EnumWindows(@IterateWindowsMethod, LongInt(@l_Data));
//#UC END# *0BC1915B6BEB_2EB6B5E4913F_impl*
end;//TkwIterateWindows.IterateWindows

procedure TkwIterateWindows.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLambda : TtfwWord;
begin
 try
  l_aLambda := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLambda: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 IterateWindows(aCtx, l_aLambda);
end;//TkwIterateWindows.DoDoIt

class function TkwIterateWindows.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IterateWindows';
end;//TkwIterateWindows.GetWordNameForRegister

function TkwIterateWindows.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwIterateWindows.GetResultTypeInfo

function TkwIterateWindows.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwIterateWindows.GetAllParamsCount

function TkwIterateWindows.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwIterateWindows.ParamsTypes

type
 TkwWindowFromPoint = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� WindowFromPoint
*��� ����������:* THandle
*������:*
[code]
CARDINAL VAR l_THandle
 aPoint WindowFromPoint >>> l_THandle
[code]  }
 private
 // private methods
   function WindowFromPoint(const aCtx: TtfwContext;
    const aPoint: TPoint): THandle;
     {* ���������� ����� ������� WindowFromPoint }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWindowFromPoint

// start class TkwWindowFromPoint

function TkwWindowFromPoint.WindowFromPoint(const aCtx: TtfwContext;
  const aPoint: TPoint): THandle;
//#UC START# *6FFCD3ADC6FE_2D01DE64792B_var*
//#UC END# *6FFCD3ADC6FE_2D01DE64792B_var*
begin
//#UC START# *6FFCD3ADC6FE_2D01DE64792B_impl*
 Result := Windows.WindowFromPoint(aPoint);
//#UC END# *6FFCD3ADC6FE_2D01DE64792B_impl*
end;//TkwWindowFromPoint.WindowFromPoint

procedure TkwWindowFromPoint.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aPoint : TPoint;
begin
 try
  l_aPoint := aCtx.rEngine.PopPoint;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aPoint: TPoint : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Integer(WindowFromPoint(aCtx, l_aPoint)));
end;//TkwWindowFromPoint.DoDoIt

class function TkwWindowFromPoint.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'WindowFromPoint';
end;//TkwWindowFromPoint.GetWordNameForRegister

function TkwWindowFromPoint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(THandle);
end;//TkwWindowFromPoint.GetResultTypeInfo

function TkwWindowFromPoint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwWindowFromPoint.GetAllParamsCount

function TkwWindowFromPoint.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwWindowFromPoint.ParamsTypes

type
 TkwGetForegroundWindow = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� GetForegroundWindow
*��� ����������:* THandle
*������:*
[code]
CARDINAL VAR l_THandle
 GetForegroundWindow >>> l_THandle
[code]  }
 private
 // private methods
   function GetForegroundWindow(const aCtx: TtfwContext): THandle;
     {* ���������� ����� ������� GetForegroundWindow }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGetForegroundWindow

// start class TkwGetForegroundWindow

function TkwGetForegroundWindow.GetForegroundWindow(const aCtx: TtfwContext): THandle;
//#UC START# *5CBACAD0EDFA_CB29543BBB60_var*
//#UC END# *5CBACAD0EDFA_CB29543BBB60_var*
begin
//#UC START# *5CBACAD0EDFA_CB29543BBB60_impl*
 Result := Windows.GetForegroundWindow;
//#UC END# *5CBACAD0EDFA_CB29543BBB60_impl*
end;//TkwGetForegroundWindow.GetForegroundWindow

procedure TkwGetForegroundWindow.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushInt(Integer(GetForegroundWindow(aCtx)));
end;//TkwGetForegroundWindow.DoDoIt

class function TkwGetForegroundWindow.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'GetForegroundWindow';
end;//TkwGetForegroundWindow.GetWordNameForRegister

function TkwGetForegroundWindow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(THandle);
end;//TkwGetForegroundWindow.GetResultTypeInfo

function TkwGetForegroundWindow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwGetForegroundWindow.GetAllParamsCount

function TkwGetForegroundWindow.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwGetForegroundWindow.ParamsTypes

type
 TkwFindWindowByCaption = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� FindWindowByCaption
*��� ����������:* THandle
*������:*
[code]
CARDINAL VAR l_THandle
 aCaption FindWindowByCaption >>> l_THandle
[code]  }
 private
 // private methods
   function FindWindowByCaption(const aCtx: TtfwContext;
    const aCaption: AnsiString): THandle;
     {* ���������� ����� ������� FindWindowByCaption }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFindWindowByCaption

// start class TkwFindWindowByCaption

function TkwFindWindowByCaption.FindWindowByCaption(const aCtx: TtfwContext;
  const aCaption: AnsiString): THandle;
//#UC START# *84D6BB2A5250_0FB930B944B8_var*
//#UC END# *84D6BB2A5250_0FB930B944B8_var*
begin
//#UC START# *84D6BB2A5250_0FB930B944B8_impl*
 Result := FindWindowA(nil, PAnsiChar(aCaption));
//#UC END# *84D6BB2A5250_0FB930B944B8_impl*
end;//TkwFindWindowByCaption.FindWindowByCaption

procedure TkwFindWindowByCaption.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCaption : AnsiString;
begin
 try
  l_aCaption := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCaption: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Integer(FindWindowByCaption(aCtx, l_aCaption)));
end;//TkwFindWindowByCaption.DoDoIt

class function TkwFindWindowByCaption.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'FindWindowByCaption';
end;//TkwFindWindowByCaption.GetWordNameForRegister

function TkwFindWindowByCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(THandle);
end;//TkwFindWindowByCaption.GetResultTypeInfo

function TkwFindWindowByCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwFindWindowByCaption.GetAllParamsCount

function TkwFindWindowByCaption.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(AnsiString)]);
end;//TkwFindWindowByCaption.ParamsTypes

type
 TkwSetFuzzInPercent = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� SetFuzzInPercent
*������:*
[code]
 aValue SetFuzzInPercent
[code]  }
 private
 // private methods
   procedure SetFuzzInPercent(const aCtx: TtfwContext;
    aValue: Integer);
     {* ���������� ����� ������� SetFuzzInPercent }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSetFuzzInPercent

// start class TkwSetFuzzInPercent

procedure TkwSetFuzzInPercent.SetFuzzInPercent(const aCtx: TtfwContext;
  aValue: Integer);
//#UC START# *FFB533EE4DD1_DDDEEE94C045_var*
//#UC END# *FFB533EE4DD1_DDDEEE94C045_var*
begin
//#UC START# *FFB533EE4DD1_DDDEEE94C045_impl*
 l3SetFuzzValueInPercent(aValue);
//#UC END# *FFB533EE4DD1_DDDEEE94C045_impl*
end;//TkwSetFuzzInPercent.SetFuzzInPercent

procedure TkwSetFuzzInPercent.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aValue : Integer;
begin
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetFuzzInPercent(aCtx, l_aValue);
end;//TkwSetFuzzInPercent.DoDoIt

class function TkwSetFuzzInPercent.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'SetFuzzInPercent';
end;//TkwSetFuzzInPercent.GetWordNameForRegister

function TkwSetFuzzInPercent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwSetFuzzInPercent.GetResultTypeInfo

function TkwSetFuzzInPercent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwSetFuzzInPercent.GetAllParamsCount

function TkwSetFuzzInPercent.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwSetFuzzInPercent.ParamsTypes

type
 TkwDesktopHeight = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� desktop:Height
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 desktop:Height >>> l_Integer
[code]  }
 private
 // private methods
   function DesktopHeight(const aCtx: TtfwContext): Integer;
     {* ���������� ����� ������� desktop:Height }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDesktopHeight

// start class TkwDesktopHeight

function TkwDesktopHeight.DesktopHeight(const aCtx: TtfwContext): Integer;
//#UC START# *4EDF1B6456EE_F5071C676120_var*
//#UC END# *4EDF1B6456EE_F5071C676120_var*
begin
//#UC START# *4EDF1B6456EE_F5071C676120_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.DesktopHeight;
 {$Else  NoVCL}
 Assert(false);
 {$EndIf NoVCL}
//#UC END# *4EDF1B6456EE_F5071C676120_impl*
end;//TkwDesktopHeight.DesktopHeight

procedure TkwDesktopHeight.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushInt((DesktopHeight(aCtx)));
end;//TkwDesktopHeight.DoDoIt

class function TkwDesktopHeight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'desktop:Height';
end;//TkwDesktopHeight.GetWordNameForRegister

function TkwDesktopHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwDesktopHeight.GetResultTypeInfo

function TkwDesktopHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwDesktopHeight.GetAllParamsCount

function TkwDesktopHeight.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwDesktopHeight.ParamsTypes

type
 TkwDesktopWidth = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� desktop:Width
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 desktop:Width >>> l_Integer
[code]  }
 private
 // private methods
   function DesktopWidth(const aCtx: TtfwContext): Integer;
     {* ���������� ����� ������� desktop:Width }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDesktopWidth

// start class TkwDesktopWidth

function TkwDesktopWidth.DesktopWidth(const aCtx: TtfwContext): Integer;
//#UC START# *EC4EA52ACE49_F2D32D266DD0_var*
//#UC END# *EC4EA52ACE49_F2D32D266DD0_var*
begin
//#UC START# *EC4EA52ACE49_F2D32D266DD0_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.DesktopWidth
 {$Else  NoVCL}
 Assert(false);
 {$EndIf NoVCL}
//#UC END# *EC4EA52ACE49_F2D32D266DD0_impl*
end;//TkwDesktopWidth.DesktopWidth

procedure TkwDesktopWidth.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushInt((DesktopWidth(aCtx)));
end;//TkwDesktopWidth.DoDoIt

class function TkwDesktopWidth.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'desktop:Width';
end;//TkwDesktopWidth.GetWordNameForRegister

function TkwDesktopWidth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwDesktopWidth.GetResultTypeInfo

function TkwDesktopWidth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwDesktopWidth.GetAllParamsCount

function TkwDesktopWidth.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwDesktopWidth.ParamsTypes

type
 TkwScreenWidth = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� screen:Width
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anIndex screen:Width >>> l_Integer
[code]  }
 private
 // private methods
   function ScreenWidth(const aCtx: TtfwContext;
    anIndex: Integer): Integer;
     {* ���������� ����� ������� screen:Width }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScreenWidth

// start class TkwScreenWidth

function TkwScreenWidth.ScreenWidth(const aCtx: TtfwContext;
  anIndex: Integer): Integer;
//#UC START# *FF7BA1B0E345_44BBDAE720F0_var*
//#UC END# *FF7BA1B0E345_44BBDAE720F0_var*
begin
//#UC START# *FF7BA1B0E345_44BBDAE720F0_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.Monitors[anIndex].Width;
 {$Else  NoVCL}
 Assert(false);
 {$EndIf NoVCL}
//#UC END# *FF7BA1B0E345_44BBDAE720F0_impl*
end;//TkwScreenWidth.ScreenWidth

procedure TkwScreenWidth.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_anIndex : Integer;
begin
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((ScreenWidth(aCtx, l_anIndex)));
end;//TkwScreenWidth.DoDoIt

class function TkwScreenWidth.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'screen:Width';
end;//TkwScreenWidth.GetWordNameForRegister

function TkwScreenWidth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwScreenWidth.GetResultTypeInfo

function TkwScreenWidth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwScreenWidth.GetAllParamsCount

function TkwScreenWidth.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwScreenWidth.ParamsTypes

type
 TkwScreenHeight = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� screen:Height
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anIndex screen:Height >>> l_Integer
[code]  }
 private
 // private methods
   function ScreenHeight(const aCtx: TtfwContext;
    anIndex: Integer): Integer;
     {* ���������� ����� ������� screen:Height }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScreenHeight

// start class TkwScreenHeight

function TkwScreenHeight.ScreenHeight(const aCtx: TtfwContext;
  anIndex: Integer): Integer;
//#UC START# *726789FBF9F7_91E516864416_var*
//#UC END# *726789FBF9F7_91E516864416_var*
begin
//#UC START# *726789FBF9F7_91E516864416_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.Monitors[anIndex].Height;
 {$Else   NoVCL}
 Assert(false);
 {$EndIf  NoVCL}
//#UC END# *726789FBF9F7_91E516864416_impl*
end;//TkwScreenHeight.ScreenHeight

procedure TkwScreenHeight.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_anIndex : Integer;
begin
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((ScreenHeight(aCtx, l_anIndex)));
end;//TkwScreenHeight.DoDoIt

class function TkwScreenHeight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'screen:Height';
end;//TkwScreenHeight.GetWordNameForRegister

function TkwScreenHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwScreenHeight.GetResultTypeInfo

function TkwScreenHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwScreenHeight.GetAllParamsCount

function TkwScreenHeight.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwScreenHeight.ParamsTypes

type
 TkwMainScreenWidth = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� MainScreen:Width
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 MainScreen:Width >>> l_Integer
[code]  }
 private
 // private methods
   function MainScreenWidth(const aCtx: TtfwContext): Integer;
     {* ���������� ����� ������� MainScreen:Width }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainScreenWidth

// start class TkwMainScreenWidth

function TkwMainScreenWidth.MainScreenWidth(const aCtx: TtfwContext): Integer;
//#UC START# *91F8A1F3931B_3832249557A1_var*
//#UC END# *91F8A1F3931B_3832249557A1_var*
begin
//#UC START# *91F8A1F3931B_3832249557A1_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.Monitors[0].Width;
 {$Else   NoVCL}
 Assert(false);
 {$EndIf  NoVCL}
//#UC END# *91F8A1F3931B_3832249557A1_impl*
end;//TkwMainScreenWidth.MainScreenWidth

procedure TkwMainScreenWidth.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushInt((MainScreenWidth(aCtx)));
end;//TkwMainScreenWidth.DoDoIt

class function TkwMainScreenWidth.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'MainScreen:Width';
end;//TkwMainScreenWidth.GetWordNameForRegister

function TkwMainScreenWidth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwMainScreenWidth.GetResultTypeInfo

function TkwMainScreenWidth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwMainScreenWidth.GetAllParamsCount

function TkwMainScreenWidth.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwMainScreenWidth.ParamsTypes

type
 TkwMainScreenHeight = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� MainScreen:Height
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 MainScreen:Height >>> l_Integer
[code]  }
 private
 // private methods
   function MainScreenHeight(const aCtx: TtfwContext): Integer;
     {* ���������� ����� ������� MainScreen:Height }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMainScreenHeight

// start class TkwMainScreenHeight

function TkwMainScreenHeight.MainScreenHeight(const aCtx: TtfwContext): Integer;
//#UC START# *8218EB203DB0_8022C1F2B088_var*
//#UC END# *8218EB203DB0_8022C1F2B088_var*
begin
//#UC START# *8218EB203DB0_8022C1F2B088_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.Monitors[0].Height;
 {$Else   NoVCL}
 Assert(false);
 {$EndIf  NoVCL}
//#UC END# *8218EB203DB0_8022C1F2B088_impl*
end;//TkwMainScreenHeight.MainScreenHeight

procedure TkwMainScreenHeight.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushInt((MainScreenHeight(aCtx)));
end;//TkwMainScreenHeight.DoDoIt

class function TkwMainScreenHeight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'MainScreen:Height';
end;//TkwMainScreenHeight.GetWordNameForRegister

function TkwMainScreenHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwMainScreenHeight.GetResultTypeInfo

function TkwMainScreenHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwMainScreenHeight.GetAllParamsCount

function TkwMainScreenHeight.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwMainScreenHeight.ParamsTypes

type
 TkwScreenCount = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� ScreenCount
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 ScreenCount >>> l_Integer
[code]  }
 private
 // private methods
   function ScreenCount(const aCtx: TtfwContext): Integer;
     {* ���������� ����� ������� ScreenCount }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScreenCount

// start class TkwScreenCount

function TkwScreenCount.ScreenCount(const aCtx: TtfwContext): Integer;
//#UC START# *D8F53100D31F_4C862EA2F8C6_var*
//#UC END# *D8F53100D31F_4C862EA2F8C6_var*
begin
//#UC START# *D8F53100D31F_4C862EA2F8C6_impl*
 {$IfNDef NoVCL}
 Result := Forms.Screen.MonitorCount;
 {$Else   NoVCL}
 Assert(false);
 {$EndIf  NoVCL}
//#UC END# *D8F53100D31F_4C862EA2F8C6_impl*
end;//TkwScreenCount.ScreenCount

procedure TkwScreenCount.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushInt((ScreenCount(aCtx)));
end;//TkwScreenCount.DoDoIt

class function TkwScreenCount.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ScreenCount';
end;//TkwScreenCount.GetWordNameForRegister

function TkwScreenCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwScreenCount.GetResultTypeInfo

function TkwScreenCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwScreenCount.GetAllParamsCount

function TkwScreenCount.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwScreenCount.ParamsTypes

type
 TkwAskWindowToCloseItself = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� AskWindowToCloseItself
*������:*
[code]
 aWnd AskWindowToCloseItself
[code]  }
 private
 // private methods
   procedure AskWindowToCloseItself(const aCtx: TtfwContext;
    const aWnd: TtfwStackValue);
     {* ���������� ����� ������� AskWindowToCloseItself }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAskWindowToCloseItself

// start class TkwAskWindowToCloseItself

procedure TkwAskWindowToCloseItself.AskWindowToCloseItself(const aCtx: TtfwContext;
  const aWnd: TtfwStackValue);
//#UC START# *7734C551216C_22E2D41E5FCD_var*
{$IfNDef NoVCL}
var
 l_Window: TWinControl;
 l_Handle: THandle;
{$EndIf  NoVCL}
//#UC END# *7734C551216C_22E2D41E5FCD_var*
begin
//#UC START# *7734C551216C_22E2D41E5FCD_impl*
 {$IfNDef NoVCL}
 l_Window := nil;
 if (aWnd.rType = tfw_vtInt) then
 begin
  l_Handle := THandle(aWnd.AsInt);
  l_Window := FindControl(l_Handle);
 end//aWnd.rType = tfw_vtInt
 else
  l_Handle := 0;

 if Assigned(l_Window) or
    (aWnd.rType = tfw_vtObj) then
 begin
  if not Assigned(l_Window) then
   l_Window := aWnd.AsObject As TWinControl;
  RunnerAssert(l_Window is TWinControl, '��� ����?!', aCtx);
  if Tl3CloseFormHelper.Instance.Close(l_Window) then
   Exit;
  if (l_Handle <> 0) then
   l_Handle := l_Window.Handle;
 end;//Assigned(l_Window) or
 RunnerAssert(l_Handle <> 0, '��� ����?!', aCtx);
 PostMessage(l_Handle, WM_CLOSE, 0, 0);
 {$Else  NoVCL}
 Assert(false);
 {$EndIf NoVCL}
//#UC END# *7734C551216C_22E2D41E5FCD_impl*
end;//TkwAskWindowToCloseItself.AskWindowToCloseItself

procedure TkwAskWindowToCloseItself.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWnd : TtfwStackValue;
begin
 try
  l_aWnd := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWnd: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 AskWindowToCloseItself(aCtx, l_aWnd);
end;//TkwAskWindowToCloseItself.DoDoIt

class function TkwAskWindowToCloseItself.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'AskWindowToCloseItself';
end;//TkwAskWindowToCloseItself.GetWordNameForRegister

function TkwAskWindowToCloseItself.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwAskWindowToCloseItself.GetResultTypeInfo

function TkwAskWindowToCloseItself.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwAskWindowToCloseItself.GetAllParamsCount

function TkwAskWindowToCloseItself.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwAskWindowToCloseItself.ParamsTypes

type
 TkwScreenShot2File = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� ScreenShot2File
[panel]��������: ������� �������� � ������������� �������� � ��������� ��� � ���� bmp. ������:
[code]
aFileName aHeight aWidth aTop aLeft aHandle ScreenShot2File
[code]
��� aFileName - ��� ����� � ����������� bmp, � ������� ��������� ��������
aHandle - ����� ��������, � �������� ������� �������� (0 - ��� ������ ��������� � ��������).
aLeft, aTop, aWidth, aHeight - ��������� ���������� � ������� ������������� �������, � ������� ������� ��������.
������:
[code]
  INTEGER VAR l_Handle
  "������� � ������" pop:control:GetHandle >>> l_Handle
  STRING VAR l_FileName
  script:FileName '.bmp' sysutils:ChangeFileExt
  sysutils:ExtractFileName >>> l_FileName  
  l_FileName 200 200 0 0 l_Handle ScreenShot2File
[code][panel]
*������:*
[code]
 aFileName aHeight aWidth aTop aLeft aWnd ScreenShot2File
[code]  }
 private
 // private methods
   procedure ScreenShot2File(const aCtx: TtfwContext;
    aWnd: THandle;
    aLeft: Integer;
    aTop: Integer;
    aWidth: Integer;
    aHeight: Integer;
    const aFileName: AnsiString);
     {* ���������� ����� ������� ScreenShot2File }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScreenShot2File

// start class TkwScreenShot2File

procedure TkwScreenShot2File.ScreenShot2File(const aCtx: TtfwContext;
  aWnd: THandle;
  aLeft: Integer;
  aTop: Integer;
  aWidth: Integer;
  aHeight: Integer;
  const aFileName: AnsiString);
//#UC START# *E3689417D97C_D7673935EC18_var*
//#UC END# *E3689417D97C_D7673935EC18_var*
begin
//#UC START# *E3689417D97C_D7673935EC18_impl*
 MakeScreenshot(aWnd, Rect(aLeft, aTop, aLeft + aWidth, aTop + aHeight), aFileName, false, aCtx, Self);
//#UC END# *E3689417D97C_D7673935EC18_impl*
end;//TkwScreenShot2File.ScreenShot2File

procedure TkwScreenShot2File.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWnd : THandle;
 l_aLeft : Integer;
 l_aTop : Integer;
 l_aWidth : Integer;
 l_aHeight : Integer;
 l_aFileName : AnsiString;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aLeft := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLeft: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aTop := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTop: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aWidth := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWidth: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aHeight := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aHeight: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFileName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFileName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ScreenShot2File(aCtx, l_aWnd, l_aLeft, l_aTop, l_aWidth, l_aHeight, l_aFileName);
end;//TkwScreenShot2File.DoDoIt

class function TkwScreenShot2File.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ScreenShot2File';
end;//TkwScreenShot2File.GetWordNameForRegister

function TkwScreenShot2File.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwScreenShot2File.GetResultTypeInfo

function TkwScreenShot2File.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 6;
end;//TkwScreenShot2File.GetAllParamsCount

function TkwScreenShot2File.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(THandle), TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer), TypeInfo(AnsiString)]);
end;//TkwScreenShot2File.ParamsTypes

type
 TkwScreenShot2FileWithCheck = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� ScreenShot2FileWithCheck
[panel]��������: ������� �������� � ������������� �������� � ��������� ��� � ���� bmp. ����� ��������� ����� ������������ ��������� � ��������.
������:
[code]
aFileName aHeight aWidth aTop aLeft aHandle ScreenShot2FileWithCheck
[code]
��� aFileName - ��� ����� � ����������� bmp, � ������� ��������� ��������
aHandle - ����� ��������, � �������� ������� �������� (0 - ��� ������ ��������� � ��������).
aLeft, aTop, aWidth, aHeight - ��������� ���������� � ������� ������������� �������, � ������� ������� ��������.
������:
[code]
  INTEGER VAR l_Handle
  "������� � ������" pop:control:GetHandle >>> l_Handle
  STRING VAR l_FileName
  script:FileName '.bmp' sysutils:ChangeFileExt
  sysutils:ExtractFileName >>> l_FileName  
  l_FileName 200 200 0 0 l_Handle ScreenShot2FileWithCheck
[code][panel]
*������:*
[code]
 aFileName aHeight aWidth aTop aLeft aWnd ScreenShot2FileWithCheck
[code]  }
 private
 // private methods
   procedure ScreenShot2FileWithCheck(const aCtx: TtfwContext;
    aWnd: THandle;
    aLeft: Integer;
    aTop: Integer;
    aWidth: Integer;
    aHeight: Integer;
    const aFileName: AnsiString);
     {* ���������� ����� ������� ScreenShot2FileWithCheck }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScreenShot2FileWithCheck

// start class TkwScreenShot2FileWithCheck

procedure TkwScreenShot2FileWithCheck.ScreenShot2FileWithCheck(const aCtx: TtfwContext;
  aWnd: THandle;
  aLeft: Integer;
  aTop: Integer;
  aWidth: Integer;
  aHeight: Integer;
  const aFileName: AnsiString);
//#UC START# *8B949444F0A6_13CADBEDE41C_var*
//#UC END# *8B949444F0A6_13CADBEDE41C_var*
begin
//#UC START# *8B949444F0A6_13CADBEDE41C_impl*
 MakeScreenshot(aWnd, Rect(aLeft, aTop, aLeft + aWidth, aTop + aHeight), aFileName, true, aCtx, Self);
//#UC END# *8B949444F0A6_13CADBEDE41C_impl*
end;//TkwScreenShot2FileWithCheck.ScreenShot2FileWithCheck

procedure TkwScreenShot2FileWithCheck.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWnd : THandle;
 l_aLeft : Integer;
 l_aTop : Integer;
 l_aWidth : Integer;
 l_aHeight : Integer;
 l_aFileName : AnsiString;
begin
 try
  l_aWnd := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWnd: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aLeft := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLeft: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aTop := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTop: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aWidth := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWidth: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aHeight := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aHeight: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFileName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFileName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ScreenShot2FileWithCheck(aCtx, l_aWnd, l_aLeft, l_aTop, l_aWidth, l_aHeight, l_aFileName);
end;//TkwScreenShot2FileWithCheck.DoDoIt

class function TkwScreenShot2FileWithCheck.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ScreenShot2FileWithCheck';
end;//TkwScreenShot2FileWithCheck.GetWordNameForRegister

function TkwScreenShot2FileWithCheck.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwScreenShot2FileWithCheck.GetResultTypeInfo

function TkwScreenShot2FileWithCheck.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 6;
end;//TkwScreenShot2FileWithCheck.GetAllParamsCount

function TkwScreenShot2FileWithCheck.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(THandle), TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer), TypeInfo(AnsiString)]);
end;//TkwScreenShot2FileWithCheck.ParamsTypes

function IterateWindowsMethod(hWindow: THandle;
  aData: PtfwWordCallContext): Boolean;
//#UC START# *510AB608018E_4F854878032F_var*
//#UC END# *510AB608018E_4F854878032F_var*
begin
//#UC START# *510AB608018E_4F854878032F_impl*
 Result := True;
 try
  aData.rCtx.rEngine.PushInt(Integer(hWindow));
  aData.rWord.DoIt(aData.rCtx^);
 except
  on EtfwBreakIterator do
   Result := False;
 end;//try..except
//#UC END# *510AB608018E_4F854878032F_impl*
end;//IterateWindowsMethod

procedure MakeScreenshot(aWnd: THandle;
  const aRect: TRect;
  const aFileName: AnsiString;
  aWithCheck: Boolean;
  const aCtx: TtfwContext;
  aCaller: TtfwWord);
//#UC START# *551D697C0023_4F854878032F_var*
var
 l_Top     : Integer;
 l_Left    : Integer;
 l_Width   : Integer;
 l_Height  : Integer;
 l_Bitmap  : TBitmap;
 l_FileName: AnsiString;
//#UC END# *551D697C0023_4F854878032F_var*
begin
//#UC START# *551D697C0023_4F854878032F_impl*
 l_Bitmap := TBitmap.Create;
 try
  l_Left := aRect.Left;
  l_Top := aRect.Top;
  l_Width := aRect.Right - aRect.Left;
  l_Height := aRect.Bottom - aRect.Top;
  aCaller.RunnerAssert(l_Height > 0, '������ ��������� ������ ��� ����� 0.', aCtx);
  aCaller.RunnerAssert(l_Width > 0, '������ ��������� ������ ��� ����� 0.', aCtx);
  l3MakeScreenShot(l_Bitmap, l_Left, l_Top, l_Width, l_Height, aWnd);
  l_FileName := aCtx.rCaller.ResolveOutputFilePath(aFileName);
  l_Bitmap.SaveToFile(l_FileName);
  if aWithCheck then
  begin
   with Tl3PicturePathService.Instance do
   begin
    AddPicturePath(l_FileName);
    SetTestName('');
   end; // with Tl3PicturePathService.Instance do
   aCtx.rCaller.CheckPictureOnly;
  end;//aWithCheck
 finally
  FreeAndNil(l_Bitmap);
 end;
//#UC END# *551D697C0023_4F854878032F_impl*
end;//MakeScreenshot
{$IfEnd} //not NoScripts AND not NoWindows

initialization
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� wnd_IsVisible
 TkwWndIsVisible.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� wnd_GetClassName
 TkwWndGetClassName.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� wnd_GetWindowText
 TkwWndGetWindowText.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� wnd_CloseWindow
 TkwWndCloseWindow.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� wnd_WindowIsMine
 TkwWndWindowIsMine.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� wnd_SetForeground
 TkwWndSetForeground.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� WinTreeGetCurrentText
 TkwWinTreeGetCurrentText.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� IterateChildWindows
 TkwIterateChildWindows.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� IterateWindows
 TkwIterateWindows.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� WindowFromPoint
 TkwWindowFromPoint.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� GetForegroundWindow
 TkwGetForegroundWindow.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� FindWindowByCaption
 TkwFindWindowByCaption.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� SetFuzzInPercent
 TkwSetFuzzInPercent.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� desktop_Height
 TkwDesktopHeight.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� desktop_Width
 TkwDesktopWidth.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� screen_Width
 TkwScreenWidth.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� screen_Height
 TkwScreenHeight.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� MainScreen_Width
 TkwMainScreenWidth.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� MainScreen_Height
 TkwMainScreenHeight.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� ScreenCount
 TkwScreenCount.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� AskWindowToCloseItself
 TkwAskWindowToCloseItself.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� ScreenShot2File
 TkwScreenShot2File.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� ScreenShot2FileWithCheck
 TkwScreenShot2FileWithCheck.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� ���� THandle
 TtfwTypeRegistrator.RegisterType(TypeInfo(THandle));
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� ���� Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� ���� String
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiString));
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� ���� TtfwWord
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� ���� TPoint
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� ���� Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts AND not NoWindows
{$If not defined(NoScripts) AND not defined(NoWindows)}
// ����������� ���� TtfwStackValue
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoWindows

end.