unit evStylesPrintAndExportFontSizeSettingRes;

interface

uses
 l3IntfUses
 , l3StringIDEx
 , afwInterfaces
 , l3Interfaces
 , l3CProtoObject
;

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
 
 PrintAndExportFontSizeValuesMapHelper = class
  {* ��������� ����� ��� �������������� �������� PrintAndExportFontSizeValuesMap }
  procedure FillStrings(const aStrings: IafwStrings);
   {* ���������� ������ ����� ���������� }
  function DisplayNameToValue(const aDisplayName: Il3CString): PrintAndExportFontSizeEnum;
   {* �������������� ���������� �������� � ����������� }
 end;//PrintAndExportFontSizeValuesMapHelper
 
 TPrintAndExportFontSizeValuesMapImplPrim = class(Tl3CProtoObject, Il3IntegerValueMap)
  {* ����� ��� ���������� ���� ��� PrintAndExportFontSizeValuesMap }
  function Make: Il3IntegerValueMap;
   {* ��������� ����� ��� TPrintAndExportFontSizeValuesMapImplPrim }
  function MapID: Tl3ValueMapID;
   {* ������������� ����. }
  procedure GetDisplayNames(const aList: Il3StringsEx);
   {* ��������� ������ ���������� "UI-������" }
  function MapSize: Integer;
   {* ���������� ��������� � ����. }
  function DisplayNameToValue(const aDisplayName: Il3CString): Integer;
  function ValueToDisplayName(aValue: Integer): Il3CString;
 end;//TPrintAndExportFontSizeValuesMapImplPrim
 
 TPrintAndExportFontSizeValuesMapImpl = class(TPrintAndExportFontSizeValuesMapImplPrim)
  {* ����� ��� ���������� ���� ��� PrintAndExportFontSizeValuesMap }
  function Make: Il3IntegerValueMap;
   {* ��������� ����� ��� TPrintAndExportFontSizeValuesMapImpl }
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TPrintAndExportFontSizeValuesMapImpl
 
implementation

uses
 l3ImplUses
 , l3MessageID
 , l3String
 , SysUtils
 , l3Base
;

end.
