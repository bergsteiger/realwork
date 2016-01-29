unit nsAppConfigRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Config"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Config/nsAppConfigRes.pas"
// �����: 10.03.2010 17:49
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 �������� ����������::Settings::Config::Config::nsAppConfigRes
//
// ������� ��� nsAppConfig
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

var
  { ������������ ������ WordPositionNames }
 str_nsc_wpAnyPathWord : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_wpAnyPathWord'; rValue : '� ����� ����� �����');
  { '� ����� ����� �����' }
 str_nsc_wpAtBeginWord : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_wpAtBeginWord'; rValue : '� ������ �����');
  { '� ������ �����' }
 str_nsc_wpAtBeginString : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_wpAtBeginString'; rValue : '� ������ ������');
  { '� ������ ������' }

const
  { ����� �������������� �������������� ����� WordPositionNames }
 WordPositionNamesMap : array [Tl3WordPosition] of Pl3StringIDEx = (
  @str_nsc_wpAnyPathWord
  , @str_nsc_wpAtBeginWord
  , @str_nsc_wpAtBeginString
 );//WordPositionNamesMap

type
 WordPositionNamesMapHelper = {final} class
  {* ��������� ����� ��� �������������� �������� WordPositionNamesMap }
 public
 // public methods
   class procedure FillStrings(const aStrings: IafwStrings);
     {* ���������� ������ ����� ���������� }
   class function DisplayNameToValue(const aDisplayName: Il3CString): Tl3WordPosition;
     {* �������������� ���������� �������� � ����������� }
 end;//WordPositionNamesMapHelper

 TWordPositionNamesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* ����� ��� ���������� ���� ��� WordPositionNamesMap }
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
     {* ��������� ����� ��� TWordPositionNamesMapImplPrim }
 end;//TWordPositionNamesMapImplPrim

 TWordPositionNamesMapImpl = {final} class(TWordPositionNamesMapImplPrim)
  {* ����� ��� ���������� ���� ��� WordPositionNamesMap }
 public
 // public methods
   class function Make: Il3IntegerValueMap; reintroduce;
     {* ��������� ����� ��� TWordPositionNamesMapImpl }
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TWordPositionNamesMapImpl

var
  { ������������ ������ TreeLevelDistNames }
 str_nsc_tldAllLevels : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_tldAllLevels'; rValue : '�� ���� �������');
  { '�� ���� �������' }
 str_nsc_tldOneLevel : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_tldOneLevel'; rValue : '� �������� ������ ������');
  { '� �������� ������ ������' }

const
  { ����� �������������� �������������� ����� TreeLevelDistNames }
 TreeLevelDistNamesMap : array [Tl3TreeLevelDist] of Pl3StringIDEx = (
  @str_nsc_tldAllLevels
  , @str_nsc_tldOneLevel
 );//TreeLevelDistNamesMap

type
 TreeLevelDistNamesMapHelper = {final} class
  {* ��������� ����� ��� �������������� �������� TreeLevelDistNamesMap }
 public
 // public methods
   class procedure FillStrings(const aStrings: IafwStrings);
     {* ���������� ������ ����� ���������� }
   class function DisplayNameToValue(const aDisplayName: Il3CString): Tl3TreeLevelDist;
     {* �������������� ���������� �������� � ����������� }
 end;//TreeLevelDistNamesMapHelper

 TTreeLevelDistNamesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* ����� ��� ���������� ���� ��� TreeLevelDistNamesMap }
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
     {* ��������� ����� ��� TTreeLevelDistNamesMapImplPrim }
 end;//TTreeLevelDistNamesMapImplPrim

 TTreeLevelDistNamesMapImpl = {final} class(TTreeLevelDistNamesMapImplPrim)
  {* ����� ��� ���������� ���� ��� TreeLevelDistNamesMap }
 public
 // public methods
   class function Make: Il3IntegerValueMap; reintroduce;
     {* ��������� ����� ��� TTreeLevelDistNamesMapImpl }
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TTreeLevelDistNamesMapImpl

var
  { ������������ ������ WordOrderNames }
 str_nsc_woAnyOrder : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_woAnyOrder'; rValue : '� ����� �������');
  { '� ����� �������' }
 str_nsc_woAsWrote : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_woAsWrote'; rValue : '� ������ �������');
  { '� ������ �������' }

const
  { ����� �������������� �������������� ����� WordOrderNames }
 WordOrderNamesMap : array [Tl3WordOrder] of Pl3StringIDEx = (
  @str_nsc_woAnyOrder
  , @str_nsc_woAsWrote
 );//WordOrderNamesMap

type
 WordOrderNamesMapHelper = {final} class
  {* ��������� ����� ��� �������������� �������� WordOrderNamesMap }
 public
 // public methods
   class procedure FillStrings(const aStrings: IafwStrings);
     {* ���������� ������ ����� ���������� }
   class function DisplayNameToValue(const aDisplayName: Il3CString): Tl3WordOrder;
     {* �������������� ���������� �������� � ����������� }
 end;//WordOrderNamesMapHelper

 TWordOrderNamesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* ����� ��� ���������� ���� ��� WordOrderNamesMap }
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
     {* ��������� ����� ��� TWordOrderNamesMapImplPrim }
 end;//TWordOrderNamesMapImplPrim

 TWordOrderNamesMapImpl = {final} class(TWordOrderNamesMapImplPrim)
  {* ����� ��� ���������� ���� ��� WordOrderNamesMap }
 public
 // public methods
   class function Make: Il3IntegerValueMap; reintroduce;
     {* ��������� ����� ��� TWordOrderNamesMapImpl }
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TWordOrderNamesMapImpl

var
  { ������������ ������ ContextParamsMessages }
 str_nsc_cpmTreeLevelDistHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_cpmTreeLevelDistHint'; rValue : '��������� �� ������� ����� �� ������ ������� �������������� ������ ��� � �������� ������ ������');
  { '��������� �� ������� ����� �� ������ ������� �������������� ������ ��� � �������� ������ ������' }
 str_nsc_cpmWordOrderHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_cpmWordOrderHint'; rValue : '������ �� ����� ������ ��������� ���� �� ������ ��� ���');
  { '������ �� ����� ������ ��������� ���� �� ������ ��� ���' }
 str_nsc_cpmWordPositionHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_cpmWordPositionHint'; rValue : '��������� ��������� � �����, ������');
  { '��������� ��������� � �����, ������' }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3MessageID,
  l3String,
  SysUtils,
  l3Base
  ;

// start class WordPositionNamesMapHelper

class procedure WordPositionNamesMapHelper.FillStrings(const aStrings: IafwStrings);
var
 l_Index: Tl3WordPosition;
begin
 aStrings.Clear;
 for l_Index := Low(l_Index) to High(l_Index) do
  aStrings.Add(WordPositionNamesMap[l_Index].AsCStr);
end;//WordPositionNamesMapHelper.FillStrings

class function WordPositionNamesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): Tl3WordPosition;
var
 l_Index: Tl3WordPosition;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  if l3Same(aDisplayName, WordPositionNamesMap[l_Index].AsCStr) then
  begin
   Result := l_Index;
   Exit;
  end;//l3Same..
 raise Exception.CreateFmt('Display name "%s" not found in map "WordPositionNamesMap"', [l3Str(aDisplayName)]);
end;//WordPositionNamesMapHelper.DisplayNameToValue
// start class TWordPositionNamesMapImplPrim

class function TWordPositionNamesMapImplPrim.Make: Il3IntegerValueMap;
var
 l_Inst : TWordPositionNamesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TWordPositionNamesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 Assert(false);
end;//TWordPositionNamesMapImplPrim.pm_GetMapID

procedure TWordPositionNamesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {-}
begin
 WordPositionNamesMapHelper.FillStrings(aList);
end;//TWordPositionNamesMapImplPrim.GetDisplayNames

function TWordPositionNamesMapImplPrim.MapSize: Integer;
 {-}
begin
 Result := Ord(High(Tl3WordPosition)) - Ord(Low(Tl3WordPosition));
end;//TWordPositionNamesMapImplPrim.MapSize

function TWordPositionNamesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
 {-}
begin
 Result := Ord(WordPositionNamesMapHelper.DisplayNameToValue(aDisplayName));
end;//TWordPositionNamesMapImplPrim.DisplayNameToValue

function TWordPositionNamesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
 {-}
begin
 Assert(aValue >= Ord(Low(Tl3WordPosition)));
 Assert(aValue <= Ord(High(Tl3WordPosition)));
 Result := WordPositionNamesMap[Tl3WordPosition(aValue)].AsCStr;
end;//TWordPositionNamesMapImplPrim.ValueToDisplayName
// start class TWordPositionNamesMapImpl

var g_TWordPositionNamesMapImpl : Pointer = nil;

procedure TWordPositionNamesMapImplFree;
begin
 IUnknown(g_TWordPositionNamesMapImpl) := nil;
end;


class function TWordPositionNamesMapImpl.Make: Il3IntegerValueMap;
begin
 if (g_TWordPositionNamesMapImpl = nil) then
 begin
  l3System.AddExitProc(TWordPositionNamesMapImplFree);
  Il3IntegerValueMap(g_TWordPositionNamesMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TWordPositionNamesMapImpl);
end;

class function TWordPositionNamesMapImpl.Exists: Boolean;
 {-}
begin
 Result := g_TWordPositionNamesMapImpl <> nil;
end;//TWordPositionNamesMapImpl.Exists
// start class TreeLevelDistNamesMapHelper

class procedure TreeLevelDistNamesMapHelper.FillStrings(const aStrings: IafwStrings);
var
 l_Index: Tl3TreeLevelDist;
begin
 aStrings.Clear;
 for l_Index := Low(l_Index) to High(l_Index) do
  aStrings.Add(TreeLevelDistNamesMap[l_Index].AsCStr);
end;//TreeLevelDistNamesMapHelper.FillStrings

class function TreeLevelDistNamesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): Tl3TreeLevelDist;
var
 l_Index: Tl3TreeLevelDist;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  if l3Same(aDisplayName, TreeLevelDistNamesMap[l_Index].AsCStr) then
  begin
   Result := l_Index;
   Exit;
  end;//l3Same..
 raise Exception.CreateFmt('Display name "%s" not found in map "TreeLevelDistNamesMap"', [l3Str(aDisplayName)]);
end;//TreeLevelDistNamesMapHelper.DisplayNameToValue
// start class TTreeLevelDistNamesMapImplPrim

class function TTreeLevelDistNamesMapImplPrim.Make: Il3IntegerValueMap;
var
 l_Inst : TTreeLevelDistNamesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TTreeLevelDistNamesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 Assert(false);
end;//TTreeLevelDistNamesMapImplPrim.pm_GetMapID

procedure TTreeLevelDistNamesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {-}
begin
 TreeLevelDistNamesMapHelper.FillStrings(aList);
end;//TTreeLevelDistNamesMapImplPrim.GetDisplayNames

function TTreeLevelDistNamesMapImplPrim.MapSize: Integer;
 {-}
begin
 Result := Ord(High(Tl3TreeLevelDist)) - Ord(Low(Tl3TreeLevelDist));
end;//TTreeLevelDistNamesMapImplPrim.MapSize

function TTreeLevelDistNamesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
 {-}
begin
 Result := Ord(TreeLevelDistNamesMapHelper.DisplayNameToValue(aDisplayName));
end;//TTreeLevelDistNamesMapImplPrim.DisplayNameToValue

function TTreeLevelDistNamesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
 {-}
begin
 Assert(aValue >= Ord(Low(Tl3TreeLevelDist)));
 Assert(aValue <= Ord(High(Tl3TreeLevelDist)));
 Result := TreeLevelDistNamesMap[Tl3TreeLevelDist(aValue)].AsCStr;
end;//TTreeLevelDistNamesMapImplPrim.ValueToDisplayName
// start class TTreeLevelDistNamesMapImpl

var g_TTreeLevelDistNamesMapImpl : Pointer = nil;

procedure TTreeLevelDistNamesMapImplFree;
begin
 IUnknown(g_TTreeLevelDistNamesMapImpl) := nil;
end;


class function TTreeLevelDistNamesMapImpl.Make: Il3IntegerValueMap;
begin
 if (g_TTreeLevelDistNamesMapImpl = nil) then
 begin
  l3System.AddExitProc(TTreeLevelDistNamesMapImplFree);
  Il3IntegerValueMap(g_TTreeLevelDistNamesMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TTreeLevelDistNamesMapImpl);
end;

class function TTreeLevelDistNamesMapImpl.Exists: Boolean;
 {-}
begin
 Result := g_TTreeLevelDistNamesMapImpl <> nil;
end;//TTreeLevelDistNamesMapImpl.Exists
// start class WordOrderNamesMapHelper

class procedure WordOrderNamesMapHelper.FillStrings(const aStrings: IafwStrings);
var
 l_Index: Tl3WordOrder;
begin
 aStrings.Clear;
 for l_Index := Low(l_Index) to High(l_Index) do
  aStrings.Add(WordOrderNamesMap[l_Index].AsCStr);
end;//WordOrderNamesMapHelper.FillStrings

class function WordOrderNamesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): Tl3WordOrder;
var
 l_Index: Tl3WordOrder;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  if l3Same(aDisplayName, WordOrderNamesMap[l_Index].AsCStr) then
  begin
   Result := l_Index;
   Exit;
  end;//l3Same..
 raise Exception.CreateFmt('Display name "%s" not found in map "WordOrderNamesMap"', [l3Str(aDisplayName)]);
end;//WordOrderNamesMapHelper.DisplayNameToValue
// start class TWordOrderNamesMapImplPrim

class function TWordOrderNamesMapImplPrim.Make: Il3IntegerValueMap;
var
 l_Inst : TWordOrderNamesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TWordOrderNamesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 Assert(false);
end;//TWordOrderNamesMapImplPrim.pm_GetMapID

procedure TWordOrderNamesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {-}
begin
 WordOrderNamesMapHelper.FillStrings(aList);
end;//TWordOrderNamesMapImplPrim.GetDisplayNames

function TWordOrderNamesMapImplPrim.MapSize: Integer;
 {-}
begin
 Result := Ord(High(Tl3WordOrder)) - Ord(Low(Tl3WordOrder));
end;//TWordOrderNamesMapImplPrim.MapSize

function TWordOrderNamesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
 {-}
begin
 Result := Ord(WordOrderNamesMapHelper.DisplayNameToValue(aDisplayName));
end;//TWordOrderNamesMapImplPrim.DisplayNameToValue

function TWordOrderNamesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
 {-}
begin
 Assert(aValue >= Ord(Low(Tl3WordOrder)));
 Assert(aValue <= Ord(High(Tl3WordOrder)));
 Result := WordOrderNamesMap[Tl3WordOrder(aValue)].AsCStr;
end;//TWordOrderNamesMapImplPrim.ValueToDisplayName
// start class TWordOrderNamesMapImpl

var g_TWordOrderNamesMapImpl : Pointer = nil;

procedure TWordOrderNamesMapImplFree;
begin
 IUnknown(g_TWordOrderNamesMapImpl) := nil;
end;


class function TWordOrderNamesMapImpl.Make: Il3IntegerValueMap;
begin
 if (g_TWordOrderNamesMapImpl = nil) then
 begin
  l3System.AddExitProc(TWordOrderNamesMapImplFree);
  Il3IntegerValueMap(g_TWordOrderNamesMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TWordOrderNamesMapImpl);
end;

class function TWordOrderNamesMapImpl.Exists: Boolean;
 {-}
begin
 Result := g_TWordOrderNamesMapImpl <> nil;
end;//TWordOrderNamesMapImpl.Exists
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_nsc_wpAnyPathWord
 str_nsc_wpAnyPathWord.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_nsc_wpAtBeginWord
 str_nsc_wpAtBeginWord.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_nsc_wpAtBeginString
 str_nsc_wpAtBeginString.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_nsc_tldAllLevels
 str_nsc_tldAllLevels.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_nsc_tldOneLevel
 str_nsc_tldOneLevel.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_nsc_woAnyOrder
 str_nsc_woAnyOrder.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_nsc_woAsWrote
 str_nsc_woAsWrote.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_nsc_cpmTreeLevelDistHint
 str_nsc_cpmTreeLevelDistHint.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_nsc_cpmWordOrderHint
 str_nsc_cpmWordOrderHint.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_nsc_cpmWordPositionHint
 str_nsc_cpmWordPositionHint.Init;
{$IfEnd} //not Admin AND not Monitorings

end.