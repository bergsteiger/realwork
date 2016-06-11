{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.BindSource;

interface

uses
  System.SysUtils,
  System.Classes,
  System.TypInfo,
  System.Generics.Collections,
  Data.Bind.Components,
  Data.Bind.ObjectScope;

type
  TRESTComponentBindSource = class;

  /// <summary>
  /// Base notify class for REST components. Support for multicast notifications
  /// </summary>
  TRESTComponentNotify = class
  public
    procedure PropertyValueChanged(Sender: TObject); virtual;
  end;

  /// <summary>
  /// Base notify class for REST components that have a JSON result. Support for multicast notifications
  /// </summary>
  TRESTJSONComponentNotify = class(TRESTComponentNotify)
  public
    procedure JSONValueChanged(Sender: TObject); virtual;
  end;

  /// <summary>
  /// LiveBindings adapter for REST components. Create bindable members
  /// </summary>
  TRESTComponentAdapter = class(TBindSourceAdapter)
  public type
    TNotify = class(TRESTComponentNotify)
    private
      FAdapter: TRESTComponentAdapter;
    public
      constructor Create(const AAdapter: TRESTComponentAdapter);
      procedure PropertyValueChanged(Sender: TObject); override;
    end;

    TReadWriteField<T> = class(TBindSourceAdapterReadWriteField<T>)
    private
      FPersistent: TPersistent;
    public
      // Reference object associated with field, such a TCollectionItem
      property Persistent: TPersistent read FPersistent;
    end;

    TReadField<T> = class(TBindSourceAdapterReadField<T>)
    private
      FPersistent: TPersistent;
    public
      // Reference object associated with field, such a TCollectionItem
      property Persistent: TPersistent read FPersistent;
    end;
  private
    FDeferActivate: Boolean;
    FPosting: Boolean;
    function HasComponent: Boolean;
    function ComponentLoading: Boolean;
  protected
    procedure DoChangePosting; virtual;
    procedure DoAfterPostFields(AFields: TArray<TBindSourceAdapterField>); override;
    procedure DoBeforePostFields(AFields: TArray<TBindSourceAdapterField>); override;
    function GetSource: TBaseLinkingBindSource; virtual;
    procedure Loaded; override;
    procedure SetActive(AValue: Boolean); override;
    function GetCanActivate: Boolean; override;
    function GetCanModify: Boolean; override;
    function SupportsNestedFields: Boolean; override;
    function GetCount: Integer; override;
    procedure DoBeforeOpen; override;
    procedure DoAfterClose; override;
    procedure AddFields; virtual;
    procedure CheckInactive;
    procedure CreateReadOnlyField<T>(const AFieldName: string; const AGetMemberObject: IGetMemberObject;
      AMemberType: TScopeMemberType; const AGetterFunc: TFunc<T>; const APersistent: TPersistent = nil);
    procedure CreateReadWriteField<T>(const AFieldName: string; const AGetMemberObject: IGetMemberObject;
      AMemberType: TScopeMemberType; const AGetterFunc: TFunc<T>; const ASetterProc: TProc<T>;
      const APersistent: TPersistent = nil);
    procedure RefreshFields;
    property Posting: Boolean read FPosting;
  end;

  /// <summary>
  /// LiveBindings bindsource for REST components.
  /// </summary>
  TRESTComponentBindSource = class(TBaseObjectBindSource)
  strict private
    FAdapter: TRESTComponentAdapter;
  private
    function GetAutoEdit: Boolean;
    function GetAutoPost: Boolean;
    procedure SetAutoEdit(const AValue: Boolean);
    procedure SetAutoPost(const AValue: Boolean);
  protected
    function GetInternalAdapter: TBindSourceAdapter; override;
    function CreateAdapter: TRESTComponentAdapter; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    property AutoEdit: Boolean read GetAutoEdit write SetAutoEdit default True;
    property AutoPost: Boolean read GetAutoPost write SetAutoPost default True;
    property AutoActivate default True;
    property Adapter: TRESTComponentAdapter read FAdapter;
  end;

  /// <summary>
  /// List of notify objects for REST components. Support for multicast notifications
  /// </summary>
  TRESTComponentNotifyList<T: TRESTComponentNotify> = class(TObject)
  private
    FNotifyList: TList<T>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddNotify(const ANotify: T);
    procedure RemoveNotify(const ANotify: T);
    procedure Notify(const AProc: TProc<T>);
  end;

implementation

uses
  REST.Consts,
  REST.Types;

{ TRESTComponentNotify }

procedure TRESTComponentNotify.PropertyValueChanged(Sender: TObject);
begin
  //
end;

{ TRESTComponentAdapter }

procedure TRESTComponentAdapter.DoAfterClose;
begin
  inherited;
  ClearFields;
end;

procedure TRESTComponentAdapter.DoBeforeOpen;
begin
  inherited;
  AddFields;
  FPosting := False;
  DoChangePosting;
end;

procedure TRESTComponentAdapter.DoBeforePostFields(
  AFields: TArray<TBindSourceAdapterField>);
begin
  FPosting := True;
  DoChangePosting;
  inherited;
end;

procedure TRESTComponentAdapter.DoChangePosting;
begin
//
end;

procedure TRESTComponentAdapter.DoAfterPostFields(
  AFields: TArray<TBindSourceAdapterField>);
begin
  FPosting := False;
  DoChangePosting;
  inherited;
end;

procedure TRESTComponentAdapter.AddFields;
begin
end;

function TRESTComponentAdapter.GetCanActivate: Boolean;
begin
  Result := HasComponent;
end;

function TRESTComponentAdapter.GetCanModify: Boolean;
begin
  Result := True;
end;

function TRESTComponentAdapter.GetCount: Integer;
begin
  Result := 1;
end;

function TRESTComponentAdapter.GetSource: TBaseLinkingBindSource;
begin
  Result := nil;
end;

function TRESTComponentAdapter.HasComponent: Boolean;
begin
  Result := GetSource <> nil;
end;

procedure TRESTComponentAdapter.Loaded;
begin
  inherited;
  if FDeferActivate then
    try
      Active := True;
    except
      // Ignore exception during load
    end;
end;

procedure TRESTComponentAdapter.RefreshFields;
begin
  if HasComponent and (NOT ComponentLoading) then
  begin
    if Active then
    begin
      if NOT(State IN seEditModes) then
      begin
        // Update all fields when the value of a parameter or property is changed
        Refresh;
      end;
    end;
  end;
end;

procedure TRESTComponentAdapter.SetActive(AValue: Boolean);
begin
  if (csLoading in ComponentState) then
  begin
    if AValue then
    begin
      FDeferActivate := True;
      Exit;
    end;
  end;
  if (AValue = False) or CanActivate then
    inherited;
end;

function TRESTComponentAdapter.SupportsNestedFields: Boolean;
begin
  Result := False; // No special handling for '.'
end;

procedure TRESTComponentAdapter.CheckInactive;
begin
  if Active then
    raise ERESTException.CreateFmt(sOperationNotAllowedOnActiveComponent, [self.ClassName]);
end;

function TRESTComponentAdapter.ComponentLoading: Boolean;
var
  LSource: TComponent;
begin
  LSource := GetSource;
  Result := (LSource <> nil) and (csLoading in LSource.ComponentState);
end;

procedure TRESTComponentAdapter.CreateReadOnlyField<T>(const AFieldName: string;
  const AGetMemberObject: IGetMemberObject; AMemberType: TScopeMemberType; const AGetterFunc: TFunc<T>;
  const APersistent: TPersistent);
var
  LField: TReadField<T>;
  LParamReader: TValueReader<T>;
  LTypeInfo: PTypeInfo;
begin
  LParamReader := TValueReaderFunc<T>.Create(AFieldName,
    function(AName: string): T
    begin
      if HasComponent then
        Result := AGetterFunc;
    end);

  LTypeInfo := System.TypeInfo(T);
  LField := TReadField<T>.Create(self, AFieldName, TBindSourceAdapterFieldType.Create(LTypeInfo.NameFld.ToString,
    LTypeInfo.Kind), AGetMemberObject, LParamReader, AMemberType);
  LField.FPersistent := APersistent;

  Fields.Add(LField);
end;

procedure TRESTComponentAdapter.CreateReadWriteField<T>(const AFieldName: string;
const AGetMemberObject: IGetMemberObject; AMemberType: TScopeMemberType; const AGetterFunc: TFunc<T>;
const ASetterProc: TProc<T>; const APersistent: TPersistent);
var
  LField: TReadWriteField<T>;
  LParamReader: TValueReader<T>;
  LParamWriter: TValueWriter<T>;
  LTypeInfo: PTypeInfo;
begin
  LParamReader := TValueReaderFunc<T>.Create(AFieldName,
    function(AName: string): T
    begin
      if HasComponent then
        Result := AGetterFunc;
    end);

  LParamWriter := TValueWriterProc<T>.Create(AFieldName,
    procedure(AName: string; AValue: T)
    begin
      if HasComponent then
        ASetterProc(AValue);
    end);

  LTypeInfo := System.TypeInfo(T);
  LField := TReadWriteField<T>.Create(self, AFieldName, TBindSourceAdapterFieldType.Create(LTypeInfo.NameFld.ToString,
    LTypeInfo.Kind), AGetMemberObject, LParamReader, LParamWriter, AMemberType);
  LField.FPersistent := APersistent;

  Fields.Add(LField);
end;

{ TRESTComponentAdapter.TNotify }

constructor TRESTComponentAdapter.TNotify.Create(const AAdapter: TRESTComponentAdapter);
begin
  FAdapter := AAdapter;
end;

procedure TRESTComponentAdapter.TNotify.PropertyValueChanged(Sender: TObject);
begin
  FAdapter.RefreshFields;
end;

{ TRESTComponentBindSource }

constructor TRESTComponentBindSource.Create(AOwner: TComponent);
begin
  inherited;
  FAdapter := CreateAdapter;
  Assert(FAdapter <> nil);

  FAdapter.AutoPost := True; // Default
end;

function TRESTComponentBindSource.GetAutoEdit: Boolean;
begin
  Result := FAdapter.AutoEdit;
end;

function TRESTComponentBindSource.GetAutoPost: Boolean;
begin
  Result := FAdapter.AutoPost;
end;

function TRESTComponentBindSource.GetInternalAdapter: TBindSourceAdapter;
begin
  Result := FAdapter;
  if (Result <> NIL) then
    ConnectAdapter(Result);
end;

procedure TRESTComponentBindSource.SetAutoEdit(const AValue: Boolean);
begin
  if (AValue <> FAdapter.AutoEdit) then
  begin
    FAdapter.AutoEdit := AValue;
  end;
end;

procedure TRESTComponentBindSource.SetAutoPost(const AValue: Boolean);
begin
  if (AValue <> FAdapter.AutoPost) then
  begin
    FAdapter.AutoPost := AValue;
  end;
end;

{ TRESTComponenttNotifyList<T> }

procedure TRESTComponentNotifyList<T>.AddNotify(const ANotify: T);
begin
  Assert(not FNotifyList.Contains(ANotify));
  FNotifyList.Add(ANotify);
end;

constructor TRESTComponentNotifyList<T>.Create;
begin
  inherited;

  FNotifyList := TList<T>.Create;
end;

destructor TRESTComponentNotifyList<T>.Destroy;
begin
  FNotifyList.Free;
  inherited;
end;

procedure TRESTComponentNotifyList<T>.Notify(const AProc: TProc<T>);
var
  LNotify: T;
begin
  for LNotify in FNotifyList do
    AProc(LNotify);
end;

procedure TRESTComponentNotifyList<T>.RemoveNotify(const ANotify: T);
begin
  Assert(FNotifyList.Contains(ANotify));
  FNotifyList.Remove(ANotify);
end;

{ TRESTJSONComponentNotify }

procedure TRESTJSONComponentNotify.JSONValueChanged(Sender: TObject);
begin
//
end;

end.
