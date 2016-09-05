unit MakeCORunner;

// Модуль: "w:\common\components\MakeCO\MakeCORunner.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TMakeCORunner" MUID: (55C1F539010F)

{$Include w:\common\components\MakeCO\MakeCO.inc}

interface

uses
 l3IntfUses
;

type
 TMakeCORunner = {final} class
  public
   class procedure Run;
 end;//TMakeCORunner

implementation

uses
 l3ImplUses
 , tfwCOMaker
 , SysUtils
 //#UC START# *55C1F539010Fimpl_uses*
 //#UC END# *55C1F539010Fimpl_uses*
;

class procedure TMakeCORunner.Run;
//#UC START# *55C1F54A0327_55C1F539010F_var*
//#UC END# *55C1F54A0327_55C1F539010F_var*
begin
//#UC START# *55C1F54A0327_55C1F539010F_impl*
 try
  TtfwCOMaker.Make(ParamStr(1));
 except
  on E: Exception do
   WriteLn(E.Message);
 end;//try..except
//#UC END# *55C1F54A0327_55C1F539010F_impl*
end;//TMakeCORunner.Run

end.
