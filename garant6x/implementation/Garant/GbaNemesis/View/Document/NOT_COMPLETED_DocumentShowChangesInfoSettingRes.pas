unit NOT_COMPLETED_DocumentShowChangesInfoSettingRes;
 {* ������� ��� ��������� "���������� ������� ��������� � ���������" }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\NOT_COMPLETED_DocumentShowChangesInfoSettingRes.pas"
// ���������: "UtilityPack"
// ������� ������: "DocumentShowChangesInfoSettingRes" MUID: (9847AD90023A)

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
 pi_Document_ShowChangesInfo = '������ � ����������/���������� ������� ��������� � ���������';
  {* ������������� ��������� "���������� ������� ��������� � ���������" }
 dv_Document_ShowChangesInfo = False;
  {* �������� ��-��������� ��������� "���������� ������� ��������� � ���������" }
 {* ������������ ������ ShowChangesInfoValues }
 str_ShowChangesInfo_Collapsed: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ShowChangesInfo_Collapsed'; rValue : '� ��������� ����');
  {* � ��������� ���� }
 str_ShowChangesInfo_Expanded: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ShowChangesInfo_Expanded'; rValue : '� ����������� ����');
  {* � ����������� ���� }
 {* ����� �������������� �������������� ����� ShowChangesInfoValues }
 ShowChangesInfoValuesMap: array [Boolean] of Pl3StringIDEx = (
 @str_ShowChangesInfo_Collapsed
 , @str_ShowChangesInfo_Expanded
 );
 {* ������������ ������ ShowChangesInfoName }
 str_ShowChangesInfo: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ShowChangesInfo'; rValue : '���������� ������� ��������� � ���������');
  {* ���������� ������� ��������� � ��������� }

type
 ShowChangesInfoValuesMapHelper = {final} class
  {* ��������� ����� ��� �������������� �������� ShowChangesInfoValuesMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* ���������� ������ ����� ���������� }
   class function DisplayNameToValue(const aDisplayName: Il3CString): Boolean;
    {* �������������� ���������� �������� � ����������� }
 end;//ShowChangesInfoValuesMapHelper

 TShowChangesInfoValuesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* ����� ��� ���������� ���� ��� ShowChangesInfoValuesMap }
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
    {* ��������� ����� ��� TShowChangesInfoValuesMapImplPrim }
 end;//TShowChangesInfoValuesMapImplPrim

 TShowChangesInfoValuesMapImpl = {final} class(TShowChangesInfoValuesMapImplPrim)
  {* ����� ��� ���������� ���� ��� ShowChangesInfoValuesMap }
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* ��������� ����� ��� TShowChangesInfoValuesMapImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TShowChangesInfoValuesMapImpl
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

var g_TShowChangesInfoValuesMapImpl: Pointer = nil;
 {* ��������� ���������� TShowChangesInfoValuesMapImpl }

procedure TShowChangesInfoValuesMapImplFree;
 {* ����� ������������ ���������� ���������� TShowChangesInfoValuesMapImpl }
begin
 IUnknown(g_TShowChangesInfoValuesMapImpl) := nil;
end;//TShowChangesInfoValuesMapImplFree

class procedure ShowChangesInfoValuesMapHelper.FillStrings(const aStrings: IafwStrings);
 {* ���������� ������ ����� ���������� }
//#UC START# *7EF6DC45032F_A1FC37E65315_var*
//#UC END# *7EF6DC45032F_A1FC37E65315_var*
begin
//#UC START# *7EF6DC45032F_A1FC37E65315_impl*
 !!! Needs to be implemented !!!
//#UC END# *7EF6DC45032F_A1FC37E65315_impl*
end;//ShowChangesInfoValuesMapHelper.FillStrings

class function ShowChangesInfoValuesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): Boolean;
 {* �������������� ���������� �������� � ����������� }
//#UC START# *68BC0BDD3BB9_A1FC37E65315_var*
//#UC END# *68BC0BDD3BB9_A1FC37E65315_var*
begin
//#UC START# *68BC0BDD3BB9_A1FC37E65315_impl*
 !!! Needs to be implemented !!!
//#UC END# *68BC0BDD3BB9_A1FC37E65315_impl*
end;//ShowChangesInfoValuesMapHelper.DisplayNameToValue

class function TShowChangesInfoValuesMapImplPrim.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TShowChangesInfoValuesMapImplPrim }
var
 l_Inst : TShowChangesInfoValuesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TShowChangesInfoValuesMapImplPrim.Make

function TShowChangesInfoValuesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
//#UC START# *46A5EFE602DE_CC1C6C840383get_var*
//#UC END# *46A5EFE602DE_CC1C6C840383get_var*
begin
//#UC START# *46A5EFE602DE_CC1C6C840383get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5EFE602DE_CC1C6C840383get_impl*
end;//TShowChangesInfoValuesMapImplPrim.pm_GetMapID

procedure TShowChangesInfoValuesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* ��������� ������ ���������� "UI-������" }
//#UC START# *46A5F0130365_CC1C6C840383_var*
//#UC END# *46A5F0130365_CC1C6C840383_var*
begin
//#UC START# *46A5F0130365_CC1C6C840383_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F0130365_CC1C6C840383_impl*
end;//TShowChangesInfoValuesMapImplPrim.GetDisplayNames

function TShowChangesInfoValuesMapImplPrim.MapSize: Integer;
 {* ���������� ��������� � ����. }
//#UC START# *46A5F03800A2_CC1C6C840383_var*
//#UC END# *46A5F03800A2_CC1C6C840383_var*
begin
//#UC START# *46A5F03800A2_CC1C6C840383_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F03800A2_CC1C6C840383_impl*
end;//TShowChangesInfoValuesMapImplPrim.MapSize

function TShowChangesInfoValuesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
//#UC START# *46A5FCF900E0_CC1C6C840383_var*
//#UC END# *46A5FCF900E0_CC1C6C840383_var*
begin
//#UC START# *46A5FCF900E0_CC1C6C840383_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FCF900E0_CC1C6C840383_impl*
end;//TShowChangesInfoValuesMapImplPrim.DisplayNameToValue

function TShowChangesInfoValuesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
//#UC START# *46A5FD1B000D_CC1C6C840383_var*
//#UC END# *46A5FD1B000D_CC1C6C840383_var*
begin
//#UC START# *46A5FD1B000D_CC1C6C840383_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FD1B000D_CC1C6C840383_impl*
end;//TShowChangesInfoValuesMapImplPrim.ValueToDisplayName

class function TShowChangesInfoValuesMapImpl.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TShowChangesInfoValuesMapImpl }
begin
 if (g_TShowChangesInfoValuesMapImpl = nil) then
 begin
  l3System.AddExitProc(TShowChangesInfoValuesMapImplFree);
  Il3IntegerValueMap(g_TShowChangesInfoValuesMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TShowChangesInfoValuesMapImpl);
end;//TShowChangesInfoValuesMapImpl.Make

class function TShowChangesInfoValuesMapImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TShowChangesInfoValuesMapImpl <> nil;
end;//TShowChangesInfoValuesMapImpl.Exists

initialization
 str_ShowChangesInfo_Collapsed.Init;
 {* ������������� str_ShowChangesInfo_Collapsed }
 str_ShowChangesInfo_Expanded.Init;
 {* ������������� str_ShowChangesInfo_Expanded }
 str_ShowChangesInfo.Init;
 {* ������������� str_ShowChangesInfo }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
