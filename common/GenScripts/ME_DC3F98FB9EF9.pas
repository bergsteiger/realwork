unit stListPrintAndExportFontSizeItem;

interface

uses
 l3IntfUses
 , ddAppConfigTypes
;

type
 TstListPrintAndExportFontSizeItem = class(TddComboBoxConfigItem)
  {* ������������ ��� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
  procedure Create(aMasterItem: TddBaseConfigItem);
 end;//TstListPrintAndExportFontSizeItem
 
implementation

uses
 l3ImplUses
 , ListPrintAndExportFontSizeSettingRes
 , l3Base
 , ddAppConfigConst
;

end.
