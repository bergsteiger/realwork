{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{   Copyright (c) 2003, Alexander Hramov             }
{                                                    }
{====================================================}

{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

(*

Version History

03/29/2003

   Fixed problem with processing symbols under Win9x and in non-Unicode version

*)

unit ElInputProcessor;

interface

uses
  SysUtils,
  Messages,
  Windows,
  Graphics,
  Dialogs,
  Forms,
  {$ifdef ELPACK_USE_INPUTPROCESSOR}
  Imm,
  {$endif}
  Classes,
  ElStrUtils,
  ElTools;

type
  TElEditCharCase = (eecNormal, eecUpperCase, eecLowerCase);

  {$ifdef ELPACK_USE_INPUTPROCESSOR}
  TIMECompositionStringProc = function(hImc: HIMC; dWord1: DWORD; lpBuf: pointer; dwBufLen: DWORD): Longint; stdcall;

  TElKeyboardInputProcessor = class(TObject)
  protected
    FCharCase: TElEditCharCase;
    FCDead: Integer;
    FDeadChar: Char;
    FHandle: THandle;
    FResultStr: TElFString;
    procedure SetCharCase(Value: TElEditCharCase); virtual;
    procedure SetResultStr(Value: TElFString); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    {$ifdef ELPACK_UNICODE}
    procedure WMDeadChar(Msg: TWMDeadChar); virtual;
    procedure WMImeComposition(Msg: TMessage); virtual;
    {$endif}

    procedure WMKeyDown(Msg: TWMKeyDown); virtual;
    procedure WMChar(Msg: TWMChar); virtual;

    function HandleAllocated: boolean;
    property CharCase: TElEditCharCase read FCharCase write SetCharCase default eecNormal;
    property Handle: THandle read FHandle write FHandle;
    property ResultStr: TElFString read FResultStr write SetResultStr;
  end;

  TElKeyboardInput = class(TElKeyboardInputProcessor)
  protected
    FText: TElFString;
    procedure SetCharCase(Value: TElEditCharCase); override;
    procedure SetResultStr(Value: TElFString); override;
    property ResultStr: TElFString read FResultStr write SetResultStr;
  public
    constructor Create;
    destructor Destroy; override;
    procedure WMKeyDown(Msg: TWMKeyDown); override;
    procedure Reset;
    property Text: TElFString read FText;
  end;
  {$endif}


  TSearchTextTimeoutThread = class (TThread)
  private
    CriticalSection : TRTLCriticalSection;
    fKeepAlive : Boolean;
    FIncrementalSearchTimeout : integer;
    procedure SetKeepAlive (KeepAlive : Boolean);
    function GetKeepAlive : Boolean;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy ;override;

    property IncrementalSearchTimeout : integer read FIncrementalSearchTimeout write FIncrementalSearchTimeout;
    property KeepAlive : Boolean read GetKeepAlive write SetKeepAlive default False;
  end ;

implementation

{$ifdef ELPACK_UNICODE}
type
  ToUnicodeProc = function(wVirtKey, wScanCode: UINT; const KeyState: TKeyboardState;
                            var pwszBuff; cchBuff: Integer; wFlags: UINT): Integer; stdcall;
var
  ToUnicode : ToUnicodeProc;

function KeyToUnicode(const Key: String): WideString;
var KeyboardCodePage: integer;
    Buf: String;
    LenBuf: Integer;
    LenRes: integer;
    Locale: LCID;
// const LOCALE_IDEFAULTANSICODEPAGE     = $00001004;
begin
  // Get right locale
  Locale := GetKeyboardLayout(0) and $FFFF;
  LenBuf := GetLocaleInfo(Locale, LOCALE_IDEFAULTANSICODEPAGE, nil, 0);
  SetLength(Buf, LenBuf);
  GetLocaleInfo(Locale, LOCALE_IDEFAULTANSICODEPAGE, PChar(Buf), LenBuf);
  KeyboardCodePage := StrToIntDef(Buf, GetACP);

  // Get length of result string
  LenRes := MultiByteToWideChar(KeyboardCodePage, MB_PRECOMPOSED or MB_USEGLYPHCHARS, PChar(Key), Length(Key), nil, 0);
  SetLength(Result, LenRes);
  MultiByteToWideChar(KeyboardCodePage, MB_PRECOMPOSED or MB_USEGLYPHCHARS, PChar(Key), Length(Key), PWideChar(Result), LenRes);
end;
{$endif}

{$ifdef ELPACK_USE_INPUTPROCESSOR}

{
******************************* TElKeyboardInput *******************************
}

constructor TElKeyboardInput.Create;
begin
  inherited;
  FText := '';
end;

destructor TElKeyboardInput.Destroy;
begin
  inherited;
end;

procedure TElKeyboardInput.Reset;
begin
  FText := '';
end;

procedure TElKeyboardInput.WMKeyDown(Msg: TWMKeyDown);
var
  {$ifdef ELPACK_UNICODE}
  S: WideString;
  {$else}
  S: String;
  {$endif}

begin
  inherited WMKeyDown(Msg);
  if (Msg.CharCode = 8) and (FText <> '') then
  begin
    S := FText;
    {$ifdef ELPACK_UNICODE}
    WideDelete(S, Length(S), 1);
    {$else}
    System.Delete(S, Length(S), 1);
    {$endif}
    FText := S;
  end;
end;

procedure TElKeyboardInput.SetCharCase(Value: TElEditCharCase);
begin
  if FCharCase <> Value then
  begin
    FCharCase := Value;
    if FCharCase <> eecNormal then
    begin
      {$ifndef ELPACK_UNICODE}
      if FCharCase = eecUppercase then
        FText := Uppercase(FText)
      else
        FText := Lowercase(FText);
      {$else}
      if FCharCase = eecUppercase then
        FText := WideUppercase(FText)
      else
        FText := WideLowercase(FText);
      {$endif}
    end;
  end;
end;

procedure TElKeyboardInput.SetResultStr(Value: TElFString);
begin
  inherited;
  FText := FText + ResultStr;
end;

{
************************** TElKeyboardInputProcessor ***************************
}
constructor TElKeyboardInputProcessor.Create;
begin
  FResultStr := '';
  FDeadChar := #0;
  FCDead := 0;

  {$ifdef ELPACK_UNICODE}
  ToUnicode := GetProcAddress(GetModuleHandle('USER32'), 'ToUnicode');
  {$endif}
end;

destructor TElKeyboardInputProcessor.Destroy;
begin
  inherited;
end;

procedure TElKeyboardInputProcessor.SetCharCase(Value: TElEditCharCase);
begin
  if FCharCase <> Value then
  begin
    FCharCase := Value;
    if FCharCase <> eecNormal then
    begin
      {$ifndef ELPACK_UNICODE}
      if FCharCase = eecUppercase then
        FResultStr := Uppercase(FResultStr)
      else
        FResultStr := Lowercase(FResultStr);
      {$else}
      if FCharCase = eecUppercase then
        FResultStr := WideUppercase(FResultStr)
      else
        FResultStr := WideLowercase(FResultStr);
      {$endif}
    end;
  end;
end;

procedure TElKeyboardInputProcessor.SetResultStr(Value: TElFString);
begin
  FResultStr := Value;
end;

{$ifdef ELPACK_UNICODE}
procedure TElKeyboardInputProcessor.WMDeadChar(Msg : TWMDeadChar);
begin
  FDeadChar := Char(Msg.CharCode);
  Msg.Result := 0;
end;

procedure TElKeyboardInputProcessor.WMImeComposition(Msg: TMessage);
var
  IMC: HIMC;
  S: string;
  SNT: WideString;
  Size: Integer;
  StrEnd: PWideChar;
  ImmGetCompositionStringW: TIMECompositionStringProc;
begin
  // Input of word is finished?
  if (HandleAllocated) then
    if ((Msg.LParam and GCS_RESULTSTR) <> 0) then
    begin
      IMC := ImmGetContext(Handle);
      if IMC<>0 then
      begin
        // NT, 2000, XP?
        if IsWinNTUp then
        begin
          try
            SNT := '';
            if GetModuleHandle('IMM32') <> 0 then
            begin
              ImmGetCompositionStringW := GetProcAddress(GetModuleHandle('IMM32'), 'ImmGetCompositionStringW');
              if @ImmGetCompositionStringW <> nil then
              begin
                Size := ImmGetCompositionStringW(IMC, GCS_RESULTSTR, nil, 0);
                SetLength(SNT, Size);
                FillWideChar(PWideChar(SNT)^, Size, #0);
                ImmGetCompositionStringW(IMC, GCS_RESULTSTR, PWideChar(SNT), Size);
              end;
            end;
          finally
            ImmReleaseContext(Handle, IMC);
          end;
          StrEnd := WideStrScan(PWideChar(SNT), WideChar(#0));
          if StrEnd <> nil then
            SetLength(SNT, StrEnd - PWideChar(SNT));
        end
        else
        begin
          // IME support for Win95-98
          // Unfortunately, should properly work not for all versions
          // (you'll get a line of '?')
          S := '';
          try
            Size := ImmGetCompositionStringA(IMC, GCS_RESULTSTR, nil, 0);
            SetLength(s, Size);
            ImmGetCompositionStringA(IMC, GCS_RESULTSTR, PChar(s), Size);
          finally
            ImmReleaseContext(Handle, IMC);
          end;
          SNT := KeyToUnicode(s);
        end;

        if FCharCase = eecUppercase then
          SNT := WideUppercase(SNT)
        else
        if FCharCase = eecLowercase then
          SNT := WideLowercase(SNT);

        ResultStr := SNT;

  //      if FSelected then
  //        DeleteSelection;
  //
  //      fx := CaretX;
  //      fy := CaretY;
  //
  //      FElEditList.InsertText(fx, fy, SNT);
  //
  //      CaretY := fy;
  //      CaretX := fx;
  //      FSelStartX := fx;
  //      FSelStartY := fy;
  //      RepaintText(FEditRect);
      end;
    end;
end;
{$endif}


procedure TElKeyboardInputProcessor.WMKeyDown(Msg : TWMKeyDown);
{$ifdef ELPACK_UNICODE}
var KeyState: TKeyboardState;
    s : WideString;
    Len : Integer;
    FAdd: Integer;
    ACharCode : integer;
    {.............................................................}
    function IsSpecialLanguage: Boolean;
    var Language: Integer;
    begin
      Language := (GetKeyboardLayout(0) and $FFFF);
      Result := (Language = $0439) {or  // Hindi
                (Language = $0404) or  // Chinese (Taiwan)
                (Language = $0804) or  //Chinese (PRC)
                (Language = $0c04) or  //Chinese (Hong Kong)
                (Language = $1004)};    //Chinese (Singapore)

    end;
{$endif}

begin
  {$ifdef ELPACK_UNICODE}
  if IsWinNTUp {and IsSpecialLanguage } then
  begin
      // Manual translation of key codes to Unicode
      // if Msg.CharCode in [ord('A')..ord('Z'),ord('0')..ord('9'),187..192,220] then
    if not (Msg.CharCode in [8, 9, 13, 27]) then
    begin
      SetLength(s, 5);
      if GetKeyboardState(KeyState) and ((KeyState[VK_CONTROL] and $80)=0) then
      begin
        ACharCode := Msg.CharCode;
        Len := ToUnicode(ACharCode, Msg.KeyData, KeyState, PWideChar(s)^, 5, 0);
        if Len > 1 then
        begin
          SetLength(s, Len);
          if (FDeadChar <> #0) then
          begin
            if FCDead >= 1 then
            begin
              ResultStr := s;
              SendMessage(Handle, WM_CHAR, Word(FDeadChar), 0);
              FDeadChar := #0;
              FCDead := 0;
            end
            else
              Inc(FCDead);
          end
          else
            ResultStr := s;
        end
        else
        if (FDeadChar <> #0) and (Len = 1) then
        begin
          FAdd := -1;
          case FDeadChar of
            #96: FAdd := 0;  // GRAVE
            #180: FAdd := 1; // ACUTE
            '^': FAdd := 2;  // CIRCUMFLEX
            '~': FAdd := 3;  // TILDE
            #168: FAdd := 4; // UMLAUT
            #161: Fadd := 5; // CORONA
          end;
          if FAdd >= 0 then
            case s[1] of
              'A': ResultStr := WideChar($00C0 + FAdd);
              'E': ResultStr := WideChar($00C8 + FAdd);
              'I': ResultStr := WideChar($00CC + FAdd);
              'O': ResultStr := WideChar($00D2 + FAdd);
              'U': ResultStr := WideChar($00D9 + FAdd);
              'a': ResultStr := WideChar($00E0 + FAdd);
              'e': ResultStr := WideChar($00E8 + FAdd);
              'i': ResultStr := WideChar($00EC + FAdd);
              'o': ResultStr := WideChar($00F2 + FAdd);
              'u': ResultStr := WideChar($00F9 + FAdd);
              else
              begin
                if ((WideUpperCase(s[1]) = 'Y') and (FAdd = 1)) or ((s[1] = 'y') and (FAdd = 4)) then
                begin
                  if FAdd = 1 then
                  begin
                    case s[1] of
                    'Y': ResultStr := WideChar($00DD);
                    'y': ResultStr := WideChar($00FD);
                    end;
                  end
                  else
                    ResultStr := WideChar($00FF);
                end
                else
                if (FAdd = 5) and ((WideUpperCase(s[1]) = 'C') or (WideUpperCase(s[1]) = 'Z') or (WideUpperCase(s[1]) = 'L')) then
                begin
                  case s[1] of
                  'C': ResultStr := WideChar($010C);
                  'c': ResultStr := WideChar($010D);
                  'Z': ResultStr := WideChar($017D);
                  'z': ResultStr := WideChar($017E);
                  'L': ResultStr := WideChar($013D);
                  'l': ResultStr := WideChar($013E);
                  end;
                end
                else
                begin
                  SetLength(s, 2);
                  s[2] := s[1];
                  s[1] := WideChar(FDeadChar);
                  ResultStr := s;
                end;
              end;
            end;
          FDeadChar := #0;
        end
        else
        if Len > 0 then
        begin
          SetLength(s, Len);
          ResultStr := s;
        end;
      end;
    end;
  end;
  inherited;
  {$else}
  inherited;
  {$endif}
end;

procedure TElKeyboardInputProcessor.WMChar(Msg: TWMChar);
begin
  inherited;
  {$ifdef ELPACK_UNICODE}
  if not IsWinNTUp then
  {$endif}
    if not (Msg.CharCode in [VK_BACK, VK_RETURN, VK_ESCAPE, VK_TAB, 127, 0]) then
      ResultStr := char(Msg.CharCode);
end;

function TElKeyboardInputProcessor.HandleAllocated: boolean;
begin
  Result := (FHandle <> 0);
end;

{$endif}

constructor TSearchTextTimeoutThread.Create ;
begin
  inherited Create (True) ;
  InitializeCriticalSection(CriticalSection);
  fKeepAlive := False;
end ;

destructor TSearchTextTimeoutThread.Destroy ;
begin
  DeleteCriticalSection(CriticalSection);
  inherited Destroy;
end ;

procedure TSearchTextTimeoutThread.Execute ;
begin
  while not Terminated do
  begin
    Sleep(FIncrementalSearchTimeout);
    if not KeepAlive then
      break;
    KeepAlive := False
  end
end ;

function TSearchTextTimeoutThread.GetKeepAlive : Boolean ;
begin
  EnterCriticalSection(CriticalSection);
  try
    Result := fKeepAlive;
  finally
    LeaveCriticalSection(CriticalSection);
  end
end ;

procedure TSearchTextTimeoutThread.SetKeepAlive (KeepAlive : Boolean) ;
begin
  EnterCriticalSection(CriticalSection);
  try
    fKeepAlive := KeepAlive;
  finally
    LeaveCriticalSection(CriticalSection);
  end
end;

end.
