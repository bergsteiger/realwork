{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit PropCB;

interface
{$I dc.inc}
uses Classes, StdCtrls, TypInfo;

type
  TDCPropCheck = class(TCheckBox)
  private
    FComponent: TPersistent;
    FPropName: string;
    FInverted: Boolean;

    piType: integer;
    {0 - error
     1 - simple bool property of FComponent or its subclass
     2 - element of set property of FComponent's subclass}
    piName : string;
    piObject: TPersistent;
    piPropInfo: TPropInfo;
    piSetValue: integer;

    procedure SetComponent(Value: TPersistent);
    procedure SetPropName(Value: string);
    procedure SetInverted(Value: Boolean);
    procedure ClearSavePropInfo;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Toggle; override;
    procedure GetCompPropValue;
    procedure SetCompPropValue;
    function GoodPropName(PropNameStr: string): Boolean;
    procedure Loaded; override;
  public
    procedure Update; override;
  published
    property Component: TPersistent read FComponent write SetComponent;
    property PropName: string read FPropName write SetPropName;
    property Inverted: Boolean read FInverted write SetInverted;
  end;

implementation

uses Consts, SysUtils;

{*** TDCPropCheck ***********************************************}

procedure TDCPropCheck.ClearSavePropInfo;
begin
  FPropName := '';
  piType := 0;
end;

procedure TDCPropCheck.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = FComponent then
      Component := nil;
end;

procedure TDCPropCheck.Toggle;
begin
  inherited;
  SetCompPropValue;
end;

procedure TDCPropCheck.Loaded;
begin
  inherited;
  GetCompPropValue;
end;

procedure TDCPropCheck.Update;
begin
  inherited;
  GetCompPropValue;
end;

function TDCPropCheck.GoodPropName(PropNameStr: string): Boolean;

  procedure GetSubPropType(AComp: TPersistent; AName: string);
  var
    PointPos: integer;
    PropInfo: PPropInfo;
  begin
    PointPos := Pos('.', AName);
    if PointPos = 0 then
    begin
      piName := AName; //simple property found
      if piType <> 2 then
        piObject := AComp;
    end
    else
    begin
      PropInfo := GetPropInfo(AComp.ClassInfo, Copy(AName, 1, PointPos - 1));
      case PropInfo.PropType^.Kind of
        tkClass: piType := 1;
        tkSet: piType := 2;
        else piType := 0;
      end;
      if piType = 2 then
        piPropInfo := PropInfo^
      else
        piObject := TPersistent(GetOrdProp(AComp, PropInfo));
      GetSubPropType(piObject,
        Copy(AName, PointPos + 1, Length(AName) - PointPos));
    end;
  end;

var
  pi: PPropInfo;
begin
  piType := 1;
  piObject := FComponent;
  GetSubPropType(FComponent, PropNameStr);
  case piType of
  1: begin
       pi := GetPropInfo(piObject.ClassInfo, piName);
       Result := (pi <> nil) and (CompareText(pi.PropType^.Name, 'Boolean') = 0);
     end;
  2: begin
       piSetValue := GetEnumValue(GetTypeData(
         piPropInfo.PropType{$IFDEF D3}^{$ENDIF})^.CompType{$IFDEF D3}^{$ENDIF}, piName);
       Result := piSetValue >= 0;
     end;
  else Result := False;
  end;
end;

procedure TDCPropCheck.SetComponent(Value: TPersistent);
begin
  if Value <> FComponent then
  begin
    FComponent := Value;
    if (FComponent <> nil) and not GoodPropName(FPropName) then
      ClearSavePropInfo; //clear PropName if Component doesn't have such property
    GetCompPropValue;
  end;
end;

procedure TDCPropCheck.SetPropName(Value: string);
begin
  if Value <> FPropName then
  begin
    FPropName := Trim(Value);
    if csLoading in ComponentState then
      exit;
    if (FComponent = nil) or GoodPropName(Value) then
      GetCompPropValue;
  end;
end;

procedure TDCPropCheck.SetInverted(Value: Boolean);
begin
  if Value <> FInverted then
  begin
    FInverted := Value;
    GetCompPropValue;
  end;
end;

procedure TDCPropCheck.GetCompPropValue;
var
  li, val: Longint;
  i: integer;
begin
  Enabled := (FComponent <> nil) and (FPropName <> '');
  if Enabled then
    case piType of
    1: Checked := Boolean(GetOrdProp(piObject,
         GetPropInfo(piObject.ClassInfo, piName))) xor FInverted;
    2: begin
         li := GetOrdProp(piObject, @piPropInfo);
         val := 1;
         for i := 1 to piSetValue do
           val := val shl 1; //get bitmask for set-element
         Checked := ((li and val) <> 0) xor FInverted;
       end;
    end;
end;

procedure TDCPropCheck.SetCompPropValue;
var
  li, val: Longint;
  i: integer;
begin
  if (FComponent <> nil) and (FPropName <> '') then
    case piType of
    1: SetOrdProp(piObject, GetPropInfo(piObject.ClassInfo, piName),
         Longint(Checked xor FInverted));
    2: begin
         li := GetOrdProp(piObject, @piPropInfo);
         val := 1;
         for i := 1 to piSetValue do
           val := val shl 1; //get bitmask for set-element
         if Checked xor FInverted then
           li := li or val
         else
           li := li and not val;
         SetOrdProp(piObject, @piPropInfo, li);
       end;
    end;
end;

end.
