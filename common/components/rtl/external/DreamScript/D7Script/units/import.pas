{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit import;

interface
{$I dc.inc}

uses
  Classes, Typinfo, Sysutils,
  {$IFDEF WIN}
  {$IFNDEF CLX}
  windows,
  {$ENDIF}
  {$ENDIF}
  dcsystem, dcdreamlib, unitpars, dcapi;

const
  MAXCONSTSINSECTION = 512; // to avoid bug in Delphi compiler
  MAXCALLSINSECTION = 5000; // to avoid another bug in Delphi compiler

procedure GenerateImportUnit(const Source, Dest, Defines, Units, Aliases : String;
  NoComments,AddUnregistration,ANoDefaultDefines:boolean;AMsgHandler : TDCMsgHandler);

Procedure GenerateImportCode(ModuleInfo : TModuleInfo; const Dest : string;
  NoComments,AddUnregistration,ANoDefaultDefines:boolean;AMsgHandler : TDCMsgHandler);

Procedure InitializeBadLists;
Procedure AddBadProc( Const ProcName : String );
Procedure AddBadProcs( Const ProcNames : TStrings );

procedure CheckDecl(decl : PTypeDeclInfo; var PropIsObject, PropIsSet,
                    PropIsChar, PropIsInterface : boolean);
function TDeclIsNoTypeInfoType(tdecl : PTypeDeclInfo) : boolean;
function TDeclIsRec(decl : PTypeDeclInfo) : boolean;
function GetRecTypeDecl(ModuleInfo:TModuleInfo;const TypeName : string) : PTypeDeclInfo;
function IsRecType(ModuleInfo:TModuleInfo;const TypeName : string) : boolean;
function IsSetType(ModuleInfo:TModuleInfo;const TypeName : string) : boolean;

function DCGetPropParamTemplate(Module:TModuleInfo;ParamIndex:Integer):String;

function GetPropParams(startindex:integer;pinfo:PPropertyInfo;
  ModuleInfo:TModuleInfo) : string;

procedure AddSetFunction(const CName, PropName, sVarType : string; decl : PTypeDeclInfo;
  pinfo : PPropertyInfo;ModuleInfo:TModuleInfo;UnitText:TStrings);
procedure AddGetFunction(const CName, PropName, sVarType : string; decl : PTypeDeclInfo;
  pinfo : PPropertyInfo;ModuleInfo:TModuleInfo;UnitText:TStrings);
function GetPropGetSetName(IsGet : boolean; const CName, PropName : string; HasProc : boolean) : string;

implementation

{---------------------------------}

function TDeclIsPointer(tdecl : PTypeDeclInfo) : boolean;
begin
  result := (tdecl <> nil);
  if result then
    repeat
      with tdecl^ do
        begin
          result := (BaseType = btPointer) or (Reference = trPointer);

          if result then
            break
          else
            tdecl := MInfo.GetTypeDecl(MInfo.GetGlobalString(BaseName));
        end;
     until tdecl = nil;
end;

{---------------------------------}

function TDeclIsType(tdecl : PTypeDeclInfo; const ATypes : TBaseTypes) : boolean;
begin
  result := (tdecl <> nil);
  if result then
    repeat
      with tdecl^ do
        begin
          result := BaseType in ATypes;

          if result then
            break
          else
            tdecl := MInfo.GetTypeDecl(MInfo.GetGlobalString(BaseName));
        end;
     until tdecl = nil;
end;

{---------------------------------}

function TDeclIsPWideChar(tdecl : PTypeDeclInfo) : boolean;
begin
  result := TDeclIsType(tdecl, [btPWideChar]);
end;

{---------------------------------}

function TDeclIsPChar(tdecl : PTypeDeclInfo) : boolean;
begin
  result := TDeclIsType(tdecl, [btPChar, btPAnsiChar]);
end;

{***********************************************************}

var
  BadProcs : TStringList;
  BadTypes : TStringList;
  SysUnits : TStringList;

{------------------------------------------------------------------}

procedure AddBadProc(const ProcName : string);
begin
  BadProcs.Add( ProcName );
end;

{------------------------------------------------------------------}

procedure AddBadProcs( Const ProcNames : TStrings );
begin
  If Assigned( ProcNames ) Then
    BadProcs.AddStrings( ProcNames );
end;

{------------------------------------------------------------------}

const
  BadProcCount = 159+13;
  BadProcList : array[0 .. BadProcCount - 1] of string =
(

  'TBOA.Initialize',
  'TQRPrintableEditor.Alignment',

  'DateUtils.TryEncodeDateWeek',   //Added in V4.1 cause when proc have var
                                   //parameters and default values for some of params
                                   //it is imported incrorrectly 

  'IBIntf.isc_install_clear_options',           // Added in V4.1
  'IBIntf.isc_install_execute',
  'IBIntf.isc_install_get_info',
  'IBIntf.isc_install_get_message',
  'IBIntf.isc_install_load_external_text',
  'IBIntf.isc_install_precheck',
  'IBIntf.isc_install_set_option',
  'IBIntf.isc_uninstall_execute',
  'IBIntf.isc_uninstall_precheck',
  'IBIntf.isc_install_unset_option',


 'activex.CoCreateStandardMalloc',
 'activex.CoHasStrongExternalConnections',
 'activex.CoMarshalHResult',
 'activex.CoUnmarshalHResult',
 'activex.VarUI1FromI2',
 'activex.VarUI1FromI4',
 'activex.VarUI1FromR4',
 'activex.VarUI1FromR8',
 'activex.VarUI1FromCy',
 'activex.VarUI1FromDate',
 'activex.VarUI1FromStr',
 'activex.VarUI1FromDisp',
 'activex.VarUI1FromBool',
 'activex.VarUI1FromI1',
 'activex.VarUI1FromUI2',
 'activex.VarUI1FromUI4',
 'activex.VarUI1FromDec',
 'activex.VarI2FromUI1',
 'activex.VarI2FromI4',
 'activex.VarI2FromR4',
 'activex.VarI2FromR8',
 'activex.VarI2FromCy',
 'activex.VarI2FromDate',
 'activex.VarI2FromStr',
 'activex.VarI2FromDisp',
 'activex.VarI2FromBool',
 'activex.VarI2FromI1',
 'activex.VarI2FromUI2',
 'activex.VarI2FromUI4',
 'activex.VarI2FromDec',
 'activex.VarI4FromUI1',
 'activex.VarI4FromI2',
 'activex.VarI4FromR4',
 'activex.VarI4FromR8',
 'activex.VarI4FromCy',
 'activex.VarI4FromDate',
 'activex.VarI4FromStr',
 'activex.VarI4FromDisp',
 'activex.VarI4FromBool',
 'activex.VarI4FromI1',
 'activex.VarI4FromUI2',
 'activex.VarI4FromUI4',
 'activex.VarI4FromDec',
 'activex.VarI4FromInt',
 'activex.VarR4FromUI1',
 'activex.VarR4FromI2',
 'activex.VarR4FromI4',
 'activex.VarR4FromR8',
 'activex.VarR4FromCy',
 'activex.VarR4FromDate',
 'activex.VarR4FromStr',
 'activex.VarR4FromDisp',
 'activex.VarR4FromBool',
 'activex.VarR4FromI1',
 'activex.VarR4FromUI2',
 'activex.VarR4FromUI4',
 'activex.VarR4FromDec',
 'activex.VarR8FromUI1',
 'activex.VarR8FromI2',
 'activex.VarR8FromI4',
 'activex.VarR8FromR4',
 'activex.VarR8FromCy',
 'activex.VarR8FromDate',
 'activex.VarR8FromStr',
 'activex.VarR8FromDisp',
 'activex.VarR8FromBool',
 'activex.VarR8FromI1',
 'activex.VarR8FromUI2',
 'activex.VarR8FromUI4',
 'activex.VarR8FromDec',
 'activex.VarDateFromUI1',
 'activex.VarDateFromI2',
 'activex.VarDateFromI4',
 'activex.VarDateFromR4',
 'activex.VarDateFromR8',
 'activex.VarDateFromCy',
 'activex.VarDateFromStr',
 'activex.VarDateFromDisp',
 'activex.VarDateFromBool',
 'activex.VarDateFromI1',
 'activex.VarDateFromUI2',
 'activex.VarDateFromUI4',
 'activex.VarDateFromDec',
 'activex.VarCyFromUI1',
 'activex.VarCyFromI2',
 'activex.VarCyFromI4',
 'activex.VarCyFromR4',
 'activex.VarCyFromR8',
 'activex.VarCyFromDate',
 'activex.VarCyFromStr',
 'activex.VarCyFromDisp',
 'activex.VarCyFromBool',
 'activex.VarCyFromI1',
 'activex.VarCyFromUI2',
 'activex.VarCyFromUI4',
 'activex.VarCyFromDec',
 'activex.VarBStrFromUI1',
 'activex.VarBStrFromI2',
 'activex.VarBStrFromI4',
 'activex.VarBStrFromR4',
 'activex.VarBStrFromR8',
 'activex.VarBStrFromCy',
 'activex.VarBStrFromDate',
 'activex.VarBStrFromDisp',
 'activex.VarBStrFromBool',
 'activex.VarBStrFromI1',
 'activex.VarBStrFromUI2',
 'activex.VarBStrFromUI4',
 'activex.VarBStrFromDec',
 'activex.VarBoolFromUI1',
 'activex.VarBoolFromI2',
 'activex.VarBoolFromI4',
 'activex.VarBoolFromR4',
 'activex.VarBoolFromR8',
 'activex.VarBoolFromDate',
 'activex.VarBoolFromCy',
 'activex.VarBoolFromStr',
 'activex.VarBoolFromDisp',
 'activex.VarBoolFromI1',
 'activex.VarBoolFromUI2',
 'activex.VarBoolFromUI4',
 'activex.VarBoolFromDec',
 'adodb._Connection',
 'adodb._Recordset', 
 'db.dbfProcDesc',
 'graphics.CopyPalette',
 'imm.ImmGetDefaultIMEWnd',
 'math.MaxExtended',
 'math.MaxIntValue',
 'math.MinIntValue',
 'math.SumInt',
 'mmsystem.errMessage',
 'oleAuto.EOleException',
 'oleAuto.EOleSysError',
 'ole2.CoCreateStandardMalloc',
 'ole2.CoHasStrongExternalConnections',
 'ole2.CoMarshalHResult',
 'ole2.CoUnmarshalHResult',
 'olectrls.TOleControl',
 'oleauto.TAutoDispatch',
 'QR2CONST.SqrReport',
 'QR2CONST.SqrWizardName',
 'QR2CONST.SqrWizardComment',
 'QR2CONST.SqrAboutInfo',
 'QR2CONST.SHtmlExportDesc',
 'QR2CONST.SHtmlExportName',
 'QR2CONST.SHtmlExportExt',
 'QR2CONST.SCsvExportDesc',
 'QR2CONST.SCsvExportName',
 'QR2CONST.SCsvExportExt',
 'SShortMonthNames',
 'SLongMonthNames',
 'SShortDayNames',
 'SLongDayNames',
 'system.VarArrayRef',
 'sysutils.SResultTooLong',
 'sysutils.WordRec',
 'sysutils.GetEnvironmentVariable',
 'windows.SetThreadIdealProcessor'
);


const
  BadTypeCount = 11+13;
  BadTypeList : array[0 .. BadTypeCount - 1] of string =
(
//  cArrayOfConst,
 'DataSources',
 'DRObject',
 'PackageInfoTable',
 'PackageUnitEntry',
 'TOleGraphic',      // Added in V4.1 (no IPicture declaration under C4)
 'POleStr',          // Added in V4.1   (no type info under C3)
 'TStatStg',         // Added in V4.1   (no type info under C3,C4)
 'TIID',             // Added in V4.1   (no type info under C3)
 'TFormatEtc',       // Added in V4.1   (no type info under C4)
 'TCLSID',           // Added in V4.1   (no type info under C4,C3)
 'TDataPacket',      // Added in V4.1   (no type info under C4,C3)
 'POPTIONS_HANDLE',  // Added in V4.1   (no type info under C4,C3)
 'PMixerControlA',   // Added in V4.1 cause sub records are declared in this record and not supp by us
 'PMixerControlW',   // -------- || ------------
 'PMixerControl',    // -------- || ------------
 'tagMIXERCONTROLA', // -------- || ------------
 'tagMIXERCONTROLW', // -------- || ------------
 'tagMIXERCONTROL',  // -------- || ------------
 'TMixerControlA',   // -------- || ------------
 'TMixerControlW',   // -------- || ------------
 'TMixerControl',    // -------- || ------------
 'MIXERCONTROLA',    // -------- || ------------
 'MIXERCONTROLW',    // -------- || ------------
 'MIXERCONTROL'      // -------- || ------------
);

const
  cSysUnits : array[0..4] of string =
(

 'DesignIntf',        //  Added un V4.1
 'DesignEditors',     //
 'VCLEditors',        //

 'System',
 'SysInit'
);

{------------------------------------------------------------------}

function InBadProcs(const ModuleName:String;Name : string) : boolean;
var
  index : integer;
begin
  If Pos('V ',Name)=1 then  // Added in V4.1
    Delete(Name,1,2);       //

  with BadProcs do
    result := (pos('R ', Name) = 1) or
              Find(ModuleName + '.' + Name, index) or Find(Name, index);
end;

{------------------------------------------------------------------}

function IsVarType(const Name : string) : boolean;
begin
  result := (length(Name) > 1) and (Name[2] = ' ');
end;

{------------------------------------------------------------------}

function getRecWrapName(const TypeName : string) : string;
begin
  result := '__' + DCRemovePoints(TypeName) + '__Wrapper';
end;

{------------------------------------------------------------------}

Procedure GenerateImportCode(ModuleInfo : TModuleInfo; const Dest : string;
  NoComments,AddUnregistration,ANoDefaultDefines:boolean;AMsgHandler : TDCMsgHandler);
var
  UnitText : TStringList;
  Calls    : TStringList;
  MWrappers: TStringList;
  BadCalls : TStringList;
  PropRegs : TStringList;
  VarRegs  : TStringList;
  VarNames : TStringList;
  Types    : TStringList;
  RegisteredMethodsList : TStringList;
  RecWrappers : TStringList;
  RWrappers   : TStringList;
  RWrappersImpl : TStringList;
  RFuncWrappers : TStringList;
  DeclaredTypes : TStringList;
  DeclaredTypeNames : TStringList;
  RegisteredMethods : TStringList;
  ProtClasses       : TStringList;
  ProtAccess        : TStringList;
  uunits            : TStringList;
  GoodTypeCount     : integer;
  DTypeCount        : integer;

  {---------------------------------}

  procedure WriteHeader;
  var
    uname : string;
    p     : integer;
  begin
    with UnitText do
      begin
        Add('{*******************************************************}');
        Add('{                                                       }');
        Add('{ Import unit generated by UNITIMPORTER program         }');
        Add('{                                                       }');
        Add('{*******************************************************}');
        Add('');
      end;

    uname := ExtractFileName(Dest);
    p := pos('.', uname);
    if p > 0 then
      delete(uname, p, length(uname) - p + 1);

    with UnitText, ModuleInfo do
      Add('Unit ' + uName  + ';');
  end;

  {---------------------------------}

  procedure AddUses(const s : string);
  var
    i : integer;
  begin
    if SysUnits.IndexOf(s) < 0 then
      with uunits do
        begin
          i := IndexOf(s);
          if i >= 0 then
            Delete(i);

          Add(s);
        end;
  end;

  {---------------------------------}

  procedure WriteUsesClause;
  var
    i : integer;

  begin
    with ModuleInfo, UnitText do
      begin
        if ModuleName = '' then
          exit;

        Add('uses');

       with uunits do
         begin
           AddUses('activex');
           AddUses('classes');
           AddUses('dcscript');
           AddUses('dcsystem');
           AddUses('dcdreamlib');



          for i := 0 to InterfaceUses.Count - 1 do  // Prior V4.1 was before AddUses('activex');
            AddUses(InterfaceUses[i]);              // but in this way is more correctly
                                                    // was bug in invokeregistry.pas import without it

           if SysUnits.IndexOf(modulename) < 0 then
             AddUses(modulename);

           for i := 0 to count - 2 do
             UnitText.Add('  ' + Strings[i] + ',');

           UnitText.Add('  ' + strings[count - 1] + ';');
         end;
      end;
  end;

  {---------------------------------}

  function IsTypeDynArray(ModInfo : TModuleInfo; const TypeName : string; var ArrElemName : string) : boolean;
  var
    tdecl : PTypeDeclInfo;
    tname : string;
  begin
    tdecl := ModInfo.GetTypeDecl(TypeName);
    result := tdecl <> nil;
    if result then
      repeat
        with tdecl^ do
          begin
            result := Reference = trDynArray;
            tname := MInfo.GetGlobalString(BaseName);
            if result then
              begin
                ArrElemName := tname;
                break;
              end
            else
              tdecl := MInfo.GetTypeDecl(tname);
          end;
      until tdecl = nil;
  end;

  {---------------------------------}

  function _BadType(ModInfo : TModuleInfo; const TypeName : string;
    BKinds : TTypeDeclKinds;
    IgnoreBadProcs, AcceptOpenArrays : boolean) : boolean;
  const
    BadBaseTypes = [btProc, {btPChar, btPWideChar, }{btPAnsiChar,} btFile, btText, btInt64,btValuedEnum];
  var
    tdecl : PTypeDeclInfo;
    tname : string;
    index : integer;
    isPointer : boolean;
  begin
    if not IgnoreBadProcs then
      begin
        result := InBadProcs(ModInfo.ModuleName, TypeName);
        if result then
          exit;
      end
    else result := false;

    tname := TypeName;

    if tname = cArrayOfConst then
      begin
        result := false;
        exit;
      end;

    isPointer := false;
    tdecl := nil;

    repeat
      if BadTypes.Find(tname, index) then
        begin
          result := true;
          exit;
        end;

      if tdecl = nil then
        tdecl := ModInfo.GetTypeDecl(tname)
      else
        tdecl := tdecl.MInfo.GetTypeDecl(tname);

      if tdecl = nil then
        break;

      with tdecl^ do
        begin
          result := (BaseType in BadBaseTypes) or (TypeKind in [tdInterface, tdDispInterface]){(TypeKind = tdRecord)} or
                  (TypeKind in BKinds) or (Reference in [trClassOf, trArray])
                  or (IsPointer and ((TypeKind = tdRecord) or ((TypeKind = tdBase) and (BaseType in [btPChar, btPWideChar, btPAnsiChar]))));

          if not result and (Reference = trDynArray) then
            begin
              if AcceptOpenArrays then
                result := _BadType(MInfo, MInfo.GetGlobalString(BaseName), BKinds, IgnoreBadProcs, false)
              else
                result := true;

              exit;
            end;

          isPointer := isPointer or ((TypeKind = tdRef));
        end;

      if not result then
        with tdecl^ do
          tname := MInfo.GetGlobalString(BaseName)
      else
        tname := '';

    until result or (tname = '');
  end;

  {---------------------------------}

  function BadType(const TypeName : GlobalString; BKinds : TTypeDeclKinds) : boolean;
  begin
    result := _BadType(ModuleInfo, ModuleInfo.GetGlobalString(TypeName), BKinds, false, false);
  end;

  {---------------------------------}

  function getsetpropprocname(const propname, proptype : string) : string;
  begin
    result := 'set' + propname + '(const val : ' + proptype + ');';
  end;

  {---------------------------------}

  function getgetpropprocname(const propname, proptype : string) : string;
  begin
    result := 'get' + propname + ' : ' + proptype + ';';
  end;

  {---------------------------------}

  function IsTypeReal48 (tdecl : PTypeDeclInfo) : boolean;
  var
    bname : string;
  begin
    result := tdecl <> nil;
    if result then
      repeat
        with tdecl^ do
          begin
            bname := MInfo.GetGlobalString(BaseName);
            result := CompareText(bname, 'real48') = 0;
            if result then
              break
            else
              tdecl := ModuleInfo.GetTypeDecl(bname);
          end;
       until tdecl = nil;
  end;

  {---------------------------------}

  procedure AddRecordWrapper(const tName : string; tdecl : PTypeDeclInfo);
  var
    i : integer;
    pvar : PVarInfo;
    pdecl : PTypeDeclInfo;
    vname : string;
    vtype : string;
    wname : string;
  begin
    if (RecWrappers.IndexOf(tName) >= 0) or _BadType(ModuleInfo, tName, [], false, false) then
      exit;

    AddUses(TDecl.MInfo.ModuleName);              // Added in V4.1
                                                  //
    With TDecl.MInfo do                           //
      for i := 0 to InterfaceUses.Count - 1 do    //
        AddUses(InterfaceUses[i]);                //


    RecWrappers.Add(tName);
    wname := getRecWrapName(tName);

    RWrappers.Add('type ' + wname + ' = class(TDCRecordWrapper)');
    RWrappers.Add('private');
    RWrappers.Add('fR : ' + tName + ';');

    RWrappers.Add('public');
    RWrappers.Add('function GetRecordPtr : pointer; override;');

    RWrappersImpl.Add('function ' + wname + '.GetRecordPtr : pointer;');
    RWrappersImpl.Add('begin');
    RWrappersImpl.Add('result := @fR;');
    RWrappersImpl.Add('end;');

    RWrappers.Add('published');
    with tdecl^ do
      begin
        for i := 0 to VarCount - 1 do
          begin
            pvar := PVarInfo(MInfo.VarList[VarIndex + i]);
            vname := MInfo.GetGlobalString(pvar^.VarName);
            vType := MInfo.GetGlobalString(pvar^.VarType);

            if _BadType(MInfo, vType, [tdRecord, tdRef], true, false) or
              IsRecType(MInfo,vType) then  // tdref added in V4.1
              continue;

            pdecl := MInfo.GetTypeDecl(vType);

            if TDeclIsNoTypeInfoType(pdecl) then
              continue;

            if (pdecl.BaseName = GSEMPTY) then
              vType := GetBaseTypeName(pdecl.BaseType)
            else if IsTypeReal48(pdecl) then
              vtype := 'double'
            else
              begin
                vType := pdecl.MInfo.GetGlobalString(pdecl.BaseName);
                while pdecl.BaseName <> GSEMPTY do
                  begin
                    with pdecl^, MInfo do
                      pdecl := GetTypeDecl(GetGlobalString(BaseName));

                    If (pdecl<>nil) and (pdecl.MInfo<>nil) then
                      AddUses(pdecl.MInfo.ModuleName);

                    if TDeclIsNoTypeInfoType(pdecl) then   // Added in V4.1
                      break;                               //

                    if pdecl = nil then
                      break;
                  end;
              end;

            if TDeclIsNoTypeInfoType(pdecl) then   // Added in V4.1
              break;                               //

            if CompareText(vtype, 'ShortString') <> 0 then
              begin
                RWrappers.Add('procedure ' + getsetpropprocname(vname, vType));
                RWrappers.Add('function ' + getgetpropprocname(vname, vType));

                RWrappersImpl.Add('procedure ' + wname + '.' + getsetpropprocname(vname, vType));
                RWrappersImpl.Add('begin');
                RWrappersImpl.Add(tName + '(GetRecordPtr^).' + vname + ' := val;');
                RWrappersImpl.Add('end;');

                RWrappersImpl.Add('function ' + wname + '.' + getgetpropprocname(vname, vType));
                RWrappersImpl.Add('begin');
                RWrappersImpl.Add('result := ' + tName + '(GetRecordPtr^).' + vname + ';');
                RWrappersImpl.Add('end;');

                RWrappers.Add('property ' + vname + ' : ' + vType + ' read get' + vname + ' write set' + vname +';');
              end;
          end;
      end;

    RWrappers.Add('end;');
  end;

  {---------------------------------}

  function _checkrecordtype(const TypeName : string) : string;
  var
    tdecl : PTypeDeclInfo;
  begin
    tdecl := GetRecTypeDecl(ModuleInfo,TypeName);

    if tdecl <> nil then
      begin
        result := 'IDispatch';
        AddRecordWrapper(TypeName, tdecl);
      end
    else
      result := TypeName;
  end;

  {---------------------------------}

  function GetTypeInfoString(TypeName : string) : string;
  begin
    if CompareText(TypeName, 'OpenString') = 0 then
      TypeName := 'ShortString';

    result := 'TypeInfo(' + _checkrecordtype(TypeName) + ')';
  end;

  {---------------------------------}

  function GetTypeInfoStr(const TypeName : string) : string;
  var
    tdecl : PTypeDeclInfo;
  begin
    tdecl := ModuleInfo.GetTypeDecl(TypeName);
    if TDeclIsPointer(tdecl) then
      begin
        result := 'TypeInfoPointer';
        exit;
      end;

    if (TypeName = '') or (CompareText(TypeName, 'const') = 0) then
      result := 'TypeInfoUntyped'
    else if CompareText(TypeName, cArrayOfConst) = 0 then
      result := 'TypeInfoArrayOfConst'
    else if CompareText(TypeName, 'REAL') = 0 then
      result := 'TypeInfoReal'
    else if TDeclIsPChar(tdecl) then
      result := 'TypeInfoPChar'
    else if TDeclIsPWideChar(tdecl) then
      result := 'TypeInfoPWideChar'  
    else
      result := GetTypeInfoString(TypeName);
  end;

  {---------------------------------}

  function GetParamsTypeInfoStr(ParamIndex, ParamCount : integer; RetType : GlobalString) : string;
  var
    k : integer;
    HasRetType : boolean;
    isdynarray : boolean;
    ParamInfo : PParamInfo;
    s         : string;
    retstr    : string;
    arrelemname : string;
  begin
    RetStr := ModuleInfo.GetGlobalString(RetType);
    HasRetType := RetStr <> '';
    if (ParamCount > 0) or HasRetType then
      begin
        result := '[';
        for k := 0 to ParamCount - 1 do
          with ModuleInfo do
            begin
              ParamInfo := PParamInfo(GlobalParams[k + ParamIndex]);
              s := GetGlobalString(ParamInfo.ParamType);
              isdynarray := IsTypeDynArray(ModuleInfo, s, arrelemname);
              s := GetTypeInfoStr(s);
              if isdynarray then
                s := 'DynArrayInfo(' + s + ')'
              else if ((pfArray in ParamInfo.ParamFlags) and (s <> 'TypeInfoArrayOfConst')) then
                s := 'ArrayInfo(' + s + ')';
              AddStr(result, #13#10 + s);
              if HasRetType or (k < ParamCount - 1) then
                AddStr(result, ',');
            end;

        if HasRetType then
          AddStr(result,  GetTypeInfoStr(RetStr));

        AddStr(result, ']');
      end
    else
      result := 'NoParams';
  end;

  {---------------------------------}

  function BadParams(ParamIndex, ParamCount : integer) : boolean;
   var
     i : integer;
     TypeName:String;
     decl:PTypeDeclInfo;
     AAIsBadType:boolean;
     AAIsNoTypeInfo:boolean;
   begin
     with ModuleInfo do
       for i := 0 to ParamCount - 1 do
       begin
         TypeName:=ModuleInfo.GetGlobalString(
           PParamInfo(GlobalParams[ParamIndex + i]).ParamType);
         Decl := ModuleInfo.GetTypeDecl(TypeName);

         AAIsbadType    := _BadType(ModuleInfo,TypeName,[], false, true);
         AAIsNoTypeInfo := TDeclIsNoTypeInfoType(Decl) and not TDeclIsPointer(Decl);

         if AAIsBadType or AAIsNoTypeInfo then
           begin
             result := true;
             exit;
           end;
       end;
     result := false;
   end;

  {---------------------------------}

  function _getpargsparamname(pindex, pcount : integer; const pType : string) : string;
  var
    decl            : PTypeDeclInfo;
    PropIsObject    : boolean;
    PropIsSet       : boolean;
    PropIsChar      : boolean;
    PropIsInterface : boolean;
    PropIsPointer   : boolean;
    PropIsPChar     : boolean;
    PropIsPWideChar : boolean;
    NeedCloseBracket: boolean;
  begin
    decl := ModuleInfo.GetTypeDecl(pType);
    CheckDecl(decl, PropIsObject, PropIsSet, PropIsChar, PropIsInterface);
    PropIsPointer := TDeclIsPointer(decl);
    PropIsPChar := TDeclIsPChar(decl);
    PropIsPWideChar := TDeclIsPWideChar(decl);

    if PropIsSet then
      begin
        result := '__s' + IntToStr(pindex);
        exit;
      end;

    result := '';
    NeedCloseBracket := true;

    if PropIsObject then
      AddStr(result, pType + '(VarToObject(')
    else if PropIsChar then
      AddStr(result, 'VarToChar(')
    else if PropIsInterface then
      AddStr(result, pType + '(VarToInterface(')
    else if PropIsPChar then
      AddStr(result, 'PChar(String(')
    else if PropIsPWideChar then
      AddStr(result, 'DCStringToOleSt(String(')
    else if PropIsPointer then
      AddStr(result, 'VarToPointer(')
    else
      NeedCloseBracket := false;

    AddStr(result, 'OleVariant(pargs^[' + IntToStr(pcount - 1 - pindex) + '])');

    if NeedCloseBracket then
      AddStr(result, ')');

    if PropIsObject or PropIsInterface or PropIsPChar or PropIsPWideChar then
      AddStr(result, ')');
  end;

  {---------------------------------}

  function GetShortParamStr(ParamIndex, ParamCount : integer;
    recparams : TStringList; UsepArgs : boolean) : string;
  var
    k : integer;
    HasParams : boolean;
    isRecParam : boolean;
  begin
    HasParams := (ParamCount > 0);

    if HasParams then
      result := '('
    else
      result := '';

    for k := 0 to ParamCount - 1 do
      begin
        with PParamInfo(ModuleInfo.GlobalParams[ParamIndex + k])^ do
          begin
            isRecParam := (RecParams <> nil) and (RecParams.IndexOfObject(pointer(k)) >= 0);
            if isRecParam then
              AddStr(result, '__');

            if UsepArgs and not isRecParam then
              AddStr(result, _getpargsparamname(k, ParamCount, ModuleInfo.GetGlobalString(ParamType)))
            else
              AddStr(result, 'p' + IntToStr(k){ModuleInfo.GetGlobalString(ParamName)});

            if isRecParam then
              AddStr(result, '^');

            if k < ParamCount - 1 then
              AddStr(result, ',');
          end;
      end;

    if HasParams then
      AddStr(result, ')');
  end;

  {---------------------------------}

  function GetParamStr(const AddInst : string; ParamIndex, ParamCount : integer) : string;
  var
    k : integer;
    pinfo : PParamInfo;
    fstr : string;
    ss   : string;
    ptype : string;
    HasParams : boolean;
    isrecparam : boolean;
  begin
    HasParams := (ParamCount > 0) or (AddInst <> '');

    if HasParams then
      result := '('
    else
      result := '';

    if AddInst <> '' then
      begin
        AddStr(result, '__Instance : ' + AddInst);
        if ParamCount > 0 then
          AddStr(result, ';'#13#10);
      end;

    for k := 0 to ParamCount - 1 do
      begin
        pinfo := PParamInfo(ModuleInfo.GlobalParams[ParamIndex + k]);
        with pinfo^ do
          begin
            ptype := ModuleInfo.GetGlobalString(ParamType);
            isrecparam := IsRecType(ModuleInfo,ptype);
            if isrecparam then
              ptype := _checkrecordtype(ptype);

            fstr := '';
            if isrecparam then
              fStr := 'const '
            else
              if pfVar in ParamFlags then
                fstr := 'var '
              {$IFDEF D3}
              else if pfOut in ParamFlags then
                fstr := 'out '
              {$ENDIF}
              else if pfConst in ParamFlags then
                fstr := 'const ';

            if ptype <> '' then
              begin
                ss := ' : ';

                if not isRecParam and ((pfArray in ParamFlags) and (ptype <> cArrayOfConst)) then
                  AddStr(ss, 'Array of ');

                AddStr(ss, ptype);
              end
            else
              ss := '';

            AddStr(result, fstr + 'p' + IntToStr(k){ModuleInfo.GetGlobalString(ParamName)} + ss);
            if k < ParamCount - 1 then
              AddStr(result, ';'#13#10);
          end;
      end;

    if HasParams then
      AddStr(result, ')');
  end;

  {---------------------------------}

  function GetProcTypeName(IsFunction : boolean) : string;
  begin
    if IsFunction then
      result := 'function '
    else
      result := 'procedure ';
  end;

  {---------------------------------}

  function GetProcDesc(pminfo : PMethodInfo; const AddInst : string) : string;
  begin
    with pminfo^ do
      begin
        result := GetParamStr(AddInst, ParamIndex, ParamCount);

        if IsFunction then
          AddStr(result, ': ' + _checkrecordtype(ModuleInfo.GetGlobalString(RetType)));
      end;
  end;

  {---------------------------------}

  procedure AddType(pminfo : PMethodInfo; const typename : string; GoodType : boolean);
  var
    s      : string;
    ss     : string;
    tindex : integer;
  begin
    with pminfo^ do
      begin
        s := typename + ' = ';

        ss := GetProcTypeName(IsFunction);
        AddStr(ss, GetProcDesc(pminfo, ''));

        AddStr(ss, ' of object;');

        if GoodType then
          if not DeclaredTypes.Find(ss, tindex) then
            begin
              tindex := DeclaredTypeNames.Add(typename);
              DeclaredTypes.AddObject(ss, TObject(tindex));
            end
          else
            ss := DeclaredTypeNames[integer(DeclaredTypes.Objects[tindex])] + ';';

        s := s + ss;

        if GoodType then
          inc(GoodTypeCount)
        else
          if NoComments then
            exit
          else
            s := '{' + s + '}';

        Types.Add(s + #13#10);
      end;
  end;

  {---------------------------------}

  procedure GenerateMethodWrapper(pminfo : PMethodInfo; const procname, cname, realprocname : string);
  var
    s : string;
  begin
    with MWrappers, pminfo^ do
      begin
        Add(GetProcTypeName(IsFunction) + procname + GetProcDesc(pminfo, cname) + ';');
        Add('begin');
        if IsFunction then
          s := 'result :='
        else
          s := '';

        if cname <> '' then
          AddStr(s, cname + '(__Instance).');

        AddStr(s, realprocname);
        AddStr(s, GetShortParamStr(ParamIndex, ParamCount, nil, false) + ';');
        Add(s);
        Add('end;'#13#10);
      end;
  end;

  {---------------------------------}

  function GetUniqueTypeName : string;
  begin
    result := '_T' + IntToStr(DTypeCount);
    Inc(DTypeCount);
  end;

  {---------------------------------}

  function GetProtAccessClassName(const cName : string) : string;
  begin
    if ProtClasses.IndexOf(cName) < 0 then
      begin
        ProtClasses.Add(cName);
        ProtAccess.Add('type __' + cName + '__ = class(' + cName + ');');
      end;
    result := '__' + cName + '__';
  end;

  {---------------------------------}

  function GetResultString(const expr, rettype : string; isscriptproc, isrecresult : boolean) : string;
  var
    rettdecl        : PTypeDeclInfo;
    PropIsObject    : boolean;
    PropIsSet       : boolean;
    PropIsChar      : boolean;
    PropIsInterface : boolean;
    PropIsPointer   : boolean;
    PropIsPChar     : boolean;
    PropIsPWideChar : boolean;
  begin
    if isrecresult then
      result := '__'
    else
      result := '';

    result := result + 'result := ';

    if not isscriptproc then
      begin
        result := result + expr;
        exit;
      end;
      
    rettdecl := ModuleInfo.GetTypeDecl(rettype);
    CheckDecl(rettdecl, PropIsObject, PropIsSet, PropIsChar, PropIsInterface);
    PropIsPointer := TDeclIsPointer(rettdecl);
    PropIsPChar := TDeclIsPChar(rettdecl);
    PropIsPWideChar := TDeclIsPWideChar(rettdecl);

    if PropIsObject then
      AddStr(result, 'VarFromObject(')
    else
    if PropIsInterface then
      AddStr(result, 'VarFromInterface(')
    else
    if PropIsSet then
      AddStr(result, 'VarFromSet(')
    else
    if PropIsPChar or PropIsPWideChar then
      AddStr(result, 'String(')
    else
    if PropIsPointer then
      AddStr(result, 'PointerToVariant(');

    if not PropIsSet then
      AddStr(result, expr)
    else
      AddStr(result, expr + ', sizeof(' + expr + ')');

    if PropIsObject  or PropIsSet or PropIsPointer or PropIsPChar or PropIsPWideChar or PropIsInterface then
      AddStr(result, ')');
  end;

  {---------------------------------}

  function AddFuncWrapper(pminfo : PMethodInfo; const cName : string) : boolean;
  var
    s           : string;
    realname    : string;
    i           : integer;
    _rettype    : string;
    ptype       : string;
    RecParams   : TStringList;
    SetParams   : TStringList;
    isrecresult : boolean;
    pname       : string;
    pindex      : integer;
    pcount      : integer;
    defparam    : integer;
    procdesc    : string;
    pstr        : string;
  begin
    with RFuncWrappers, pminfo^ do
      begin
        realname := ModuleInfo.GetGlobalString(MName);

        defparam := 0;
        if not ((MethodType in [mtConstructor, mtDestructor]) or (mfOverload in MethodFlags)) then
          defparam := DefaultParam;

        for i := 0 to ParamCount - 1 do
          with ModuleInfo do
            if pfArray in PParamInfo(GlobalParams[ParamIndex + i]).ParamFlags then
              begin
                defparam := 0;
                break;
              end;

        result := defparam > 0;

        if defparam > 0 then
          begin
            procdesc := '(';
            if MethodType = mtMethod then
              procdesc := procdesc + '__Instance : TObject; ';

            procdesc := procdesc + 'cArgs : integer; pArgs : PArgList)';
            if IsFunction then
              procdesc := procdesc + ' : OleVariant';
          end
        else
          procdesc := GetProcDesc(pminfo, cname);

        Add(GetProcTypeName(IsFunction) +
          GetRecWrapName(cName + '__' + realname) + procdesc + ';');



        _RetType := ModuleInfo.GetGlobalString(RetType);
        RecParams   := TStringList.Create;
        SetParams   := TStringList.Create;
        try
          isrecresult := IsRecType(ModuleInfo,_rettype);

          for i := 0 to ParamCount - 1 do
            with ModuleInfo do
              begin
                ptype := GetGlobalString(PParamInfo(GlobalParams[ParamIndex + i]).ParamType);
                if IsRecType(ModuleInfo,ptype) then
                  RecParams.AddObject(ptype, pointer(i))
                else if (defparam > 0) and IsSetType(ModuleInfo,ptype) then
                  SetParams.AddObject(ptype, pointer(i));
              end;

          if isrecresult or (RecParams.Count > 0) or (SetParams.Count > 0) then
            Add('var');

          if isrecresult then
            begin
              Add('__result : ' + _RetType + ';');
              Add('__wrapper : ' + getRecWrapName(_RetType) + ';');
            end;

          for i := 0 to RecParams.Count - 1 do
            begin
              pstr := IntToStr(integer(RecParams.Objects[i]));
              Add('__p' + pstr + ' : ^' + RecParams[i] + ';');
              Add('__i' + pstr + ' : IDispatch;');
            end;

          for i := 0 to SetParams.Count - 1 do
            Add('__s' + IntToStr(integer(SetParams.Objects[i])) + ' : ' + SetParams[i] + ';');

          Add('begin');

          for i := 0 to SetParams.Count - 1 do
            begin
              pstr := IntToStr(integer(SetParams.Objects[i]));
              Add('if cArgs > ' + pstr + ' then');
              Add('VarToSet(' + '__s' + pstr + ',OleVariant(pargs^[' + pstr + ']),SizeOf(' + SetParams[i] + '));');
            end;

          for i := 0 to RecParams.Count - 1 do
            begin
              pstr := IntToStr(integer(RecParams.Objects[i]));
              if defparam > 0 then
                begin
                  pname := '__i' + pstr;
                  Add(pname + ' := VarToInterface(OleVariant(pargs^[' + pstr + ']));');
                end
              else
                pname := 'p' + pstr;

              Add('if ' + pname + ' = nil then exit;');
              Add('__p' + pstr  + ' := ' + {RecParams[i] +} '(' + pname + ' as IDCRecordWrapper).GetRecordPtr;');
            end;

          pindex := defparam - 2;
          if pindex >= -1 then
            Add('case cArgs of');

          repeat
            inc(pindex);

            if pindex >= 0 then
              begin
                Add(IntToStr(pindex) + ':');
                Add('begin');
              end;

            s := '';

            if cname <> '' then
              begin
                if Scope = sProtected then
                  AddStr(s, GetProtAccessClassName(cname))
                else
                  AddStr(s, cname);

                AddStr(s, '(__Instance).');
              end;

            AddStr(s, realname);

            pcount := pindex;
            if pcount = -1 then
              pcount := ParamCount;

            AddStr(s, GetShortParamStr(ParamIndex, pCount, RecParams, defparam > 0));

            if IsFunction then
              s := GetResultString(s, _rettype, defparam > 0, isrecresult);

            Add(s + ';');

{-------}

            if isrecresult then
              begin
                Add('__wrapper := ' + getRecWrapName(_RetType) +'.Create;');
                Add('__wrapper.fR := __result;');
                Add('result := IDispatch(__wrapper);');
              end;

            if pindex >= 0 then
              Add('end;');

            if pindex < 0 then
              break;

(*

Was before V4.1:

            if isrecresult then
              begin
                Add('__wrapper := ' + getRecWrapName(_RetType) + '.Create;');
                Add('__wrapper.fR := __result;');
                Add('result := __wrapper;'{ as IDispatch;'});
              end;

            if pindex < 0 then
              break;
*)

{-------}

          until pIndex = ParamCount;

          if pIndex > 0 then
            Add('end'); // case

          Add('end;'#13#10);
        finally
          RecParams.Free;
          SetParams.Free;
        end;
      end;
  end;

  {---------------------------------}

  procedure RegisterMethods(const CName : string; MList : TRecordList; MIndex, MCount : integer);
  var
    i         : integer;
    j         : integer;
    MTypeName : string;
    mmname    : string;
    s         : string;
    pminfo    : PMethodInfo;
    procname    : string;
    cType       : string;
    procindex   : integer;
    RecUsed     : boolean;
    UseWrapper  : boolean;
    IsRegMethod : boolean;
    MethodIsBad : boolean;
    WrapperUsed : boolean;
    ABadParams,ABadType:boolean;
  begin
    for i := 0 to MCount - 1 do
      begin
        pminfo := PMethodInfo(MList[MIndex + i]);

        with pminfo^ do
          begin
            if not ((Scope in [sPublic, sPublished]) or (MethodFlags * [mfVirtual, mfDynamic] <> [])) or (MName = GSEMPTY) or
               (mfMapped in MethodFlags) or (MethodFlags * [mfOverride, mfReIntroduce] = [mfOverride]) then
              continue;

            with ModuleInfo do
              begin
                mmname := GetGlobalString(MName);
                if (length(mmname) > 1) and (mmname[1] = '_') and (SysUnits.IndexOf(ModuleName) >= 0) then
                  continue; // compiler magic in system.pas

                if InBadProcs(ModuleName, mmname) then
                  continue;
              end;

            procname := '';
            if CName <> '' then
              AddStr(procname, CName + '.');

            AddStr(procname, mmname);

            if RegisteredMethods.Find(procname, procindex) then
              continue;

            RegisteredMethods.Add(procname);

            MTypeName := GetUniqueTypeName;
            IsRegMethod := (MethodType = mtMethod) and (CallType = cRegister);

            RecUsed := IsRecType(ModuleInfo,ModuleInfo.GetGlobalString(RetType));

            if not RecUsed then
              for j := 0 to ParamCount - 1 do
                with ModuleInfo do
                  if IsRecType(ModuleInfo,GetGlobalString(PParamInfo(GlobalParams[ParamIndex + j]).ParamType)) then
                    begin
                      RecUsed := true;
                      break;
                    end;

            if RecUsed and (Scope = sPrivate) then
              continue;

            UseWrapper := RecUsed or ((pmInfo.DefaultParam > 0) and not (pminfo.MethodType in [mtConstructor, mtDestructor]));

            If ProcName='TList.Add' then
              asm nop end;

            ABadParams:= BadParams(ParamIndex, ParamCount);
            ABadType  := BadType(RetType, []);

            MethodIsBad := ABadParams or ABadType;

            if not MethodIsBad and (pmInfo.DefaultParam > 0) then
              for j := ParamIndex to ParamIndex + ParamCount - 1 do
                if pfVar in PParamInfo(ModuleInfo.GlobalParams[j]).ParamFlags then
                  begin
                    MethodIsBad := true;
                    break;
                  end;

            WrapperUsed := false;
            if UseWrapper then
              begin
                if MethodIsBad then
                  continue;

                WrapperUsed := AddFuncWrapper(pmInfo, cName);
              end;

            IsRegMethod := IsRegMethod and not WrapperUsed;

            if IsRegMethod then
              s := 'RegRegisterMethod('
            else
              s := 'RegisterProc(';

            if CName <> '' then
              AddStr(s, CName)
            else
              AddStr(s, 'nil');

            AddStr(s, ',');

            if not (MethodIsBad or (cname <> '')) then
              AddStr(s, 'MethodNames[' + IntToStr(RegisteredMethodsList.Count) + ']' + ',')
            else
              AddStr(s, '''' + mmname + ''',');

            if not IsRegMethod then
              begin
                if WrapperUsed then
                  if MethodType = mtMethod then
                    AddStr(s, 'mtScriptMethod')
                  else
                    AddStr(s, 'mtScriptProc')
                else
                  AddStr(s, GetEnumName(TypeInfo(TMethodType), ord(MethodType)));

                s := s + ',';
              end;

            AddStr(s, GetTypeInfoString(MTypeName) + ',');
            AddStr(s, GetParamsTypeInfoStr(ParamIndex, ParamCount, RetType));

            if (MethodFlags * [mfVirtual, mfDynamic] <> []) and not WrapperUsed then
              if {$IFDEF VER93}true{$ELSE}(mfVirtual in MethodFlags){$ENDIF} then
                AddStr(s, ', pointer(' + IntToStr(VMTOffset) + ')')
              else
                AddStr(s, ', pointer(MinVMTOffset - ' + IntToStr(VMTOffset) + ')')
            else
              begin
                AddStr(s,',Addr(');
                if UseWrapper then
                  AddStr(s, GetRecWrapName(cname + '__' + mmname) + ')')
                else
                  AddStr(s, procname + ')');
              end;

            if not IsRegMethod then
              begin
                if UseWrapper then
                  ctype := 'cRegister'
                else
                  ctype := GetEnumName(TypeInfo(TCallType), ord(CallType));
                AddStr(s, ',' + ctype);
              end;

            AddStr(s, ')');

            if MethodIsBad then
              begin
                if NoComments then
                  continue;

                BadCalls.Add('{' + s + '}'#13#10);
                AddType(pminfo, MTypeName, false);
              end
            else
              begin
                if CName = '' then
                  begin
                    //s := '__RegisteredMethods.Add(' + s + ')';
                    RegisteredMethodsList.Add(AnsiQuotedStr(mmname, ''''));
                  end;

                s := s + ';';
                Calls.Add(s + #13#10);

                AddType(pminfo, MTypeName, true);
              end;
          end;
      end;
  end;

  {---------------------------------}

  function recconvertfuncname1 (const rectypename : string) : string;
  begin
    result := 'function Convert' + DCRemovePoints(rectypename) + 'ToVariant(var R : ' + rectypename + ') : OleVariant;';
  end;

  {---------------------------------}

  function recconvertfuncname2 (const rectypename : string) : string;
  begin
    result := 'function ConvertVariantTo' + DCRemovePoints(rectypename) + '(const V : OleVariant) : ' + rectypename + ';';
  end;

  {---------------------------------}

  procedure OutRecConvertorsDecl;
  var
    i : integer;
    tname : string;
  begin
    for i := 0 to RecWrappers.Count - 1 do
      begin
        tname := RecWrappers[i];
        UnitText.Add(recconvertfuncname1(tname));
        UnitText.Add(recconvertfuncname2(tname));
      end;
  end;

  {---------------------------------}

  procedure OutRecConvertorsImpl;
  var
    i      : integer;
    tname  : string;
    wname  : string;
    wname2 : string;
  begin
    for i := 0 to RecWrappers.Count - 1 do
      begin
        tname := RecWrappers[i];
        wname := getRecWrapName(tname);
        wname2 := wname + '__';
        with UnitText do
          begin
            Add('');
            Add('type ' + wname2 + ' = class(' + wname + ')');
            Add('private');
            Add('fRPtr : pointer;');
            Add('function GetRecordPtr : pointer; override;');
            Add('end;');
            Add('function ' + wname2 + '.GetRecordPtr : pointer;');
            Add('begin');
            Add('result := fRPtr;');
            Add('end;');

            Add(recconvertfuncname1(tname));
            Add('var');
            Add('__rw : ' + wname2 + ';');
            Add('begin');
            Add('__rw := ' + wname2 + '.Create;');
            Add('__rw.fRPtr := @R;');
            Add('result := IDispatch(__rw);');
            Add('end;');

            Add(recconvertfuncname2(tname));
            Add('var');
            Add('_idisp : IDispatch;');
            Add('begin');
            Add('_idisp := VarToInterface(v);');
            Add('if _idisp = nil then exit;');
            Add('result := ' + tname + '((_idisp as IDCRecordWrapper).GetRecordPtr^);');
            Add('end;');
          end;
      end;
  end;

  {---------------------------------}

  procedure FillRecWrappers;
  var
    i : integer;
    tdecl : PTypeDeclInfo;
    tname : string;
    wraplist : TStringList;
    fname    : string;
  begin
    wraplist := TStringList.Create;
      try
        with ModuleInfo, TypeList do
          for i := 0 to Count - 1 do
            with PTypeDeclInfo(TypList[integer(Objects[i])])^ do
              begin
                tname := Strings[i];
                if (pos(' ', tname) > 0) or _BadType(ModuleInfo, tName, [], false, false) then
                  continue;
                tdecl := GetRecTypeDecl(ModuleInfo,tname);
                if tdecl <> nil then
                  begin
                    wraplist.Add(tname);
                    AddRecordWrapper(tname, tdecl);
                  end;
              end;

        for i := 0 to wraplist.Count - 1 do
          begin
            tname := wraplist[i];
            fname := '_' + tname + '_';
            RWrappersImpl.Add('function ' + fname + ' : IDispatch;');
            RWrappersImpl.Add('begin');
            RWrappersImpl.Add('  result := ' + getRecWrapName(tname) + '.Create;');
            RWrappersImpl.Add('end;');
            Calls.Add('__RegisteredMethods.Add(RegisterRWProc(MethodNames[' + IntToStr(RegisteredMethodsList.Count) + '],Addr(' + fname + ')));');
            RegisteredMethodsList.Add(AnsiQuotedStr(tname, ''''));
          end;

      finally
        wraplist.Free;
      end;
  end;

  {---------------------------------}

  procedure FillRegisteredMethods;
  var
    i : integer;
  begin
    with ModuleInfo, TypeList do
      begin
        RegisterMethods('', GlobalProcList, 0, GlobalProcList.Count {ProcCount});

        for i := 0 to Count - 1 do
          with PTypeDeclInfo(TypList[integer(Objects[i])])^ do
            if TypeKind = tdClass then
              if not InBadProcs(ModuleName, Strings[i]) then
                RegisterMethods(Strings[i], ProcList, MethodIndex, MethodCount);
      end;
  end;

  {---------------------------------}

  procedure OutTypes;
  begin
    if GoodTypeCount > 0 then
      with UnitText do
        begin
          Add('type');
          AddStrings(Types);
        end;
  end;

  {---------------------------------}

  procedure OutCalls(SectionIndex : integer);
  var
    StartIndex : integer;
    i          : integer;
  begin
    StartIndex := SectionIndex * MAXCALLSINSECTION;
    UnitText.Add('procedure _mreg_' + IntToStr(SectionIndex) + ';');
    UnitText.Add('begin');
    for i := StartIndex to min(StartIndex + MAXCALLSINSECTION, Calls.Count) - 1 do
      UnitText.Add(Calls[i]);
    UnitText.Add('end;');
  end;

  {---------------------------------}

  function GetRegProc(const CName, PropName : string; pinfo : PPropertyInfo; IsRec : boolean) : string;
  var
    ss : string;
    ppname : string;
  begin
    with pinfo^ do
      begin
        if ParamCount > 0 then
          begin
            result := 'RegisterIndexedProperty(';
            ss := IntToStr(ParamCount) + ',' + GetEnumName(TypeInfo(boolean), ord(pmDefault in Mode)) + ',';
          end
        else
          begin
            result := 'RegisterProperty(';
            ss := ''
          end;

        ppname := ModuleInfo.GetGlobalString(PropName);
        AddStr(result, CName + ',''' + ppname + ''',' + ss);
        AddStr(result, GetPropGetSetName(true, CName, ppname, pmRead in Mode));
        AddStr(result, ',' + GetPropGetSetName(false, CName, ppname, {not IsRec and }(pmWrite in Mode)) + ');');
      end;
  end;

  {---------------------------------}

  procedure RegisterProps(const CName : string; PropIndex, PropCount : integer;
    GetUnits : boolean);
  var
    i            : integer;
    pinfo        : PPropertyInfo;
    decl         : PTypeDeclInfo;
    ppname       : string;
    sVarType     : string;
    minfo        : TModuleInfo;
    PropIsRec    : boolean;
  begin
    for i := 0 to PropCount - 1 do
      begin
        pinfo := PPropertyInfo(ModuleInfo.PropList[i + PropIndex]);
        with pinfo^ do
          begin
            if not (Scope in [sPublic{, sPublished}]) or (Mode * [pmRead, pmWrite] = [])
            {or BadType(VarType)} then
              continue;

            with UnitText do
              begin
                ppname := ModuleInfo.GetGlobalString(PropName);

                with ModuleInfo do
                  begin
                    sVarType := GetGlobalString(VarType);
                    minfo := GetUnitWherePropertyWasDeclared(CName, ppname);
                  end;

                if _BadType(minfo, sVarType, [], false, false) {or IsRecType(sVarType)} then
                  continue;

                decl := minfo.GetTypeDecl(sVarType);

                if GetUnits then
                  begin
                    if (decl <> nil) and (decl.MInfo <> nil) then
                      AddUses(decl.MInfo.ModuleName);

                    _checkrecordtype(sVarType);
                  end
                else
                  begin

                    if pmRead in Mode then
                      AddGetFunction(CName, ppName, sVarType, decl, pinfo,MInfo,UnitText);

                    PropIsRec := TDeclIsRec(decl);
                    if {not PropIsRec and }(pmWrite in Mode) then
                      AddSetFunction(CName, ppName, sVarType, decl, pinfo,MInfo,UnitText);

                    PropRegs.Add(GetRegProc(CName, ppname, pinfo, PropIsRec));
                  end;
              end;
          end;
      end;
  end;

  {---------------------------------}

  procedure OutPropReg(GetUnits : boolean);
  var
    i : integer;
    index:integer;
  begin
    with ModuleInfo, TypeList do
      for i := 0 to Count - 1 do
        with PTypeDeclInfo(TypList[integer(Objects[i])])^ do
          if (TypeKind = tdClass) and not InBadProcs(ModuleName, Strings[i]) then
            begin
              If not BadTypes.Find(Strings[i],index) then //Added in V4.1
                RegisterProps(Strings[i], PropIndex, PropCount, GetUnits);
//              RegisterVars()
            end;

    if not GetUnits then
      with UnitText do
        begin
          Add('procedure __RegisterProps;');
          Add('begin');
          AddStrings(PropRegs);
          Add('end;'#13#10);
        end;
  end;

  {---------------------------------}

  procedure RegisterVar(PVar : PVarInfo; onlyscan : boolean);
  var
    decl     : PTypeDeclInfo;
    pdecl    : PTypeDeclInfo;
    sVarType : string;
    sVarName : string;
    ss       : string;
    b        : boolean;
    isVarRec : boolean;
    M        : TModuleInfo;
  begin
    with pvar^ do
      begin
        if IsThread or BadType(VarType, []) then
          exit;

        with ModuleInfo do
          begin
            sVarName := GetGlobalString(VarName);
            decl := GetTypeDecl(GetGlobalString(VarType));
            pdecl := decl;
            repeat
              if pdecl <> nil then
                with pdecl^ do
                  if (Reference <> trEqual) or (TypeKind = tdRecord) then
                    break
                  else
                    with MInfo do
                      pdecl := GetTypeDecl(GetGlobalString(BaseName));
            until (pdecl = nil);

            if pdecl <> nil then
              begin
                with pdecl^ do
                  sVarType := MInfo.GetGlobalString(TypeName);

                if pos(' ', sVarType) <> 0 then
                  exit;
              end
            else
              sVarType := '';

            isVarRec := TDeclIsRec(decl);
            if not onlyscan then
              begin
                If pdecl<>nil then
                  M:=pdecl^.MInfo
                else
                  M:=nil;

                AddGetFunction(ModuleName, sVarName, sVarType, decl, nil,M,UnitText);
                if not isVarRec then
                  AddSetFunction(ModuleName, sVarName, sVarType, decl, nil,M,UnitText);
              end
            else
              begin
                _checkrecordtype(sVarType);
                ss := '__RegisteredVars.Add(RegisterVar(''' + sVarName + '''';
                for b := true downto false do
                  AddStr(ss, ',' + GetPropGetSetName(b, ModuleName, sVarName, not isVarRec or b));

                VarRegs.Add(ss + '));');
                VarNames.Add(AnsiQuotedStr(sVarName, ''''));
              end;
          end;
      end;
  end;

  {---------------------------------}

  procedure OutStringArrayConstant(ConstList : TStringList; const ConstName : string);
  var
    i : integer;
    ccount : integer;
  begin
    ccount := ConstList.Count;
    if ccount = 0 then
      exit;

    UnitText.Add('const ' + ConstName + ' : array[0..' + inttostr(ccount - 1) + '] of string = (');
    UnitText.Add(ConstList[0]);
    for i := 1 to ccount - 1 do
      UnitText.Add(',' + ConstList[i]);

    UnitText.Add(');');
  end;

  {---------------------------------}

  procedure OutVarReg(onlyscan : boolean);
  var
    i : integer;
  begin
    with ModuleInfo do
      for i := 0 to VarCount - 1 do
        RegisterVar(PVarInfo(VarList[i]), onlyscan);

    if not onlyscan then
      with UnitText do
        begin
          if VarNames.Count > 0 then
            begin
              Add('var __RegisteredVars : TList;');
              Add('procedure __RegisterVars;');
              Add('begin');
              Add('__RegisteredVars := TList.Create;');
              AddStrings(VarRegs);
              Add('end;'#13#10);
              Add('procedure __UnregisterVars;');
              Add('begin');
              if AddUnregistration then
                for i := 0 to VarNames.Count - 1 do
                  begin
                    Add('UnregisterVar(' + VarNames[i] + ', __RegisteredVars[' + IntToStr(i) + ']);');
                  end;
              Add('__RegisteredVars.Free;');
              Add('end;'#13#10);
            end;
        end;
  end;

  {---------------------------------}

  procedure OutEventsReg;

    {---------------------------------}

    procedure RegEvent(const TypeName : string; EvInfo : PMethodInfo);
    var
      s : string;
      i : integer;
      badparamtype : boolean;
      _mi : TModuleInfo;
      AAIsRecType:boolean;
      AABadRetType:boolean;
      AABadparams:boolean;
    begin
      If TypeName='TKeyEvent' then
        asm nop end;

      with EvInfo^ do
        begin
          if not OfObject or (pos(' ', TypeName) <> 0) then
            exit;

          s := 'RegisterEvent(' + GetTypeInfoString(TypeName) + ',';
          AddStr(s, GetParamsTypeInfoStr(ParamIndex, ParamCount, RetType));
          AddStr(s, ');');

          badparamtype := false;

          _mi := ModuleInfo;
          for i := ParamCount - 1 downto 0 do
            with _mi do
              if IsRecType(ModuleInfo,GetGlobalString(PParamInfo(GlobalParams[ParamIndex + i]).ParamType)) then
                begin
                  badparamtype := true;
                  break;
                end;

          AAIsRecType  := IsRecType(ModuleInfo,_mi.GetGlobalString(RetType));
          AABadRetType := BadType(RetType, []);
          AABadparams  := BadParams(ParamIndex, ParamCount);

          if badparamtype or AABadParams or AABadRetType or AAIsRecType then
            if NoComments then
              exit
            else
              s := '{' +  s + '}';
        end;

      UnitText.Add(s + #13#10);
    end;

    {---------------------------------}

  var
    i : integer;
  begin
    with ModuleInfo, TypeList do
      for i := 0 to Count - 1 do
        with PTypeDeclInfo(TypList[integer(Objects[i])])^ do
          if (BaseType = btProc) then
            RegEvent(Strings[i], PMethodInfo(GlobalProcList[ProcInfo]));
  end;

  {---------------------------------}

  procedure OutConstsReg(SectionIndex : integer);
  var
    RegisteredConstsListName : string;
    i               : integer;
    cval            : string;
    PropIsObject    : boolean;
    PropIsSet       : boolean;
    PropIsChar      : boolean;
    PropIsInterface : boolean;
    tdecl           : PTypeDeclInfo;
    creglist        : TStringList;
    cnameslist      : TStringList;
    _cname          : string;
    SectionIndexStr : string;
    StartIndex      : integer;
    ConstNamesName  : string;
    AABadType       : boolean;
    AAIsRecType     : boolean;

  begin
    SectionIndexStr := IntToStr(SectionIndex);
    RegisteredConstsListName := '__RegisteredConstsList' + SectionIndexStr;
    ConstNamesName := '__ConstNames' + SectionIndexStr;
    creglist   := TStringList.Create;
    cnameslist := TStringList.Create;
    try
      StartIndex := SectionIndex * MAXCONSTSINSECTION;
      with ModuleInfo, ConstList do
        for i := StartIndex to min(StartIndex + MAXCONSTSINSECTION, Count) - 1 do
          with PConstInfo(Items[i])^ do
          begin
            if GetGlobalString(ConstName)='IID_IQStmt' then
              asm nop end;

            AABadType:=BadType(ConstType, [tdClass]);
            AAIsRecType:=IsRecType(ModuleInfo,MInfo.GetGlobalString(ConstType));

            if not (AABadType or AAIsRecType) then
              begin
                cval := GetGlobalString(ConstName);
                if CompareText(cval, 'nil') = 0 then
                  continue;

                if InBadProcs(ModuleName, cval) then
                  continue;

                with ModuleInfo do
                  begin
                    tdecl := GetTypeDecl(GetGlobalString(ConstType));
                    CheckDecl(tdecl, PropIsObject, PropIsSet, PropIsChar, PropIsInterface);
                  end;

                if PropIsSet or IsSet then
                  cval := 'VarFromSet(' + cval + ', sizeof(' + cval + '))'
                else if TDeclIsPointer(tdecl) or TDeclIsPChar(tdecl) or TDeclIsPWideChar(tdecl) then
                  cval := 'Integer(' + cval + ')';

                _cname := AnsiQuotedStr(GetGlobalString(ConstName), '''');
                cval := RegisteredConstsListName + '.Add(RegisterConst(' + ConstNamesName + '[' + inttostr(cnameslist.count) + '] ,' + cval + '));';
                cnameslist.Add(_cname);

                {if i > MAXCONSTINFILE then
                  if NoComments then
                    break
                  else
                    cval := '//' + cval;}

                creglist.Add(cval);
              end;
          end;

      if cnameslist.Count > 0 then
        begin
          OutStringArrayConstant(cnameslist, ConstNamesName);
          UnitText.Add('var ' + RegisteredConstsListName + ' : TList;');
        end;

      UnitText.Add('procedure __RegisterConsts' + SectionIndexStr + ';');
      UnitText.Add('begin');

      if cnameslist.count > 0 then
        UnitText.Add(RegisteredConstsListName + ' := TList.Create;');

      for i := 0 to creglist.Count - 1 do
        UnitText.Add(creglist[i]);

      UnitText.Add('end;'#13#10);

      UnitText.Add('procedure __UnregisterConsts' + SectionIndexStr + ';');
      if cnameslist.count > 0 then
        UnitText.Add('var i : integer;');

      UnitText.Add('begin');

      if cnameslist.count > 0 then
        begin
          if AddUnregistration then
            begin
              UnitText.Add('for i := 0 to ' + IntToStr(cnameslist.Count - 1) + ' do');
              UnitText.Add('UnregisterConst(' + ConstNamesName + '[i], ' + RegisteredConstsListName + '[i]);');
            end;

          UnitText.Add(RegisteredConstsListName + '.Free');
        end;

      UnitText.Add('end;'#13#10);

    finally
      cnameslist.Free;
      creglist.Free;
    end;
  end;

  {---------------------------------}

  procedure OutClassesReg;
  var
    i      : integer;
    clist  : TStringList;
    ccount : integer;
    s      : string;
    tname  : string;
  begin
    clist := TStringList.Create;
    try
      with ModuleInfo, TypeList do
        for i := 0 to Count - 1 do
          with PTypeDeclInfo(TypList[integer(Objects[i])])^ do
            begin
              tname := Strings[i];
              if (TypeKind = tdClass) and not (InBadProcs(ModuleName, tname) or IsVarType(tname)) then
                clist.Add(tname);
            end;

      ccount := clist.Count;
      if ccount > 0 then
        begin
          UnitText.Add('const ClassList : array[0..' + IntToStr(cCount - 1) + '] of TClass = (');
          for i := 0 to ccount - 1 do
            begin
              s := clist[i];
              if i < ccount - 1 then
                s := s + ',';

              UnitText.Add(s);
            end;
          UnitText.Add(');');
        end;
      UnitText.Add('procedure __RegisterClasses;');
      UnitText.Add('begin');
      if ccount > 0 then
        UnitText.Add('RegisterClassesInScript(ClassList);');
      UnitText.Add('end;'#13#10);

      UnitText.Add('procedure __UnRegisterClasses;');
      UnitText.Add('begin');
      if ccount > 0 then
        if AddUnregistration then
          UnitText.Add('UnRegisterClassesInScript(ClassList);');
          
      UnitText.Add('end;'#13#10);
    finally
      clist.Free;
    end;
  end;

  {---------------------------------}

  procedure OutRecWrappers;
  begin
    UnitText.AddStrings(RWrappers);
  end;

  {---------------------------------}

  procedure OutProtAccess;
  begin
    UnitText.AddStrings(ProtAccess);
  end;

  {---------------------------------}

  procedure OutRWrappersImpl;
  begin
    UnitText.AddStrings(RWrappersImpl);
  end;

  {---------------------------------}

  procedure OutRFuncWrappers;
  begin
    UnitText.AddStrings(RFuncWrappers);
  end;

  {---------------------------------}

  procedure OutMethodWrappers;
  begin
    UnitText.AddStrings(MWrappers);
  end;

  {---------------------------------}

var
  index  : integer;
  i      : integer;
  ConstSections : integer;
  CallsSections : integer;
begin
  GoodTypeCount := 0;
  ConstSections := ModuleInfo.ConstList.Count div MAXCONSTSINSECTION;
  Calls    := TStringList.Create;
  BadCalls := TStringList.Create;
  Types    := TStringList.Create;
  UnitText := TStringList.Create;
  PropRegs := TStringList.Create;
  VarRegs  := TStringList.Create;
  VarNames := TStringList.Create;
  uunits   := TStringList.Create;
  RWrappers := TStringList.Create;
  RWrappersImpl := TStringList.Create;
  RFuncWrappers := TStringList.Create;
  RegisteredMethodsList := TStringList.Create;
  RecWrappers := CreateSortedStringList;
  DeclaredTypes := CreateSortedStringList;
  DeclaredTypeNames := TStringList.Create;
  RegisteredMethods := CreateSortedStringList;
  ProtClasses := CreateSortedStringList;
  MWrappers := TStringList.Create;
  ProtAccess := TStringList.Create;
  DTypeCount := 0;

  with UnitText do
    try
      WriteHeader;
      Add('interface');
      Add('{$I dc.inc}');
      Add('{$D-,L-,Y-}');
      Add('{$HINTS OFF}');
      Add('{$WARNINGS OFF}');
      OutPropReg(true);
      OutVarReg(true);
      FillRecWrappers;
      FillRegisteredMethods;
      WriteUsesClause;

      OutRecConvertorsDecl;

      Add('implementation');
      {$IFNDEF CLX}
      Add('{$IFDEF D3}');
      uunits.Sorted := true;
//      if not uunits.Find('activex', index) then
//        Add('uses activex;');
      Add('{$ELSE}');
      if not uunits.Find('ole2', index) then
        Add('uses ole2;');
      Add('type');
      Add('  OleVariant = Variant;');
      Add('{$ENDIF}');
      {$ELSE}
      Add('uses dcactivex;');
      {$ENDIF}

      OutRecWrappers;
      OutProtAccess;
      OutMethodWrappers;
      OutTypes;

      OutRWrappersImpl;
      OutRFuncWrappers;
      OutRecConvertorsImpl;
      OutPropReg(false);
      OutVarReg(false);

      for i := 0 to ConstSections do
        OutConstsReg(i);

      OutClassesReg;
      if Calls.Count > 0 then
        Add('var __RegisteredMethods : TList;');

      if RegisteredMethodsList.Count > 0 then
        begin
          OutStringArrayConstant(RegisteredMethodsList, 'MethodNames');
          Add('');
          Add('procedure __UnregisterProcs;');
          Add('var i : integer;');
          Add('begin');
          if AddUnregistration then
            begin
              Add('  for i := 0 to ' + IntToStr(RegisteredMethodsList.Count - 1) + ' do');
              Add('    UnregisterProcedure(MethodNames[i] ,__RegisteredMethods[i]);');
            end;
          Add('__RegisteredMethods.Free;');
          Add('end;');
          Add('');
        end;

      CallsSections := Calls.Count div MAXCALLSINSECTION;
      for i := 0 to CallsSections do
        OutCalls(i);

      Add('initialization');

      if RegisteredMethodsList.Count > 0 then
        Add('__RegisteredMethods := TList.Create;');

      for i := 0 to CallsSections do
        UnitText.Add('_mreg_' + IntToStr(i) + ';');
        
      UnitText.AddStrings(BadCalls);

      OutEventsReg;
      Add('__RegisterClasses;');

      for i := 0 to ConstSections do
        Add('__RegisterConsts' + IntToStr(i) + ';');

      Add('__RegisterProps;');
      if VarNames.Count > 0 then
        Add('__RegisterVars;');

      Add('');
      Add('finalization');
      Add('__UnRegisterClasses;');
      for i := 0 to ConstSections do
        Add('__UnregisterConsts' + IntToStr(i) + ';');

      //Add('__UnRegisterProps;');  // UnRegisterclass frees all props and methods
      if VarNames.Count > 0 then
        Add('__UnRegisterVars;');

      if RegisteredMethodsList.Count > 0 then
        begin
          Add('__UnregisterProcs;');
        end;

      Add('end.');
      SaveToFile(Dest);
    finally
      Free;
      Types.Free;
      Calls.Free;
      BadCalls.Free;
      PropRegs.Free;
      VarRegs.Free;
      VarNames.Free;
      uunits.Free;
      DeclaredTypes.Free;
      DeclaredTypeNames.Free;
      MWrappers.Free;
      RWrappers.Free;
      RWrappersImpl.Free;
      RFuncWrappers.Free;
      RegisteredMethodsList.Free;
      RecWrappers.Free;
      RegisteredMethods.Free;
      ProtClasses.Free;
      ProtAccess.Free;
    end;
end;

{------------------------------------------------------------------}

procedure GenerateImportUnit(const Source, Dest, Defines, Units, Aliases : String;
  NoComments,AddUnregistration,ANoDefaultDefines:boolean;AMsgHandler : TDCMsgHandler);
var
  parser : TUnitParser;
  ADelphiVer:TDelphiVer;
begin

  DCGetDelphiVerFromDefinesStr(Defines,ADelphiVer);

  parser := LoadModuleEx( Source, Defines, '', Units, Aliases,
    DCGenDPUPath( ADelphiVer ), TUnitParser ,ANoDefaultDefines,AMsgHandler);
  with parser do
    try
      if ModuleInfo.ModuleType <> moLibrary then
        GenerateImportCode(ModuleInfo, Dest, NoComments, AddUnregistration,
          ANoDefaultDefines,AMsgHandler);
    finally
      Free;
    end;
end;

{------------------------------------------------------------------}
{
procedure LoadStringsFromFile(S : TStrings; const FileName : string);
var
  fHandle   : THandle;
  MapHandle : THandle;
  FileBuf   : PChar;
begin
  MapHandle := 0;
  fHandle := CreateFile(PChar(FileName), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, 0, FILE_FLAG_SEQUENTIAL_SCAN);
  try
    if fHandle = INVALID_HANDLE_VALUE then
      ErrorFmt(SErrOpenFile, [FileName]);

    MapHandle := CreateFileMapping(fHandle, nil, PAGE_READONLY, 0, 0, nil);
    if MapHandle = 0 then
      Error(SErrorCreateMap);

    FileBuf := MapViewOfFile(MapHandle, FILE_MAP_READ, 0, 0, 0);
    if FileBuf = nil then
      ErrorFmt(SErrorMap, [FileName]);

    try
      S.Text := FileBuf;
    finally
      UnMapViewOfFile(FileBuf);
    end;
  finally
    CloseHandle(MapHandle);
    CloseHandle(fHandle);
  end;
end;
}
{------------------------------------------------------------------}

Procedure InitializeBadLists;
begin
  BadProcs.Clear;
  StrArrayToStrings( BadProcs, BadProcList );
  BadTypes.Clear;
  StrArrayToStrings( BadTypes, BadTypeList );
  SysUnits.Clear;
  StrArrayToStrings( SysUnits, cSysUnits );
end;

{---------------------------------}

function GetRecTypeDecl(ModuleInfo:TModuleInfo;const TypeName : string) : PTypeDeclInfo;
begin
  if TypeName = '' then
    begin
      result := nil;
      exit;
    end;

  result := ModuleInfo.GetTypeDecl{InAllUnits}(TypeName);
  while result <> nil do
    begin
      if (result.TypeKind = tdRef) then
        begin
          result := nil;
          exit;
        end;
      if result.TypeKind = tdRecord then
        exit;
      with result^, MInfo do
        result := GetTypeDecl{InAllUnits}(GetGlobalString(BaseName));
    end;
end;

{---------------------------------}

function IsSetType(ModuleInfo:TModuleInfo;const TypeName : string) : boolean;
var
  decl : PTypeDeclInfo;
begin
  result := false;
  decl := ModuleInfo.GetTypeDecl(TypeName);

  while decl <> nil do
    with decl^ do
      begin
        result := Reference = trSetOf;
        if result then
          exit;
        if (TypeKind <> tdBase) or (Reference <> trEqual) then
          break
        else
          with MInfo do
            decl := GetTypeDecl(GetGlobalString(BaseName));
      end;
end;

{---------------------------------}

function IsRecType(ModuleInfo:TModuleInfo;const TypeName : string) : boolean;
begin
  result := GetRecTypeDecl(ModuleInfo,TypeName) <> nil;
end;

{---------------------------------}

function TDeclIsRec(decl : PTypeDeclInfo) : boolean;
begin
  result := (decl <> nil) and IsRecType(decl.MInfo,decl.MInfo.GetGlobalString(decl.TypeName));
end;

{---------------------------------}

function TDeclIsNoTypeInfoType(tdecl : PTypeDeclInfo) : boolean;
const
  cDCNoTypeInfoTypes=
    [btPointer, btProc, btPChar, btPWideChar, btPAnsiChar
//     btNone // added in V4.1
    ];
var
  BaseNameStr:String;  
begin
  result := (tdecl <> nil);
  if result then
    repeat
      with tdecl^ do
        begin
          result := (BaseType in cDCNoTypeInfoTypes) or (Reference = trPointer);

          if result then
            break
          else
            begin
              BaseNameStr:=MInfo.GetGlobalString(BaseName);
              tdecl := MInfo.GetTypeDecl(BaseNameStr);
            end;
        end;
     until tdecl = nil;
end;

{---------------------------------}

procedure CheckDecl(decl : PTypeDeclInfo; var PropIsObject, PropIsSet,
                    PropIsChar, PropIsInterface : boolean);
begin
  PropIsObject := false;
  PropIsSet := false;
  PropIsChar := false;
  PropIsInterface := false;

  while decl <> nil do
    with decl^ do
      begin
        PropIsObject := (TypeKind = tdClass);
        PropIsInterface := TypeKind in [tdInterface, tdDispInterface];
        PropIsSet := Reference = trSetOf;
        PropIsChar := BaseType in [btChar, btAnsiChar];
        if (TypeKind <> tdBase) or (Reference <> trEqual) then
          break
        else
          with MInfo do
            decl := GetTypeDecl(GetGlobalString(BaseName));
      end;
end;

{-----------------------------}

{
Not supported when
 - type is record (can use DCVarToInterface and IDCRecordWrapper interface)
 - type is set (can use dcscript.VarToSet with temp variable)
}

function DCGetParamTemplate(Decl:PTypeDeclInfo):String;
var
  ParamIsObject    : boolean;
  ParamIsSet       : boolean;
  ParamIsChar      : boolean;
  ParamIsInterface : boolean;
  ParamIsPointer   : boolean;
  ParamIsPChar     : boolean;
  ParamIsPWideChar : boolean;
{
  ParamIsRec       : boolean;
}
  Prefix,Suffix    : String;
  TypeName         : String;
begin
  If Decl=nil then
    begin
      Result:='%S';
      exit;
    end;

  CheckDecl(Decl,ParamIsObject, ParamIsSet, ParamIsChar, ParamIsInterface);
{
  ParamIsRec := TDeclIsRec(Decl);
}
  ParamIsPointer := TDeclIsPointer(Decl);
  ParamIsPChar := TDeclIsPChar(Decl);
  ParamIsPWideChar := TDeclIsPWideChar(Decl);

  TypeName:=Decl.MInfo.GetGlobalString(Decl.TypeName);

  if ParamIsObject then
    Prefix:=TypeName+'(VarToObject('
  else
  if ParamIsChar then
    Prefix:='VarToChar('
  else
  if ParamIsInterface then
    Prefix:=TypeName+'(VarToInterface('
  else
  if ParamIsPChar then
    Prefix:='PChar(String('
  else
  if ParamIsPWideChar then
    Prefix:='DCStringToOleSt(String('
  else
  if ParamIsPointer then
    Prefix:='VarToPointer('
  else
    Prefix:='';

  if ParamIsObject or ParamIsInterface or ParamIsPChar or ParamIsPWideChar then
    Suffix:='))'
  else
  if ParamIsChar or ParamIsPointer then
    Suffix:=')'
  else
    Suffix:='';

  Result:=Prefix+'%S'+Suffix;
end;

{-----------------------------}

function DCGetPropParamTemplate(Module:TModuleInfo;ParamIndex:Integer):String;
var
  ParamInfo:PParamInfo;
  ParamName:String;
  ParamType:String;
  Decl:PTypeDeclInfo;
begin
  If Module<>nil then
    begin
      ParamInfo:=PParamInfo(Module.GlobalParams[ParamIndex]);
      ParamName:=Module.GetGlobalString(ParamInfo.ParamName);
      ParamType:=Module.GetGlobalString(ParamInfo.ParamType);
      Decl:=Module.GetTypeDecl(ParamType);
    end
  else
    Decl:=nil;
  Result:=DCGetParamTemplate(Decl);
end;

{---------------------------------}

function GetPropParams(startindex:integer;pinfo:PPropertyInfo;
  ModuleInfo:TModuleInfo) : string;
var
  i : integer;
  S : String;
begin
  result := '';
  with pinfo^ do
    if ParamCount > 0 then
      begin
        result := '[';
        for i := ParamCount - 1 downto 0 do
          begin
            S:='OleVariant(Params^[' + IntToStr(startindex + i) + '])';

            S:=Format(DCGetPropParamTemplate(ModuleInfo,ParamIndex),[S]); // Added in V4.1

            AddStr(result, S);
            if i > 0 then
              AddStr(result, ', ');
          end;

        AddStr(result, ']');
      end;
end;

{---------------------------------}

function GetPropGetSetName(IsGet : boolean; const CName, PropName : string; HasProc : boolean) : string;
const
  _Names : array[boolean] of string = ('__DC__Set', '__DC__Get');
begin
  if HasProc then
    result :=  _Names[IsGet] + CName + '__' + PropName
  else
    result := 'nil';
end;

{---------------------------------}

procedure AddTmpVar(IsSet, IsRec : boolean; const sVarType : string;UnitText:TStrings);
begin
  if IsSet or IsRec then
    with UnitText do
      begin
        Add('var');
        if IsRec then
          Add('__wrapper : ' + getRecWrapName(sVarType) + ';')
        else
          Add('  tmp : ' + sVarType + ';');
      end;
end;

{---------------------------------}

procedure AddGetFunction(const CName, PropName, sVarType : string; decl : PTypeDeclInfo;
  pinfo : PPropertyInfo;ModuleInfo:TModuleInfo;UnitText:TStrings);
var
  ss : string;
  pppname         : string;
  PropIsObject    : boolean;
  PropIsSet       : boolean;
  PropIsChar      : boolean;
  PropIsInterface : boolean;
  PropIsPointer   : boolean;
  PropIsPChar     : boolean;
  PropIsPWideChar : boolean;
  PropIsRec       : boolean;
  M               : TModuleInfo;
begin
  with UnitText do
    begin
      PropIsRec := TDeclIsRec(decl);
      CheckDecl(decl, PropIsObject, PropIsSet, PropIsChar, PropIsInterface);

      Add('function ' + GetPropGetSetName(true, CName, PropName, true) + '(Instance : TObject; Params : PVariantArgList) : OleVariant;');
      AddTmpVar(PropIsSet, PropIsRec, sVarType,UnitText);
      {
      If Decl<>nil then
        M:=Decl.MInfo
      else
        M:=nil;
      }

      M:=ModuleInfo;

      if pinfo <> nil then
        pppname := CName + '(Instance).' + PropName + GetPropParams(0, pinfo,M)
      else
        pppname := CName + '.' + PropName;

      Add('begin');

      if PropIsSet and (pinfo <> nil) then
        Add('tmp := ' + pppname + ';');

      if PropIsRec then
        begin
          Add('__wrapper := ' + getRecWrapName(sVarType) + '.Create;');
          Add('__wrapper.fR := ' + pppname + ';');
          Add('result := IUnknown(__wrapper) as IDispatch;');
          Add('end;'#13#10);
          exit;
        end;

      ss := 'result := ';

      PropIsPointer := TDeclIsPointer(decl);
      PropIsPChar := TDeclIsPChar(decl);
      PropIsPWideChar := TDeclIsPWideChar(decl);

      if PropIsObject then
        AddStr(ss, 'VarFromObject(')
      else
      if PropIsSet then
        AddStr(ss, 'VarFromSet(')
      else
      if PropIsPChar or PropIsPWideChar then
        AddStr(ss, 'String(')
      else
      if PropIsPointer then
        AddStr(ss, 'PointerToVariant(')
      else
      if PropIsInterface then
        AddStr(ss, 'VarFromInterface(');

      if not PropIsSet then
        AddStr(ss, pppname)
      else
        if pinfo <> nil then
          AddStr(ss, 'tmp, sizeof(tmp)')
        else
          AddStr(ss, pppname + ', sizeof(' + pppname + ')');

      if PropIsObject  or PropIsSet or PropIsPointer or PropIsPChar or
        PropIsPWideChar or PropIsInterface
      then
        AddStr(ss, ')');

      AddStr(ss, ';');
      Add(ss);
      Add('end;'#13#10);
    end;
end;

{---------------------------------}

procedure AddRecVars(UnitText:TStrings);
begin
  with UnitText do
    begin
      Add('var');
      Add('__idisp:IDispatch;');
      Add('__iwrapper:IDCRecordWrapper;');
    end;
end;

{---------------------------------}

procedure AddSetFunction(const CName, PropName, sVarType : string; decl : PTypeDeclInfo;
  pinfo : PPropertyInfo;ModuleInfo:TModuleInfo;UnitText:TStrings);
var
  ss : string;
  PropIsObject    : boolean;
  PropIsSet       : boolean;
  PropIsChar      : boolean;
  PropIsInterface : boolean;
  PropIsPointer   : boolean;
  PropIsPChar     : boolean;
  PropIsPWideChar : boolean;
  PropIsRec       : boolean;
  pppname         : string;
begin
  with UnitText do
    begin
      Add('procedure ' + GetPropGetSetName(false, CName, PropName, true) + '(Instance : TObject; Params : PVariantArgList);');

      if (pinfo = nil) and ((CompareText(CName, 'system') = 0) and
             ((CompareText(PropName, 'Null') = 0) or
              (CompareText(PropName, 'UnAssigned') = 0))) then
        begin
          Add('begin');
          Add('end;'#13#10);
          exit;
        end;

      CheckDecl(decl, PropIsObject, PropIsSet, PropIsChar, PropIsInterface);
      PropIsRec := TDeclIsRec(decl);

      if PropIsRec then
        AddRecVars(UnitText);

      if pinfo <> nil then
        AddTmpVar(PropIsSet, false, sVarType,UnitText);

      Add('begin');

      if PropIsSet then
        begin
          if pinfo <> nil then
            ss := 'VarToSet(tmp, sizeof(tmp), Variant(Params^[0]));'
          else
            begin
              pppname := CName + '.' + PropName;
              ss := 'VarToSet(' + pppname + ', sizeof(' + pppname + '), Variant(Params^[0]));';
            end;

          Add(ss);
        end;

      if (pinfo <> nil) or not PropIsSet then
        begin
           if PropIsRec then
             begin
               Add('__idisp:=DCVarToInterface(OleVariant(Params^[0]));');
               Add('if __idisp=nil then exit;');
               Add('__idisp.QueryInterface(IDCRecordWrapper, __iwrapper);');
             end;

           if (pinfo = nil) and PropIsObject then
             ss := 'TObject('
           else
             ss := '';
            {
            If Decl<>nil then
              M:=Decl.MInfo
            else
              M:=nil;
            }
            {
            M:=ModuleInfo;
            }
           if pinfo <> nil then
             AddStr(ss, CName + '(Instance).' + PropName + GetPropParams(1, pinfo,ModuleInfo))
           else
             AddStr(ss, CName + '.' + PropName);

           if (pinfo = nil) and PropIsObject then
             AddStr(ss, ')');

           AddStr(ss, ':=');

           PropIsPointer := TDeclIsPointer(decl);
           PropIsPChar := TDeclIsPChar(decl);
           PropIsPWideChar := TDeclIsPWideChar(decl);

           if PropIsObject then
             AddStr(ss, sVarType + '(VarToObject(')
           else if PropIsChar then
             AddStr(ss, 'VarToChar(')
           else if PropIsInterface then
             AddStr(ss, sVarType + '(VarToInterface(')
           else if PropIsPChar then
             AddStr(ss, 'PChar(String(')
           else if PropIsPWideChar then
             AddStr(ss, 'DCStringToOleSt(String(')
           else if PropIsPointer then
             AddStr(ss, 'VarToPointer(')
           else if PropIsRec then
             AddStr(ss, sVarType + '(__iwrapper.GetRecordPtr^');

           if PropIsSet then
             AddStr(ss, 'tmp')
           else if not PropIsRec then
             AddStr(ss, 'OleVariant(Params^[0]');

           if PropIsObject or PropIsInterface or PropIsPChar or PropIsPWideChar then
             AddStr(ss, '))')
           else if PropIsChar or PropIsPointer then
             AddStr(ss, ')');

           if PropIsSet then
             AddStr(ss, ';')
           else
             AddStr(ss, ');');

           Add(ss);
        end;

      Add('end;'#13#10);
    end;
end;

{-----------------------------}

initialization
  BadProcs := TStringList.Create;
  StrArrayToStrings(BadProcs, BadProcList);
  BadProcs.Sorted := true;

  BadTypes := TStringList.Create;
  StrArrayToStrings(BadTypes, BadTypeList);
  BadTypes.Sorted := true;

  SysUnits := TStringList.Create;
  StrArrayToStrings(SysUnits, cSysUnits);

finalization
  BadProcs.Free;
  BadTypes.Free;
  SysUnits.Free;
end.
