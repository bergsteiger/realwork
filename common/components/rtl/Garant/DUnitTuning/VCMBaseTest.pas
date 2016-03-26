unit VCMBaseTest;

// Модуль: "w:\common\components\rtl\Garant\DUnitTuning\VCMBaseTest.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "VCMBaseTest" MUID: (4B3235370235)

{$Include w:\common\components\rtl\Garant\DUnitTuning\tfwDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , BaseTest
;

type
 TVCMBaseTest = {abstract} class(TBaseTest)
  {* Базовый тест для тестирования объектов VCM }
  protected
   procedure InitFields; override;
 end;//TVCMBaseTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3Base
 , SysUtils
 , l3MenuManagerHelper
;

procedure FreeMM;
//#UC START# *4B323587024D_4B3235370235_var*
//#UC END# *4B323587024D_4B3235370235_var*
begin
//#UC START# *4B323587024D_4B3235370235_impl*
 if Tl3MenuManagerHelper.Exists then
  Tl3MenuManagerHelper.Instance.FreeManager;
//#UC END# *4B323587024D_4B3235370235_impl*
end;//FreeMM

procedure TVCMBaseTest.InitFields;
//#UC START# *4B30EEA10210_4B30EEEB01EF_var*
//#UC END# *4B30EEA10210_4B30EEEB01EF_var*
begin
//#UC START# *4B30EEA10210_4B30EEEB01EF_impl*
 inherited;
 if Tl3MenuManagerHelper.Instance.CreateManager then
  l3System.AddExitProc(FreeMM);
//#UC END# *4B30EEA10210_4B30EEEB01EF_impl*
end;//TVCMBaseTest.InitFields
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
