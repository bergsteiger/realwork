unit stevStylesPrintAndExportFontSizeItem;

interface

uses
 l3IntfUses
 , ddAppConfigTypes
;

type
 TstevStylesPrintAndExportFontSizeItem = class(TddComboBoxConfigItem)
  {* ������������ ��� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
  procedure Create(aMasterItem: TddBaseConfigItem);
 end;//TstevStylesPrintAndExportFontSizeItem
 
implementation

uses
 l3ImplUses
 , evStylesPrintAndExportFontSizeSettingRes
 , l3Base
 , ddAppConfigConst
;

end.
