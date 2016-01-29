unit evStyles_SH;

interface

uses
 l3IntfUses
 , evInterface
 , l3ProtoObject
 , afwInterfaces
;

type
 SHevStyles = class(TevInterface)
  {* ����� }
  function PrintAndExportFontSize: Integer;
   {* ����������� ������ ������ ��� ������ � �������� }
  function PrintAndExportDefaultSetting: Boolean;
   {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
  function PrintAndExportCustomSetting: Boolean;
   {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ��������� ������ ������" }
  function PrintAndExportFontSizeSetting: Integer;
   {* ����� ��� ��������� �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
  procedure WritePrintAndExportFontSizeSetting(aValue: Integer);
   {* ����� ��� ������ �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
 end;//SHevStyles
 
implementation

uses
 l3ImplUses
 , evStyleTableSpy
 , evStylesPrintAndExportSettingRes
 , evStylesPrintAndExportFontSizeSettingRes
 , SysUtils
 , afwFacade
 , afwSettingsChangePublisher
;

type
 TevStylesSettingsListener = class(Tl3ProtoObject)
  {* ��������� evStyles, ������� ������������� � ���������� }
  procedure CheckSubscribe;
   {* ����� ��� �������� ���� �����, ��� TevStylesSettingsListener �������� �� ��������� ����������� �������� }
  function IsSettingAffectsUs(const aSettingId: TafwSettingId): Boolean;
   {* ����� ��� �������� ���� �����, ��� TevStylesSettingsListener �������� ��������� ��������� ��������� }
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TevStylesSettingsListener
 
end.
