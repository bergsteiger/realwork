unit tfwAxiomaticsResNameGetter;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwAxiomaticsResNameGetter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwAxiomaticsResNameGetter" MUID: (55B7A33101AF)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;

type
 RtfwAxiomaticsResNameGetter = class of TtfwAxiomaticsResNameGetter;

 TtfwAxiomaticsResNameGetter = class
  public
   class function ResName: AnsiString; virtual; abstract;
   class procedure Register;
 end;//TtfwAxiomaticsResNameGetter
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwAxiomaticsResNameGetters
;

class procedure TtfwAxiomaticsResNameGetter.Register;
//#UC START# *55B8C6800184_55B7A33101AF_var*
//#UC END# *55B8C6800184_55B7A33101AF_var*
begin
//#UC START# *55B8C6800184_55B7A33101AF_impl*
 if (TtfwAxiomaticsResNameGetters.Instance.IndexOf(Self) < 0) then
  TtfwAxiomaticsResNameGetters.Instance.Add(Self);
//#UC END# *55B8C6800184_55B7A33101AF_impl*
end;//TtfwAxiomaticsResNameGetter.Register
{$IfEnd} // NOT Defined(NoScripts)

end.
