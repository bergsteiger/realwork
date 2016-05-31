unit NOT_COMPLETED_MainMenuChangeableMainMenuTypeSettingRes;
 {* ������� ��� ��������� "��� ���������� ����� ��������� ����" }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\NOT_COMPLETED_MainMenuChangeableMainMenuTypeSettingRes.pas"
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
//#UC START# *C12B875224F2_B9C724B3AF5F_var*
//#UC END# *C12B875224F2_B9C724B3AF5F_var*
begin
//#UC START# *C12B875224F2_B9C724B3AF5F_impl*
 !!! Needs to be implemented !!!
//#UC END# *C12B875224F2_B9C724B3AF5F_impl*
end;//ChangeableMainMenuTypeValuesMapHelper.FillStrings

class function ChangeableMainMenuTypeValuesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): ChangeableMainMenuTypeEnum;
 {* �������������� ���������� �������� � ����������� }
//#UC START# *7A134379805A_B9C724B3AF5F_var*
//#UC END# *7A134379805A_B9C724B3AF5F_var*
begin
//#UC START# *7A134379805A_B9C724B3AF5F_impl*
 !!! Needs to be implemented !!!
//#UC END# *7A134379805A_B9C724B3AF5F_impl*
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
//#UC START# *46A5EFE602DE_318BDF027E3Aget_var*
//#UC END# *46A5EFE602DE_318BDF027E3Aget_var*
begin
//#UC START# *46A5EFE602DE_318BDF027E3Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5EFE602DE_318BDF027E3Aget_impl*
end;//TChangeableMainMenuTypeValuesMapImplPrim.pm_GetMapID

procedure TChangeableMainMenuTypeValuesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* ��������� ������ ���������� "UI-������" }
//#UC START# *46A5F0130365_318BDF027E3A_var*
//#UC END# *46A5F0130365_318BDF027E3A_var*
begin
//#UC START# *46A5F0130365_318BDF027E3A_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F0130365_318BDF027E3A_impl*
end;//TChangeableMainMenuTypeValuesMapImplPrim.GetDisplayNames

function TChangeableMainMenuTypeValuesMapImplPrim.MapSize: Integer;
 {* ���������� ��������� � ����. }
//#UC START# *46A5F03800A2_318BDF027E3A_var*
//#UC END# *46A5F03800A2_318BDF027E3A_var*
begin
//#UC START# *46A5F03800A2_318BDF027E3A_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F03800A2_318BDF027E3A_impl*
end;//TChangeableMainMenuTypeValuesMapImplPrim.MapSize

function TChangeableMainMenuTypeValuesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
//#UC START# *46A5FCF900E0_318BDF027E3A_var*
//#UC END# *46A5FCF900E0_318BDF027E3A_var*
begin
//#UC START# *46A5FCF900E0_318BDF027E3A_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FCF900E0_318BDF027E3A_impl*
end;//TChangeableMainMenuTypeValuesMapImplPrim.DisplayNameToValue

function TChangeableMainMenuTypeValuesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
//#UC START# *46A5FD1B000D_318BDF027E3A_var*
//#UC END# *46A5FD1B000D_318BDF027E3A_var*
begin
//#UC START# *46A5FD1B000D_318BDF027E3A_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FD1B000D_318BDF027E3A_impl*
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
