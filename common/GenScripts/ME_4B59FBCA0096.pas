unit NOT_FINISHED_ddNSRCGenerator;

// Модуль: "w:\common\components\rtl\Garant\EVD\NOT_FINISHED_ddNSRCGenerator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddNSRCGenerator" MUID: (4B59FBCA0096)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
;

type
 TddNSRCGenerator = {abstract} class
  protected
   {$If Defined(nsTest)}
   procedure SaveObjFileName(const aFileName: AnsiString); virtual;
   {$IfEnd} // Defined(nsTest)
 end;//TddNSRCGenerator

implementation

uses
 l3ImplUses
;

{$If Defined(nsTest)}
procedure TddNSRCGenerator.SaveObjFileName(const aFileName: AnsiString);
//#UC START# *4D70C8250128_4B59FBCA0096_var*
//#UC END# *4D70C8250128_4B59FBCA0096_var*
begin
//#UC START# *4D70C8250128_4B59FBCA0096_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D70C8250128_4B59FBCA0096_impl*
end;//TddNSRCGenerator.SaveObjFileName
{$IfEnd} // Defined(nsTest)

end.
