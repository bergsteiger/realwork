unit ddCmdLineUtils;

{ Обработка командной строки }

{$I ddDefine.inc}

interface

uses
  Windows, SysUtils, Contnrs, l3ProtoObject;

type
  TddCmdLine = class(TObject)
  private
    FItemList: TObjectList;
    f_HelpText: AnsiString;
    f_NeedHelp: Boolean;
    procedure makeHelp;
  protected
    procedure AddBool(const Name, NeedHelp, Param: AnsiString; var Value: Boolean);
    procedure AddFolder(const Name, NeedHelp, Param: AnsiString; var Value: AnsiString);
    procedure AddSpace;
    procedure AddString(const aName: AnsiString; aHelp: AnsiString; const aParam:
        string; var Value: AnsiString);
    procedure Init; virtual;
    procedure SetDefault; virtual;
  public
    constructor Create(aEmptyAsHelp: Boolean = False);
    function SplitParam(const aParam: AnsiString; Index: Integer; const aDefault:
        AnsiString = ''): AnsiString;
    function SplitParamInt(const aParam: AnsiString; Index: Integer; aDefault: Integer
        = 0): Integer;
    property HelpText: AnsiString read f_HelpText;
    property NeedHelp: Boolean read f_NeedHelp write f_NeedHelp;
  end;

 TddBaseCmdLine = class(TddCmdLine)
 private
  f_BaseRoot: AnsiString;
  f_ServerParams: AnsiString;
  f_UserParams: AnsiString;
  function pm_GetPassword: AnsiString;
  function pm_GetserverHostName: AnsiString;
  function pm_GetServerPort: Integer;
  function pm_GetUser: AnsiString;
 protected
  procedure Init; override;
 public
  property BaseRoot: AnsiString read f_BaseRoot;
  property Password: AnsiString read pm_GetPassword;
  property serverHostName: AnsiString read pm_GetserverHostName;
  property ServerPort: Integer read pm_GetServerPort;
  property User: AnsiString read pm_GetUser;
 end;

 TcmdCheckItem = class(Tl3ProtoObject)
 private
  f_Help: AnsiString;
  f_Key: AnsiString;
  f_Next: TcmdCheckItem;
 public
  constructor Create(const aKey, AHelp: AnsiString; aNext: TcmdCheckItem);

 end;

function FindCmdLineSwitch(const Switch: AnsiString; out aParam: AnsiString;
    ParamIsNext: Boolean = False): Boolean;

function AddCheckItem(const aKey, AHelp: AnsiString; aNext: TcmdCheckItem):
    TcmdCheckItem;

implementation

uses
 StrUtils;


type
  TddCmdLineItem = class(TObject)
  private
    f_Help: AnsiString;
    f_Name: AnsiString;
    f_Param: AnsiString;
  public
    constructor Create(const AName, AHelp, aParam: AnsiString);
    function IsItem(const ParStr: AnsiString): Boolean; virtual;

    property Name: AnsiString read f_Name;
    property Help: AnsiString read f_Help;
    property Param: AnsiString read f_Param write f_Param;
  end;

  TddCmdStringItem = class(TddCmdLineItem)
  private
    FValue: ^AnsiString;
  public
    constructor Create(const AName, AHelp, aParam: AnsiString; var Value: AnsiString);
    function IsItem(const ParStr: AnsiString): Boolean; override;
  end;

  TddCmdBoolItem = class(TddCmdLineItem)
  private
    FValue: ^Boolean;
  public
    constructor Create(const AName, AHelp, aParam: AnsiString; var Value: Boolean);
    function IsItem(const ParStr: AnsiString): Boolean; override;
  end;

  TddCmdFolderItem = class(TddCmdStringItem)
  private
    function IsItem(const ParStr: AnsiString): Boolean; override;
  end;

 TddCmdCheckList = class(TddCmdStringItem)
 public
  constructor Create(const AName, AHelp, aParam: AnsiString; var Value: AnsiString);
 end;


function PadString(const S: AnsiString; Count: Integer): AnsiString;
var
  Len: Integer;
begin
  Len := Length(S);
  if Len < Count then
  begin
    SetLength(Result, Count);
    Move(S[1], Result[1], Count);
    FillChar(Result[Len + 1], Count - Len, ' ');
  end
  else
    Result := S;
end;

function FindCmdLineSwitch(const Switch: AnsiString; out aParam: AnsiString;
    ParamIsNext: Boolean = False): Boolean;
var
 I: Integer;
 S: AnsiString;
begin
 Result := False;
 aParam:= '';
 for I := 1 to ParamCount do
 begin
  S := ParamStr(I);
  if (S[1] in SwitchChars) then
   if AnsiStartsText(Switch, Copy(S, 2, Maxint)) then
   begin
    if ParamIsNext then
    begin
     if i < ParamCount then
      aParam:= ParamStr(Succ(i))
    end
    else
     aParam := Copy(S, 3 + length(Switch), Maxint);
    Result:= True;
    Exit;
   end;
 end;
end;

function AddCheckItem(const aKey, AHelp: AnsiString; aNext: TcmdCheckItem):
    TcmdCheckItem;
begin
 Result := TcmdCheckItem.Create(aKey, aHelp, aNext);
end;

{ TddCmdLineItem }

constructor TddCmdLineItem.Create(const AName, AHelp, aParam: AnsiString);
begin
  inherited Create;
  f_Name := AName;
  f_Help := AHelp;
  f_Param:= aParam;
end;

function TddCmdLineItem.IsItem(const ParStr: AnsiString): Boolean;
begin
  Result := False;
end;

{ TddCmdStringItem }

constructor TddCmdStringItem.Create(const AName, AHelp, aParam: AnsiString; var
    Value: AnsiString);
begin
  inherited Create(AName, AHelp, aParam);
  FValue := @Value;
end;

function TddCmdStringItem.IsItem(const ParStr: AnsiString): Boolean;
begin
  Result := AnsiStartsText(Name, ParStr);
  if Result then
  begin
    if Pos(':', ParStr) = Succ(Length(Name)) then
     FValue^ := Copy(ParStr, Length(Name) + 2, MaxInt)
    else
     FValue^ := Copy(ParStr, Length(Name) + 1, MaxInt);
  end;
end;

{ TddCmdBoolItem }

constructor TddCmdBoolItem.Create(const AName, AHelp, aParam: AnsiString; var
    Value: Boolean);
begin
  inherited Create(AName, AHelp, aParam);
  FValue := @Value;
end;

function TddCmdBoolItem.IsItem(const ParStr: AnsiString): Boolean;
begin
  Result := AnsiSameText(ParStr, Name);
  if Result then
    FValue^ := True
  else
  begin
    Result := AnsiSameText(ParStr, Name + '-');
    if Result then
      FValue^ := False;
  end;
end;

{ TddCmdFolderItem }

function TddCmdFolderItem.IsItem(const ParStr: AnsiString): Boolean;
var
  OldDir: AnsiString;
begin
  OldDir := FValue^;
  Result := inherited IsItem(ParStr);
  if Result then
    if not DirectoryExists(FValue^) then
      FValue^ := OldDir;
end;

constructor TddCmdLine.Create(aEmptyAsHelp: Boolean = False);
var
  i, Index: Integer;
  S: AnsiString;
begin
 FItemList := TObjectList.Create;
 try
   Init;
   SetDefault;
   MakeHelp;
   NeedHelp:= aEmptyAsHelp and (ParamCount = 0);
   for i := 1 to ParamCount do
   begin
     S := ParamStr(I);
     if AnsiStartsText('/', S) or AnsiStartsText('-', S) then
      Delete(S, 1, 1);
     for Index := 0 to FItemList.Count - 1 do
     begin
       if TddCmdLineItem(FItemList[Index]).IsItem(S) then
         Break;
     end;
   end;
 finally
   FItemList.Free;
 end;
end;

{ TddCmdLine }

procedure TddCmdLine.AddBool(const Name, NeedHelp, Param: AnsiString; var Value:
    Boolean);
begin
  FItemList.Add(TddCmdBoolItem.Create(Name, NeedHelp, Param, Value));
end;

procedure TddCmdLine.AddFolder(const Name, NeedHelp, Param: AnsiString; var Value:
    AnsiString);
begin
  FItemList.Add(TddCmdFolderItem.Create(Name, NeedHelp, Param, Value));
end;

procedure TddCmdLine.AddSpace;
begin
  FItemList.Add(TddCmdLineItem.Create('', '', ''));
end;

procedure TddCmdLine.AddString(const aName: AnsiString; aHelp: AnsiString;
    const aParam: AnsiString; var Value: AnsiString);
begin
  FItemList.Add(TddCmdStringItem.Create(aName, aHelp, aParam, Value));
end;

procedure TddCmdLine.Init;
begin
  //AddBool('Help', 'Show this screen.', ' ', f_NeedHelp);
  AddBool('?', 'Show this screen.', ' ', f_NeedHelp);
 // В наследнике задаются параметры командной строки
 // AddXXX(<ключ>, <описание>, <поле для доступа>
end;

procedure TddCmdLine.SetDefault;
begin
 // TODO -cMM: TddCmdLine.SetDefault default body inserted
end;

procedure TddCmdLine.makeHelp;
var
  i: Integer;
  Item: TddCmdLineItem;
  S: AnsiString;
  l_UsageStr: AnsiString;
begin
 if IsConsole then
  l_UsageStr:= ExtractFileName(ParamStr(0))
 else
  l_UsageStr:= '';

 f_HelpText:= '';
 for i := 0 to FItemList.Count - 1 do
 begin
   Item := TddCmdLineItem(FItemList[i]);
   if Item.Name = '' then
    f_HelpText:= f_HelpText + #13#10;
   if Item.Help <> '' then
   begin
     //if Item is TddCmdStringItem then
    if Item.Param <> '' then
     S:= Item.Name + Item.Param
    else
     S:= Item.Name + '<value>';
    f_HelpText:= f_HelpText + #13#10 + S + #9 + Item.Help;
    if IsConsole then
     l_UsageStr:= l_UsageStr + ' ' + S;
   end; // Item.Help <> ''
 end; // for i
 f_HelpText:= l_UsageStr + #13#10 + f_HelpText;
end;

function TddCmdLine.SplitParam(const aParam: AnsiString; Index: Integer; const
    aDefault: AnsiString = ''): AnsiString;
var
 l_PrevPos, l_pos, l_NextPos, l_Index: Integer;
begin
 Result := aDefault;
 if aParam <> '' then
 begin
  l_Pos:= Pos(':', aparam);
  l_PrevPos:= 0;
  l_NextPos:= l_Pos;
  if l_Pos > 0 then
  begin
   l_Index:= 0;
   while (l_Index <> Index) and (l_Pos > 0) do
   begin
    Inc(l_Index);
    l_PrevPos:= l_Pos;
    l_Pos:= PosEx(':', aParam, Succ(l_pos));
    if l_Pos > 0 then
     l_NextPos:= PosEx(':', aParam, Succ(l_pos))
    else
     l_NextPos:= 0;
    if l_NextPos = 0 then
     l_NextPos:= MaxInt;
   end; // while (l_Index <> Index) and (l_Pos > 0)

   if (l_Index = Index) then
    Result:= Copy(aParam, Succ(l_PrevPos), Pred(l_NextPos-l_PrevPos));
  end
  else
  if Index = 0 then
   Result:= aParam;
 end;
end;

function TddCmdLine.SplitParamInt(const aParam: AnsiString; Index: Integer;
    aDefault: Integer = 0): Integer;
var
 l_PrevPos, l_pos, l_NextPos, l_Index: Integer;
begin
 Result := aDefault;
 if aParam <> '' then
 begin
  l_Pos:= Pos(':', aparam);
  l_PrevPos:= 0;
  l_NextPos:= l_Pos;
  if l_Pos > 0 then
  begin
   l_Index:= 0;
   while (l_Index <> Index) and (l_Pos > 0) do
   begin
    Inc(l_Index);
    l_PrevPos:= l_Pos;
    l_Pos:= PosEx(':', aParam, Succ(l_pos));
    if l_Pos > 0 then
     l_NextPos:= PosEx(':', aParam, Succ(l_pos))
    else
     l_NextPos:= 0;
    if l_NextPos = 0 then
     l_NextPos:= MaxInt;
   end; // while (l_Index <> Index) and (l_Pos > 0)

   if (l_Index = Index) then
    Result:= StrToIntDef(Copy(aParam, Succ(l_PrevPos), Pred(l_NextPos-l_PrevPos)), aDefault);
  end
  else
  if Index = 0 then
   Result:= StrToIntDef(aParam, aDefault);
 end;
end;

procedure TddBaseCmdLine.Init;
begin
 inherited Init;
 AddString('user', 'Логин-пароль для подлкючения к базе', '<login>[:<password>]', f_UserParams);
 AddString('Server', 'Параметры сервера Архивариуса. Порт по умолчанию 32100', '<ServerHostName>[:<Port>]', f_ServerParams);
 AddFolder('Base', 'Путь к базе данных', '', f_BaseRoot);
end;

function TddBaseCmdLine.pm_GetPassword: AnsiString;
begin
 Result := SplitParam(f_UserParams, 1);
end;

function TddBaseCmdLine.pm_GetserverHostName: AnsiString;
begin
 Result := SplitParam(f_ServerParams, 0);
end;

function TddBaseCmdLine.pm_GetServerPort: Integer;
begin
 Result := SplitParamInt(f_ServerParams, 1, 32100);
end;

function TddBaseCmdLine.pm_GetUser: AnsiString;
begin
 Result := SplitParam(f_UserParams, 0);
end;

constructor TcmdCheckItem.Create(const aKey, AHelp: AnsiString; aNext:
    TcmdCheckItem);
begin
 inherited Create;
 f_Key:= aKey;
 f_Help:= aHelp;
 f_Next:= aNext;
end;

{ TddCmdCheckList }

constructor TddCmdCheckList.Create(const AName, AHelp, aParam: AnsiString; var
    Value: AnsiString);
begin
end;


end.
