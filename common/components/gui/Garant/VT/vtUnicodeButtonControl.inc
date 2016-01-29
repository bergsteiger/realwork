{$IfNDef UnicodeButtonControlImpl}

  {$Define UnicodeButtonControlImpl}
  {$IfNDef DesignTimeLibrary}
  _UnicodeButtonControl_ = class(_UnicodeButtonControlParent_)
  {$IfNDef XE}
  private
   f_Caption : AnsiString;
   f_WinClassName : WideString;
   function ConvertWndClass(AAnsiWndClass : TWndClass) : TWndClassW;
  protected
   procedure CreateWnd; override;
   procedure CreateWindowHandle(const Params: TCreateParams); override;
   procedure WMSetText(var Msg: TMessage); message WM_SetText;
   procedure WMGetText(var Msg: TMessage); message WM_GetText;
   procedure WMGetTextLength(var Msg: TMessage); message WM_GetTextLength;
   procedure DefaultHandler(var Message); override;
   procedure CreateSubClass(var Params: TCreateParams;
    ControlClassName: PWideChar); {virtual;}
  {$EndIf XE}
  end;
  {$Else DesignTimeLibrary}
  _UnicodeButtonControl_ = _UnicodeButtonControlParent_;
  {$EndIf DesignTimeLibrary}

{$Else UnicodeButtonControlImpl}

{$IfNDef XE}
{$IfNDef DesignTimeLibrary}
const
 C_CURRENT_CODEPAGE = 1251;

function AnsiToWide(AAnsiStr : AnsiString): WideString;
var
 l_WideString : WideString;
begin
 SetLength(l_WideString, MultiByteToWideChar(C_CURRENT_CODEPAGE, 0,
  PAnsiChar(AAnsiStr), Length(aAnsiStr), nil, 0));
 MultiByteToWideChar(C_CURRENT_CODEPAGE, 0, PAnsiChar(AAnsiStr),
  Length(AAnsiStr), PWideChar(l_WideString), Length(l_WideString));
 Result := l_WideString;
end;

function WideToAnsi(AWideStr : WideString): AnsiString;
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

{ _UnicodeButtonControl_ }

function _UnicodeButtonControl_.ConvertWndClass(AAnsiWndClass: TWndClass): TWndClassW;
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

procedure _UnicodeButtonControl_.CreateWnd;
var
 l_Params: TCreateParams;
 l_TempClass: TWndClassW;
 l_ClassRegistered: Boolean;
 l_WideWindowClass : TWndClassW;
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
   // Здесь оконная функция уже Unicode
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
 if AutoSize then
  AdjustSize;
end;

procedure _UnicodeButtonControl_.CreateWindowHandle(const Params: TCreateParams);
begin
 with Params do
  WindowHandle := CreateWindowExW(ExStyle, PWideChar(f_WinClassName),
   PWideChar(AnsiToWide(f_Caption)), Style, X, Y, Width, Height, WndParent, 0,
   WindowClass.hInstance, Param);
 Assert(WindowHandle <> 0,
  Format('WindowHandle = 0; LastError code = %d', [GetLastError]));
end;

procedure _UnicodeButtonControl_.WMSetText(var Msg: TMessage);
var
 l_WideText : WideString;
begin
 if (Msg.lParam <> 0) then
 begin
  f_Caption := PAnsiChar(Msg.LParam);
  l_WideText := AnsiToWide(PAnsiChar(Msg.LParam));
  SendDockNotification(Msg.Msg, Msg.wParam, Msg.lParam);
  Msg.LParam := LParam(PWideChar(l_WideText));
  if (DefWndProc <> nil) then
   Msg.Result := CallWindowProcW(DefWndProc, Handle, Msg.Msg, Msg.wParam, Msg.lParam);
 end//Msg.lParam <> 0
 else
  Msg.Result := Ord(false);
end;

procedure _UnicodeButtonControl_.WMGetText(var Msg: TMessage);
begin
 with Msg do
  Result := StrLen(StrLCopy(PAnsiChar(LParam), PAnsiChar(f_Caption), WParam - 1));
end;

procedure _UnicodeButtonControl_.WMGetTextLength(var Msg: TMessage);
begin
 Msg.Result := Length(f_Caption);
end;

procedure _UnicodeButtonControl_.DefaultHandler(var Message);
begin
 with TMessage(Message) do
  case Msg of
    WM_SETTEXT:
     WMSetText(TMessage(Message));
    WM_GETTEXT:
     WMGetText(TMessage(Message));
    WM_GETTEXTLENGTH:
     WMGetTextLength(TMessage(Message));
  else
   inherited DefaultHandler(Message);
  end;
end;

procedure _UnicodeButtonControl_.CreateSubClass(var Params: TCreateParams;
  ControlClassName: PWideChar);
const
  CS_OFF = CS_OWNDC or CS_CLASSDC or CS_PARENTDC or CS_GLOBALCLASS;
  CS_ON = CS_VREDRAW or CS_HREDRAW;
var
  l_TempWndClass : TWndClassW;
begin
 if ControlClassName <> nil then
  with Params do
  begin
   // Перезапишем параметры из ANSI версии TWndClass в Unicode версию,
   // чтобы получить информацию о зарегистрированном в системе классе
   l_TempWndClass := ConvertWndClass(Params.WindowClass);
   if not GetClassInfoW(HInstance, ControlClassName, l_TempWndClass) and
      not GetClassInfoW(0, ControlClassName, l_TempWndClass) and
      not GetClassInfoW(MainInstance, ControlClassName, l_TempWndClass) then
       GetClassInfoW(WindowClass.hInstance, ControlClassName, l_TempWndClass);
  // Обратно возвращаем структуру TWndClassA, в которой lpfnWndProc
  // указывает на Unicode-версию оконной функции
  WindowClass.style := l_TempWndClass.style and not CS_OFF or CS_ON;
  {$IfDef XE}
  WindowClass.lpszMenuName := l_TempWndClass.lpszMenuName;
  WindowClass.lpszClassName := l_TempWndClass.lpszClassName;
  {$Else  XE}
  WindowClass.lpszMenuName := PAnsiChar(WideToAnsi(l_TempWndClass.lpszMenuName));
  WindowClass.lpszClassName := PAnsiChar(WideToAnsi(l_TempWndClass.lpszClassName));
  {$EndIf XE}
  WindowClass.lpfnWndProc := l_TempWndClass.lpfnWndProc;
 end;
end;
{$EndIf DesignTimeLibrary}
{$EndIf XE}

{$EndIf UnicodeButtonControlImpl}