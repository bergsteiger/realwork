unit tfwConst;
 {* Поддержка констант. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwConst.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwConstLike
 , tfwScriptingInterfaces
;

type
 TtfwConst = {abstract} class(TtfwConstLike)
  {* Поддержка констант. }
  protected
   function AcceptsKeyWordAfter(const aContext: TtfwContext;
    aWordNumber: Integer): Boolean; override;
 end;//TtfwConst
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function TtfwConst.AcceptsKeyWordAfter(const aContext: TtfwContext;
 aWordNumber: Integer): Boolean;
//#UC START# *4DB9B502013D_4DBFC3520093_var*
//#UC END# *4DB9B502013D_4DBFC3520093_var*
begin
//#UC START# *4DB9B502013D_4DBFC3520093_impl*
 //Result := false;
 Result := true;
 // - специально так сделано, чтобы можно было написать CONST XXX true
//#UC END# *4DB9B502013D_4DBFC3520093_impl*
end;//TtfwConst.AcceptsKeyWordAfter

initialization
 TtfwConst.RegisterClass;
 {* Регистрация TtfwConst }
{$IfEnd} // NOT Defined(NoScripts)

end.
