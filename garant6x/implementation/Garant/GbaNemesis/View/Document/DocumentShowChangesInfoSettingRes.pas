unit DocumentShowChangesInfoSettingRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/DocumentShowChangesInfoSettingRes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Document::DocumentShowChangesInfoSettingRes
//
// ������� ��� ��������� "���������� ������� ��������� � ���������"
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces,
  afwInterfaces,
  l3CProtoObject,
  l3StringIDEx
  ;

const
  { ShowChangesInfoKey }
 pi_Document_ShowChangesInfo = '������ � ����������/���������� ������� ��������� � ���������';
  { ������������� ��������� "���������� ������� ��������� � ���������" }
 dv_Document_ShowChangesInfo = false;
  { �������� ��-��������� ��������� "���������� ������� ��������� � ���������" }

var
  { ������������ ������ ShowChangesInfoValues }
 str_ShowChangesInfo_Collapsed : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ShowChangesInfo_Collapsed'; rValue : '� ��������� ����');
  { � ��������� ���� }
 str_ShowChangesInfo_Expanded : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ShowChangesInfo_Expanded'; rValue : '� ����������� ����');
  { � ����������� ���� }

const
  { ����� �������������� �������������� ����� ShowChangesInfoValues }
 ShowChangesInfoValuesMap : array [Boolean] of Pl3StringIDEx = (
  @str_ShowChangesInfo_Collapsed
  , @str_ShowChangesInfo_Expanded
 );//ShowChangesInfoValuesMap

type
 ShowChangesInfoValuesMapHelper = {final} class
  {* ��������� ����� ��� �������������� �������� ShowChangesInfoValuesMap }
 public
 // public methods
   class procedure FillStrings(const aStrings: IafwStrings);
     {* ���������� ������ ����� ���������� }
   class function DisplayNameToValue(const aDisplayName: Il3CString): Boolean;
     {* �������������� ���������� �������� � ����������� }
 end;//ShowChangesInfoValuesMapHelper

 TShowChangesInfoValuesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* ����� ��� ���������� ���� ��� ShowChangesInfoValuesMap }
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
     {* ��������� ����� ��� TShowChangesInfoValuesMapImplPrim }
 end;//TShowChangesInfoValuesMapImplPrim

 TShowChangesInfoValuesMapImpl = {final} class(TShowChangesInfoValuesMapImplPrim)
  {* ����� ��� ���������� ���� ��� ShowChangesInfoValuesMap }
 public
 // public methods
   class function Make: Il3IntegerValueMap; reintroduce;
     {* ��������� ����� ��� TShowChangesInfoValuesMapImpl }
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TShowChangesInfoValuesMapImpl

var
  { ������������ ������ ShowChangesInfoName }
 str_ShowChangesInfo : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ShowChangesInfo'; rValue : '���������� ������� ��������� � ���������');
  { ���������� ������� ��������� � ��������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3MessageID,
  l3String,
  SysUtils,
  l3Base
  ;

// start class ShowChangesInfoValuesMapHelper

class procedure ShowChangesInfoValuesMapHelper.FillStrings(const aStrings: IafwStrings);
var
 l_Index: Boolean;
begin
 aStrings.Clear;
 for l_Index := Low(l_Index) to High(l_Index) do
  aStrings.Add(ShowChangesInfoValuesMap[l_Index].AsCStr);
end;//ShowChangesInfoValuesMapHelper.FillStrings

class function ShowChangesInfoValuesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): Boolean;
var
 l_Index: Boolean;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  if l3Same(aDisplayName, ShowChangesInfoValuesMap[l_Index].AsCStr) then
  begin
   Result := l_Index;
   Exit;
  end;//l3Same..
 raise Exception.CreateFmt('Display name "%s" not found in map "ShowChangesInfoValuesMap"', [l3Str(aDisplayName)]);
end;//ShowChangesInfoValuesMapHelper.DisplayNameToValue
// start class TShowChangesInfoValuesMapImplPrim

class function TShowChangesInfoValuesMapImplPrim.Make: Il3IntegerValueMap;
var
 l_Inst : TShowChangesInfoValuesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TShowChangesInfoValuesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 Assert(false);
end;//TShowChangesInfoValuesMapImplPrim.pm_GetMapID

procedure TShowChangesInfoValuesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {-}
begin
 ShowChangesInfoValuesMapHelper.FillStrings(aList);
end;//TShowChangesInfoValuesMapImplPrim.GetDisplayNames

function TShowChangesInfoValuesMapImplPrim.MapSize: Integer;
 {-}
begin
 Result := Ord(High(Boolean)) - Ord(Low(Boolean));
end;//TShowChangesInfoValuesMapImplPrim.MapSize

function TShowChangesInfoValuesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
 {-}
begin
 Result := Ord(ShowChangesInfoValuesMapHelper.DisplayNameToValue(aDisplayName));
end;//TShowChangesInfoValuesMapImplPrim.DisplayNameToValue

function TShowChangesInfoValuesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
 {-}
begin
 Assert(aValue >= Ord(Low(Boolean)));
 Assert(aValue <= Ord(High(Boolean)));
 Result := ShowChangesInfoValuesMap[Boolean(aValue)].AsCStr;
end;//TShowChangesInfoValuesMapImplPrim.ValueToDisplayName
// start class TShowChangesInfoValuesMapImpl

var g_TShowChangesInfoValuesMapImpl : Pointer = nil;

procedure TShowChangesInfoValuesMapImplFree;
begin
 IUnknown(g_TShowChangesInfoValuesMapImpl) := nil;
end;


class function TShowChangesInfoValuesMapImpl.Make: Il3IntegerValueMap;
begin
 if (g_TShowChangesInfoValuesMapImpl = nil) then
 begin
  l3System.AddExitProc(TShowChangesInfoValuesMapImplFree);
  Il3IntegerValueMap(g_TShowChangesInfoValuesMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TShowChangesInfoValuesMapImpl);
end;

class function TShowChangesInfoValuesMapImpl.Exists: Boolean;
 {-}
begin
 Result := g_TShowChangesInfoValuesMapImpl <> nil;
end;//TShowChangesInfoValuesMapImpl.Exists
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_ShowChangesInfo_Collapsed
 str_ShowChangesInfo_Collapsed.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_ShowChangesInfo_Expanded
 str_ShowChangesInfo_Expanded.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_ShowChangesInfo
 str_ShowChangesInfo.Init;
{$IfEnd} //not Admin AND not Monitorings

end.