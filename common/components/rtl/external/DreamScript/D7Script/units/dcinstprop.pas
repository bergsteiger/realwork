{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcinstprop;

interface
{$I dc.inc}

uses
  controls,
  
  {$IFDEF D6}
  RTLConsts,
  {$ENDIF}
  Consts,

  {$IFDEF WIN}
  {$IFNDEF CLX}
    windows,messages,
    {$IFDEF D3} activex,{$ELSE} ole2,oleauto,olectl,{$ENDIF}
  {$ELSE}
    dcactivex,Types,QGraphics,
  {$ENDIF}
  {$ENDIF}
  dcClasses,Classes,Sysutils,Typinfo,dcapi,dchook,
  {$IFDEF WIN}
  {$IFNDEF CLX}
  registry,graphics,//never remove graphics from the uses
  {$ENDIF}
  {$ENDIF}

  dialogs,menus,forms,dcsystem,dcconsts,dcdreamlib

  {$IFDEF WIN}
  {$IFNDEF CLX}
  ,Stdctrls
  {$ELSE}
  ,QStdCtrls
  {$ENDIF}
  {$ENDIF}
  {$IFDEF D6}
  ,Variants
  {$ENDIF}
  ;

{----------------------------------------}

type
  TDCPropProcKind=(
    ikAllEqual,ikGetValue,ikGetValues,ikSetValue,ikEdit,
    //----------
    ikSetValueByDataPtr,ikGetValueAt,ikEditLimit,ikPropAttrs);

  TDCErrorAccessKind=TDCPropProcKind;

const
  ikAllValues=ikAllEqual;

type
  TDCGetStrFunc=function(const Value:string):Integer of object;

  TDCAccessKindsInPropEdit=ikAllEqual..ikEdit;

  TDCDsgnPropEditParamInfoKind=TDCErrorAccessKind;
  TDCDsgnPropEditParamInfoKinds=set of TDCDsgnPropEditParamInfoKind;

  PDCInstPropItem=^TDCInstPropItem;
  TDCInstPropItem=record
    Instance:TPersistent;
    PropInfo:PPropInfo;
  end;

  TDCGetValueProc=function:string of object;

  TDCPropAccessKind=(
    akInvalid,akDefault,akShortCut,akModalResult,akCursor,akColor,akImeName,akFontCharSet,
    akEnum,akSetElem,akMethod,akComponent,akFontName,akDateTime,akTime,akDate,
    akInt64,akClass,akSet,akStr,akFloat,akInt,akChar,aktElem,akOrd,akVar,
    akMPFileName,akFont
  );

  IDCInstPropList=interface
  ['{FC03E54E-ACE9-4C17-BD8C-257FEE3783C1}']
    procedure Edit(AccessKind:TDCPropAccessKind);
    procedure Assign(PropList:IDCInstPropList);
    procedure GetValues(Proc:TGetStrProc;AccessKind:TDCPropAccessKind);
    procedure SetValue(const Value:string;AccessKind:TDCPropAccessKind);

    function GetValue(AccessKind:TDCPropAccessKind):string;
    function AllEqual(AccessKind:TDCPropAccessKind):boolean;

    function GetName:String;
    function GetPropType:PTypeInfo;
    function GetPropInfo:PPropInfo;

    procedure GetValueAt(AccessKind:TDCPropAccessKind;Index:Integer;var ResultVar);
    procedure SetValueByDataPtr(AccessKind:TDCPropAccessKind;DataPtr:Pointer);

    function HasInstance(Instance:TPersistent):Boolean;
    function GetEditValue(Proc:TDCGetValueProc;var Value:string):Boolean;

    function GetItem(Index:Integer):TDCInstPropItem;
    procedure SetItem(Index:Integer;const Value:TDCInstPropItem);
    function GetCount:Integer;
    function GetElement:Integer;
    function AllNamed:Boolean;

    property Count:Integer Read GetCount;
    property Items[Index:Integer]:TDCInstPropItem Read GetItem Write SetItem;default;
  end;

type
  TDCDateTimeToStrProc = function(const DateTime:TDateTime):string;
  TDCStrToDateTimeProc = function(const S:string):TDateTime;

  TDCBooleanMethod     = function:boolean of object;
  TDCStringMethod      = function:String of object;
  TDCNoParamsMethod    = procedure of object;
  TDCGetValueAt        = procedure(Index:Integer;Var ResultVar) of object;
  TDCSetValueDataPtr   = procedure(DataPtr:Pointer) of object;

  TDCSetValue          = procedure(const Value:string) of object;
  TDCGetValues         = procedure(Proc:TGetStrProc) of object;

  TDCProcArrayItem=record
    ProcWasUsed:boolean;
    case Byte of
      1:(AsBoolMethod   : TDCBooleanMethod);
      2:(AsStrMethod    : TDCStringMethod);
      3:(AsNoParams     : TDCNoParamsMethod);
      4:(AsGetValueAt   : TDCGetValueAt);
      5:(AsSetDataPtr   : TDCSetValueDataPtr);
      6:(AsSetValue     : TDCSetValue);
      7:(AsGetValues    : TDCGetValues);
  end;
  PDCProcArray=^TDCProcArray;
  TDCProcArray=Array[TDCPropAccessKind] of TDCProcArrayItem;

  TDCProcArrays=record
    case Byte of
      0:(
        FAllEqualProcs        : TDCProcArray;//ikAllEqual,
        FGetValueProcs        : TDCProcArray;//ikGetValue,
        FGetValuesProcs       : TDCProcArray;//ikGetValues,
        FSetValueProcs        : TDCProcArray;//ikSetValue,
        FEditProcs            : TDCProcArray;//ikEdit,
        FSetValueDataPtrProcs : TDCProcArray;//ikSetValueByDataPtr,
        FGetValueAtProcs      : TDCProcArray;//ikGetValueAt,
        //ikEditLimit,
        //ikPropAttrs
      );
      1:
       (ProcArray:Array[TDCPropProcKind] of TDCProcArray);
  end;

  TDCInstPropList=class(TRecordList,IDCInstPropList)
  private
    FProcArrays : TDCProcArrays;
    FElement    : Integer;

  protected
    function AllNamed:Boolean;

    procedure DoLoadGetValueProcs;
    procedure DoLoadEditProcs;
    procedure DoLoadSetValueProcs;
    procedure DoLoadGetValuesProcs;
    procedure DoLoadAllEqualProcs;
    procedure DoLoadGetValueAtProcs;
    procedure DoLoadSetValueByDataPtrProcs;
    function GetValueAsDateTimeUseProc(Proc:TDCDateTimeToStrProc):String;
    procedure SetValueAsDateTimeUseProc(const Value:string;Proc:TDCStrToDateTimeProc);

    property ProcArrays:TDCProcArrays Read FProcArrays;
    procedure LoadAllProcs;virtual;
    procedure EditAsMPFileName;
    procedure EditAsColor;
    procedure EditAsFont;

    function GetElement:Integer;
    procedure Assign(PropList:IDCInstPropList);
    procedure SetValueAsDateTime(const Value:string);
    procedure SetValueAsTime(const Value:string);
    procedure SetValueAsDate(const Value:string);
    procedure SetValueAsShortCut(const Value:string);
    procedure SetValueAsModalResult(const Value:string);
    procedure SetValueAsCursor(const Value:string);
    procedure SetValueAsColor(const Value:string);
    procedure SetValueAsFontCharSet(const Value:string);
    procedure SetValueAsInt64(const Value:string);
    procedure SetValueAsStr(const Value:string);
    procedure SetValueAsFloat(const Value:string);
    procedure SetValueAsEnum(const Value:string);
    procedure SetValueAsInt(const Value:string);
    procedure SetValueAsChar(const Value:string);
    procedure SetValueAsSetElem(const Value:string);
    function GetValueAsDateTime:string;
    function GetValueAsTime:string;
    function GetValueAsDate:string;
    function GetValueAsShortCut:string;
    function GetValueAsModalResult:string;
    function GetValueAsCursor:string;
    function GetValueAsColor:string;
    function GetValueAsFontCharSet:string;
    function GetValueAsInt64:string;
    function GetValueAsClass:string;
    function GetValueAsSetElem:string;
    function GetValueAsSet:string;
    function GetValueAsStr:string;
    function GetValueAsFloat:string;
    function GetValueAsEnum:string;
    function GetValueAsInt:string;
    function GetValueAsChar:string;
    procedure GetValuesAsShortCut(Proc:TGetStrProc);
    procedure GetValuesAsModalResult(Proc:TGetStrProc);
    procedure GetValuesAsCursor(Proc:TGetStrProc);
    procedure GetValuesAsColor(Proc:TGetStrProc);
    procedure GetValuesAsImeName(Proc:TGetStrProc);
    procedure GetValuesAsFontCharSet(Proc:TGetStrProc);
    procedure GetValuesAsEnum(Proc:TGetStrProc);
    procedure GetValuesAsSetElem(Proc:TGetStrProc);
    procedure GetValuesAsFontName(Proc:TGetStrProc);

    function HasInstance(Instance:TPersistent):Boolean;
    function GetEditValue(Proc:TDCGetValueProc;var Value:string):Boolean;

    function GetPropType:PTypeInfo;
    function GetPropInfo:PPropInfo;
    function GetName:String;

    procedure SetInt64ValueWrapper(DataPtr:Pointer);
    procedure SetMethodValueWrapper(DataPtr:Pointer);
    procedure SetFloatValueWrapper(DataPtr:Pointer);
    procedure SetOrdValueWrapper(DataPtr:Pointer);
    procedure SetStrValueWrapper(DataPtr:Pointer);
    procedure SetVarValueWrapper(DataPtr:Pointer);

    procedure SetInt64Value(const Value:Int64);
    procedure SetMethodValue(const Value:TMethod);
    procedure SetFloatValue(const Value:Extended);
    procedure SetOrdValue(Value:Longint);
    procedure SetStrValue(const Value:String);
    procedure SetVarValue(const Value:Variant);

    procedure GetValueAtAsFloatWrapper(Index:Integer;Var ResultVar);
    procedure GetValueAtAsOrdWrapper(Index:Integer;Var ResultVar);
    procedure GetValueAtAsMethodWrapper(Index:Integer;Var ResultVar);
    procedure GetValueAtAsStrWrapper(Index:Integer;Var ResultVar);
    procedure GetValueAtAsVarWrapper(Index:Integer;Var ResultVar);
    procedure GetValueAtAsInt64Wrapper(Index:Integer;Var ResultVar);

    function GetValueAtAsFloat(Index:Integer):Extended;
    function GetValueAtAsOrd(Index:Integer):Longint;
    function GetValueAtAsMethod(Index:Integer):TMethod;
    function GetValueAtAsStr(Index:Integer):String;
    function GetValueAtAsVar(Index:Integer):Variant;
    function GetValueAtAsInt64(Index:Integer):Int64;

    procedure SetItem(Index:Integer;const Value:TDCInstPropItem);
    function GetItem(Index:Integer):TDCInstPropItem;
    function GetCount:Integer;

    function StrValuesAllEqual:boolean;
    function OrdValuesAllEqual:boolean;
    function Int64ValuesAllEqual:boolean;
    function FloatValuesAllEqual:boolean;
    function SetElemAllEqual:boolean;
    function DefaultAllEqual:boolean;
    function MethodValuesAllEqual:boolean;
    function ComponentValuesAllEqual:boolean;

    procedure GetValues(Proc:TGetStrProc;AccessKind:TDCPropAccessKind);
    procedure SetValue(const Value:string;AccessKind:TDCPropAccessKind);
    function GetValue(AccessKind:TDCPropAccessKind):string;
    function AllEqual(AccessKind:TDCPropAccessKind):boolean;
    procedure GetValueAt(AccessKind:TDCPropAccessKind;Index:Integer;var ResultVar);
    procedure SetValueByDataPtr(AccessKind:TDCPropAccessKind;DataPtr:Pointer);
    procedure Edit(AccessKind:TDCPropAccessKind);
  public
    constructor Create(ItemCount,Element:Integer);
  end;

  TDCInstPropListClass=class of TDCInstPropList;

function DCCreateInstPropList(Count,Element:Integer):IDCInstPropList;
function DCEnumValueToStr(const EnumValue:Integer;ATypeInfo:PTypeInfo):String;

procedure DCDumpInvalidProcAccessKinds(ProcKind:TDCAccessKindsInPropEdit;
  AccessKind:TDCPropAccessKind;UserData:Pointer);

function DCTrimEventName(const EventName:String):String;
function DCErrorAccessKindToStr(ErrorAccessKind:TDCErrorAccessKind):String;

function DCCreateTestInstPropList:Pointer;

procedure DCDumpProcUsage(InstPropList:Pointer);

var
  CDCDefInstPropList:TDCInstPropListClass=nil;

{----------------------------------------}

implementation

uses
  dcgen;

{--------------------------------------}

function DCEnumValueToStr(const EnumValue:Integer;ATypeInfo:PTypeInfo):String;
var
  AValueNames:TStringList;
begin
  AValueNames:=TStringList.Create;
  try
    DCGetEnumTypeValueNames(ATypeInfo,AValueNames);
    Result:=AValueNames[EnumValue];
  finally
    AValueNames.Free;
  end;
end;

{--------------------------------------}

function DCAccessKindToStr(AccessKind:TDCPropAccessKind):String;
begin
  Result:=DCEnumValueToStr(Integer(AccessKind),TypeInfo(TDCPropAccessKind));
end;

{--------------------------------------}

function DCErrorAccessKindToStr(ErrorAccessKind:TDCErrorAccessKind):String;
begin
  Result:=DCEnumValueToStr(Integer(ErrorAccessKind),TypeInfo(TDCErrorAccessKind));
end;

{--------------------------------------}

procedure DCErrorAccessKind(ErrorAccessKind:TDCErrorAccessKind;
  AccessKind:TDCPropAccessKind);
const
  CErrorStr='%S not registered for %S access kind';
begin
  Raise Exception.CreateFmt(CErrorStr,[
    DCErrorAccessKindToStr(ErrorAccessKind),
    DCAccessKindToStr(AccessKind)]);
end;

{--------------------------------------}

const
  ModalResults:array[mrNone..mrYesToAll] of string=(
    'mrNone',
    'mrOk',
    'mrCancel',
    'mrAbort',
    'mrRetry',
    'mrIgnore',
    'mrYes',
    'mrNo',
    'mrAll',
    'mrNoToAll',
    'mrYesToAll');

{------------------------------------}

procedure TDCInstPropList.DoLoadEditProcs;
begin
  With FProcArrays do
  begin
    FEditProcs[akMPFileName].AsNoParams := EditAsMPFileName;
    FEditProcs[akColor].AsNoParams      := EditAsColor;
    FEditProcs[akFont].AsNoParams       := EditAsFont;
  end;
end;

{------------------------------------}

procedure TDCInstPropList.LoadAllProcs;
begin
  DoLoadEditProcs;
  DoLoadSetValueProcs;
  DoLoadGetValueProcs;
  DoLoadGetValuesProcs;
  DoLoadAllEqualProcs;
  DoLoadGetValueAtProcs;
  DoLoadSetValueByDataPtrProcs;
end;

{------------------------------------}

function DCCreateTestInstPropList:Pointer;
begin
  If CDCDefInstPropList=nil then
    Result:=TDCInstPropList.Create(1,0)
  else
    Result:=CDCDefInstPropList.Create(1,0)
end;

{------------------------------------}

procedure DCDumpProcUsageForProcKind(InstPropList:Pointer;ProcKind:TDCAccessKindsInPropEdit);
var
  i:TDCPropAccessKind;
begin
  With TDCInstPropList(InstPropList).FProcArrays do
    for i:=Low(TDCPropAccessKind) to High(TDCPropAccessKind) do
      With ProcArray[ProcKind][i] do
      if Assigned(AsStrMethod) and (not ProcWasUsed) then
        DoWriteToLog('Proc not used '+DCAccessKindToStr(i)+'  '+DCErrorAccessKindToStr(ProcKind))
end;

{------------------------------------}

procedure DCDumpProcUsage(InstPropList:Pointer);
var
  i:TDCAccessKindsInPropEdit;
begin
  for i:=Low(TDCAccessKindsInPropEdit) to High(TDCAccessKindsInPropEdit) do
    DCDumpProcUsageForProcKind(InstPropList,i);
end;

{------------------------------------}

procedure DCDumpInvalidProcAccessKinds(ProcKind:TDCAccessKindsInPropEdit;
  AccessKind:TDCPropAccessKind;UserData:Pointer);
var
  PropList:TDCInstPropList;
  AccessList:PDCProcArray;
begin
  If UserData=nil then
    PropList:=TDCInstPropList.Create(1,0)
  else
    PropList:=TDCInstPropList(UserData);

  AccessList:=@PropList.FProcArrays.ProcArray[ProcKind];

  If not Assigned(AccessList[AccessKind].AsBoolMethod) then
    DoWriteToLog(DCAccessKindToStr(AccessKind)+'  '+DCErrorAccessKindToStr(ProcKind))
  else
    AccessList[AccessKind].ProcWasUsed:=True;

  If PropList<>UserData then
    PropList.Free;
end;

{--------------------------------------}

procedure TDCInstPropList.DoLoadSetValueProcs;
begin
  With FProcArrays do
  begin
    FSetValueProcs[akDateTime].AsSetValue        :=SetValueAsDateTime;
    FSetValueProcs[akTime].AsSetValue            :=SetValueAsTime;
    FSetValueProcs[akDate].AsSetValue            :=SetValueAsDate;
    FSetValueProcs[akShortCut].AsSetValue        :=SetValueAsShortCut;
    FSetValueProcs[akModalResult].AsSetValue     :=SetValueAsModalResult;
    FSetValueProcs[akCursor].AsSetValue          :=SetValueAsCursor;
    FSetValueProcs[akColor].AsSetValue           :=SetValueAsColor;
    FSetValueProcs[akFontCharSet].AsSetValue     :=SetValueAsFontCharSet;
    FSetValueProcs[akInt64].AsSetValue           :=SetValueAsInt64;
    FSetValueProcs[akStr].AsSetValue             :=SetValueAsStr;
    FSetValueProcs[akFloat].AsSetValue           :=SetValueAsFloat;
    FSetValueProcs[akEnum].AsSetValue            :=SetValueAsEnum;
    FSetValueProcs[akInt].AsSetValue             :=SetValueAsInt;
    FSetValueProcs[akChar].AsSetValue            :=SetValueAsChar;
    FSetValueProcs[akSetElem].AsSetValue         :=SetValueAsSetElem;
  end;
end;

{--------------------------------------}

procedure TDCInstPropList.DoLoadGetValueProcs;
begin
  With FProcArrays do
  begin

  FGetValueProcs[akDateTime].AsStrMethod          :=GetValueAsDateTime;
  FGetValueProcs[akTime].AsStrMethod              :=GetValueAsTime;
  FGetValueProcs[akDate].AsStrMethod              :=GetValueAsDate;
  FGetValueProcs[akShortCut].AsStrMethod          :=GetValueAsShortCut;
  FGetValueProcs[akModalResult].AsStrMethod       :=GetValueAsModalResult;
  FGetValueProcs[akCursor].AsStrMethod            :=GetValueAsCursor;
  FGetValueProcs[akColor].AsStrMethod             :=GetValueAsColor;
  FGetValueProcs[akFontCharSet].AsStrMethod       :=GetValueAsFontCharSet;
  FGetValueProcs[akInt64].AsStrMethod             :=GetValueAsInt64;
  FGetValueProcs[akClass].AsStrMethod             :=GetValueAsClass;
  FGetValueProcs[akSetElem].AsStrMethod           :=GetValueAsSetElem;
  FGetValueProcs[akSet].AsStrMethod               :=GetValueAsSet;
  FGetValueProcs[akStr].AsStrMethod               :=GetValueAsStr;
  FGetValueProcs[akFloat].AsStrMethod             :=GetValueAsFloat;
  FGetValueProcs[akEnum].AsStrMethod              :=GetValueAsEnum;
  FGetValueProcs[akInt].AsStrMethod               :=GetValueAsInt;
  FGetValueProcs[akChar].AsStrMethod              :=GetValueAsChar;

  end;
end;

{--------------------------------------}

procedure TDCInstPropList.DoLoadGetValuesProcs;
begin
  With FProcArrays do
  begin
  FGetValuesProcs[akShortCut].AsGetValues     := GetValuesAsShortCut;
  FGetValuesProcs[akModalResult].AsGetValues  := GetValuesAsModalResult;
  FGetValuesProcs[akCursor].AsGetValues       := GetValuesAsCursor;
  FGetValuesProcs[akColor].AsGetValues        := GetValuesAsColor;
  FGetValuesProcs[akImeName].AsGetValues      := GetValuesAsImeName;
  FGetValuesProcs[akFontCharSet].AsGetValues  := GetValuesAsFontCharSet;
  FGetValuesProcs[akEnum].AsGetValues         := GetValuesAsEnum;
  FGetValuesProcs[akSetElem].AsGetValues      := GetValuesAsSetElem;
  FGetValuesProcs[akFontName].AsGetValues     := GetValuesAsFontName;
  end;
end;

{--------------------------------------}

function TDCInstPropList.GetElement:Integer;
begin
  Result:=FElement;
end;

{--------------------------------------}

procedure TDCInstPropList.SetValueAsSetElem(const Value:string);
var
  S:TIntegerSet;
begin
  Integer(S):=GetValueAtAsOrd(0);
  if CompareText(Value,BooleanIdents[True])=0 then
    Include(S,FElement)
  else
    Exclude(S,FElement);
  SetOrdValue(Integer(S));
end;

{--------------------------------------}

procedure TDCInstPropList.Assign(PropList:IDCInstPropList);
var
  i:Integer;
begin
  Count:=PropList.Count;
  for i:=0 to Count-1 do
    SetItem(i,PropList.Items[i]);
end;

{--------------------------------------}

procedure TDCInstPropList.GetValues(Proc:TGetStrProc;AccessKind:TDCPropAccessKind);
begin
  If Assigned(FProcArrays.FGetValuesProcs[AccessKind].AsGetValues) then
    FProcArrays.FGetValuesProcs[AccessKind].AsGetValues(Proc)
  else
    DCErrorAccessKind(ikGetValues,AccessKind);
end;

{--------------------------------------}

procedure TDCInstPropList.SetValue(const Value:string;AccessKind:TDCPropAccessKind);
begin
  If Assigned(FProcArrays.FSetValueProcs[AccessKind].AsSetValue) then
    FProcArrays.FSetValueProcs[AccessKind].AsSetValue(Value)
  else
    DCErrorAccessKind(ikSetValue,AccessKind);
end;

{--------------------------------------}

function TDCInstPropList.GetValue(AccessKind:TDCPropAccessKind):string;
begin
{
  If not (AccessKind in [Low(TDCPropAccessKind)..High(TDCPropAccessKind)]) then
    asm nop end;
}
  If Assigned(FProcArrays.FGetValueProcs[AccessKind].AsStrMethod) then
    Result:=FProcArrays.FGetValueProcs[AccessKind].AsStrMethod
  else
    DCErrorAccessKind(ikGetValue,AccessKind);
end;

{--------------------------------------}

procedure TDCInstPropList.DoLoadAllEqualProcs;
{
var
  i:TDCPropAccessKind;
}
begin
  With FProcArrays do
  begin
{
  for i:=Low(TDCPropAccessKind) to High(TDCPropAccessKind) do
    FAllEqualProcs[i].AsBoolMethod:=DefaultAllEqual;
}
  FAllEqualProcs[akDefault].AsBoolMethod   :=DefaultAllEqual;
  FAllEqualProcs[akComponent].AsBoolMethod :=ComponentValuesAllEqual;
  FAllEqualProcs[akOrd].AsBoolMethod       :=OrdValuesAllEqual;
  FAllEqualProcs[akStr].AsBoolMethod       :=StrValuesAllEqual;
  FAllEqualProcs[akInt64].AsBoolMethod     :=Int64ValuesAllEqual;
  FAllEqualProcs[akFloat].AsBoolMethod     :=FloatValuesAllEqual;
  FAllEqualProcs[akMethod].AsBoolMethod    :=MethodValuesAllEqual;
  FAllEqualProcs[akSetElem].AsBoolMethod   :=SetElemAllEqual;
  end;
end;

{--------------------------------------}

function TDCInstPropList.AllEqual(AccessKind:TDCPropAccessKind):boolean;
begin
  Result:=FProcArrays.FAllEqualProcs[AccessKind].AsBoolMethod;
end;

{--------------------------------------}

procedure TDCInstPropList.GetValueAtAsFloatWrapper(Index:Integer;Var ResultVar);
begin
  Extended(ResultVar):=GetValueAtAsFloat(Index);
end;

{--------------------------------------}

procedure TDCInstPropList.GetValueAtAsOrdWrapper(Index:Integer;Var ResultVar);
begin
  Longint(ResultVar):=GetValueAtAsOrd(Index);
end;

{--------------------------------------}

procedure TDCInstPropList.GetValueAtAsMethodWrapper(Index:Integer;Var ResultVar);
begin
  TMethod(ResultVar):=GetValueAtAsMethod(Index);
end;

{--------------------------------------}

procedure TDCInstPropList.GetValueAtAsStrWrapper(Index:Integer;Var ResultVar);
begin
  String(ResultVar):=GetValueAtAsStr(Index);
end;

{--------------------------------------}

procedure TDCInstPropList.GetValueAtAsVarWrapper(Index:Integer;Var ResultVar);
begin
  Variant(ResultVar):=GetValueAtAsVar(Index);
end;

{--------------------------------------}

procedure TDCInstPropList.GetValueAtAsInt64Wrapper(Index:Integer;Var ResultVar);
begin
  Int64(ResultVar):=GetValueAtAsInt64(Index);
end;

{--------------------------------------}

procedure TDCInstPropList.DoLoadGetValueAtProcs;
begin
  With FProcArrays do
  begin
  FGetValueAtProcs[akFloat].AsGetValueAt :=GetValueAtAsFloatWrapper;
  FGetValueAtProcs[akOrd].AsGetValueAt   :=GetValueAtAsOrdWrapper;
  FGetValueAtProcs[akMethod].AsGetValueAt:=GetValueAtAsMethodWrapper;
  FGetValueAtProcs[akStr].AsGetValueAt   :=GetValueAtAsStrWrapper;
  FGetValueAtProcs[akVar].AsGetValueAt   :=GetValueAtAsVarWrapper;
  FGetValueAtProcs[akInt64].AsGetValueAt :=GetValueAtAsInt64Wrapper;
  end;
end;

{--------------------------------------}

procedure TDCInstPropList.GetValueAt(AccessKind:TDCPropAccessKind;Index:Integer;var ResultVar);
begin
  If Assigned(FProcArrays.FGetValueAtProcs[AccessKind].AsGetValueAt) then
    FProcArrays.FGetValueAtProcs[AccessKind].AsGetValueAt(Index,ResultVar)
  else
    DCErrorAccessKind(ikGetValueAt,AccessKind);
end;

{--------------------------------------}

procedure TDCInstPropList.SetInt64ValueWrapper(DataPtr:Pointer);
begin
  SetInt64Value(PInt64(DataPtr)^);
end;

{--------------------------------------}

type
  PMethod=^TMethod;

procedure TDCInstPropList.SetMethodValueWrapper(DataPtr:Pointer);
begin
  SetMethodValue(PMethod(DataPtr)^);
end;

{--------------------------------------}

procedure TDCInstPropList.SetFloatValueWrapper(DataPtr:Pointer);
begin
  SetFloatValue(PExtended(DataPtr)^);
end;

{--------------------------------------}

procedure TDCInstPropList.SetOrdValueWrapper(DataPtr:Pointer);
begin
  SetOrdValue(PLongint(DataPtr)^);
end;

{--------------------------------------}

procedure TDCInstPropList.SetStrValueWrapper(DataPtr:Pointer);
begin
  SetStrValue(PString(DataPtr)^);
end;

{--------------------------------------}

procedure TDCInstPropList.SetVarValueWrapper(DataPtr:Pointer);
begin
  SetVarValue(PVariant(DataPtr)^);
end;

{--------------------------------------}

procedure TDCInstPropList.DoLoadSetValueByDataPtrProcs;
begin
  With FProcArrays do
  begin
  FSetValueDataPtrProcs[akInt64].AsSetDataPtr :=SetInt64ValueWrapper;
  FSetValueDataPtrProcs[akMethod].AsSetDataPtr:=SetMethodValueWrapper;
  FSetValueDataPtrProcs[akFloat].AsSetDataPtr :=SetFloatValueWrapper;
  FSetValueDataPtrProcs[akOrd].AsSetDataPtr   :=SetOrdValueWrapper;
  FSetValueDataPtrProcs[akStr].AsSetDataPtr   :=SetStrValueWrapper;
  FSetValueDataPtrProcs[akVar].AsSetDataPtr   :=SetVarValueWrapper;
  end;
end;

{--------------------------------------}

procedure TDCInstPropList.Edit(AccessKind:TDCPropAccessKind);
begin
  If Assigned(FProcArrays.FEditProcs[AccessKind].AsNoParams) then
    FProcArrays.FEditProcs[AccessKind].AsNoParams
  else
    DCErrorAccessKind(ikEdit,AccessKind);
end;

{--------------------------------------}

procedure TDCInstPropList.SetValueByDataPtr(AccessKind:TDCPropAccessKind;DataPtr:Pointer);
begin
  If Assigned(FProcArrays.FSetValueDataPtrProcs[AccessKind].AsSetDataPtr) then
    FProcArrays.FSetValueDataPtrProcs[AccessKind].AsSetDataPtr(DataPtr)
  else
    DCErrorAccessKind(ikSetValueByDataPtr,AccessKind);
end;

{--------------------------------------}

procedure TDCInstPropList.GetValuesAsShortCut(Proc:TGetStrProc);
begin
  DCEnumShortCutNames(Proc);
end;

{--------------------------------------}

procedure TDCInstPropList.GetValuesAsModalResult(Proc:TGetStrProc);
var
  I:Integer;
begin
  for I:=Low(ModalResults) to High(ModalResults) do
    Proc(ModalResults[I]);
end;

{--------------------------------------}

procedure TDCInstPropList.GetValuesAsCursor(Proc:TGetStrProc);
begin
  GetCursorValues(Proc);
end;

{--------------------------------------}

procedure TDCInstPropList.GetValuesAsColor(Proc:TGetStrProc);
begin
  GetColorValues(Proc);
end;

{--------------------------------------}

procedure TDCInstPropList.GetValuesAsImeName(Proc:TGetStrProc);
var
  I:Integer;
begin
  for I:=0 to Screen.Imes.Count-1 do
    Proc(Screen.Imes[I]);
end;

{--------------------------------------}

procedure TDCInstPropList.GetValuesAsFontCharSet(Proc:TGetStrProc);
begin
  GetCharsetValues(Proc);
end;

{--------------------------------------}

procedure TDCInstPropList.GetValuesAsEnum(Proc:TGetStrProc);
var
  I:Integer;
  EnumType:PTypeInfo;
begin
  EnumType:=GetPropType;
  with GetTypeData(EnumType)^ do
  begin
    if MinValue<0 then
    begin
      Proc(GetEnumName(EnumType,0));
      Proc(GetEnumName(EnumType,1));
    end
    else
      for I:=MinValue to MaxValue do
        Proc(GetEnumName(EnumType,I));
  end;
end;

{--------------------------------------}

procedure TDCInstPropList.GetValuesAsSetElem(Proc:TGetStrProc);
begin
  Proc(BooleanIdents[False]);
  Proc(BooleanIdents[True]);
end;

{--------------------------------------}

procedure TDCInstPropList.GetValuesAsFontName(Proc:TGetStrProc);
var
  I:Integer;
begin
  for I:=0 to Screen.Fonts.Count-1 do
    Proc(Screen.Fonts[I]);
end;

{--------------------------------------}

procedure TDCInstPropList.SetValueAsDateTimeUseProc(const Value:string;
  Proc:TDCStrToDateTimeProc);
var
  DT:TDateTime;
begin
  if Value='' then
    DT:=0.0
  else
    DT:=Proc(Value);
  SetFloatValue(DT);
end;

{--------------------------------------}

procedure TDCInstPropList.SetValueAsDateTime(const Value:string);
begin
  SetValueAsDateTimeUseProc(Value,StrToDateTime);
end;

{--------------------------------------}

procedure TDCInstPropList.SetValueAsTime(const Value:string);
begin
  SetValueAsDateTimeUseProc(Value,StrToTime);
end;

{--------------------------------------}

procedure TDCInstPropList.SetValueAsDate(const Value:string);
begin
  SetValueAsDateTimeUseProc(Value,StrToDate);
end;

{--------------------------------------}

procedure TDCInstPropList.SetValueAsShortCut(const Value:string);
var
  NewValue:TShortCut;
begin
  NewValue:=0;
  if (Value<>'') and (AnsiCompareText(Value,srNone)<>0) then
  begin
    NewValue:=TextToShortCut(Value);
    if NewValue=0 then
      raise EPropertyError.Create(SInvalidPropertyValue);
  end;
  SetOrdValue(NewValue);
end;

{--------------------------------------}

procedure TDCInstPropList.SetValueAsModalResult(const Value:string);
var
  I:Integer;
begin
  if Value='' then
  begin
    SetOrdValue(0);
    Exit;
  end;
  for I:=Low(ModalResults) to High(ModalResults) do
    if CompareText(ModalResults[I],Value)=0 then
    begin
      SetOrdValue(I);
      Exit;
    end;
  SetValueAsInt(Value);
end;

{--------------------------------------}

procedure TDCInstPropList.SetValueAsCursor(const Value:string);
var
  NewValue:Longint;
begin
  if IdentToCursor(Value,NewValue) then
    SetOrdValue(NewValue)
  else
    SetValueAsInt(Value);
end;

{--------------------------------------}

procedure TDCInstPropList.SetValueAsColor(const Value:string);
var
  NewValue:Longint;
begin
  if IdentToColor(Value,NewValue) then
    SetOrdValue(NewValue)
  else
    SetValueAsInt(Value);
end;

{--------------------------------------}

procedure TDCInstPropList.SetValueAsFontCharSet(const Value:string);
var
  NewValue:Longint;
begin
  if IdentToCharset(Value,NewValue) then
    SetOrdValue(NewValue)
  else
    SetValueAsInt(Value);
end;

{--------------------------------------}

procedure TDCInstPropList.SetValueAsInt64(const Value:string);
begin
  SetInt64Value(StrToInt64(Value));
end;

{--------------------------------------}

procedure TDCInstPropList.SetValueAsStr(const Value:string);
begin
  SetStrValue(Value);
end;

{--------------------------------------}

procedure TDCInstPropList.SetValueAsFloat(const Value:string);
begin
  SetFloatValue(StrToFloat(Value));
end;

{--------------------------------------}

procedure TDCInstPropList.SetValueAsEnum(const Value:string);
var
  I:Integer;
begin
  I:=GetEnumValue(GetPropType,Value);
  with GetTypeData(GetPropType)^ do
    if (I<MinValue) or (I>MaxValue) then
      raise EPropertyError.Create(SInvalidPropertyValue);
  SetOrdValue(I);
end;

{--------------------------------------}

procedure TDCInstPropList.SetValueAsInt(const Value:string);

  procedure Error(const Args:array of const);
  begin
    raise EPropertyError.CreateFmt(SOutOfRange,Args);
  end;

var
  L:Int64;
begin
  L:=StrToInt64(Value);
  with GetTypeData(GetPropType)^ do
    if OrdType=otULong then
      begin
        if (L<Cardinal(MinValue)) or (L>Cardinal(MaxValue)) then
          Error([Int64(Cardinal(MinValue)),Int64(Cardinal(MaxValue))]);
      end
    else
    if (L<MinValue) or (L>MaxValue) then
      Error([MinValue,MaxValue]);
  SetOrdValue(L);
end;

{--------------------------------------}

procedure TDCInstPropList.SetValueAsChar(const Value:string);
var
  L:Longint;
begin
  if Length(Value)=0 then
    L:=0
  else
  if Length(Value)=1 then
    L:=Ord(Value[1])
  else
  if Value[1]='#' then
    L:=StrToInt(Copy(Value,2,Maxint))
  else
    raise EPropertyError.Create(SInvalidPropertyValue);

  with GetTypeData(GetPropType)^ do
    if (L<MinValue) or (L>MaxValue) then
      raise EPropertyError.CreateFmt(SOutOfRange,[MinValue,MaxValue]);
      
  SetOrdValue(L);
end;

{--------------------------------------}

function TDCInstPropList.GetValueAsDateTimeUseProc(Proc:TDCDateTimeToStrProc):String;
var
  DT:TDateTime;
begin
  DT:=GetValueAtAsFloat(0);
  if DT=0.0 then
    Result:=''
  else
    Result:=Proc(DT);
end;

{--------------------------------------}

function TDCInstPropList.GetValueAsDateTime:string;
begin
  Result:=GetValueAsDateTimeUseProc(DateTimeToStr);
end;

{--------------------------------------}

function TDCInstPropList.GetValueAsTime:string;
begin
  Result:=GetValueAsDateTimeUseProc(TimeToStr);
end;

{--------------------------------------}

function TDCInstPropList.GetValueAsDate:string;
begin
  Result:=GetValueAsDateTimeUseProc(DateToStr);
end;

{--------------------------------------}

function TDCInstPropList.GetValueAsShortCut:string;
var
  CurValue:TShortCut;
begin
  CurValue:=GetValueAtAsOrd(0);
  if CurValue=scNone then
    Result:=srNone
  else
    Result:=ShortCutToText(CurValue);
end;

{--------------------------------------}

function TDCInstPropList.GetValueAsModalResult:string;
var
  CurValue:Longint;
begin
  CurValue:=GetValueAtAsOrd(0);
  If CurValue in [Low(ModalResults)..High(ModalResults)] then
    Result:=ModalResults[CurValue]
  else
    Result:=IntToStr(CurValue);
end;

{--------------------------------------}

function TDCInstPropList.GetValueAsCursor:string;
begin
  Result:=CursorToString(TCursor(GetValueAtAsOrd(0)));
end;

{--------------------------------------}

function TDCInstPropList.GetValueAsColor:string;
begin
  Result:=ColorToString(TColor(GetValueAtAsOrd(0)));
end;

{--------------------------------------}

function TDCInstPropList.GetValueAsFontCharSet:string;
begin
  if not CharsetToIdent(TFontCharset(GetValueAtAsOrd(0)),Result) then
    FmtStr(Result,'%d',[GetValueAtAsOrd(0)]);
end;

{--------------------------------------}

function TDCInstPropList.GetValueAsInt64:string;
begin
  Result:=IntToStr(GetValueAtAsInt64(0));
end;

{--------------------------------------}

function TDCInstPropList.GetValueAsClass:string;
begin
  FmtStr(Result,'(%s)',[GetPropType^.Name]);
end;

{--------------------------------------}

function TDCInstPropList.GetValueAsSetElem:string;
var
  S:TIntegerSet;
begin
  Integer(S):=GetValueAtAsOrd(0);
  Result:=BooleanIdents[FElement in S];
end;

{--------------------------------------}

function TDCInstPropList.GetValueAsSet:string;
var
  I:Integer;
  S:TIntegerSet;
  TypeInfo:PTypeInfo;
begin
  Integer(S):=GetValueAtAsOrd(0);
  TypeInfo:=GetTypeData(GetPropType)^.CompType^;
  Result:='[';
  for I:=0 to SizeOf(Integer)*8-1 do
    if I in S then
    begin
      if Length(Result)<>1 then
        Result:=Result+',';
      Result:=Result+GetEnumName(TypeInfo,I);
    end;
  Result:=Result+']';
end;

{--------------------------------------}

function TDCInstPropList.GetValueAsStr:string;
begin
  Result:=GetValueAtAsStr(0);
end;

{--------------------------------------}

function TDCInstPropList.GetValueAsFloat:string;
const
  CDCPrecisions:array[TFloatType] of Integer=
    (7,15,18,18,18);
begin
  Result:=FloatToStrF(GetValueAtAsFloat(0),ffGeneral,
    CDCPrecisions[GetTypeData(GetPropType)^.FloatType],0);
end;

{--------------------------------------}

function TDCInstPropList.GetValueAsEnum:string;
var
  L:Longint;
begin
  L:=GetValueAtAsOrd(0);
  with GetTypeData(GetPropType)^ do
    if (L<MinValue) or (L>MaxValue) then
      L:=MaxValue;
  Result:=GetEnumName(GetPropType,L);
end;

{--------------------------------------}

function TDCInstPropList.GetValueAsInt:string;
begin
  with GetTypeData(GetPropType)^ do
    if OrdType=otULong then
      Result:=IntToStr(Cardinal(GetValueAtAsOrd(0)))
    else
      Result:=IntToStr(GetValueAtAsOrd(0));
end;

{--------------------------------------}

function TDCInstPropList.GetValueAsChar:string;
const
  CDCSpecialCharSet=[#33..#127];
var
  Ch:Char;
begin
  Ch:=Chr(GetValueAtAsOrd(0));
  if Ch in CDCSpecialCharSet then
    Result:=Ch
  else
    FmtStr(Result,'#%d',[Ord(Ch)]);
end;

{--------------------------------------}

function TDCInstPropList.DefaultAllEqual:boolean;
begin
  Result:=GetCount=1;
end;

{--------------------------------------}

function TDCInstPropList.ComponentValuesAllEqual:boolean;
var
  I:Integer;
  Component:TComponent;
begin
  Result:=False;
  Component:=TComponent(GetValueAtAsOrd(0));
  if GetCount>1 then
    for I:=1 to GetCount-1 do
      if TComponent(GetValueAtAsOrd(I))<>Component then
        Exit;
  Result:=True;
end;

{--------------------------------------}

function TDCInstPropList.MethodValuesAllEqual:boolean;
var
  I:Integer;
  V,T:TMethod;
begin
  Result:=False;
  if GetCount>1 then
  begin
    V:=GetValueAtAsMethod(0);
    for I:=1 to GetCount-1 do
    begin
      T:=GetValueAtAsMethod(I);
      if (T.Code<>V.Code) or (T.Data<>V.Data) then
        Exit;
    end;
  end;
  Result:=True;
end;

{--------------------------------------}

function TDCInstPropList.SetElemAllEqual:boolean;
var
  I:Integer;
  S:TIntegerSet;
  V:Boolean;
begin
  Result:=False;
  if GetCount>1 then
  begin
    Integer(S):=GetValueAtAsOrd(0);
    V:=FElement in S;
    for I:=1 to GetCount-1 do
    begin
      Integer(S):=GetValueAtAsOrd(I);
      if (FElement in S)<>V then
        Exit;
    end;
  end;
  Result:=True;
end;

{--------------------------------------}

function TDCInstPropList.StrValuesAllEqual:boolean;
var
  I:Integer;
  V:String;
begin
  Result:=False;
  if GetCount>1 then
  begin
    V:=GetValueAtAsStr(0);
    for I:=1 to GetCount-1 do
      if GetValueAtAsStr(I)<>V then
        Exit;
  end;
  Result:=True;
end;

{--------------------------------------}

function TDCInstPropList.OrdValuesAllEqual:boolean;
var
  I:Integer;
  V:Longint;
begin
  Result:=False;
  if GetCount>1 then
  begin
    V:=GetValueAtAsOrd(0);
    for I:=1 to GetCount-1 do
      if GetValueAtAsOrd(I)<>V then
        Exit;
  end;
  Result:=True;
end;

{--------------------------------------}

function TDCInstPropList.Int64ValuesAllEqual:boolean;
var
  I:Integer;
  V:Int64;
begin
  Result:=False;
  if GetCount>1 then
  begin
    V:=GetValueAtAsInt64(0);
    for I:=1 to GetCount-1 do
      if GetValueAtAsInt64(I)<>V then
        Exit;
  end;
  Result:=True;
end;

{--------------------------------------}

function TDCInstPropList.FloatValuesAllEqual:boolean;
var
  I:Integer;
  V:Extended;
begin
  Result:=False;
  if GetCount>1 then
  begin
    V:=GetValueAtAsFloat(0);
    for I:=1 to GetCount-1 do
      if GetValueAtAsFloat(I)<>V then
        Exit;
  end;
  Result:=True;
end;

{--------------------------------------}

procedure TDCInstPropList.SetStrValue(const Value:String);
var
  I:Integer;
begin
  for I:=0 to GetCount-1 do
    with GetItem(I) do
      SetStrProp(Instance,PropInfo,Value);
end;

{--------------------------------------}

procedure TDCInstPropList.SetVarValue(const Value:Variant);
var
  I:Integer;
begin
  for I:=0 to GetCount-1 do
    with GetItem(I) do
      SetVariantProp(Instance,PropInfo,Value);
end;

{------------------}

function TDCInstPropList.GetValueAtAsInt64(Index:Integer):Int64;
begin
  with GetItem(Index) do
    Result:=GetInt64Prop(Instance,PropInfo);
end;

{------------------}

procedure TDCInstPropList.SetInt64Value(const Value:Int64);
var
  I:Integer;
begin
  for I:=0 to GetCount-1 do
    with GetItem(I) do
      SetInt64Prop(Instance,PropInfo,Value);
end;

{------------------}

function TDCInstPropList.GetEditValue(Proc:TDCGetValueProc;var Value:string):Boolean;
begin
  Result:=False;
  try
    Value:=Proc;
    Result:=True;
  except
    on E:EPropWriteOnly do
      Value:=sDCNotAvailable;
    on E:Exception do
      Value:=Format('(%s)',[E.Message]);
  end;
end;

{------------------}

function TDCInstPropList.HasInstance(Instance:TPersistent):Boolean;
var
  I:Integer;
begin
  for I:=0 to GetCount-1 do
    if GetItem(I).Instance=Instance then
    begin
      Result:=True;
      Exit;
    end;
  Result:=False;
end;

{--------------------------------------}

procedure TDCInstPropList.SetMethodValue(const Value:TMethod);
var
  I:Integer;
begin
  for I:=0 to GetCount-1 do
    with GetItem(I) do
      SetMethodProp(Instance,PropInfo,Value);
end;

{--------------------------------------}

procedure TDCInstPropList.SetOrdValue(Value:Longint);
var
  I:Integer;
begin
  for I:=0 to GetCount-1 do
    with GetItem(I) do
      SetOrdProp(Instance,PropInfo,Value);
end;

{--------------------------------------}

procedure TDCInstPropList.SetFloatValue(const Value:Extended);
var
  I:Integer;
begin
  for I:=0 to GetCount-1 do
    with GetItem(I) do
      SetFloatProp(Instance,PropInfo,Value);
end;

{--------------------------------------}

function TDCInstPropList.GetName:String;
begin
  Result:=GetItem(0).PropInfo^.Name;
end;

{--------------------------------------}

function TDCInstPropList.GetValueAtAsMethod(Index:Integer):TMethod;
begin
  with GetItem(Index) do
    Result:=GetMethodProp(Instance,PropInfo);
end;

{--------------------------------------}

function TDCInstPropList.GetValueAtAsStr(Index:Integer):String;
begin
  with GetItem(Index) do
    Result:=GetStrProp(Instance,PropInfo);
end;

{--------------------------------------}

function TDCInstPropList.GetValueAtAsVar(Index:Integer):Variant;
begin
  with GetItem(Index) do
    Result:=GetVariantProp(Instance,PropInfo);
end;

{------------------}

function TDCInstPropList.GetPropInfo:PPropInfo;
begin
  Result:=GetItem(0).PropInfo;
end;

{------------------}

function TDCInstPropList.GetPropType:PTypeInfo;
begin
  Result:=GetItem(0).PropInfo^.PropType^;
end;

{--------------------------------------}

function TDCInstPropList.GetValueAtAsOrd(Index:Integer):Longint;
begin
  with GetItem(Index) do
    Result:=GetOrdProp(Instance,PropInfo);
end;

{--------------------------------------}

function TDCInstPropList.GetValueAtAsFloat(Index:Integer):Extended;
begin
  with GetItem(Index) do
    Result:=GetFloatProp(Instance,PropInfo);
end;

{--------------------------------------}

procedure TDCInstPropList.SetItem(Index:Integer;const Value:TDCInstPropItem);
begin
  PDCInstPropItem(Items[Index])^:=Value;
end;

{--------------------------------------}

function TDCInstPropList.GetItem(Index:Integer):TDCInstPropItem;
begin
  Result:=PDCInstPropItem(Items[Index])^;
end;

{--------------------------------------}

function TDCInstPropList.GetCount:Integer;
begin
  Result:=Count;
end;

{---------------------}

procedure TDCInstPropList.EditAsMPFileName;
var
  FileOpen:TOpenDialog;
begin
  FileOpen:=TOpenDialog.Create(Application);
  With FileOpen do
    try
      Options:=Options+[ofPathMustExist,ofFileMustExist];
      Filter:=SMPOpenFilter;
      Filename:=GetValueAsStr;
      if Execute then
        SetValueAsStr(Filename);
    finally
      Free;
    end;
end;

{---------------------}

procedure TDCInstPropList.EditAsColor;
begin
  SetOrdValue(DCChangeColorWithDlg(GetValueAtAsOrd(0)));
end;

{---------------------}

procedure TDCInstPropList.EditAsFont;
begin
  DCChangeFontWithDlg(TFont(GetValueAtAsOrd(0)));
  SetOrdValue(Integer(GetValueAtAsOrd(0)));
end;

{---------------------}

function TDCInstPropList.AllNamed:Boolean;
var
  I:Integer;
begin
  Result:=True;
  for I:=0 to Count - 1 do
    if GetItem(I).Instance.GetNamePath='' then
    begin
      Result:=False;
      Break;
    end;
end;

{--------------------------------------}

constructor TDCInstPropList.Create(ItemCount,Element:Integer);
begin
  inherited Create(SizeOf(TDCInstPropItem));
  Count:=ItemCount;
  FElement:=Element;
  LoadAllProcs;
end;

{--------------------------------------}

function DCCreateInstPropList(Count,Element:Integer):IDCInstPropList;
begin
  If CDCDefInstPropList=nil then
    Result:=TDCInstPropList.Create(Count,Element)
  else
    Result:=CDCDefInstPropList.Create(Count,Element);
end;

{---------------------}

function DCTrimEventName(const EventName:String):String;
begin
  Result:=EventName;
  if (Length(Result)>=2) and
    (Result[1] in ['O','o']) and (Result[2] in ['N','n'])
  then
    Delete(Result,1,2);
end;

{--------------------------------------}

end.
