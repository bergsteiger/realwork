unit evStylesPrintAndExportFontSizeSettingRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/evStylesPrintAndExportFontSizeSettingRes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::StyleTable::evStylesPrintAndExportFontSizeSettingRes
//
// ������� ��� ��������� "������������ ��� �������� � ������ ��������� ������ ������"
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Interfaces,
  afwInterfaces,
  l3CProtoObject,
  l3StringIDEx
  ;

type
 PrintAndExportFontSizeEnum = (
  {* ����� ��� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
   KEY_PrintAndExportFontSize_pef8 // 8
 , KEY_PrintAndExportFontSize_pef9 // 9
 , KEY_PrintAndExportFontSize_pef10 // 10
 , KEY_PrintAndExportFontSize_pef11 // 11
 , KEY_PrintAndExportFontSize_pef12 // 12
 , KEY_PrintAndExportFontSize_pef14 // 14
 , KEY_PrintAndExportFontSize_pef16 // 16
 );//PrintAndExportFontSizeEnum

const
  { PrintAndExportFontSizeKey }
 pi_evStyles_PrintAndExportFontSize = '�����/������������ ��� �������� � ������ ��������� ������ ������';
  { ������������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
 dv_evStyles_PrintAndExportFontSize = 0;
  { �������� ��-��������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }

var
  { ������������ ������ PrintAndExportFontSizeValues }
 str_PrintAndExportFontSize_pef8 : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef8'; rValue : '8');
  { 8 }
 str_PrintAndExportFontSize_pef9 : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef9'; rValue : '9');
  { 9 }
 str_PrintAndExportFontSize_pef10 : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef10'; rValue : '10');
  { 10 }
 str_PrintAndExportFontSize_pef11 : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef11'; rValue : '11');
  { 11 }
 str_PrintAndExportFontSize_pef12 : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef12'; rValue : '12');
  { 12 }
 str_PrintAndExportFontSize_pef14 : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef14'; rValue : '14');
  { 14 }
 str_PrintAndExportFontSize_pef16 : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef16'; rValue : '16');
  { 16 }

const
  { ����� �������������� �������������� ����� PrintAndExportFontSizeValues }
 PrintAndExportFontSizeValuesMap : array [PrintAndExportFontSizeEnum] of Pl3StringIDEx = (
  @str_PrintAndExportFontSize_pef8
  , @str_PrintAndExportFontSize_pef9
  , @str_PrintAndExportFontSize_pef10
  , @str_PrintAndExportFontSize_pef11
  , @str_PrintAndExportFontSize_pef12
  , @str_PrintAndExportFontSize_pef14
  , @str_PrintAndExportFontSize_pef16
 );//PrintAndExportFontSizeValuesMap

type
 PrintAndExportFontSizeValuesMapHelper = {final} class
  {* ��������� ����� ��� �������������� �������� PrintAndExportFontSizeValuesMap }
 public
 // public methods
   class procedure FillStrings(const aStrings: IafwStrings);
     {* ���������� ������ ����� ���������� }
   class function DisplayNameToValue(const aDisplayName: Il3CString): PrintAndExportFontSizeEnum;
     {* �������������� ���������� �������� � ����������� }
 end;//PrintAndExportFontSizeValuesMapHelper

 TPrintAndExportFontSizeValuesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* ����� ��� ���������� ���� ��� PrintAndExportFontSizeValuesMap }
 protected
 // realized methods
   function pm_GetMapID: Tl3ValueMapID;
   procedure GetDisplayNames(const aList: Il3StringsEx);
     {* ��������� ������ ���������� "UI-������" }
   function MapSize: Integer;
     {* ���������� ��������� � ����. }
   function DisplayNameToValue(const aDisplayName: Il3CString): Integer;
   function ValueToDisplayName(aValue: Integer): Il3CString;
 public
 // public methods
   class function Make: Il3IntegerValueMap; reintroduce;
     {* ��������� ����� ��� TPrintAndExportFontSizeValuesMapImplPrim }
 end;//TPrintAndExportFontSizeValuesMapImplPrim

 TPrintAndExportFontSizeValuesMapImpl = {final} class(TPrintAndExportFontSizeValuesMapImplPrim)
  {* ����� ��� ���������� ���� ��� PrintAndExportFontSizeValuesMap }
 public
 // public methods
   class function Make: Il3IntegerValueMap; reintroduce;
     {* ��������� ����� ��� TPrintAndExportFontSizeValuesMapImpl }
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TPrintAndExportFontSizeValuesMapImpl

var
  { ������������ ������ PrintAndExportFontSizeName }
 str_PrintAndExportFontSize : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize'; rValue : '������������ ��� �������� � ������ ��������� ������ ������');
  { ������������ ��� �������� � ������ ��������� ������ ������ }

implementation

uses
  l3MessageID,
  l3String,
  SysUtils,
  l3Base
  ;

// start class PrintAndExportFontSizeValuesMapHelper

class procedure PrintAndExportFontSizeValuesMapHelper.FillStrings(const aStrings: IafwStrings);
var
 l_Index: PrintAndExportFontSizeEnum;
begin
 aStrings.Clear;
 for l_Index := Low(l_Index) to High(l_Index) do
  aStrings.Add(PrintAndExportFontSizeValuesMap[l_Index].AsCStr);
end;//PrintAndExportFontSizeValuesMapHelper.FillStrings

class function PrintAndExportFontSizeValuesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): PrintAndExportFontSizeEnum;
var
 l_Index: PrintAndExportFontSizeEnum;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  if l3Same(aDisplayName, PrintAndExportFontSizeValuesMap[l_Index].AsCStr) then
  begin
   Result := l_Index;
   Exit;
  end;//l3Same..
 raise Exception.CreateFmt('Display name "%s" not found in map "PrintAndExportFontSizeValuesMap"', [l3Str(aDisplayName)]);
end;//PrintAndExportFontSizeValuesMapHelper.DisplayNameToValue
// start class TPrintAndExportFontSizeValuesMapImplPrim

class function TPrintAndExportFontSizeValuesMapImplPrim.Make: Il3IntegerValueMap;
var
 l_Inst : TPrintAndExportFontSizeValuesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TPrintAndExportFontSizeValuesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 Assert(false);
end;//TPrintAndExportFontSizeValuesMapImplPrim.pm_GetMapID

procedure TPrintAndExportFontSizeValuesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {-}
begin
 PrintAndExportFontSizeValuesMapHelper.FillStrings(aList);
end;//TPrintAndExportFontSizeValuesMapImplPrim.GetDisplayNames

function TPrintAndExportFontSizeValuesMapImplPrim.MapSize: Integer;
 {-}
begin
 Result := Ord(High(PrintAndExportFontSizeEnum)) - Ord(Low(PrintAndExportFontSizeEnum));
end;//TPrintAndExportFontSizeValuesMapImplPrim.MapSize

function TPrintAndExportFontSizeValuesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
 {-}
begin
 Result := Ord(PrintAndExportFontSizeValuesMapHelper.DisplayNameToValue(aDisplayName));
end;//TPrintAndExportFontSizeValuesMapImplPrim.DisplayNameToValue

function TPrintAndExportFontSizeValuesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
 {-}
begin
 Assert(aValue >= Ord(Low(PrintAndExportFontSizeEnum)));
 Assert(aValue <= Ord(High(PrintAndExportFontSizeEnum)));
 Result := PrintAndExportFontSizeValuesMap[PrintAndExportFontSizeEnum(aValue)].AsCStr;
end;//TPrintAndExportFontSizeValuesMapImplPrim.ValueToDisplayName
// start class TPrintAndExportFontSizeValuesMapImpl

var g_TPrintAndExportFontSizeValuesMapImpl : Pointer = nil;

procedure TPrintAndExportFontSizeValuesMapImplFree;
begin
 IUnknown(g_TPrintAndExportFontSizeValuesMapImpl) := nil;
end;


class function TPrintAndExportFontSizeValuesMapImpl.Make: Il3IntegerValueMap;
begin
 if (g_TPrintAndExportFontSizeValuesMapImpl = nil) then
 begin
  l3System.AddExitProc(TPrintAndExportFontSizeValuesMapImplFree);
  Il3IntegerValueMap(g_TPrintAndExportFontSizeValuesMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TPrintAndExportFontSizeValuesMapImpl);
end;

class function TPrintAndExportFontSizeValuesMapImpl.Exists: Boolean;
 {-}
begin
 Result := g_TPrintAndExportFontSizeValuesMapImpl <> nil;
end;//TPrintAndExportFontSizeValuesMapImpl.Exists

initialization
// ������������� str_PrintAndExportFontSize_pef8
 str_PrintAndExportFontSize_pef8.Init;
// ������������� str_PrintAndExportFontSize_pef9
 str_PrintAndExportFontSize_pef9.Init;
// ������������� str_PrintAndExportFontSize_pef10
 str_PrintAndExportFontSize_pef10.Init;
// ������������� str_PrintAndExportFontSize_pef11
 str_PrintAndExportFontSize_pef11.Init;
// ������������� str_PrintAndExportFontSize_pef12
 str_PrintAndExportFontSize_pef12.Init;
// ������������� str_PrintAndExportFontSize_pef14
 str_PrintAndExportFontSize_pef14.Init;
// ������������� str_PrintAndExportFontSize_pef16
 str_PrintAndExportFontSize_pef16.Init;
// ������������� str_PrintAndExportFontSize
 str_PrintAndExportFontSize.Init;

end.