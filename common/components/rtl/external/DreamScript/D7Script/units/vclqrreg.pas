{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit vclqrreg;

{ This unit requires Quick Report v2.0 or higher. 
  If you don't have it comment out QREP define
  in DREAM\UNITS\dc.inc
  (If you comment out this define some script examples in \DREAM\SCRIPTS 
  directory may not work properly (scripts that use Quick Report components,
  MastApp for example))
}

interface
{.$I dc.inc}
{$I dcprod.inc}

uses
  {$IFNDEF D3}QuickRep{$ELSE}QuickRpt{$ENDIF},// if this line causes compilation error see above comment

  {$IFDEF D4}
  QRExport,
  {$ENDIF}

  {$IFDEF DREAMIDE}
  dcapp,
  {$ENDIF}

  {$IFDEF MEMODESIGNER}
  dcfdmemo,
  {$ENDIF}

  {$IFDEF DREAMDESIGNER}
  dcfdes,
  {$IFDEF DREAMIDE}
  dcidedes,
  {$ENDIF}
  {$ENDIF}

  {$IFDEF DCEDIT}
  {dcdbctl,} dcdbctlreg,
  {$ENDIF}

  dcsystem,dcgen,forms,dcconsts,dcrespic;

procedure Register;

{$IFNDEF D3}
Type
  TCustomForm=TForm;
  TQuickRep=TQuickReport;
{$ENDIF}

{$IFDEF D3}
procedure CreateQuickRep(FormInstance:TCustomForm);
{$ENDIF}

implementation
uses
  sysutils, windows, typinfo, classes,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  controls, stdctrls,
  db, Dialogs,
  {$IFDEF D3}
  qrprntr,  QRCtrls, QRExtra, QRAbout, QRComped, QRExpbld,
  {$ENDIF}
  {$IFDEF D4}QR3Const{$ELSE}{$IFDEF D3}QR2Const{$ELSE}qrconst{$ENDIF}{$ENDIF};

{--------------------------------------------------------------------}
type

  TDSDataFieldProperty = class(TDBStringProperty)
  public
    function GetDataSetPropName: string; virtual;
    procedure GetValueList(List: TStrings); override;
  end;

  TFloatProperty2 = class(TFloatProperty)
  protected
    function GetValue : String; override;
  end;

  TMasterProperty = class(TComponentProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

{--------------------------------------------------------------------}

function TFloatProperty2.GetValue : String;
begin
  result:=FloatToStrF(GetFloatValue, ffFixed,18,2);
end;

{--------------------------------------------------------------------}

procedure TMasterProperty.GetValues(Proc: TGetStrProc);

  procedure ProcessComponent(C: TComponent);
  begin
    If C.Name='' then exit;
    if ((C is TQuickRep) or (C is TQRController) {$IFDEF D3}or (C is TQRControllerBand){$ENDIF})
    then
      Proc(C.Name);
  end;

  procedure ProcessRoot(C:TComponent);
  var
    I: Integer;
  begin
    With C do
      for I := 0 to ComponentCount - 1 do
        ProcessComponent(Components[I]);
  end;

begin
{$ifdef D3}
  ProcessComponent(TFormDesigner(Designer).GetRoot);
  ProcessRoot(TFormDesigner(Designer).GetRoot);
{$else}
  ProcessRoot(Designer.Form);
{$endif}
end;

{--------------------------------------------------------------------}

{$IFDEF D3}
type
  TQuickRepEditor = Class(TComponentEditor)
  public
    procedure Edit; override;
    procedure ExecuteVerb(Index: integer); override;
    function GetVerb(Index: integer): string; override;
    function GetVerbCount : integer; override;
  end;

{--------------------------------------------------------------------}

procedure TQuickRepEditor.Edit;
begin
  with TQRCompEd.Create(Application) do
  try
    QuickRep:=TQuickRep(Component);
    ShowModal;
  finally
    free;
  end;
end;

{--------------------------------------------------------------------}

procedure TQuickRepEditor.ExecuteVerb(Index: integer);
begin
  With TQuickRep(Component) do
  case Index of
    0 : Self.Edit;
    1 : Preview;
    3 : Zoom := Zoom + 20;
    4 : Zoom := Zoom - 20;
    6 : RotateBands := RotateBands + 1;
    7 : HideBands := true;
    8 : begin
           RotateBands := 0;
           HideBands := false;
        end;
  end;
  if Index in [4, 7, 8] then Designer.Modified;
end;

{--------------------------------------------------------------------}

function TQuickRepEditor.GetVerb(Index: integer): string;
var
  tmp : {$IFDEF D4}string{$ELSE}integer{$ENDIF};
begin
  Case Index of
      0 : tmp := SqrReportSettings;  //4
      1 : tmp := SqrPreview;    //5
      3 : tmp := SqrZoomIn;  //7
      4 : tmp := SqrZoomOut; //8
      6 : tmp := SqrRotateBands;  //10
      7 : tmp := SqrHideBands; //11
      8 : tmp := SqrResetBands; //12
    else
      begin
        result := '-';
        exit;
      end;
  end;
  result := {$IFDEF D4} tmp {$ELSE} LoadStr(tmp) {$ENDIF};
end;

{--------------------------------------------------------------------}

function TQuickRepEditor.GetVerbCount : integer;
begin
  Result:=9;
end;

{--------------------------------------------------------------------}

procedure CreateQuickRep(FormInstance:TCustomForm);
var
  QuickRep:TQuickRep;
begin
  QuickRep:=TQuickRep.Create(FormInstance);
  QuickRep.Parent:=FormInstance;
  QuickRep.Name:='QuickRep1'; //don't resource
end;
{$ENDIF}

{$IFDEF MEMODESIGNER}
{$IFDEF D3}
type
  TIDEReportMemoObject = class(TIDEFormMemoObject)
    constructor CreateNew(const FileName:TFileName; const FilerID:TFilerID;Dummy:Integer);override;
  end;

  TPerlReportObject=class(TIDEReportMemoObject);
  TVBSReportObject=class(TIDEReportMemoObject);
  TJSReportObject=class(TIDEReportMemoObject);
  TDelphiReportObject=class(TIDEReportMemoObject);

constructor TIDEReportMemoObject.CreateNew(const FileName:TFileName; const FilerID:TFilerID;Dummy:Integer);
begin
  inherited;
  CreateQuickRep(FormObject.FormInstance);
  ObjectCreated;
end;
{$ENDIF}

{$ENDIF}

{$IFDEF DCEDIT}
{------------------------------------------------------------------}

function TDSDataFieldProperty.GetDataSetPropName: string;
begin
  Result:='DataSet';  //don't resource
end;

{------------------------------------------------------------------}

procedure TDSDataFieldProperty.GetValueList(List: TStrings);
var
  Instance: TComponent;
  PropInfo: PPropInfo;
  DataSet: TDataSet;
begin
  Instance := TComponent(GetComponent(0));
  PropInfo := TypInfo.GetPropInfo(Instance.ClassInfo, GetDataSetPropName);
  if (PropInfo <> nil) and (PropInfo^.PropType^.Kind = tkClass) then
  begin
    DataSet := TObject(GetOrdProp(Instance, PropInfo)) as TDataSet;
    if (DataSet <> nil) then
      DataSet.GetFieldNames(List);
  end;
end;

{$ENDIF}

{$IFDEF DREAMDESIGNER}
{$IFDEF DREAMIDE}
{$IFDEF D3}
type
  TIDEReportObject = class(TIDEFormObject)
    constructor CreateNew(const FileName:TFileName; const FilerID:TFilerID;Dummy:Integer);override;
  end;

constructor TIDEReportObject.CreateNew(const FileName:TFileName; const FilerID:TFilerID;Dummy:Integer);
begin
  inherited;
  CreateQuickRep(FormInstance);
  ObjectCreated;
end;
{$ENDIF}

{$ENDIF}
{$ENDIF}
{--------------------------------------------------------------------}
//BeginSkipConst
procedure _InstantRegister;
begin
 RegisterComponents(SPalQReport,[TQuickRep,
   {$IFDEF D3}TQRSubDetail,TQRChildBand,TQRExpr,TQRRichText,TQRDBRichText,
   TQRImage,{$ENDIF}
   TQRBand,
   TQRGroup,TQRLabel,TQRDBText,TQRSysData,TQRMemo,
   TQRShape,TQRPreview
 {$IFDEF D4}
 ,TQRTextFilter,TQRCSVFilter,TQRHTMLFilter
 {$ENDIF}
  ]);
 SafeRegisterClasses([{$IFNDEF D4}{TQuickReport,TQRDetailLink,}{$ENDIF}TQRDBCalc]);

 {$IFDEF D3}
 RegisterNonActiveX([TQRSubDetail,TQRBand,TQRImage,TQRPrintable,TQuickRep,
   TQRChildBand,TQRGroup,TQRCustomLabel,TQRDBRichText,TQRDBImage,TQRDBText,
   TQRExpr,TQRSysData,TQRMemo,TQRShape,TQRLabel,TQRCustomRichText,
   TQRCompositeReport,TQRPreview,TQRControllerBand,TQRBasePanel,TQRCustomBand,
   TQRRichText], axrIncludeDescendants);

  {$IFDEF DCEDIT}
  RegisterPropertyEditor(TypeInfo(string), TQRDBRichText, 'DataField', TDSDataFieldProperty);
  {$ENDIF}

 {$ENDIF}

  {$IFDEF D3}
  RegisterPropertyEditor(TypeInfo(extended), TQRPage, '', TFloatProperty2);
  RegisterPropertyEditor(TypeInfo(extended), TQRBandSize, '', TFloatProperty2);
  RegisterPropertyEditor(TypeInfo(extended), TQRPrintableSize, '', TFloatProperty2);
  {$ENDIF}

  {$IFDEF DCEDIT}
  RegisterPropertyEditor(TypeInfo(string), TQRDBText, 'DataField', TDSDataFieldProperty);
  {$IFDEF D3}
  RegisterPropertyEditor(TypeInfo(string), TQRDBImage, 'DataField', TDSDataFieldProperty);
  {$ENDIF}
  {$ENDIF}

  {$IFDEF D3}
  RegisterPropertyEditor(TypeInfo(string), TQRCustomLabel, 'Caption', TCaptionProperty);
  RegisterPropertyEditor(TypeInfo(TComponent), TQRExpr, 'Master', TMasterProperty);
  RegisterPropertyEditor(TypeInfo(TComponent), TQRSubDetail, 'Master', TMasterProperty);
  RegisterComponentEditor(TQuickRep,TQuickRepEditor);
  {$ENDIF}
  RegisterPropertyEditor(TypeInfo(TComponent), TQRGroup, 'Master', TMasterProperty);


{$ifdef D3}
{  RegisterLibraryExpert(TQuickReportExpert.Create);}
{$endif}

//  RegisterPropertyEditor(TypeInfo(string), TQRExpr, 'Expression', TQRExprProperty);
//  RegisterPropertyEditor(TypeInfo(string), TQRGroup, 'Expression', TQRExprProperty);

//  RegisterComponentEditor(TQRImage, TQRGraphicEditor);
//  RegisterComponentEditor(TQRGroup, TQRGroupDesignModeMenu);
//  RegisterComponentEditor(TQRSubDetail, TQRSubDetailDesignModeMenu);

  {$IFDEF DREAMDESIGNER}
  {$IFDEF D3}
  RegisterNewItem(TIDEReportObject,Sunitdfm,'NEWREPORT',SPageReport,SSimpleReport);
  {$ENDIF}
  {$ENDIF}

  {$IFDEF MEMODESIGNER}
  {$IFDEF D3}
  RegisterClasses([
    TIDEReportMemoObject, TPerlReportObject,  TVBSReportObject,
    TJSReportObject, TDelphiReportObject]);

  RegisterNewItem(TPerlReportObject,Sunitperl,'NEWPERLREPORT',SPageReport,SPerlReport);
  RegisterNewItem(TDelphiReportObject,Sunitpas,'NEWDELPHIREPORT',SPageReport,SDelphiReport);
  RegisterNewItem(TVBSReportObject,Sunitvbs,'NEWVBSREPORT',SPageReport,SVBScriptReport);
  RegisterNewItem(TJSReportObject,Sunitjs,'NEWJSREPORT',SPageReport,SJScriptReport);
  {$ENDIF}
  {$ENDIF}

end;
//EndSkipConst
procedure Register;
begin
  RegisterForInstant(_InstantRegister);
end;

{--------------------------------------------------------------------}
initialization
  RegisterForInstant(_InstantRegister);
end.

