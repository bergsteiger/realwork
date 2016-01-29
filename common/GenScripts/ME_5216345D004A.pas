unit Document_Module;

interface

uses
 l3IntfUses
;

type
 TDocumentModule = class
  {* �������� }
  function DocumentPrintAndExportDefaultSetting: Boolean;
   {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
  function DocumentPrintAndExportCustomSetting: Boolean;
   {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ��������� ������ ������" }
  function DocumentPrintAndExportFontSizeSetting: Integer;
   {* ����� ��� ��������� �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
  procedure WriteDocumentPrintAndExportFontSizeSetting(aValue: Integer);
   {* ����� ��� ������ �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
 end;//TDocumentModule
 
implementation

uses
 l3ImplUses
 , DocumentPrintAndExportSettingRes
 , DocumentPrintAndExportFontSizeSettingRes
 , stDocumentPrintAndExportFontSizeItem
 , afwFacade
;

end.
