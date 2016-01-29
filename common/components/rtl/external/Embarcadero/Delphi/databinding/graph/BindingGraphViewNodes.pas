{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit BindingGraphViewNodes;

interface

uses
  System.SysUtils, Vcl.Graphics, System.Rtti, System.Bindings.Expression, GraphView;

type
  TGraphNodeValue = class(TGraphNode)
  private
    FValueToStringCallback: TFunc<TValue, String>;
    FValueAsContent: Boolean;

    procedure SetValueAsContent(const Value: Boolean);
  protected
    function GetContent: String; override;
    // if ValueVisible is True, the string returned by this method is attached
    // on the next line in the caption; it returns an empty string, but
    // descendant classes can use it to return emphasize important data
    function GetValueString: String; virtual;
  public
    // specifies if the Content property is automatically set to Value
    property ValueAsContent: Boolean read FValueAsContent write SetValueAsContent;
    // called when ValueVisible is True and when the value of the property
    // needs to be shown on the screen
    property ValueToStringCallback: TFunc<TValue, String> read FValueToStringCallback
      write FValueToStringCallback;
  end;

  // TGraphNodeExpr - maps binding expression
  TGraphNodeExpr = class(TGraphNodeValue)
  private
    FExpression: TBindingExpression;
    procedure SetExpression(const Value: TBindingExpression);
  protected
    // returns the result of the binding expression attached to the graph node
    function GetValueString: String; override;
  public
    constructor Create(Owner: TGraph); override;

    // the expression attached to a node
    property Expression: TBindingExpression read FExpression write SetExpression;
  end;

  // TGraphNodeProp - maps a binding property of an object
  TGraphNodeProp = class(TGraphNodeValue)
  private
    FRttiCtx: TRttiContext;
    FPropertyInfo: TRttiProperty;
    FObj: TObject;
    FPropertyName: String;
    procedure SetObj(const Value: TObject);
    procedure SetPropertyName(const Value: String);
  protected
    // returns the value of ValueToStringCallback if ValueVisible is True or
    // an empty string if it is False
    function GetValueString: String; override;

    // updates the internal fields depending on the value of Obj and PropName
    procedure UpdateData;
  public
    constructor Create(AOwner: TGraph); override;

    // the object that has the property denoted by the node
    property Obj: TObject read FObj write SetObj;
    // the name of the property
    property PropertyName: String read FPropertyName write SetPropertyName;
    // RTTI information on the property
    property PropertyInfo: TRttiProperty read FPropertyInfo;
  end;

implementation

{ TGraphNodeExpr }

constructor TGraphNodeExpr.Create(Owner: TGraph);
begin
  inherited;

  Owner.BeginUpdate;
  Color := clGreen;
  TextColor := clWhite;
  Width := 50;
  Height := 50;
  KeepWidth := True;
  KeepHeight := True;
  Owner.EndUpdate;
end;

function TGraphNodeExpr.GetValueString: String;
begin
  Result := '';
  if Assigned(ValueToStringCallback) and Assigned(Expression) then
    Result := ValueToStringCallback(Expression.OutputValue);
end;

procedure TGraphNodeExpr.SetExpression(const Value: TBindingExpression);
begin
  if FExpression <> Value then
  begin
    FExpression := Value;
                                                                                    

    Update;
  end;
end;

{ TGraphNodeProp }

constructor TGraphNodeProp.Create(AOwner: TGraph);
begin
  inherited;

  FRttiCtx := TRttiContext.Create;

  Owner.BeginUpdate;
  Color := clBlue;
  TextColor := clWhite;
  Width := 30;
  Height := 30;
  KeepWidth := True;
  KeepHeight := True;
  Owner.EndUpdate;
end;

function TGraphNodeValue.GetContent: String;
begin
  if ValueAsContent then
    Result := GetValueString
  else
    Result := inherited;
end;

function TGraphNodeValue.GetValueString: String;
begin
  Result := '';
end;

function TGraphNodeProp.GetValueString: String;
begin
  Result := '';
  if Assigned(ValueToStringCallback) and Assigned(PropertyInfo) then
    Result := ValueToStringCallback(PropertyInfo.GetValue(Obj));
end;

procedure TGraphNodeProp.SetObj(const Value: TObject);
begin
  if FObj <> Value then
  begin
    FObj := Value;

    UpdateData;
    Update;
  end;
end;

procedure TGraphNodeProp.SetPropertyName(const Value: String);
begin
  if FPropertyName <> Value then
  begin
    FPropertyName := Value;

    UpdateData;
    Update;
  end;
end;

procedure TGraphNodeValue.SetValueAsContent(const Value: Boolean);
begin
  if FValueAsContent <> Value then
  begin
    FValueAsContent := Value;

    UpdateFitText;
    Update;
  end;
end;

procedure TGraphNodeProp.UpdateData;
begin
  FPropertyInfo := nil;
  if Assigned(Obj) then
    FPropertyInfo := FRttiCtx.GetType(Obj.ClassInfo).GetProperty(FPropertyName);
end;

end.
