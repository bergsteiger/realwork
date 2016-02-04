unit nsTextWithCommentsRes;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsTextWithCommentsRes.pas"
// ���������: "UtilityPack"

{$Include nsDefine.inc}

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
 {* ������������ ������ ShowVersionComments }
 str_svcCollapsed: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'svcCollapsed'; rValue : '� ��������� ����');
  {* '� ��������� ����' }
 str_svcExpanded: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'svcExpanded'; rValue : '� ����������� ����');
  {* '� ����������� ����' }
 {* ����� �������������� �������������� ����� ShowVersionComments }
 ShowVersionCommentsMap: array [Boolean] of Pl3StringIDEx = (@str_svcCollapsed
 , @str_svcExpanded
 );
 {* ������������ ������ Local }
 str_pi_Document_ShowVersionsComment: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_Document_ShowVersionsComment'; rValue : '���������� ���������� �� ���������� � ������ ���������');
  {* '���������� ���������� �� ���������� � ������ ���������' }
 str_pi_Document_ShowVersionsComment_Hint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_Document_ShowVersionsComment_Hint'; rValue : '���������� ���������� �� ���������� � ������ ���������');
  {* '���������� ���������� �� ���������� � ������ ���������' }
 str_pi_Document_SubPanel_ShowVersionComments: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_Document_SubPanel_ShowVersionComments'; rValue : '���������� �� ����������');
  {* '���������� �� ����������' }
 str_pi_Document_ShowVersionCommentsLinkBehaviour: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_Document_ShowVersionCommentsLinkBehaviour'; rValue : '�� ������ � ���������� �� ���������� � ������ ��������� ���������');
  {* '�� ������ � ���������� �� ���������� � ������ ��������� ���������' }
 {* ������������ ������ VersionCommentsLinkBegaviour }
 str_vclbComparison: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vclbComparison'; rValue : '��������� ��������');
  {* '��������� ��������' }
 str_vclbText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vclbText'; rValue : '����� ��������');
  {* '����� ��������' }
 {* ����� �������������� �������������� ����� VersionCommentsLinkBegaviour }
 VersionCommentsLinkBegaviourMap: array [Boolean] of Pl3StringIDEx = (@str_vclbComparison
 , @str_vclbText
 );

type
 ShowVersionCommentsMapHelper = {final} class
  {* ��������� ����� ��� �������������� �������� ShowVersionCommentsMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* ���������� ������ ����� ���������� }
   class function DisplayNameToValue(const aDisplayName: Il3CString): Boolean;
    {* �������������� ���������� �������� � ����������� }
 end;//ShowVersionCommentsMapHelper

 TShowVersionCommentsMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* ����� ��� ���������� ���� ��� ShowVersionCommentsMap }
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
    {* ��������� ����� ��� TShowVersionCommentsMapImplPrim }
 end;//TShowVersionCommentsMapImplPrim

 TShowVersionCommentsMapImpl = {final} class(TShowVersionCommentsMapImplPrim)
  {* ����� ��� ���������� ���� ��� ShowVersionCommentsMap }
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* ��������� ����� ��� TShowVersionCommentsMapImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TShowVersionCommentsMapImpl;
    {* ����� ��������� ���������� ���������� TShowVersionCommentsMapImpl }
 end;//TShowVersionCommentsMapImpl

 VersionCommentsLinkBegaviourMapHelper = {final} class
  {* ��������� ����� ��� �������������� �������� VersionCommentsLinkBegaviourMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* ���������� ������ ����� ���������� }
   class function DisplayNameToValue(const aDisplayName: Il3CString): Boolean;
    {* �������������� ���������� �������� � ����������� }
 end;//VersionCommentsLinkBegaviourMapHelper

 TVersionCommentsLinkBegaviourMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* ����� ��� ���������� ���� ��� VersionCommentsLinkBegaviourMap }
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
    {* ��������� ����� ��� TVersionCommentsLinkBegaviourMapImplPrim }
 end;//TVersionCommentsLinkBegaviourMapImplPrim

 TVersionCommentsLinkBegaviourMapImpl = {final} class(TVersionCommentsLinkBegaviourMapImplPrim)
  {* ����� ��� ���������� ���� ��� VersionCommentsLinkBegaviourMap }
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* ��������� ����� ��� TVersionCommentsLinkBegaviourMapImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TVersionCommentsLinkBegaviourMapImpl;
    {* ����� ��������� ���������� ���������� TVersionCommentsLinkBegaviourMapImpl }
 end;//TVersionCommentsLinkBegaviourMapImpl
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

var g_TShowVersionCommentsMapImpl: TShowVersionCommentsMapImpl = nil;
 {* ��������� ���������� TShowVersionCommentsMapImpl }
var g_TVersionCommentsLinkBegaviourMapImpl: TVersionCommentsLinkBegaviourMapImpl = nil;
 {* ��������� ���������� TVersionCommentsLinkBegaviourMapImpl }

procedure TShowVersionCommentsMapImplFree;
 {* ����� ������������ ���������� ���������� TShowVersionCommentsMapImpl }
begin
 l3Free(g_TShowVersionCommentsMapImpl);
end;//TShowVersionCommentsMapImplFree

procedure TVersionCommentsLinkBegaviourMapImplFree;
 {* ����� ������������ ���������� ���������� TVersionCommentsLinkBegaviourMapImpl }
begin
 l3Free(g_TVersionCommentsLinkBegaviourMapImpl);
end;//TVersionCommentsLinkBegaviourMapImplFree

class procedure ShowVersionCommentsMapHelper.FillStrings(const aStrings: IafwStrings);
 {* ���������� ������ ����� ���������� }
//#UC START# *8F841ADC29B1_1F19B60638CF_var*
//#UC END# *8F841ADC29B1_1F19B60638CF_var*
begin
//#UC START# *8F841ADC29B1_1F19B60638CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *8F841ADC29B1_1F19B60638CF_impl*
end;//ShowVersionCommentsMapHelper.FillStrings

class function ShowVersionCommentsMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): Boolean;
 {* �������������� ���������� �������� � ����������� }
//#UC START# *5E0573B53350_1F19B60638CF_var*
//#UC END# *5E0573B53350_1F19B60638CF_var*
begin
//#UC START# *5E0573B53350_1F19B60638CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *5E0573B53350_1F19B60638CF_impl*
end;//ShowVersionCommentsMapHelper.DisplayNameToValue

class function TShowVersionCommentsMapImplPrim.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TShowVersionCommentsMapImplPrim }
var
 l_Inst : TShowVersionCommentsMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TShowVersionCommentsMapImplPrim.Make

function TShowVersionCommentsMapImplPrim.pm_GetMapID: Tl3ValueMapID;
//#UC START# *46A5EFE602DE_E2B3C0235006get_var*
//#UC END# *46A5EFE602DE_E2B3C0235006get_var*
begin
//#UC START# *46A5EFE602DE_E2B3C0235006get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5EFE602DE_E2B3C0235006get_impl*
end;//TShowVersionCommentsMapImplPrim.pm_GetMapID

procedure TShowVersionCommentsMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* ��������� ������ ���������� "UI-������" }
//#UC START# *46A5F0130365_E2B3C0235006_var*
//#UC END# *46A5F0130365_E2B3C0235006_var*
begin
//#UC START# *46A5F0130365_E2B3C0235006_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F0130365_E2B3C0235006_impl*
end;//TShowVersionCommentsMapImplPrim.GetDisplayNames

function TShowVersionCommentsMapImplPrim.MapSize: Integer;
 {* ���������� ��������� � ����. }
//#UC START# *46A5F03800A2_E2B3C0235006_var*
//#UC END# *46A5F03800A2_E2B3C0235006_var*
begin
//#UC START# *46A5F03800A2_E2B3C0235006_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F03800A2_E2B3C0235006_impl*
end;//TShowVersionCommentsMapImplPrim.MapSize

function TShowVersionCommentsMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
//#UC START# *46A5FCF900E0_E2B3C0235006_var*
//#UC END# *46A5FCF900E0_E2B3C0235006_var*
begin
//#UC START# *46A5FCF900E0_E2B3C0235006_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FCF900E0_E2B3C0235006_impl*
end;//TShowVersionCommentsMapImplPrim.DisplayNameToValue

function TShowVersionCommentsMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
//#UC START# *46A5FD1B000D_E2B3C0235006_var*
//#UC END# *46A5FD1B000D_E2B3C0235006_var*
begin
//#UC START# *46A5FD1B000D_E2B3C0235006_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FD1B000D_E2B3C0235006_impl*
end;//TShowVersionCommentsMapImplPrim.ValueToDisplayName

class function TShowVersionCommentsMapImpl.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TShowVersionCommentsMapImpl }
var
 l_Inst : TShowVersionCommentsMapImpl;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TShowVersionCommentsMapImpl.Make

class function TShowVersionCommentsMapImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TShowVersionCommentsMapImpl <> nil;
end;//TShowVersionCommentsMapImpl.Exists

class function TShowVersionCommentsMapImpl.Instance: TShowVersionCommentsMapImpl;
 {* ����� ��������� ���������� ���������� TShowVersionCommentsMapImpl }
begin
 if (g_TShowVersionCommentsMapImpl = nil) then
 begin
  l3System.AddExitProc(TShowVersionCommentsMapImplFree);
  g_TShowVersionCommentsMapImpl := Create;
 end;
 Result := g_TShowVersionCommentsMapImpl;
end;//TShowVersionCommentsMapImpl.Instance

class procedure VersionCommentsLinkBegaviourMapHelper.FillStrings(const aStrings: IafwStrings);
 {* ���������� ������ ����� ���������� }
//#UC START# *474F5AA5D378_E8F3B033F09E_var*
//#UC END# *474F5AA5D378_E8F3B033F09E_var*
begin
//#UC START# *474F5AA5D378_E8F3B033F09E_impl*
 !!! Needs to be implemented !!!
//#UC END# *474F5AA5D378_E8F3B033F09E_impl*
end;//VersionCommentsLinkBegaviourMapHelper.FillStrings

class function VersionCommentsLinkBegaviourMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): Boolean;
 {* �������������� ���������� �������� � ����������� }
//#UC START# *BA5ADD58E319_E8F3B033F09E_var*
//#UC END# *BA5ADD58E319_E8F3B033F09E_var*
begin
//#UC START# *BA5ADD58E319_E8F3B033F09E_impl*
 !!! Needs to be implemented !!!
//#UC END# *BA5ADD58E319_E8F3B033F09E_impl*
end;//VersionCommentsLinkBegaviourMapHelper.DisplayNameToValue

class function TVersionCommentsLinkBegaviourMapImplPrim.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TVersionCommentsLinkBegaviourMapImplPrim }
var
 l_Inst : TVersionCommentsLinkBegaviourMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TVersionCommentsLinkBegaviourMapImplPrim.Make

function TVersionCommentsLinkBegaviourMapImplPrim.pm_GetMapID: Tl3ValueMapID;
//#UC START# *46A5EFE602DE_EEAC7EDDFD54get_var*
//#UC END# *46A5EFE602DE_EEAC7EDDFD54get_var*
begin
//#UC START# *46A5EFE602DE_EEAC7EDDFD54get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5EFE602DE_EEAC7EDDFD54get_impl*
end;//TVersionCommentsLinkBegaviourMapImplPrim.pm_GetMapID

procedure TVersionCommentsLinkBegaviourMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* ��������� ������ ���������� "UI-������" }
//#UC START# *46A5F0130365_EEAC7EDDFD54_var*
//#UC END# *46A5F0130365_EEAC7EDDFD54_var*
begin
//#UC START# *46A5F0130365_EEAC7EDDFD54_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F0130365_EEAC7EDDFD54_impl*
end;//TVersionCommentsLinkBegaviourMapImplPrim.GetDisplayNames

function TVersionCommentsLinkBegaviourMapImplPrim.MapSize: Integer;
 {* ���������� ��������� � ����. }
//#UC START# *46A5F03800A2_EEAC7EDDFD54_var*
//#UC END# *46A5F03800A2_EEAC7EDDFD54_var*
begin
//#UC START# *46A5F03800A2_EEAC7EDDFD54_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F03800A2_EEAC7EDDFD54_impl*
end;//TVersionCommentsLinkBegaviourMapImplPrim.MapSize

function TVersionCommentsLinkBegaviourMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
//#UC START# *46A5FCF900E0_EEAC7EDDFD54_var*
//#UC END# *46A5FCF900E0_EEAC7EDDFD54_var*
begin
//#UC START# *46A5FCF900E0_EEAC7EDDFD54_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FCF900E0_EEAC7EDDFD54_impl*
end;//TVersionCommentsLinkBegaviourMapImplPrim.DisplayNameToValue

function TVersionCommentsLinkBegaviourMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
//#UC START# *46A5FD1B000D_EEAC7EDDFD54_var*
//#UC END# *46A5FD1B000D_EEAC7EDDFD54_var*
begin
//#UC START# *46A5FD1B000D_EEAC7EDDFD54_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FD1B000D_EEAC7EDDFD54_impl*
end;//TVersionCommentsLinkBegaviourMapImplPrim.ValueToDisplayName

class function TVersionCommentsLinkBegaviourMapImpl.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TVersionCommentsLinkBegaviourMapImpl }
var
 l_Inst : TVersionCommentsLinkBegaviourMapImpl;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TVersionCommentsLinkBegaviourMapImpl.Make

class function TVersionCommentsLinkBegaviourMapImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TVersionCommentsLinkBegaviourMapImpl <> nil;
end;//TVersionCommentsLinkBegaviourMapImpl.Exists

class function TVersionCommentsLinkBegaviourMapImpl.Instance: TVersionCommentsLinkBegaviourMapImpl;
 {* ����� ��������� ���������� ���������� TVersionCommentsLinkBegaviourMapImpl }
begin
 if (g_TVersionCommentsLinkBegaviourMapImpl = nil) then
 begin
  l3System.AddExitProc(TVersionCommentsLinkBegaviourMapImplFree);
  g_TVersionCommentsLinkBegaviourMapImpl := Create;
 end;
 Result := g_TVersionCommentsLinkBegaviourMapImpl;
end;//TVersionCommentsLinkBegaviourMapImpl.Instance

initialization
 str_svcCollapsed.Init;
 {* ������������� str_svcCollapsed }
 str_svcExpanded.Init;
 {* ������������� str_svcExpanded }
 str_pi_Document_ShowVersionsComment.Init;
 {* ������������� str_pi_Document_ShowVersionsComment }
 str_pi_Document_ShowVersionsComment_Hint.Init;
 {* ������������� str_pi_Document_ShowVersionsComment_Hint }
 str_pi_Document_SubPanel_ShowVersionComments.Init;
 {* ������������� str_pi_Document_SubPanel_ShowVersionComments }
 str_pi_Document_ShowVersionCommentsLinkBehaviour.Init;
 {* ������������� str_pi_Document_ShowVersionCommentsLinkBehaviour }
 str_vclbComparison.Init;
 {* ������������� str_vclbComparison }
 str_vclbText.Init;
 {* ������������� str_vclbText }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
