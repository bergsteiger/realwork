unit msmEditViewUtils;

// Модуль: "w:\common\components\gui\Garant\msm\msmEditViewUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "msmEditViewUtils" MUID: (5810C59F0109)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
;

type
 TmsmEditViewInitContext = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rDisabled: Boolean;
   rReadOnly: Boolean;
 end;//TmsmEditViewInitContext

function TmsmEditViewInitContext_C: TmsmEditViewInitContext;

implementation

uses
 l3ImplUses
 //#UC START# *5810C59F0109impl_uses*
 //#UC END# *5810C59F0109impl_uses*
;

function TmsmEditViewInitContext_C: TmsmEditViewInitContext;
//#UC START# *5810C5F70254_5810C5BF0218_var*
//#UC END# *5810C5F70254_5810C5BF0218_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *5810C5F70254_5810C5BF0218_impl*
 Result.rDisabled := false;
 Result.rReadOnly := false;
//#UC END# *5810C5F70254_5810C5BF0218_impl*
end;//TmsmEditViewInitContext_C

end.
