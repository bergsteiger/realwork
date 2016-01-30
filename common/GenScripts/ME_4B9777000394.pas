unit vcmToolbarMenuRes;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmToolbarMenuRes.pas"
// Стереотип: "UtilityPack"

{$Include vcmDefine.inc}

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
 {* Карта преобразования локализованных строк vcmIconSize }
 Automatic: Pl3StringIDEx = str_vcmgsAutomatic;
 16x16: Pl3StringIDEx = str_vcmgs16x16;
 24x24: Pl3StringIDEx = str_vcmgs24x24;
 32x32: Pl3StringIDEx = str_vcmgs32x32;

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
//#UC START# *FB88C9F59624_6882EB48F231_var*
//#UC END# *FB88C9F59624_6882EB48F231_var*
begin
//#UC START# *FB88C9F59624_6882EB48F231_impl*
 !!! Needs to be implemented !!!
//#UC END# *FB88C9F59624_6882EB48F231_impl*
end;//vcmIconSizeMapHelper.FillStrings

class function vcmIconSizeMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): TvcmGlyphSize;
 {* Преобразование строкового значения к порядковому }
//#UC START# *BC56D7E589F8_6882EB48F231_var*
//#UC END# *BC56D7E589F8_6882EB48F231_var*
begin
//#UC START# *BC56D7E589F8_6882EB48F231_impl*
 !!! Needs to be implemented !!!
//#UC END# *BC56D7E589F8_6882EB48F231_impl*
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
