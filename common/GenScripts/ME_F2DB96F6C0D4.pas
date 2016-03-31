unit DocumentPrintAndExportFontSizeSettingRes;
 {* ������� ��� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }

// ������: "w:\common\components\SandBox\VCM\View\Document\DocumentPrintAndExportFontSizeSettingRes.pas"
// ���������: "UtilityPack"
// ������� ������: "DocumentPrintAndExportFontSizeSettingRes" MUID: (F2DB96F6C0D4)

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
 , afwInterfaces
 , l3Interfaces
 , l3CProtoObject
;

const
 pi_Document_PrintAndExportFontSize = '��������/������������ ��� �������� � ������ ��������� ������ ������';
  {* ������������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
 dv_Document_PrintAndExportFontSize = 0;
  {* �������� ��-��������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
 {* ������������ ������ PrintAndExportFontSizeValues }
 str_PrintAndExportFontSize_pef8: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef8'; rValue : '8');
  {* 8 }
 str_PrintAndExportFontSize_pef9: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef9'; rValue : '9');
  {* 9 }
 str_PrintAndExportFontSize_pef10: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef10'; rValue : '10');
  {* 10 }
 str_PrintAndExportFontSize_pef11: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef11'; rValue : '11');
  {* 11 }
 str_PrintAndExportFontSize_pef12: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef12'; rValue : '12');
  {* 12 }
 str_PrintAndExportFontSize_pef14: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef14'; rValue : '14');
  {* 14 }
 str_PrintAndExportFontSize_pef16: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize_pef16'; rValue : '16');
  {* 16 }
 {* ������������ ������ PrintAndExportFontSizeName }
 str_PrintAndExportFontSize: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintAndExportFontSize'; rValue : '������������ ��� �������� � ������ ��������� ������ ������');
  {* ������������ ��� �������� � ������ ��������� ������ ������ }

type
 PrintAndExportFontSizeEnum = (
  {* ����� ��� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
  KEY_PrintAndExportFontSize_pef8
   {* 8 }
  , KEY_PrintAndExportFontSize_pef9
   {* 9 }
  , KEY_PrintAndExportFontSize_pef10
   {* 10 }
  , KEY_PrintAndExportFontSize_pef11
   {* 11 }
  , KEY_PrintAndExportFontSize_pef12
   {* 12 }
  , KEY_PrintAndExportFontSize_pef14
   {* 14 }
  , KEY_PrintAndExportFontSize_pef16
   {* 16 }
 );//PrintAndExportFontSizeEnum

 PrintAndExportFontSizeValuesMapHelper = {final} class
  {* ��������� ����� ��� �������������� �������� PrintAndExportFontSizeValuesMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* ���������� ������ ����� ���������� }
   class function DisplayNameToValue(const aDisplayName: Il3CString): PrintAndExportFontSizeEnum;
    {* �������������� ���������� �������� � ����������� }
 end;//PrintAndExportFontSizeValuesMapHelper

 TPrintAndExportFontSizeValuesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* ����� ��� ���������� ���� ��� PrintAndExportFontSizeValuesMap }
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
    {* ��������� ����� ��� TPrintAndExportFontSizeValuesMapImplPrim }
 end;//TPrintAndExportFontSizeValuesMapImplPrim

 TPrintAndExportFontSizeValuesMapImpl = {final} class(TPrintAndExportFontSizeValuesMapImplPrim)
  {* ����� ��� ���������� ���� ��� PrintAndExportFontSizeValuesMap }
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* ��������� ����� ��� TPrintAndExportFontSizeValuesMapImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TPrintAndExportFontSizeValuesMapImpl

const
 {* ����� �������������� �������������� ����� PrintAndExportFontSizeValues }
 PrintAndExportFontSizeValuesMap: array [PrintAndExportFontSizeEnum] of Pl3StringIDEx = (
 @str_PrintAndExportFontSize_pef8
 , @str_PrintAndExportFontSize_pef9
 , @str_PrintAndExportFontSize_pef10
 , @str_PrintAndExportFontSize_pef11
 , @str_PrintAndExportFontSize_pef12
 , @str_PrintAndExportFontSize_pef14
 , @str_PrintAndExportFontSize_pef16
 );

implementation

uses
 l3ImplUses
 , l3MessageID
 , l3String
 , SysUtils
 , l3Base
;

var g_TPrintAndExportFontSizeValuesMapImpl: Pointer = nil;
 {* ��������� ���������� TPrintAndExportFontSizeValuesMapImpl }

procedure TPrintAndExportFontSizeValuesMapImplFree;
 {* ����� ������������ ���������� ���������� TPrintAndExportFontSizeValuesMapImpl }
begin
 IUnknown(g_TPrintAndExportFontSizeValuesMapImpl) := nil;
end;//TPrintAndExportFontSizeValuesMapImplFree

class procedure PrintAndExportFontSizeValuesMapHelper.FillStrings(const aStrings: IafwStrings);
 {* ���������� ������ ����� ���������� }
//#UC START# *4C25465FA194_7EA9EF3DF3F2_var*
//#UC END# *4C25465FA194_7EA9EF3DF3F2_var*
begin
//#UC START# *4C25465FA194_7EA9EF3DF3F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C25465FA194_7EA9EF3DF3F2_impl*
end;//PrintAndExportFontSizeValuesMapHelper.FillStrings

class function PrintAndExportFontSizeValuesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): PrintAndExportFontSizeEnum;
 {* �������������� ���������� �������� � ����������� }
//#UC START# *495A60C6598A_7EA9EF3DF3F2_var*
//#UC END# *495A60C6598A_7EA9EF3DF3F2_var*
begin
//#UC START# *495A60C6598A_7EA9EF3DF3F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *495A60C6598A_7EA9EF3DF3F2_impl*
end;//PrintAndExportFontSizeValuesMapHelper.DisplayNameToValue

class function TPrintAndExportFontSizeValuesMapImplPrim.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TPrintAndExportFontSizeValuesMapImplPrim }
var
 l_Inst : TPrintAndExportFontSizeValuesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrintAndExportFontSizeValuesMapImplPrim.Make

function TPrintAndExportFontSizeValuesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
//#UC START# *46A5EFE602DE_2F2F16F4BFC4get_var*
//#UC END# *46A5EFE602DE_2F2F16F4BFC4get_var*
begin
//#UC START# *46A5EFE602DE_2F2F16F4BFC4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5EFE602DE_2F2F16F4BFC4get_impl*
end;//TPrintAndExportFontSizeValuesMapImplPrim.pm_GetMapID

procedure TPrintAndExportFontSizeValuesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* ��������� ������ ���������� "UI-������" }
//#UC START# *46A5F0130365_2F2F16F4BFC4_var*
//#UC END# *46A5F0130365_2F2F16F4BFC4_var*
begin
//#UC START# *46A5F0130365_2F2F16F4BFC4_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F0130365_2F2F16F4BFC4_impl*
end;//TPrintAndExportFontSizeValuesMapImplPrim.GetDisplayNames

function TPrintAndExportFontSizeValuesMapImplPrim.MapSize: Integer;
 {* ���������� ��������� � ����. }
//#UC START# *46A5F03800A2_2F2F16F4BFC4_var*
//#UC END# *46A5F03800A2_2F2F16F4BFC4_var*
begin
//#UC START# *46A5F03800A2_2F2F16F4BFC4_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5F03800A2_2F2F16F4BFC4_impl*
end;//TPrintAndExportFontSizeValuesMapImplPrim.MapSize

function TPrintAndExportFontSizeValuesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
//#UC START# *46A5FCF900E0_2F2F16F4BFC4_var*
//#UC END# *46A5FCF900E0_2F2F16F4BFC4_var*
begin
//#UC START# *46A5FCF900E0_2F2F16F4BFC4_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FCF900E0_2F2F16F4BFC4_impl*
end;//TPrintAndExportFontSizeValuesMapImplPrim.DisplayNameToValue

function TPrintAndExportFontSizeValuesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
//#UC START# *46A5FD1B000D_2F2F16F4BFC4_var*
//#UC END# *46A5FD1B000D_2F2F16F4BFC4_var*
begin
//#UC START# *46A5FD1B000D_2F2F16F4BFC4_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5FD1B000D_2F2F16F4BFC4_impl*
end;//TPrintAndExportFontSizeValuesMapImplPrim.ValueToDisplayName

class function TPrintAndExportFontSizeValuesMapImpl.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TPrintAndExportFontSizeValuesMapImpl }
begin
 if (g_TPrintAndExportFontSizeValuesMapImpl = nil) then
 begin
  l3System.AddExitProc(TPrintAndExportFontSizeValuesMapImplFree);
  Il3IntegerValueMap(g_TPrintAndExportFontSizeValuesMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TPrintAndExportFontSizeValuesMapImpl);
end;//TPrintAndExportFontSizeValuesMapImpl.Make

class function TPrintAndExportFontSizeValuesMapImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TPrintAndExportFontSizeValuesMapImpl <> nil;
end;//TPrintAndExportFontSizeValuesMapImpl.Exists

initialization
 str_PrintAndExportFontSize_pef8.Init;
 {* ������������� str_PrintAndExportFontSize_pef8 }
 str_PrintAndExportFontSize_pef9.Init;
 {* ������������� str_PrintAndExportFontSize_pef9 }
 str_PrintAndExportFontSize_pef10.Init;
 {* ������������� str_PrintAndExportFontSize_pef10 }
 str_PrintAndExportFontSize_pef11.Init;
 {* ������������� str_PrintAndExportFontSize_pef11 }
 str_PrintAndExportFontSize_pef12.Init;
 {* ������������� str_PrintAndExportFontSize_pef12 }
 str_PrintAndExportFontSize_pef14.Init;
 {* ������������� str_PrintAndExportFontSize_pef14 }
 str_PrintAndExportFontSize_pef16.Init;
 {* ������������� str_PrintAndExportFontSize_pef16 }
 str_PrintAndExportFontSize.Init;
 {* ������������� str_PrintAndExportFontSize }

end.
