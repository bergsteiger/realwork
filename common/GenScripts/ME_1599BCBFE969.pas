unit stDocumentPrintAndExportFontSizeItem;

interface

uses
 l3IntfUses
 , ddAppConfigTypes
;

type
 TstDocumentPrintAndExportFontSizeItem = class(TddComboBoxConfigItem)
  {* ������������ ��� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
  procedure Create(aMasterItem: TddBaseConfigItem);
 end;//TstDocumentPrintAndExportFontSizeItem
 
implementation

uses
 l3ImplUses
 , DocumentPrintAndExportFontSizeSettingRes
 , l3Base
 , ddAppConfigConst
;

end.
