{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit BindCompBasePropEditor;

// Unit not used?
interface

uses
  DesignIntf, DesignEditors, System.Classes, System.TypInfo, System.Generics.Collections;

type
  TCustomSyntheticProperty = class(TBasePropertyEditor, IProperty, IPropertyKind)
  private
    FDesigner: IDesigner;
  protected
    { IProperty }
    procedure Initialize; override;
    procedure SetPropEntry(Index: Integer; AInstance: TPersistent;
      APropInfo: PPropInfo); override;
    procedure Activate;
    function AllEqual: Boolean;
    function AutoFill: Boolean;
    procedure Edit; virtual;
    function HasInstance(Instance: TPersistent): Boolean;
    function GetAttributes: TPropertyAttributes; virtual;
    function GetEditLimit: Integer;
    function GetEditValue(out Value: string): Boolean;
    function GetName: string; virtual;
    function GetValue: string; virtual;
    procedure SetValue(const Value: string); virtual;
    procedure GetProperties(Proc: TGetPropProc); virtual;
    function GetPropInfo: PPropInfo; virtual;
    function GetPropType: PTypeInfo; virtual;
    procedure GetValues(Proc: TGetStrProc); virtual;
    procedure Revert;
    function ValueAvailable: Boolean;
    { IPropertyKind }
    function GetKind: TTypeKind; virtual;
  public
    constructor Create(const ADesigner: IDesigner; APropCount: Integer); override;
    property Designer: IDesigner read FDesigner;
  end;

  TPropertyList = TList<IProperty>;

implementation

{ TCustomSyntheticProperty }

constructor TCustomSyntheticProperty.Create(const ADesigner: IDesigner; APropCount: Integer);
begin
  inherited;
  FDesigner := ADesigner;
end;

procedure TCustomSyntheticProperty.Activate;
begin
end;

function TCustomSyntheticProperty.AllEqual: Boolean;
begin
  Result := True;
end;

function TCustomSyntheticProperty.AutoFill: Boolean;
begin
  Result := True;
end;

procedure TCustomSyntheticProperty.Edit;
begin
  inherited;
end;

function TCustomSyntheticProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paNotNestable, paReadOnly];
end;

function TCustomSyntheticProperty.GetEditLimit: Integer;
begin
  Result := -1;
end;

function TCustomSyntheticProperty.GetEditValue(out Value: string): Boolean;
begin
  Result := True;
  Value := GetValue;
end;

function TCustomSyntheticProperty.GetKind: TTypeKind;
begin
  Result := tkInteger;
end;

function TCustomSyntheticProperty.GetName: string;
begin
  Result := '';
end;

procedure TCustomSyntheticProperty.GetProperties(Proc: TGetPropProc);
begin
end;

function TCustomSyntheticProperty.GetPropInfo: PPropInfo;
begin
  Result := nil;
end;

function TCustomSyntheticProperty.GetPropType: PTypeInfo;
begin
  Result := nil;
end;

function TCustomSyntheticProperty.GetValue: string;
begin
  Result := ''
end;

procedure TCustomSyntheticProperty.GetValues(Proc: TGetStrProc);
begin
end;

function TCustomSyntheticProperty.HasInstance(Instance: TPersistent): Boolean;
begin
  Result := False;
end;

procedure TCustomSyntheticProperty.Initialize;
begin
  inherited;
end;

procedure TCustomSyntheticProperty.Revert;
begin
end;

procedure TCustomSyntheticProperty.SetPropEntry(Index: Integer;
  AInstance: TPersistent; APropInfo: PPropInfo);
begin
  inherited;
end;

procedure TCustomSyntheticProperty.SetValue(const Value: string);
begin
end;

function TCustomSyntheticProperty.ValueAvailable: Boolean;
begin
  Result := True;
end;

end.
