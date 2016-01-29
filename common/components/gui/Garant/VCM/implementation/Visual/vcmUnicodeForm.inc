{$IfNDef vcmUnicodeFormImpl}

  {$Define vcmUnicodeFormImpl}
  _vcmUnicodeForm_ = class(_vcmUnicodeFormParent_)
  {$If not defined(XE) and not defined(DesignTimeLibrary)}
  private
   f_WinClassName : WideString;
   function ConvertWndClass(const AAnsiWndClass : TWndClass) : TWndClassW;
   procedure DrawWindowText;
  protected
   procedure CreateWnd; override;
   procedure CreateWindowHandle(const Params: TCreateParams); override;
   procedure CMTextChanged(var Msg: TMessage); message CM_TextChanged;
   procedure CreateParams(var Params: TCreateParams); override;
  {$ifend}
  end;

{$Else vcmUnicodeFormImpl}

{$If not defined(XE) and not defined(DesignTimeLibrary)}
const
 C_CURRENT_CODEPAGE = 1251;

function AnsiToWide(const AAnsiStr : AnsiString): WideString;
var
 l_WideString : WideString;
begin
 SetLength(l_WideString, MultiByteToWideChar(C_CURRENT_CODEPAGE, 0,
  PAnsiChar(AAnsiStr), Length(aAnsiStr), nil, 0));
 MultiByteToWideChar(C_CURRENT_CODEPAGE, 0, PAnsiChar(AAnsiStr),
  Length(AAnsiStr), PWideChar(l_WideString), Length(l_WideString));
 Result := l_WideString;
end;

function WideToAnsi(const AWideStr : WideString): AnsiString;
var
 l_AnsiText: AnsiString;
 l_UsedDefChar: BOOL;
begin
 SetLength(l_AnsiText,
  WideCharToMultiByte(C_CURRENT_CODEPAGE, 0, PWideChar(AWideStr),
  Length(AWideStr), nil, 0, nil, @l_UsedDefChar));
 WideCharToMultiByte(C_CURRENT_CODEPAGE, 0, PWideChar(aWideStr), Length(AWideStr),
  PAnsiChar(l_AnsiText), Length(l_AnsiText), nil, @l_UsedDefChar);
 Result := l_AnsiText;
end;

{_vcmUnicodeForm_}

type
 THackCustomForm = class(TCustomForm)
 private
  FClientHandle: HWND;
  FDefClientProc: TFarProc;
  FClientInstance: TFarProc;
 end;

procedure _vcmUnicodeForm_.DrawWindowText;
begin
 CallWindowProcW(DefWndProc, Handle, WM_SETTEXT, 0, LPARAM(PWideChar(Caption)));
end;

function _vcmUnicodeForm_.ConvertWndClass(const AAnsiWndClass: TWndClass): TWndClassW;
var
 l_WideWndClass : TWndClassW;
begin
 with l_WideWndClass do
 begin
  style := AAnsiWndClass.style;
  lpfnWndProc := AAnsiWndClass.lpfnWndProc;
  cbClsExtra := AAnsiWndClass.cbClsExtra;
  cbWndExtra := AAnsiWndClass.cbWndExtra;
  hInstance := AAnsiWndClass.hInstance;
  hIcon := AAnsiWndClass.hIcon;
  hCursor := AAnsiWndClass.hCursor;
  hbrBackground := AAnsiWndClass.hbrBackground;
  lpszMenuName := PWideChar(AnsiToWide(AAnsiWndClass.lpszMenuName));
  lpszClassName := PWideChar(AnsiToWide(AAnsiWndClass.lpszClassName));
 end;
 Result := l_WideWndClass;
end;

procedure _vcmUnicodeForm_.CreateWnd;

 function lp_GetIconHandle: HICON;
 begin
  Result := Icon.Handle;
  if (Result = 0) then
   Result := Application.Icon.Handle;
  if (Result = 0) then
   Result := LoadIcon(0, IDI_APPLICATION);
 end;

var
 l_Params: TCreateParams;
 l_TempClass: TWndClassW;
 l_ClassRegistered: Boolean;
 l_WideWindowClass : TWndClassW;
 l_ClientCreateStruct: TClientCreateStruct;
begin
 CreateParams(l_Params);
 with l_Params do
 begin
  if (WndParent = 0) and (Style and WS_CHILD <> 0) then
   if (Owner <> nil) and (csReading in Owner.ComponentState) and
    (Owner is TWinControl) then
     WndParent := TWinControl(Owner).Handle
   else
    raise EInvalidOperation.CreateFmt(SParentRequired, [Name]);
   DefWndProc := WindowClass.lpfnWndProc;
   l_WideWindowClass := ConvertWndClass(WindowClass);
   f_WinClassName := AnsiToWide(WinClassName);
   l_ClassRegistered := GetClassInfoW(l_WideWindowClass.hInstance, PWideChar(f_WinClassName), l_TempClass);
   if not l_ClassRegistered or (l_TempClass.lpfnWndProc <> @InitWndProc) then
   begin
    if l_ClassRegistered then Windows.UnregisterClassW(PWideChar(f_WinClassName),
     l_WideWindowClass.hInstance);
     l_WideWindowClass.lpfnWndProc := @InitWndProc;
     l_WideWindowClass.lpszClassName := PWideChar(f_WinClassName);
     if Windows.RegisterClassW(l_WideWindowClass) = 0 then
      RaiseLastOSError;
   end;
   CreationControl := Self;
   CreateWindowHandle(l_Params);
   if Handle = 0 then
    RaiseLastOSError;
   if (GetWindowLong(Handle, GWL_STYLE) and WS_CHILD <> 0) and
      (GetWindowLong(Handle, GWL_ID) = 0) then
      SetWindowLong(Handle, GWL_ID, Handle);
 end;
 SendMessage(Handle, WM_SETFONT, WParam(Font.Handle), MakeLParam(1, 0));
 DrawWindowText;

 if NewStyleControls then
  if BorderStyle <> bsDialog then
   SendMessage(HWND(Handle), WM_SETICON, 1, LPARAM(lp_GetIconHandle))
  else
   SendMessage(HWND(Handle), WM_SETICON, 1, 0);
 if not (csDesigning in ComponentState) then
  case FormStyle of
   fsMDIForm:
    begin
     with l_ClientCreateStruct do
     begin
      idFirstChild := $FF00;
      hWindowMenu := 0;
      if WindowMenu <> nil then
       hWindowMenu := WindowMenu.Handle;
     end;
     THackCustomForm(Self).FClientHandle := Windows.CreateWindowExW(WS_EX_CLIENTEDGE, 'MDICLIENT',
      nil, WS_CHILD or WS_VISIBLE or WS_GROUP or WS_TABSTOP or
      WS_CLIPCHILDREN or WS_HSCROLL or WS_VSCROLL or WS_CLIPSIBLINGS or
      MDIS_ALLCHILDSTYLES, 0, 0, ClientWidth, ClientHeight, Handle, 0,
      HInstance, @l_ClientCreateStruct);
     THackCustomForm(Self).FClientInstance := Classes.MakeObjectInstance(ClientWndProc);
     THackCustomForm(Self).FDefClientProc := Pointer(GetWindowLong(THackCustomForm(Self).FClientHandle, GWL_WNDPROC));
     SetWindowLong(THackCustomForm(Self).FClientHandle, GWL_WNDPROC, Longint(THackCustomForm(Self).FClientInstance));
    end;
   fsStayOnTop:
    SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or
     SWP_NOSIZE or SWP_NOACTIVATE);
  end;
end;

procedure _vcmUnicodeForm_.CreateWindowHandle(const Params: TCreateParams);
begin
 with Params do
  WindowHandle := CreateWindowExW(ExStyle, PWideChar(f_WinClassName),
   PWideChar(AnsiToWide(Caption)), Style, X, Y, Width, Height, WndParent, 0,
   WindowClass.hInstance, Param);
 Assert(WindowHandle <> 0,
  Format('WindowHandle = 0; LastError code = %d', [GetLastError]));
end;

procedure _vcmUnicodeForm_.CMTextChanged(var Msg: TMessage);
begin
 if not HandleAllocated then
  Exit;
 DrawWindowText;
end;

procedure _vcmUnicodeForm_.CreateParams(var Params: TCreateParams);
begin
 inherited CreateParams(Params);
 Params.WindowClass.lpfnWndProc := @DefWindowProcW;
end;

{$ifend}

{$EndIf vcmUnicodeFormImpl}