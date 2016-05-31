unit NOT_COMPLETED_nsAppConfigRes;
 {* ������� ��� nsAppConfig }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Config\NOT_COMPLETED_nsAppConfigRes.pas"
// ���������: "UtilityPack"
// ������� ������: "nsAppConfigRes" MUID: (4B97B148028B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3Interfaces
 , l3StringIDEx
 , afwInterfaces
 , l3CProtoObject
;

const
 {* ������������ ������ ContextParamsMessages }
 str_nsc_cpmTreeLevelDistHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_cpmTreeLevelDistHint'; rValue : '��������� �� ������� ����� �� ������ ������� �������������� ������ ��� � �������� ������ ������');
  {* '��������� �� ������� ����� �� ������ ������� �������������� ������ ��� � �������� ������ ������' }
 str_nsc_cpmWordOrderHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_cpmWordOrderHint'; rValue : '������ �� ����� ������ ��������� ���� �� ������ ��� ���');
  {* '������ �� ����� ������ ��������� ���� �� ������ ��� ���' }
 str_nsc_cpmWordPositionHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_cpmWordPositionHint'; rValue : '��������� ��������� � �����, ������');
  {* '��������� ��������� � �����, ������' }
 {* ������������ ������ WordPositionNames }
 str_nsc_wpAnyPathWord: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_wpAnyPathWord'; rValue : '� ����� ����� �����');
  {* '� ����� ����� �����' }
 str_nsc_wpAtBeginWord: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_wpAtBeginWord'; rValue : '� ������ �����');
  {* '� ������ �����' }
 str_nsc_wpAtBeginString: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_wpAtBeginString'; rValue : '� ������ ������');
  {* '� ������ ������' }
 {* ����� �������������� �������������� ����� WordPositionNames }
 WordPositionNamesMap: array [Tl3WordPosition] of Pl3StringIDEx = (
 @str_nsc_wpAnyPathWord
 , @str_nsc_wpAtBeginWord
 , @str_nsc_wpAtBeginString
 );
 {* ������������ ������ TreeLevelDistNames }
 str_nsc_tldAllLevels: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_tldAllLevels'; rValue : '�� ���� �������');
  {* '�� ���� �������' }
 str_nsc_tldOneLevel: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_tldOneLevel'; rValue : '� �������� ������ ������');
  {* '� �������� ������ ������' }
 {* ����� �������������� �������������� ����� TreeLevelDistNames }
 TreeLevelDistNamesMap: array [Tl3TreeLevelDist] of Pl3StringIDEx = (
 @str_nsc_tldAllLevels
 , @str_nsc_tldOneLevel
 );
 {* ������������ ������ WordOrderNames }
 str_nsc_woAnyOrder: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_woAnyOrder'; rValue : '� ����� �������');
  {* '� ����� �������' }
 str_nsc_woAsWrote: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_woAsWrote'; rValue : '� ������ �������');
  {* '� ������ �������' }
 {* ����� �������������� �������������� ����� WordOrderNames }
 WordOrderNamesMap: array [Tl3WordOrder] of Pl3StringIDEx = (
 @str_nsc_woAnyOrder
 , @str_nsc_woAsWrote
 );

type
 WordPositionNamesMapHelper = {final} class
  {* ��������� ����� ��� �������������� �������� WordPositionNamesMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* ���������� ������ ����� ���������� }
   class function DisplayNameToValue(const aDisplayName: Il3CString): Tl3WordPosition;
    {* �������������� ���������� �������� � ����������� }
 end;//WordPositionNamesMapHelper

 TWordPositionNamesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* ����� ��� ���������� ���� ��� WordPositionNamesMap }
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
    {* ��������� ����� ��� TWordPositionNamesMapImplPrim }
 end;//TWordPositionNamesMapImplPrim

 TWordPositionNamesMapImpl = {final} class(TWordPositionNamesMapImplPrim)
  {* ����� ��� ���������� ���� ��� WordPositionNamesMap }
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* ��������� ����� ��� TWordPositionNamesMapImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TWordPositionNamesMapImpl

 TreeLevelDistNamesMapHelper = {final} class
  {* ��������� ����� ��� �������������� �������� TreeLevelDistNamesMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* ���������� ������ ����� ���������� }
   class function DisplayNameToValue(const aDisplayName: Il3CString): Tl3TreeLevelDist;
    {* �������������� ���������� �������� � ����������� }
 end;//TreeLevelDistNamesMapHelper

 TTreeLevelDistNamesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* ����� ��� ���������� ���� ��� TreeLevelDistNamesMap }
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
    {* ��������� ����� ��� TTreeLevelDistNamesMapImplPrim }
 end;//TTreeLevelDistNamesMapImplPrim

 TTreeLevelDistNamesMapImpl = {final} class(TTreeLevelDistNamesMapImplPrim)
  {* ����� ��� ���������� ���� ��� TreeLevelDistNamesMap }
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* ��������� ����� ��� TTreeLevelDistNamesMapImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TTreeLevelDistNamesMapImpl

 WordOrderNamesMapHelper = {final} class
  {* ��������� ����� ��� �������������� �������� WordOrderNamesMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* ���������� ������ ����� ���������� }
   class function DisplayNameToValue(const aDisplayName: Il3CString): Tl3WordOrder;
    {* �������������� ���������� �������� � ����������� }
 end;//WordOrderNamesMapHelper

 TWordOrderNamesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* ����� ��� ���������� ���� ��� WordOrderNamesMap }
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
    {* ��������� ����� ��� TWordOrderNamesMapImplPrim }
 end;//TWordOrderNamesMapImplPrim

 TWordOrderNamesMapImpl = {final} class(TWordOrderNamesMapImplPrim)
  {* ����� ��� ���������� ���� ��� WordOrderNamesMap }
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* ��������� ����� ��� TWordOrderNamesMapImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TWordOrderNamesMapImpl
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

var g_TWordPositionNamesMapImpl: Pointer = nil;
 {* ��������� ���������� TWordPositionNamesMapImpl }
var g_TTreeLevelDistNamesMapImpl: Pointer = nil;
 {* ��������� ���������� TTreeLevelDistNamesMapImpl }
var g_TWordOrderNamesMapImpl: Pointer = nil;
 {* ��������� ���������� TWordOrderNamesMapImpl }

procedure TWordPositionNamesMapImplFree;
 {* ����� ������������ ���������� ���������� TWordPositionNamesMapImpl }
begin
 IUnknown(g_TWordPositionNamesMapImpl) := nil;
end;//TWordPositionNamesMapImplFree

procedure TTreeLevelDistNamesMapImplFree;
 {* ����� ������������ ���������� ���������� TTreeLevelDistNamesMapImpl }
begin
 IUnknown(g_TTreeLevelDistNamesMapImpl) := nil;
end;//TTreeLevelDistNamesMapImplFree

procedure TWordOrderNamesMapImplFree;
 {* ����� ������������ ���������� ���������� TWordOrderNamesMapImpl }
begin
 IUnknown(g_TWordOrderNamesMapImpl) := nil;
end;//TWordOrderNamesMapImplFree

class procedure WordPositionNamesMapHelper.FillStrings(const aStrings: IafwStrings);
 {* ���������� ������ ����� ���������� }
//#UC START# *C2DB53EB6783_54A4B8A0B9D2_var*
//#UC END# *C2DB53EB6783_54A4B8A0B9D2_var*
begin
//#UC START# *C2DB53EB6783_54A4B8A0B9D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *C2DB53EB6783_54A4B8A0B9D2_impl*
end;//WordPositionNamesMapHelper.FillStrings

class function WordPositionNamesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): Tl3WordPosition;
 {* �������������� ���������� �������� � ����������� }
//#UC START# *AF278AD4DE32_54A4B8A0B9D2_var*
//#UC END# *AF278AD4DE32_54A4B8A0B9D2_var*
begin
//#UC START# *AF278AD4DE32_54A4B8A0B9D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *AF278AD4DE32_54A4B8A0B9D2_impl*
end;//WordPositionNamesMapHelper.DisplayNameToValue

class function TWordPositionNamesMapImplPrim.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TWordPositionNamesMapImplPrim }
var
 l_Inst : TWordPositionNamesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TWordPositionNamesMapImplPrim.Make

function TWordPositionNamesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
//#UC START# *46A5EFE602DE_0D20FE889A83get_var*
//#UC END# *46A5EFE602DE_0D20FE889A83get_var*
begin
//#UC START# *46A5EFE602DE_0D20FE889A83get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5EFE602DE_0D20FE889A83get_impl*
end;//TWordPositionNamesMapImplPrim.pm_GetMapID

procedure TWordPositionNamesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* ��������� ������ ���������� "UI-������" }
//#UC START# *46A5F0130365_0D20FE889A83_var*
//#UC END# *46A5F0130365_0D20FE889A83_var*
begin
//#UC START# *46A5F0130365_0D20FE889A83_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F0130365_0D20FE889A83_impl*
end;//TWordPositionNamesMapImplPrim.GetDisplayNames

function TWordPositionNamesMapImplPrim.MapSize: Integer;
 {* ���������� ��������� � ����. }
//#UC START# *46A5F03800A2_0D20FE889A83_var*
//#UC END# *46A5F03800A2_0D20FE889A83_var*
begin
//#UC START# *46A5F03800A2_0D20FE889A83_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F03800A2_0D20FE889A83_impl*
end;//TWordPositionNamesMapImplPrim.MapSize

function TWordPositionNamesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
//#UC START# *46A5FCF900E0_0D20FE889A83_var*
//#UC END# *46A5FCF900E0_0D20FE889A83_var*
begin
//#UC START# *46A5FCF900E0_0D20FE889A83_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FCF900E0_0D20FE889A83_impl*
end;//TWordPositionNamesMapImplPrim.DisplayNameToValue

function TWordPositionNamesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
//#UC START# *46A5FD1B000D_0D20FE889A83_var*
//#UC END# *46A5FD1B000D_0D20FE889A83_var*
begin
//#UC START# *46A5FD1B000D_0D20FE889A83_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FD1B000D_0D20FE889A83_impl*
end;//TWordPositionNamesMapImplPrim.ValueToDisplayName

class function TWordPositionNamesMapImpl.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TWordPositionNamesMapImpl }
begin
 if (g_TWordPositionNamesMapImpl = nil) then
 begin
  l3System.AddExitProc(TWordPositionNamesMapImplFree);
  Il3IntegerValueMap(g_TWordPositionNamesMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TWordPositionNamesMapImpl);
end;//TWordPositionNamesMapImpl.Make

class function TWordPositionNamesMapImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TWordPositionNamesMapImpl <> nil;
end;//TWordPositionNamesMapImpl.Exists

class procedure TreeLevelDistNamesMapHelper.FillStrings(const aStrings: IafwStrings);
 {* ���������� ������ ����� ���������� }
//#UC START# *968A40ED5C3C_444575E246EA_var*
//#UC END# *968A40ED5C3C_444575E246EA_var*
begin
//#UC START# *968A40ED5C3C_444575E246EA_impl*
 !!! Needs to be implemented !!!
//#UC END# *968A40ED5C3C_444575E246EA_impl*
end;//TreeLevelDistNamesMapHelper.FillStrings

class function TreeLevelDistNamesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): Tl3TreeLevelDist;
 {* �������������� ���������� �������� � ����������� }
//#UC START# *C310C0288899_444575E246EA_var*
//#UC END# *C310C0288899_444575E246EA_var*
begin
//#UC START# *C310C0288899_444575E246EA_impl*
 !!! Needs to be implemented !!!
//#UC END# *C310C0288899_444575E246EA_impl*
end;//TreeLevelDistNamesMapHelper.DisplayNameToValue

class function TTreeLevelDistNamesMapImplPrim.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TTreeLevelDistNamesMapImplPrim }
var
 l_Inst : TTreeLevelDistNamesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TTreeLevelDistNamesMapImplPrim.Make

function TTreeLevelDistNamesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
//#UC START# *46A5EFE602DE_5EAAE9B60711get_var*
//#UC END# *46A5EFE602DE_5EAAE9B60711get_var*
begin
//#UC START# *46A5EFE602DE_5EAAE9B60711get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5EFE602DE_5EAAE9B60711get_impl*
end;//TTreeLevelDistNamesMapImplPrim.pm_GetMapID

procedure TTreeLevelDistNamesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* ��������� ������ ���������� "UI-������" }
//#UC START# *46A5F0130365_5EAAE9B60711_var*
//#UC END# *46A5F0130365_5EAAE9B60711_var*
begin
//#UC START# *46A5F0130365_5EAAE9B60711_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F0130365_5EAAE9B60711_impl*
end;//TTreeLevelDistNamesMapImplPrim.GetDisplayNames

function TTreeLevelDistNamesMapImplPrim.MapSize: Integer;
 {* ���������� ��������� � ����. }
//#UC START# *46A5F03800A2_5EAAE9B60711_var*
//#UC END# *46A5F03800A2_5EAAE9B60711_var*
begin
//#UC START# *46A5F03800A2_5EAAE9B60711_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F03800A2_5EAAE9B60711_impl*
end;//TTreeLevelDistNamesMapImplPrim.MapSize

function TTreeLevelDistNamesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
//#UC START# *46A5FCF900E0_5EAAE9B60711_var*
//#UC END# *46A5FCF900E0_5EAAE9B60711_var*
begin
//#UC START# *46A5FCF900E0_5EAAE9B60711_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FCF900E0_5EAAE9B60711_impl*
end;//TTreeLevelDistNamesMapImplPrim.DisplayNameToValue

function TTreeLevelDistNamesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
//#UC START# *46A5FD1B000D_5EAAE9B60711_var*
//#UC END# *46A5FD1B000D_5EAAE9B60711_var*
begin
//#UC START# *46A5FD1B000D_5EAAE9B60711_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FD1B000D_5EAAE9B60711_impl*
end;//TTreeLevelDistNamesMapImplPrim.ValueToDisplayName

class function TTreeLevelDistNamesMapImpl.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TTreeLevelDistNamesMapImpl }
begin
 if (g_TTreeLevelDistNamesMapImpl = nil) then
 begin
  l3System.AddExitProc(TTreeLevelDistNamesMapImplFree);
  Il3IntegerValueMap(g_TTreeLevelDistNamesMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TTreeLevelDistNamesMapImpl);
end;//TTreeLevelDistNamesMapImpl.Make

class function TTreeLevelDistNamesMapImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TTreeLevelDistNamesMapImpl <> nil;
end;//TTreeLevelDistNamesMapImpl.Exists

class procedure WordOrderNamesMapHelper.FillStrings(const aStrings: IafwStrings);
 {* ���������� ������ ����� ���������� }
//#UC START# *6E3894B77C4A_2C955AD033BA_var*
//#UC END# *6E3894B77C4A_2C955AD033BA_var*
begin
//#UC START# *6E3894B77C4A_2C955AD033BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *6E3894B77C4A_2C955AD033BA_impl*
end;//WordOrderNamesMapHelper.FillStrings

class function WordOrderNamesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): Tl3WordOrder;
 {* �������������� ���������� �������� � ����������� }
//#UC START# *4CD8F3EDFF4B_2C955AD033BA_var*
//#UC END# *4CD8F3EDFF4B_2C955AD033BA_var*
begin
//#UC START# *4CD8F3EDFF4B_2C955AD033BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CD8F3EDFF4B_2C955AD033BA_impl*
end;//WordOrderNamesMapHelper.DisplayNameToValue

class function TWordOrderNamesMapImplPrim.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TWordOrderNamesMapImplPrim }
var
 l_Inst : TWordOrderNamesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TWordOrderNamesMapImplPrim.Make

function TWordOrderNamesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
//#UC START# *46A5EFE602DE_1E42BDDCD137get_var*
//#UC END# *46A5EFE602DE_1E42BDDCD137get_var*
begin
//#UC START# *46A5EFE602DE_1E42BDDCD137get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5EFE602DE_1E42BDDCD137get_impl*
end;//TWordOrderNamesMapImplPrim.pm_GetMapID

procedure TWordOrderNamesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* ��������� ������ ���������� "UI-������" }
//#UC START# *46A5F0130365_1E42BDDCD137_var*
//#UC END# *46A5F0130365_1E42BDDCD137_var*
begin
//#UC START# *46A5F0130365_1E42BDDCD137_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F0130365_1E42BDDCD137_impl*
end;//TWordOrderNamesMapImplPrim.GetDisplayNames

function TWordOrderNamesMapImplPrim.MapSize: Integer;
 {* ���������� ��������� � ����. }
//#UC START# *46A5F03800A2_1E42BDDCD137_var*
//#UC END# *46A5F03800A2_1E42BDDCD137_var*
begin
//#UC START# *46A5F03800A2_1E42BDDCD137_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F03800A2_1E42BDDCD137_impl*
end;//TWordOrderNamesMapImplPrim.MapSize

function TWordOrderNamesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
//#UC START# *46A5FCF900E0_1E42BDDCD137_var*
//#UC END# *46A5FCF900E0_1E42BDDCD137_var*
begin
//#UC START# *46A5FCF900E0_1E42BDDCD137_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FCF900E0_1E42BDDCD137_impl*
end;//TWordOrderNamesMapImplPrim.DisplayNameToValue

function TWordOrderNamesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
//#UC START# *46A5FD1B000D_1E42BDDCD137_var*
//#UC END# *46A5FD1B000D_1E42BDDCD137_var*
begin
//#UC START# *46A5FD1B000D_1E42BDDCD137_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FD1B000D_1E42BDDCD137_impl*
end;//TWordOrderNamesMapImplPrim.ValueToDisplayName

class function TWordOrderNamesMapImpl.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TWordOrderNamesMapImpl }
begin
 if (g_TWordOrderNamesMapImpl = nil) then
 begin
  l3System.AddExitProc(TWordOrderNamesMapImplFree);
  Il3IntegerValueMap(g_TWordOrderNamesMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TWordOrderNamesMapImpl);
end;//TWordOrderNamesMapImpl.Make

class function TWordOrderNamesMapImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TWordOrderNamesMapImpl <> nil;
end;//TWordOrderNamesMapImpl.Exists

initialization
 str_nsc_cpmTreeLevelDistHint.Init;
 {* ������������� str_nsc_cpmTreeLevelDistHint }
 str_nsc_cpmWordOrderHint.Init;
 {* ������������� str_nsc_cpmWordOrderHint }
 str_nsc_cpmWordPositionHint.Init;
 {* ������������� str_nsc_cpmWordPositionHint }
 str_nsc_wpAnyPathWord.Init;
 {* ������������� str_nsc_wpAnyPathWord }
 str_nsc_wpAtBeginWord.Init;
 {* ������������� str_nsc_wpAtBeginWord }
 str_nsc_wpAtBeginString.Init;
 {* ������������� str_nsc_wpAtBeginString }
 str_nsc_tldAllLevels.Init;
 {* ������������� str_nsc_tldAllLevels }
 str_nsc_tldOneLevel.Init;
 {* ������������� str_nsc_tldOneLevel }
 str_nsc_woAnyOrder.Init;
 {* ������������� str_nsc_woAnyOrder }
 str_nsc_woAsWrote.Init;
 {* ������������� str_nsc_woAsWrote }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
