unit List_Module;

interface

uses
 l3IntfUses
;

type
 TListModule = class
  {* ������ }
  function ListPrintAndExportDefaultSetting: Boolean;
   {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ������ ������, ������������� �� ������" }
  function ListPrintAndExportCustomSetting: Boolean;
   {* ����� ��� ��������� �������� ��������� "������ � �������"."������������ ��� �������� � ������ ��������� ������ ������" }
  function ListPrintAndExportFontSizeSetting: Integer;
   {* ����� ��� ��������� �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
  procedure WriteListPrintAndExportFontSizeSetting(aValue: Integer);
   {* ����� ��� ������ �������� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
 end;//TListModule
 
implementation

uses
 l3ImplUses
 , ListPrintAndExportSettingRes
 , ListPrintAndExportFontSizeSettingRes
 , stListPrintAndExportFontSizeItem
 , afwFacade
;

end.
