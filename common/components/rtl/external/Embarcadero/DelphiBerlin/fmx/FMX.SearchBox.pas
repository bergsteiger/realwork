{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.SearchBox;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, FMX.Edit, FMX.Controls, FMX.Controls.Model;

type

  /// <summary>Type of event handler for filtering of string value. If value is filtered by the filter condition,
  /// <c>Accept</c> should be True, Otherwise - false</summary>
  TFilterEvent = procedure (Sender: TObject; const AFilter: string; const AValue: string; var Accept: Boolean) of object;

{ TSearchBox }

  TSearchBoxModel = class(TCustomEditModel)
  private
    [Weak] FSearchResponder: ISearchResponder;
    FOnFilter: TFilterEvent;
  protected
    procedure DoChangeTracking; override;
  public
    property SearchResponder: ISearchResponder read FSearchResponder write FSearchResponder;
    /// <summary>Event handler for setting custom filter on text of <c>TSearchBox</c>.</summary>
    property OnFilter: TFilterEvent read FOnFilter write FOnFilter;
  end;

  TSearchBox = class(TEdit, IListBoxHeaderTrait)
  private
    function GetOnFilter: TFilterEvent;
    procedure SetOnFilter(const Value: TFilterEvent);
    function GetModel: TSearchBoxModel; overload;
  protected
    function DefinePresentationName: string; override;
    function DefineModelClass: TDataModelClass; override;
    procedure ParentChanged; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Model: TSearchBoxModel read GetModel;
  published
    /// <summary>Event handler for setting custom filter on text of <c>TSearchBox</c>.</summary>
    property OnFilter: TFilterEvent read GetOnFilter write SetOnFilter;
  end;

implementation

uses
{$IFDEF MACOS}
  Macapi.CoreFoundation,
{$ENDIF}
  System.SysUtils, FMX.Types, FMX.SearchBox.Style;

{ TSearchBox }

constructor TSearchBox.Create(AOwner: TComponent);
begin
  inherited;
  Align := TAlignLayout.Top;
end;

function TSearchBox.DefineModelClass: TDataModelClass;
begin
  Result := TSearchBoxModel;
end;

function TSearchBox.DefinePresentationName: string;
begin
  Result := 'SearchBox-' + GetPresentationSuffix;
end;

function TSearchBox.GetModel: TSearchBoxModel;
begin
  Result := GetModel<TSearchBoxModel>;
end;

function TSearchBox.GetOnFilter: TFilterEvent;
begin
  Result := Model.OnFilter;
end;

procedure TSearchBox.ParentChanged;
var
  ParentObject: TFmxObject;
  SearchResponder: ISearchResponder;
begin
  inherited;
  ParentObject := Self.Parent;
  while (ParentObject <> nil) and not Supports(ParentObject, ISearchResponder, SearchResponder) do
    ParentObject := ParentObject.Parent;
  Model.SearchResponder := SearchResponder;
end;

procedure TSearchBox.SetOnFilter(const Value: TFilterEvent);
begin
  Model.OnFilter := Value;
end;

{ TSearchBoxModel }

procedure TSearchBoxModel.DoChangeTracking;
var
  Lower: string;
begin
  inherited;
  Lower := Text.Trim.ToLower;
  if SearchResponder <> nil then
    SearchResponder.SetFilterPredicate(function (X: string): Boolean
      begin
        Result := True;
        if Assigned(OnFilter) then
          OnFilter(Owner, Text, X, Result)
        else
          Result := Lower.IsEmpty or X.ToLower.Contains(Lower);
      end);
end;

initialization
  RegisterFmxClasses([TSearchBox]);
end.
