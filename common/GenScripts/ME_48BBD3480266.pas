unit afwCustomCommonTextControlPrim;

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\Visual\afwCustomCommonTextControlPrim.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , afwTextControl
 , l3InternalInterfaces
;

type
 TafwCustomCommonTextControlPrim = class(TafwTextControl)
  protected
   procedure DoPaint; virtual; abstract;
   procedure Paint(const CN: Il3Canvas); override;
    {* процедура рисования внешнего вида управляющего элемента }
 end;//TafwCustomCommonTextControlPrim

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TafwCustomCommonTextControlPrim.Paint(const CN: Il3Canvas);
 {* процедура рисования внешнего вида управляющего элемента }
//#UC START# *48C6C044025E_48BBD3480266_var*
//#UC END# *48C6C044025E_48BBD3480266_var*
begin
//#UC START# *48C6C044025E_48BBD3480266_impl*
 inherited;
 DoPaint;
//#UC END# *48C6C044025E_48BBD3480266_impl*
end;//TafwCustomCommonTextControlPrim.Paint

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TafwCustomCommonTextControlPrim);
 {* Регистрация TafwCustomCommonTextControlPrim }
{$IfEnd} // NOT Defined(NoScripts)

end.
