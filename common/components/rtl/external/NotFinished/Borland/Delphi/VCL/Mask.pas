unit Mask;

// Модуль: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Vcl\Mask.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "Mask" MUID: (52A9ADB60286)

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
 , StdCtrls
;

type
 TCustomMaskEdit = class(TCustomEdit)
  protected
   {$If Defined(l3HackedVCL) AND NOT Defined(DesignTimeLibrary)}
   function TextFromClipboard: AnsiString; virtual;
   {$IfEnd} // Defined(l3HackedVCL) AND NOT Defined(DesignTimeLibrary)
 end;//TCustomMaskEdit
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If Defined(l3HackedVCL) AND NOT Defined(DesignTimeLibrary)}
function TCustomMaskEdit.TextFromClipboard: AnsiString;
//#UC START# *554CBB4B0240_52A9ADCB0092_var*
//#UC END# *554CBB4B0240_52A9ADCB0092_var*
begin
//#UC START# *554CBB4B0240_52A9ADCB0092_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CBB4B0240_52A9ADCB0092_impl*
end;//TCustomMaskEdit.TextFromClipboard
{$IfEnd} // Defined(l3HackedVCL) AND NOT Defined(DesignTimeLibrary)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCustomMaskEdit);
 {* Регистрация TCustomMaskEdit }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
