{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit BindVisualizers;

interface

uses System.Bindings.EvalProtocol, System.Classes,System.SysUtils, Vcl.StdCtrls, Vcl.Controls;

type
  TBindExpressionVisualizerView = class;

  TBindExpressionVisualizer = class
  protected
    function GetName: string; virtual; abstract;
  public
    property Name: string read GetName;
    function SupportsValue(AValue: IValue): Boolean; virtual; abstract;
    function CreateView: TBindExpressionVisualizerView; virtual; abstract;
  end;

  TBindExpressionVisualizerClass = class of TBindExpressionVisualizer;

  TBindExpressionVisualizerView = class
  private
    FVisualizer: TBindExpressionVisualizer;
  public
    constructor Create(AVisualizer: TBindExpressionVisualizer);
    procedure Show(AOwner: TComponent; AParent: TWinControl); virtual; abstract;
    procedure Update(AValue: IValue); virtual; abstract;
    procedure Clear; virtual; abstract;
    property Visualizer: TBindExpressionVisualizer read FVisualizer;
  end;

  procedure RegisterVisualizerClasses(AClasses: array of TBindExpressionVisualizerClass);
  procedure UnregisterVisualizerClasses(AClasses: array of TBindExpressionVisualizerClass);
  function GetVisualizerClasses: TArray<TBindExpressionVisualizerClass>;

implementation

uses
  System.Generics.Collections, Vcl.Graphics, Vcl.ExtCtrls, Vcl.Forms,
  System.UITypes, BindCompDsnResStrs;

type
  TVisualizerClasses = class
  strict private
    class var FInstance: TVisualizerClasses;
    var
    FList: TList<TBindExpressionVisualizerClass>;
  public
    class constructor Create;
    class destructor Destroy;
    constructor Create;
    destructor Destroy; override;
    procedure Add(AClass: TBindExpressionVisualizerClass);
    procedure Remove(AClass: TBindExpressionVisualizerClass);
    function GetClasses: TArray<TBindExpressionVisualizerClass>;
    class property Instance: TVisualizerClasses read FInstance;
  end;

procedure RegisterVisualizerClasses(AClasses: array of TBindExpressionVisualizerClass);
var
  LClass: TBindExpressionVisualizerClass;
begin
  for LClass in AClasses do
    TVisualizerClasses.Instance.Add(LClass);
end;

procedure UnregisterVisualizerClasses(AClasses: array of TBindExpressionVisualizerClass);
var
  LClass: TBindExpressionVisualizerClass;
begin
  for LClass in AClasses do
    TVisualizerClasses.Instance.Remove(LClass);
end;

function GetVisualizerClasses: TArray<TBindExpressionVisualizerClass>;
begin
  Result := TVisualizerClasses.Instance.GetClasses;
end;

type

  TBindExpressStringVisualizer = class(TBindExpressionVisualizer)
  private
    function TryAsString(AValue: IValue; out AString: string): Boolean;
  protected
    function GetName: string; override;
  public
    function SupportsValue(AValue: IValue): Boolean; override;
    function CreateView: TBindExpressionVisualizerView; override;
  end;

  TBindExpressionStringVisualizerView = class(TBindExpressionVisualizerView)
  private
    FMemo: TMemo;
    FVisualizer: TBindExpressStringVisualizer;
  public
    constructor Create(AVisualizer: TBindExpressionVisualizer);
    destructor Destroy; override;
    procedure Show(AOwner: TComponent; AParent: TWinControl); override;
    procedure Update(AValue: IValue); override;
    procedure Clear; override;
  end;

  TBindExpressTypeVisualizer = class(TBindExpressionVisualizer)
  protected
    function GetName: string; override;
  public
    function SupportsValue(AValue: IValue): Boolean; override;
    function CreateView: TBindExpressionVisualizerView; override;
  end;

  TBindExpressionTypeVisualizerView = class(TBindExpressionVisualizerView)
  private
    FMemo: TMemo;
  public
    destructor Destroy; override;
    procedure Show(AOwner: TComponent; AParent: TWinControl); override;
    procedure Update(AValue: IValue); override;
    procedure Clear; override;
  end;

  TBindExpressPictureVisualizer = class(TBindExpressionVisualizer)
  private
    function TryAsPicture(AValue: IValue; out APicture: TPicture): Boolean;
  protected
    function GetName: string; override;
  public
    function SupportsValue(AValue: IValue): Boolean; override;
    function CreateView: TBindExpressionVisualizerView; override;
  end;

  TBindExpressionPictureVisualizerView = class(TBindExpressionVisualizerView)
  private
    FImage: TImage;
    FPanel: TPanel;
    FVisualizer: TBindExpressPictureVisualizer;
  public
    constructor Create(AVisualizer: TBindExpressionVisualizer);
    destructor Destroy; override;
    procedure Show(AOwner: TComponent; AParent: TWinControl); override;
    procedure Update(AValue: IValue); override;
    procedure Clear; override;
  end;


{ TBindExpressStringVisualizer }

function TBindExpressStringVisualizer.CreateView: TBindExpressionVisualizerView;
begin
  Result := TBindExpressionStringVisualizerView.Create(Self);
end;

function TBindExpressStringVisualizer.GetName: string;
begin
  Result := sStringVisualizer;
end;

function TBindExpressStringVisualizer.TryAsString(AValue: IValue; out AString: string): Boolean;
var
  LString: string;
  LInteger: Integer;
  LDouble: Double;
begin
  Result := True;
  AString := '';
  if AValue = nil then
    AString := '(nil)'
  else if AValue.GetValue.IsEmpty then
    AString := '(empty)'
  else
    if AValue.GetValue.TryAsType<string>(LString) then
      AString := '''' + LString + ''''
    else if AValue.GetValue.TryAsType<Integer>(LInteger) then
      AString := IntToStr(LInteger)
    else if AValue.GetValue.TryAsType<Double>(LDouble) then
      AString := FloatToStr(LDouble)
    else
      Result := False;
end;

function TBindExpressStringVisualizer.SupportsValue(AValue: IValue): Boolean;
var
  LString: string;
begin
  Result := (AValue <> nil) and TryAsString(AValue, LString);
end;

{ TBindExpressionStringVisualizerView }

procedure TBindExpressionStringVisualizerView.Clear;
begin
  if FMemo <> nil then
    FMemo.Clear;
end;

constructor TBindExpressionStringVisualizerView.Create(
  AVisualizer: TBindExpressionVisualizer);
begin
  inherited;
  FVisualizer := TBindExpressStringVisualizer(AVisualizer);
end;

destructor TBindExpressionStringVisualizerView.Destroy;
begin
  FMemo.Free;
  inherited;
end;

procedure TBindExpressionStringVisualizerView.Show(AOwner: TComponent; AParent: TWinControl);
begin
  if FMemo = nil then
  begin
    FMemo := TMemo.Create(AOwner);
    FMemo.ScrollBars := System.UITypes.TScrollStyle.ssVertical;
    FMemo.WordWrap := True;
    FMemo.Align := alClient;
    FMemo.ReadOnly := True;
  end;
  FMemo.Parent := AParent;
end;


procedure TBindExpressionStringVisualizerView.Update(AValue: IValue);
var
  LString: string;
begin
  if FMemo <> nil then
  begin
    if FVisualizer.TryAsString(AValue, LString) then
      FMemo.Text := LString
    else if AValue.GetValue.TypeInfo <> nil then
      FMemo.Text := 'Visualizer does not support type: ' + String(AValue.GetValue.TypeInfo.Name)
    else
      FMemo.Text := '(undefined)';
  end;
end;

{ TBindExpressTypeVisualizer }

function TBindExpressTypeVisualizer.CreateView: TBindExpressionVisualizerView;
begin
  Result := TBindExpressionTypeVisualizerView.Create(Self);
end;

function TBindExpressTypeVisualizer.GetName: string;
begin
  Result := sTypeVisualizer;
end;

function TBindExpressTypeVisualizer.SupportsValue(AValue: IValue): Boolean;
begin
  Result := True;
end;

{ TBindExpressionTypeVisualizerView }

procedure TBindExpressionTypeVisualizerView.Clear;
begin
  if FMemo <> nil then
    FMemo.Clear;
end;

destructor TBindExpressionTypeVisualizerView.Destroy;
begin
  FMemo.Free;
  inherited;
end;

procedure TBindExpressionTypeVisualizerView.Show(AOwner: TComponent; AParent: TWinControl);
begin
  if FMemo = nil then
  begin
    FMemo := TMemo.Create(AOwner);
    FMemo.ScrollBars := System.UITypes.TScrollStyle.ssVertical;
    FMemo.WordWrap := True;
    FMemo.Align := alClient;
    FMemo.ReadOnly := True;
  end;
  FMemo.Parent := AParent;
end;


procedure TBindExpressionTypeVisualizerView.Update(AValue: IValue);
begin
  if FMemo <> nil then
  begin
    if AValue = nil then
      FMemo.Text := '(nil)'
    else if AValue.GetValue.IsEmpty then
      FMemo.Text := '(empty)'
    else
      try
        if AValue.GetValue.TypeInfo <> nil then
          FMemo.Text := 'Type: ' + String(AValue.GetValue.TypeInfo.Name)
        else
          FMemo.Text := '(undefined)';
      except
        on E: Exception do
          FMemo.Text := E.Message;
      end;
  end;
end;

{ TBindExpressPictureVisualizer }

function TBindExpressPictureVisualizer.CreateView: TBindExpressionVisualizerView;
begin
  Result := TBindExpressionPictureVisualizerView.Create(Self);
end;

function TBindExpressPictureVisualizer.GetName: string;
begin
  Result := sPictureVisualizer;
end;

function TBindExpressPictureVisualizer.TryAsPicture(AValue: IValue; out APicture: TPicture): Boolean;
begin
  Result := False;
  if AValue <>  nil then
    if not AValue.GetValue.IsEmpty then
      if AValue.GetValue.TryAsType<TPicture>(APicture) then
        Result := True;
end;

function TBindExpressPictureVisualizer.SupportsValue(AValue: IValue): Boolean;
var
  LPicture: TPicture;
begin
  Result := TryAsPicture(AValue, LPicture);
end;

{ TBindExpressionPictureVisualizerView }

procedure TBindExpressionPictureVisualizerView.Clear;
begin
  if FImage <> nil then
    FImage.Picture.Graphic := nil;
end;

constructor TBindExpressionPictureVisualizerView.Create(
  AVisualizer: TBindExpressionVisualizer);
begin
  inherited;
  FVisualizer := TBindExpressPictureVisualizer(AVisualizer);
end;

destructor TBindExpressionPictureVisualizerView.Destroy;
begin
  FPanel.Free;
  inherited;
end;

procedure TBindExpressionPictureVisualizerView.Show(AOwner: TComponent; AParent: TWinControl);
begin
  if FImage = nil then
  begin
    FPanel := TPanel.Create(AOwner);
    FPanel.Align := alClient;
    FPanel.BorderStyle := Vcl.Forms.TFormBorderStyle.bsSingle;
    FPanel.BorderWidth := 1;
    FPanel.BevelOuter := bvNone;
    FImage := TImage.Create(FPanel);
    FImage.Align := alClient;
    FImage.Parent := FPanel;
  end;
  FPanel.Parent := AParent;
end;


procedure TBindExpressionPictureVisualizerView.Update(AValue: IValue);
var
  LPicture: TPicture;
begin
  if FImage <> nil then
  begin
    if FVisualizer.TryAsPicture(AValue, LPicture) then
      FImage.Picture.Assign(LPicture)
    else
      FImage.Picture.Graphic := nil;
  end;
end;


{ TVisualizerClasses }

procedure TVisualizerClasses.Add(AClass: TBindExpressionVisualizerClass);
begin
  FList.Add(AClass);
end;

constructor TVisualizerClasses.Create;
begin
  FList := TList<TBindExpressionVisualizerClass>.Create;

end;

class constructor TVisualizerClasses.Create;
begin
  FInstance := TVisualizerClasses.Create;
end;

destructor TVisualizerClasses.Destroy;
begin
  FList.Free;
  inherited;
end;

class destructor TVisualizerClasses.Destroy;
begin
  FreeAndNil(FInstance);
end;

function TVisualizerClasses.GetClasses: TArray<TBindExpressionVisualizerClass>;
begin
  Result := FList.ToArray;
end;

procedure TVisualizerClasses.Remove(AClass: TBindExpressionVisualizerClass);
begin
  FList.Remove(AClass);
end;

{ TBindExpressionVisualizerView }

constructor TBindExpressionVisualizerView.Create(
  AVisualizer: TBindExpressionVisualizer);
begin
  FVisualizer := AVisualizer;
end;

initialization
  RegisterVisualizerClasses([TBindExpressStringVisualizer, TBindExpressTypeVisualizer, TBindExpressPictureVisualizer]);
finalization
  UnregisterVisualizerClasses([TBindExpressStringVisualizer, TBindExpressTypeVisualizer, TBindExpressPictureVisualizer]);
end.
