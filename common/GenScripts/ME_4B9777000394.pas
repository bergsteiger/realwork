unit vcmToolbarMenuRes;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmToolbarMenuRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "vcmToolbarMenuRes" MUID: (4B9777000394)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3StringIDEx
 , afwInterfaces
 , l3Interfaces
;

const
 {* Локализуемые строки vcmIconSize }
 str_vcmgsAutomatic: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmgsAutomatic'; rValue : 'Автоматически');
  {* 'Автоматически' }
 str_vcmgs16x16: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmgs16x16'; rValue : 'Маленькие');
  {* 'Маленькие' }
 str_vcmgs24x24: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmgs24x24'; rValue : 'Средние');
  {* 'Средние' }
 str_vcmgs32x32: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'vcmgs32x32'; rValue : 'Большие');
  {* 'Большие' }

type
 TvcmGlyphSize = (
  vcm_gsAutomatic
  , vcm_gs16x16
  , vcm_gs24x24
  , vcm_gs32x32
 );//TvcmGlyphSize

 vcmIconSizeMapHelper = {final} class
  {* Утилитный класс для преобразования значений vcmIconSizeMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* Заполнение списка строк значениями }
   class function DisplayNameToValue(const aDisplayName: Il3CString): TvcmGlyphSize;
    {* Преобразование строкового значения к порядковому }
 end;//vcmIconSizeMapHelper

const
 {* Карта преобразования локализованных строк vcmIconSize }
 vcmIconSizeMap: array [TvcmGlyphSize] of Pl3StringIDEx = (
 @str_vcmgsAutomatic
 , @str_vcmgs16x16
 , @str_vcmgs24x24
 , @str_vcmgs32x32
 );
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3MessageID
 , l3String
 , SysUtils
;

class procedure vcmIconSizeMapHelper.FillStrings(const aStrings: IafwStrings);
 {* Заполнение списка строк значениями }
var
 l_Index: TvcmGlyphSize;
begin
 aStrings.Clear;
 for l_Index := Low(l_Index) to High(l_Index) do
  aStrings.Add(vcmIconSizeMap[l_Index].AsCStr);
end;//vcmIconSizeMapHelper.FillStrings

class function vcmIconSizeMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): TvcmGlyphSize;
 {* Преобразование строкового значения к порядковому }
var
 l_Index: TvcmGlyphSize;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  if l3Same(aDisplayName, vcmIconSizeMap[l_Index].AsCStr) then
  begin
   Result := l_Index;
   Exit;
  end;//l3Same..
 raise Exception.CreateFmt('Display name "%s" not found in map "vcmIconSizeMap"', [l3Str(aDisplayName)]);
end;//vcmIconSizeMapHelper.DisplayNameToValue

initialization
 str_vcmgsAutomatic.Init;
 {* Инициализация str_vcmgsAutomatic }
 str_vcmgs16x16.Init;
 {* Инициализация str_vcmgs16x16 }
 str_vcmgs24x24.Init;
 {* Инициализация str_vcmgs24x24 }
 str_vcmgs32x32.Init;
 {* Инициализация str_vcmgs32x32 }
{$IfEnd} // NOT Defined(NoVCM)

end.
