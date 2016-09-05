unit stevStylesPrintAndExportFontSizeItem;
 {* ������������ ��� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }

// ������: "w:\common\components\rtl\Garant\dd\stevStylesPrintAndExportFontSizeItem.pas"
// ���������: "SimpleClass"
// ������� ������: "TstevStylesPrintAndExportFontSizeItem" MUID: (DF1A3014EEBC)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddAppConfigTypes
;

type
 TstevStylesPrintAndExportFontSizeItem = class(TddComboBoxConfigItem)
  {* ������������ ��� ��������� "������������ ��� �������� � ������ ��������� ������ ������" }
  public
   constructor Create(aMasterItem: TddBaseConfigItem = nil); reintroduce;
 end;//TstevStylesPrintAndExportFontSizeItem

implementation

uses
 l3ImplUses
 , evStylesPrintAndExportFontSizeSettingRes
 , l3Base
 , ddAppConfigConst
 //#UC START# *DF1A3014EEBCimpl_uses*
 //#UC END# *DF1A3014EEBCimpl_uses*
;

constructor TstevStylesPrintAndExportFontSizeItem.Create(aMasterItem: TddBaseConfigItem = nil);
var
 l_Value : TddConfigValue;
begin
 l3FillChar(l_Value, SizeOf(l_Value));
 l_Value.Kind := dd_vkInteger;
 l_Value.AsInteger := dv_evStyles_PrintAndExportFontSize;
 inherited Create(pi_evStyles_PrintAndExportFontSize,
  str_PrintAndExportFontSize.AsStr,
  l_Value, TPrintAndExportFontSizeValuesMapImpl.Make, aMasterItem);
end;//TstevStylesPrintAndExportFontSizeItem.Create

end.
