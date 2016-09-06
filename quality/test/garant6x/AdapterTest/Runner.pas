unit Runner;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Runner.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TRunner" MUID: (4DE8C9DB02AD)

interface

uses
 l3IntfUses
;

type
 TRunner = class
  public
   class procedure Run;
 end;//TRunner

implementation

uses
 l3ImplUses
 , atAdapterTest
 , SysUtils
 , ActiveX
 {$If Defined(Nemesis)}
 , eeDocument_Schema
 {$IfEnd} // Defined(Nemesis)
 //#UC START# *4DE8C9DB02ADimpl_uses*
 //#UC END# *4DE8C9DB02ADimpl_uses*
;

class procedure TRunner.Run;
//#UC START# *4DE8CA530214_4DE8C9DB02AD_var*
var
  Test : TatAdapterTest;
//#UC END# *4DE8CA530214_4DE8C9DB02AD_var*
begin
//#UC START# *4DE8CA530214_4DE8C9DB02AD_impl*
  CoInitialize(nil);
  try
   Test := TatAdapterTest.Create;
   try
    Test.Start;
   finally
    FreeAndNil(Test);
   end;//try..finally
  finally
    CoUninitialize;
  end;//try..finally
//#UC END# *4DE8CA530214_4DE8C9DB02AD_impl*
end;//TRunner.Run

end.
