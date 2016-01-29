{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit vcldbreg;

interface
{.$I dc.inc}
{$I dcprod.inc}
uses

// --------------- Dream Company Units -------------

  dcsystem,dcconsts,dcrespic,

    {$IFDEF DCEDIT}
      dcdbctl,
    {$ENDIF}

// --------------- Delphi Units ----------------

  windows, classes, db, dbctrls, dbgrids,
  dcGen,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcdbctlreg,
  typinfo, controls, forms, dialogs, sysutils,clipbrd, stdctrls,
  dblookup

  {$IFDEF USEBDE}
  ,dbtables
  {$ENDIF}

  {$IFDEF D3}
  {$IFDEF CSDELPHI}
  ,dbclient{$IFNDEF D5},bdeprov{$ENDIF}
  {$IFDEF D4}
  ,mconnect,
  {$IFNDEF CPB5}{$IFNDEF D6}corbacon,{$ENDIF}{$ENDIF}
  sconnect,provider,ObjBrkr,MIDASCon
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  ;

{------------------------------------------------------------------}

procedure Register;

{------------------------------------------------------------------}

implementation

type
  TLookupFieldProperty = class(TDataFieldProperty)
  public
    function GetDataSourcePropName: string; override;
  end;

{------------------------------------------------------------------}

procedure _InstantRegister;
begin
  If Assigned(RegisterComponentsProc) then
  begin
    RegisterComponents(SPalDataAccess, [TDataSource
    {$IFDEF USEBDE}
    , TTable
    , TQuery
    , TStoredProc
    , TDatabase
    , TSession
    , TBatchMove
    , TUpdateSQL
    {$ENDIF}

    {$IFDEF D3}
    {$IFNDEF D4}
    {$IFDEF CSDELPHI}
      ,TProvider,TClientDataSet, TRemoteServer
    {$ENDIF}
    {$ENDIF}
    {$ENDIF}

    {$IFDEF D4}
    {$IFDEF USEBDE}
      ,TNestedTable
    {$ENDIF}
    {$ENDIF}
      ]);

    {$IFDEF D4}
    {$IFDEF CSDELPHI}
    RegisterComponents(SPalMidas,[TClientDataSet,TDCOMConnection,{$IFNDEF CPB5}{$IFNDEF D6}TCorbaConnection,{$ENDIF}{$ENDIF}
    TSocketConnection,TOLEnterpriseConnection,TDatasetProvider,TProvider,
    TSimpleObjectBroker,TRemoteServer,TMidasConnection ]);
    {$ENDIF}
    {$ENDIF}

    RegisterComponents(SPalDataControls, [TDBGrid, TDBNavigator, TDBText,
      TDBEdit, TDBMemo, TDBImage, TDBListBox, TDBComboBox, TDBCheckBox,
      TDBRadioGroup, TDBLookupListBox, TDBLookupComboBox
    {$IFDEF D3}
       ,TDBRichEdit
    {$ENDIF}
      ]);

    RegisterNoIcon([TField]);

    RegisterFields([TStringField, TIntegerField, TSmallintField, TWordField,
      TFloatField, TCurrencyField, TBCDField, TBooleanField, TDateField,
      TVarBytesField, TBytesField, TTimeField, TDateTimeField,
      TBlobField, TMemoField, TGraphicField, TAutoIncField
      {$IFDEF D4}
      ,TADTField, TArrayField, TLargeIntField, TDataSetField, TReferenceField,
      TAggregateField
      {$ENDIF}
      ]);
  end;

  RegisterVisualProperty(SVerbColumnsEditor,TDBGrid,'Columns'); //don't resource

  RegisterComponents(SPalWin31, [TDBLookupList, TDBLookupCombo]);
    {$IFDEF DCEDIT}
      RegisterPropertyEditor(TypeInfo(string), TDBLookupCombo, 'LookupField', TLookupFieldProperty);//don't resource
      RegisterPropertyEditor(TypeInfo(string), TDBLookupCombo, 'LookupDisplay', TLookupFieldProperty);//don't resource
    {$ENDIF}
end;

procedure Register;
begin
  RegisterForInstant(_InstantRegister);
end;

{------------------------------------------------------------------}

procedure mregisterfieldproc (const FieldClasses: array of TFieldClass);
Var
  i:Integer;
begin
  for i := Low(FieldClasses) to High(FieldClasses) do
    begin
      SafeRegisterClass(FieldClasses[i]);
      ClassItems.RegisterClass(FieldClasses[i],[icField,icNoIcon]);
    end;
end;

{------------------------------------------------------------------}

procedure PatchDBpackage;
begin
  If not Assigned(RegisterFieldsProc) then
    RegisterFieldsProc:=mregisterfieldproc;
end;

{------------------------------------------------------------------}

procedure UnPatchDBPackage;
begin
  If @RegisterFieldsProc=@mregisterfieldproc then
    RegisterFieldsProc:=nil;
end;

{******************************************************************}

function TLookupFieldProperty.GetDataSourcePropName: string;
begin
  Result := 'LookupSource';//don't resource
end;

{------------------------------------------------------------------}

initialization
  PatchDBPackage;
  RegisterForInstant(_InstantRegister);
finalization
  UnPatchDBPackage;
end.

