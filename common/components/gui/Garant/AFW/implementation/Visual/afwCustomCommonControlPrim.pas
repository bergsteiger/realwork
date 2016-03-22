unit afwCustomCommonControlPrim;

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\Visual\afwCustomCommonControlPrim.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TafwCustomCommonControlPrim" MUID: (48BBE35E039F)

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , afwControl
 , l3InternalInterfaces
;

type
 TafwCustomCommonControlPrim = class(TafwControl)
  protected
   procedure DoPaint; virtual; abstract;
   procedure Paint(const CN: Il3Canvas); override;
    {* процедура рисования внешнего вида управляющего элемента }
 end;//TafwCustomCommonControlPrim

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TafwCustomCommonControlPrim.Paint(const CN: Il3Canvas);
 {* процедура рисования внешнего вида управляющего элемента }
//#UC START# *48C6C044025E_48BBE35E039F_var*
//#UC END# *48C6C044025E_48BBE35E039F_var*
begin
//#UC START# *48C6C044025E_48BBE35E039F_impl*
 DoPaint;
//#UC END# *48C6C044025E_48BBE35E039F_impl*
end;//TafwCustomCommonControlPrim.Paint

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TafwCustomCommonControlPrim);
 {* Регистрация TafwCustomCommonControlPrim }
{$IfEnd} // NOT Defined(NoScripts)

end.
