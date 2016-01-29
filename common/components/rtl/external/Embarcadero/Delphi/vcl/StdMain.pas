{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit StdMain;

interface

uses System.Classes, Winapi.ActiveX;

type
  PPropApplyRec = ^TPropApplyRec;
  TPropApplyRec = record
    PropId: Integer;
    PropValue: OleVariant;
  end;

  TPropApplyList = class(TList)
  private
    function FindProp(Id: Integer): Integer;
    function GetProp(Index: Integer): PPropApplyRec;
  public
    destructor Destroy; override;
    procedure AddProp(Id: Integer; Value: OleVariant);
    procedure ClearProps;
    property Props[Index: Integer]: PPropApplyRec read GetProp;
  end;

implementation

uses Winapi.Windows, System.Win.ComObj, System.Win.ComServ;

{ TPropApplyList }

destructor TPropApplyList.Destroy;
begin
  ClearProps;
  inherited Destroy;
end;

procedure TPropApplyList.AddProp(Id: Integer; Value: OleVariant);
var
  PropRec: PPropApplyRec;
  PropIdx: Integer;
begin
  PropIdx := FindProp(Id);
  if PropIdx >= 0 then
    PropRec := Props[PropIdx]
  else begin
    New(PropRec);
    Add(PropRec);
    PropRec.PropId := Id;
  end;
  PropRec.PropValue := Value;
end;

procedure TPropApplyList.ClearProps;
var
  i: Integer;
begin
  for i := Count - 1 downto 0 do
    Dispose(Props[i]);
  Clear;
end;

function TPropApplyList.FindProp(Id: Integer): Integer;
begin
  for Result := 0 to Count - 1 do
    if Props[Result]^.PropId = Id then Exit;
  Result := -1;
end;

function TPropApplyList.GetProp(Index: Integer): PPropApplyRec;
begin
  Result := PPropApplyRec(Items[Index]);
end;

initialization
  ComServer.LoadTypeLib;
end.
