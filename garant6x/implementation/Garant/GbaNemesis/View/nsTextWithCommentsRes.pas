unit nsTextWithCommentsRes;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsTextWithCommentsRes.pas"
// ���������: "UtilityPack"
// ������� ������: "nsTextWithCommentsRes" MUID: (4D5A701702B4)

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
 {* ������������ ������ Local }
 str_pi_Document_ShowVersionsComment: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_Document_ShowVersionsComment'; rValue : '���������� ���������� �� ���������� � ������ ���������');
  {* '���������� ���������� �� ���������� � ������ ���������' }
 str_pi_Document_ShowVersionsComment_Hint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_Document_ShowVersionsComment_Hint'; rValue : '���������� ���������� �� ���������� � ������ ���������');
  {* '���������� ���������� �� ���������� � ������ ���������' }
 str_pi_Document_SubPanel_ShowVersionComments: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_Document_SubPanel_ShowVersionComments'; rValue : '���������� �� ����������');
  {* '���������� �� ����������' }
 str_pi_Document_ShowVersionCommentsLinkBehaviour: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pi_Document_ShowVersionCommentsLinkBehaviour'; rValue : '�� ������ � ���������� �� ���������� � ������ ��������� ���������');
  {* '�� ������ � ���������� �� ���������� � ������ ��������� ���������' }
 {* ������������ ������ ShowVersionComments }
 str_svcCollapsed: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'svcCollapsed'; rValue : '� ��������� ����');
  {* '� ��������� ����' }
 str_svcExpanded: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'svcExpanded'; rValue : '� ����������� ����');
  {* '� ����������� ����' }
 {* ����� �������������� �������������� ����� ShowVersionComments }
 ShowVersionCommentsMap: array [Boolean] of Pl3StringIDEx = (
 @str_svcCollapsed
 , @str_svcExpanded
 );
 {* ������������ ������ VersionCommentsLinkBegaviour }
 str_vclbComparison: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vclbComparison'; rValue : '��������� ��������');
  {* '��������� ��������' }
 str_vclbText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vclbText'; rValue : '����� ��������');
  {* '����� ��������' }
 {* ����� �������������� �������������� ����� VersionCommentsLinkBegaviour }
 VersionCommentsLinkBegaviourMap: array [Boolean] of Pl3StringIDEx = (
 @str_vclbComparison
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

var g_TShowVersionCommentsMapImpl: Pointer = nil;
 {* ��������� ���������� TShowVersionCommentsMapImpl }
var g_TVersionCommentsLinkBegaviourMapImpl: Pointer = nil;
 {* ��������� ���������� TVersionCommentsLinkBegaviourMapImpl }

procedure TShowVersionCommentsMapImplFree;
 {* ����� ������������ ���������� ���������� TShowVersionCommentsMapImpl }
begin
 IUnknown(g_TShowVersionCommentsMapImpl) := nil;
end;//TShowVersionCommentsMapImplFree

procedure TVersionCommentsLinkBegaviourMapImplFree;
 {* ����� ������������ ���������� ���������� TVersionCommentsLinkBegaviourMapImpl }
begin
 IUnknown(g_TVersionCommentsLinkBegaviourMapImpl) := nil;
end;//TVersionCommentsLinkBegaviourMapImplFree

class procedure ShowVersionCommentsMapHelper.FillStrings(const aStrings: IafwStrings);
 {* ���������� ������ ����� ���������� }
var
 l_Index: Boolean;
begin
 aStrings.Clear;
 for l_Index := Low(l_Index) to High(l_Index) do
  aStrings.Add(ShowVersionCommentsMap[l_Index].AsCStr);
end;//ShowVersionCommentsMapHelper.FillStrings

class function ShowVersionCommentsMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): Boolean;
 {* �������������� ���������� �������� � ����������� }
var
 l_Index: Boolean;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  if l3Same(aDisplayName, ShowVersionCommentsMap[l_Index].AsCStr) then
  begin
   Result := l_Index;
   Exit;
  end;//l3Same..
 raise Exception.CreateFmt('Display name "%s" not found in map "ShowVersionCommentsMap"', [l3Str(aDisplayName)]);
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
begin
 l3FillChar(Result, SizeOf(Result));
 Assert(false);
end;//TShowVersionCommentsMapImplPrim.pm_GetMapID

procedure TShowVersionCommentsMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* ��������� ������ ���������� "UI-������" }
begin
 ShowVersionCommentsMapHelper.FillStrings(aList);
end;//TShowVersionCommentsMapImplPrim.GetDisplayNames

function TShowVersionCommentsMapImplPrim.MapSize: Integer;
 {* ���������� ��������� � ����. }
begin
 Result := Ord(High(Boolean)) - Ord(Low(Boolean));
end;//TShowVersionCommentsMapImplPrim.MapSize

function TShowVersionCommentsMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
begin
 Result := Ord(ShowVersionCommentsMapHelper.DisplayNameToValue(aDisplayName));
end;//TShowVersionCommentsMapImplPrim.DisplayNameToValue

function TShowVersionCommentsMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
begin
 Assert(aValue >= Ord(Low(Boolean)));
 Assert(aValue <= Ord(High(Boolean)));
 Result := ShowVersionCommentsMap[Boolean(aValue)].AsCStr;
end;//TShowVersionCommentsMapImplPrim.ValueToDisplayName

class function TShowVersionCommentsMapImpl.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TShowVersionCommentsMapImpl }
begin
 if (g_TShowVersionCommentsMapImpl = nil) then
 begin
  l3System.AddExitProc(TShowVersionCommentsMapImplFree);
  Il3IntegerValueMap(g_TShowVersionCommentsMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TShowVersionCommentsMapImpl);
end;//TShowVersionCommentsMapImpl.Make

class function TShowVersionCommentsMapImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TShowVersionCommentsMapImpl <> nil;
end;//TShowVersionCommentsMapImpl.Exists

class procedure VersionCommentsLinkBegaviourMapHelper.FillStrings(const aStrings: IafwStrings);
 {* ���������� ������ ����� ���������� }
var
 l_Index: Boolean;
begin
 aStrings.Clear;
 for l_Index := Low(l_Index) to High(l_Index) do
  aStrings.Add(VersionCommentsLinkBegaviourMap[l_Index].AsCStr);
end;//VersionCommentsLinkBegaviourMapHelper.FillStrings

class function VersionCommentsLinkBegaviourMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): Boolean;
 {* �������������� ���������� �������� � ����������� }
var
 l_Index: Boolean;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  if l3Same(aDisplayName, VersionCommentsLinkBegaviourMap[l_Index].AsCStr) then
  begin
   Result := l_Index;
   Exit;
  end;//l3Same..
 raise Exception.CreateFmt('Display name "%s" not found in map "VersionCommentsLinkBegaviourMap"', [l3Str(aDisplayName)]);
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
begin
 l3FillChar(Result, SizeOf(Result));
 Assert(false);
end;//TVersionCommentsLinkBegaviourMapImplPrim.pm_GetMapID

procedure TVersionCommentsLinkBegaviourMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* ��������� ������ ���������� "UI-������" }
begin
 VersionCommentsLinkBegaviourMapHelper.FillStrings(aList);
end;//TVersionCommentsLinkBegaviourMapImplPrim.GetDisplayNames

function TVersionCommentsLinkBegaviourMapImplPrim.MapSize: Integer;
 {* ���������� ��������� � ����. }
begin
 Result := Ord(High(Boolean)) - Ord(Low(Boolean));
end;//TVersionCommentsLinkBegaviourMapImplPrim.MapSize

function TVersionCommentsLinkBegaviourMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
begin
 Result := Ord(VersionCommentsLinkBegaviourMapHelper.DisplayNameToValue(aDisplayName));
end;//TVersionCommentsLinkBegaviourMapImplPrim.DisplayNameToValue

function TVersionCommentsLinkBegaviourMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
begin
 Assert(aValue >= Ord(Low(Boolean)));
 Assert(aValue <= Ord(High(Boolean)));
 Result := VersionCommentsLinkBegaviourMap[Boolean(aValue)].AsCStr;
end;//TVersionCommentsLinkBegaviourMapImplPrim.ValueToDisplayName

class function TVersionCommentsLinkBegaviourMapImpl.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TVersionCommentsLinkBegaviourMapImpl }
begin
 if (g_TVersionCommentsLinkBegaviourMapImpl = nil) then
 begin
  l3System.AddExitProc(TVersionCommentsLinkBegaviourMapImplFree);
  Il3IntegerValueMap(g_TVersionCommentsLinkBegaviourMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TVersionCommentsLinkBegaviourMapImpl);
end;//TVersionCommentsLinkBegaviourMapImpl.Make

class function TVersionCommentsLinkBegaviourMapImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TVersionCommentsLinkBegaviourMapImpl <> nil;
end;//TVersionCommentsLinkBegaviourMapImpl.Exists

initialization
 str_pi_Document_ShowVersionsComment.Init;
 {* ������������� str_pi_Document_ShowVersionsComment }
 str_pi_Document_ShowVersionsComment_Hint.Init;
 {* ������������� str_pi_Document_ShowVersionsComment_Hint }
 str_pi_Document_SubPanel_ShowVersionComments.Init;
 {* ������������� str_pi_Document_SubPanel_ShowVersionComments }
 str_pi_Document_ShowVersionCommentsLinkBehaviour.Init;
 {* ������������� str_pi_Document_ShowVersionCommentsLinkBehaviour }
 str_svcCollapsed.Init;
 {* ������������� str_svcCollapsed }
 str_svcExpanded.Init;
 {* ������������� str_svcExpanded }
 str_vclbComparison.Init;
 {* ������������� str_vclbComparison }
 str_vclbText.Init;
 {* ������������� str_vclbText }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
