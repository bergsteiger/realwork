{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.NumberBox;

interface

{$SCOPEDENUMS ON}

uses
  System.UITypes, FMX.Types, FMX.EditBox, FMX.Presentation.Messages, FMX.Controls.Presentation, FMX.Controls.Model;

type

{ TNumberBox }

  TNumberBoxModel = class(TEditBoxModel)
  public const
    DefaultVertIncrement = 5;
  private
    FVertIncrement: Single;
  public
    constructor Create; override;
    property VertIncrement: Single read FVertIncrement write FVertIncrement;
  end;

  TNumberBox = class(TCustomEditBox)
  private
    function GetVertIncrement: Single;
    procedure SetVertIncrement(const Value: Single);
    function VertIncrementStored: Boolean;
    function GetModel: TNumberBoxModel; overload;
  protected
    function DefineModelClass: TDataModelClass; override;
    function DefinePresentationName: string; override;
  public
    property Model: TNumberBoxModel read GetModel;
    property TextAlign;
  published
    property Action;
    property CanFocus default True;
    property CanParentFocus;
    property Cursor default crDefault;
    property DisableFocusEffect;
    property ReadOnly;
    property KeyboardType default TVirtualKeyboardType.NumberPad;
    property TextSettings;
    property Position;
    property Width;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HorzIncrement;
    property VertIncrement: Single read GetVertIncrement write SetVertIncrement stored VertIncrementStored nodefault;
    property ClipChildren default False;
    property ClipParent default False;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Hint;
    property HitTest default True;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property StyleLookup;
    property StyledSettings;
    property TouchTargetExpansion;
    property Visible default True;
    property Caret;
    property KillFocusByReturn;
    property ParentShowHint;
    property ShowHint;
    { Events }
    property OnChange;
    property OnChangeTracking;
    property OnTyping;
    property OnApplyStyleLookup;
    { Drag and Drop events }
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    { Keyboard events }
    property OnKeyDown;
    property OnKeyUp;
    { Mouse events }
    property OnCanFocus;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnPainting;
    property OnPaint;
    property OnResize;
    property OnPresentationNameChoosing;
  end;

implementation

uses
  System.Math.Vectors, System.Math, FMX.NumberBox.Style;

{ TNumberBox }

procedure TNumberBox.SetVertIncrement(const Value: Single);
begin
  Model.VertIncrement := Value;
end;

function TNumberBox.VertIncrementStored: Boolean;
begin
  Result := not SameValue(Model.VertIncrement, TNumberBoxModel.DefaultVertIncrement, TEpsilon.Vector);
end;

function TNumberBox.DefineModelClass: TDataModelClass;
begin
  Result := TNumberBoxModel;
end;

function TNumberBox.DefinePresentationName: string;
begin
  Result := 'NumberBox-' + GetPresentationSuffix;
end;

function TNumberBox.GetModel: TNumberBoxModel;
begin
  Result := GetModel<TNumberBoxModel>;
end;

function TNumberBox.GetVertIncrement: Single;
begin
  Result := Model.VertIncrement;
end;

{ TNumberBoxModel }

constructor TNumberBoxModel.Create;
begin
  inherited;
  VertIncrement := DefaultVertIncrement;
end;

initialization
  RegisterFmxClasses([TNumberBox]);
end.
