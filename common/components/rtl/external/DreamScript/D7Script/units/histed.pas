{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit histed;

interface
{$I dc.inc}

uses
  {$IFNDEF CLX}
  windows, messages, controls, stdctrls, registry,
  {$ELSE}
  QStdCtrls,
  {$ENDIF}
  classes, sysutils, dcsystem;

type
  TDCHistoryEditor = class(TComboBox)
  private
    FRegName: string;
    {$IFDEF D7}
    FDestroying: boolean;
    {$ENDIF}
    function GetRegName: string;
  protected
    {$IFNDEF CLX}
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMDestroy(var Message: TWMDestroy); message WM_DESTROY;
    procedure CMWANTSPECIALKEY(var Message : TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    {$ELSE}
    procedure CreateWidget; override;
    procedure DestroyWidget; override;
    procedure DoExit; override;
    {$ENDIF}
    procedure Loaded; override;
    procedure HistoryChanged; virtual;
    procedure KeyPress(var Key: Char); override;
  public
    procedure SaveHistory; virtual;
    procedure LoadHistory; virtual;
    procedure EmptyHistory;
    {$IFDEF D7}
    destructor Destroy; override;
    {$ENDIF}
  published
    property Align;
    property RegName: string read FRegName write FRegName;
  end;

//const
  //SErrUnknRegType = 'This type isn''t supported by WriteToRegistry';

procedure Register;

implementation

{---------TDCHistoryEditor---------------------------------}

procedure TDCHistoryEditor.Loaded;
begin
  inherited;
  LoadHistory;

end;

{----------------------------------------------------------}
{$IFNDEF CLX}
procedure TDCHistoryEditor.CreateWnd;
begin
  inherited;
  LoadHistory;
//  Text := '';
end;

{----------------------------------------------------------}

procedure TDCHistoryEditor.DestroyWnd;
begin
  SaveHistory;
  inherited;
end;
{$ENDIF}

{----------------------------------------------------------}

procedure TDCHistoryEditor.SaveHistory;
begin
  {$IFDEF D7}
  if FDestroying or not HandleAllocated then
    Exit;
  {$ENDIF}

  {$IFNDEF CLX}
  WriteToRegistry(GetRegName, Items.Text);
  {$ENDIF}
end;

{----------------------------------------------------------}

procedure TDCHistoryEditor.LoadHistory;
begin
  {$IFNDEF CLX}
  Items.Text := ReadFromRegistry(GetRegName, '');
  {$ENDIF}
end;

{----------------------------------------------------------}

procedure TDCHistoryEditor.EmptyHistory;
begin
  Items.Clear;
end;

{----------------------------------------------------------}

function TDCHistoryEditor.GetRegName: string;
begin
  result := FRegName;
  if result = '' then
  begin
    result := GetCompName(Self.Owner) + GetCompName(Self);
    if result = '' then
      result := 'Default';
  end;
  result := 'EditHistory\' + result;
end;

{----------------------------------------------------------}

procedure TDCHistoryEditor.HistoryChanged;
var
  Index: integer;
  s: string;
begin
  s := Text;
  with Items do
  begin
    Index := IndexOf(s);
    if Index >= 0 then
      Delete(Index);
    if s <> '' then
      Insert(0, s);
    Self.Text := s;
  end;
end;

{----------------------------------------------------------}

procedure TDCHistoryEditor.KeyPress(var Key: Char);
begin
  if Key = #13 then
  begin
    if DroppedDown then
      DroppedDown := false
    else
      HistoryChanged;
    Key := #0;
  end
  else
  if (Key = #27) and not DroppedDown then
    Key := #0;
  inherited;
end;

{----------------------------------------------------------}
{$IFNDEF CLX}
procedure TDCHistoryEditor.CMExit(var Message: TCMExit);
begin
  HistoryChanged;
  inherited;
end;

{----------------------------------------------------------}

procedure TDCHistoryEditor.WMDestroy(var Message: TWMDestroy);
begin
  SaveHistory;
  inherited;
end;

{----------------------------------------------------------}

procedure TDCHistoryEditor.CMWANTSPECIALKEY(var Message : TCMWantSpecialKey);
begin
  if Message.CharCode = VK_RETURN then
    HistoryChanged;
  inherited;
end;

{$ELSE}

{----------------------------------------------------------}

procedure TDCHistoryEditor.CreateWidget;
begin
  inherited;
  LoadHistory;
end;

{----------------------------------------------------------}

procedure TDCHistoryEditor.DestroyWidget;
begin
  SaveHistory;
  inherited;
end;

{----------------------------------------------------------}

procedure TDCHistoryEditor.DoExit;
begin
  HistoryChanged;
  inherited;
end;
{$ENDIF}

{----------------------------------------------------------}
{$IFDEF D7}
destructor TDCHistoryEditor.Destroy;
begin
  SaveHistory;
  FDestroying := true;
  inherited;
end;
{$ENDIF}


{----------------------------------------------------------}

procedure Register;
begin
  RegisterComponents('Dream Edit', [TDCHistoryEditor]);
end;

end.
