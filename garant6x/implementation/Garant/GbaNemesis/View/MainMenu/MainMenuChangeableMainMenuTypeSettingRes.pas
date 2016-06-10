unit MainMenuChangeableMainMenuTypeSettingRes;
 {* ������� ��� ��������� "��� ���������� ����� ��������� ����" }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\MainMenuChangeableMainMenuTypeSettingRes.pas"
// ���������: "UtilityPack"
// ������� ������: "MainMenuChangeableMainMenuTypeSettingRes" MUID: (4135B54EF3A1)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
 , afwInterfaces
 , l3Interfaces
 , l3CProtoObject
;

const
 {* ������������ ������ ChangeableMainMenuTypeName }
 str_ChangeableMainMenuType: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType'; rValue : '��� ���������� ����� ��������� ����');
  {* ��� ���������� ����� ��������� ���� }
 pi_MainMenu_ChangeableMainMenuType = '/��� ���������� ����� ��������� ����';
  {* ������������� ��������� "��� ���������� ����� ��������� ����" }
 dv_MainMenu_ChangeableMainMenuType = 0;
  {* �������� ��-��������� ��������� "��� ���������� ����� ��������� ����" }
 {* ������������ ������ ChangeableMainMenuTypeValues }
 str_ChangeableMainMenuType_ST_FINANCE: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType_ST_FINANCE'; rValue : '������ � �������');
  {* ������ � ������� }
 str_ChangeableMainMenuType_ST_HR: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType_ST_HR'; rValue : '������ ��� ����������');
  {* ������ ��� ���������� }
 str_ChangeableMainMenuType_ST_LEGAL: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType_ST_LEGAL'; rValue : '������ ��� �������');
  {* ������ ��� ������� }
 str_ChangeableMainMenuType_ST_BUDGET_ORGS: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType_ST_BUDGET_ORGS'; rValue : '��������� �����������');
  {* ��������� ����������� }

type
 ChangeableMainMenuTypeEnum = (
  {* ����� ��� ��������� "��� ���������� ����� ��������� ����" }
  KEY_ChangeableMainMenuType_ST_FINANCE
   {* ������ � ������� }
  , KEY_ChangeableMainMenuType_ST_HR
   {* ������ ��� ���������� }
  , KEY_ChangeableMainMenuType_ST_LEGAL
   {* ������ ��� ������� }
  , KEY_ChangeableMainMenuType_ST_BUDGET_ORGS
   {* ��������� ����������� }
 );//ChangeableMainMenuTypeEnum

 ChangeableMainMenuTypeValuesMapHelper = {final} class
  {* ��������� ����� ��� �������������� �������� ChangeableMainMenuTypeValuesMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* ���������� ������ ����� ���������� }
   class function DisplayNameToValue(const aDisplayName: Il3CString): ChangeableMainMenuTypeEnum;
    {* �������������� ���������� �������� � ����������� }
 end;//ChangeableMainMenuTypeValuesMapHelper

 TChangeableMainMenuTypeValuesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* ����� ��� ���������� ���� ��� ChangeableMainMenuTypeValuesMap }
  protected
   function pm_GetMapID: Tl3ValueMapID;
   procedure GetDisplayNames(const aList: Il3StringsEx);
    {* ��������� ������ ���������� "UI-������" }
   function MapSize: Integer;
    {* ���������� ��������� � ����. }
   function DisplayNameToValue(const aDisplayName: Il3CString): Integer;
   function ValueToDisplayName(aValue: Integer): Il3CString;
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* ��������� ����� ��� TChangeableMainMenuTypeValuesMapImplPrim }
 end;//TChangeableMainMenuTypeValuesMapImplPrim

 TChangeableMainMenuTypeValuesMapImpl = {final} class(TChangeableMainMenuTypeValuesMapImplPrim)
  {* ����� ��� ���������� ���� ��� ChangeableMainMenuTypeValuesMap }
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* ��������� ����� ��� TChangeableMainMenuTypeValuesMapImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TChangeableMainMenuTypeValuesMapImpl

const
 {* ����� �������������� �������������� ����� ChangeableMainMenuTypeValues }
 ChangeableMainMenuTypeValuesMap: array [ChangeableMainMenuTypeEnum] of Pl3StringIDEx = (
 @str_ChangeableMainMenuType_ST_FINANCE
 , @str_ChangeableMainMenuType_ST_HR
 , @str_ChangeableMainMenuType_ST_LEGAL
 , @str_ChangeableMainMenuType_ST_BUDGET_ORGS
 );
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3MessageID
 , l3String
 , SysUtils
 , l3Base
;

var g_TChangeableMainMenuTypeValuesMapImpl: Pointer = nil;
 {* ��������� ���������� TChangeableMainMenuTypeValuesMapImpl }

procedure TChangeableMainMenuTypeValuesMapImplFree;
 {* ����� ������������ ���������� ���������� TChangeableMainMenuTypeValuesMapImpl }
begin
 IUnknown(g_TChangeableMainMenuTypeValuesMapImpl) := nil;
end;//TChangeableMainMenuTypeValuesMapImplFree

class procedure ChangeableMainMenuTypeValuesMapHelper.FillStrings(const aStrings: IafwStrings);
 {* ���������� ������ ����� ���������� }
var
 l_Index: ChangeableMainMenuTypeEnum;
begin
 aStrings.Clear;
 for l_Index := Low(l_Index) to High(l_Index) do
  aStrings.Add(ChangeableMainMenuTypeValuesMap[l_Index].AsCStr);
end;//ChangeableMainMenuTypeValuesMapHelper.FillStrings

class function ChangeableMainMenuTypeValuesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): ChangeableMainMenuTypeEnum;
 {* �������������� ���������� �������� � ����������� }
var
 l_Index: ChangeableMainMenuTypeEnum;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  if l3Same(aDisplayName, ChangeableMainMenuTypeValuesMap[l_Index].AsCStr) then
  begin
   Result := l_Index;
   Exit;
  end;//l3Same..
 raise Exception.CreateFmt('Display name "%s" not found in map "ChangeableMainMenuTypeValuesMap"', [l3Str(aDisplayName)]);
end;//ChangeableMainMenuTypeValuesMapHelper.DisplayNameToValue

class function TChangeableMainMenuTypeValuesMapImplPrim.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TChangeableMainMenuTypeValuesMapImplPrim }
var
 l_Inst : TChangeableMainMenuTypeValuesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TChangeableMainMenuTypeValuesMapImplPrim.Make

function TChangeableMainMenuTypeValuesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
begin
 l3FillChar(Result, SizeOf(Result));
 Assert(false);
end;//TChangeableMainMenuTypeValuesMapImplPrim.pm_GetMapID

procedure TChangeableMainMenuTypeValuesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* ��������� ������ ���������� "UI-������" }
begin
 ChangeableMainMenuTypeValuesMapHelper.FillStrings(aList);
end;//TChangeableMainMenuTypeValuesMapImplPrim.GetDisplayNames

function TChangeableMainMenuTypeValuesMapImplPrim.MapSize: Integer;
 {* ���������� ��������� � ����. }
begin
 Result := Ord(High(ChangeableMainMenuTypeEnum)) - Ord(Low(ChangeableMainMenuTypeEnum));
end;//TChangeableMainMenuTypeValuesMapImplPrim.MapSize

function TChangeableMainMenuTypeValuesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
begin
 Result := Ord(ChangeableMainMenuTypeValuesMapHelper.DisplayNameToValue(aDisplayName));
end;//TChangeableMainMenuTypeValuesMapImplPrim.DisplayNameToValue

function TChangeableMainMenuTypeValuesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
begin
 Assert(aValue >= Ord(Low(ChangeableMainMenuTypeEnum)));
 Assert(aValue <= Ord(High(ChangeableMainMenuTypeEnum)));
 Result := ChangeableMainMenuTypeValuesMap[ChangeableMainMenuTypeEnum(aValue)].AsCStr;
end;//TChangeableMainMenuTypeValuesMapImplPrim.ValueToDisplayName

class function TChangeableMainMenuTypeValuesMapImpl.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TChangeableMainMenuTypeValuesMapImpl }
begin
 if (g_TChangeableMainMenuTypeValuesMapImpl = nil) then
 begin
  l3System.AddExitProc(TChangeableMainMenuTypeValuesMapImplFree);
  Il3IntegerValueMap(g_TChangeableMainMenuTypeValuesMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TChangeableMainMenuTypeValuesMapImpl);
end;//TChangeableMainMenuTypeValuesMapImpl.Make

class function TChangeableMainMenuTypeValuesMapImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TChangeableMainMenuTypeValuesMapImpl <> nil;
end;//TChangeableMainMenuTypeValuesMapImpl.Exists

initialization
 str_ChangeableMainMenuType.Init;
 {* ������������� str_ChangeableMainMenuType }
 str_ChangeableMainMenuType_ST_FINANCE.Init;
 {* ������������� str_ChangeableMainMenuType_ST_FINANCE }
 str_ChangeableMainMenuType_ST_HR.Init;
 {* ������������� str_ChangeableMainMenuType_ST_HR }
 str_ChangeableMainMenuType_ST_LEGAL.Init;
 {* ������������� str_ChangeableMainMenuType_ST_LEGAL }
 str_ChangeableMainMenuType_ST_BUDGET_ORGS.Init;
 {* ������������� str_ChangeableMainMenuType_ST_BUDGET_ORGS }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
