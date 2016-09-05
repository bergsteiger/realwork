unit k2NotStructuredTag;

// Модуль: "w:\common\components\rtl\Garant\K2\k2NotStructuredTag.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2NotStructuredTag" MUID: (533E8F8D0334)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2Tag
 , l3Variant
;

type
 Tk2NotStructuredTag = {abstract} class(Tk2Tag, Il3TagRef)
  protected
   function GetAsRef: Il3TagRef; override;
 end;//Tk2NotStructuredTag

implementation

uses
 l3ImplUses
 , k2NullTagImpl
 //#UC START# *533E8F8D0334impl_uses*
 //#UC END# *533E8F8D0334impl_uses*
;

function Tk2NotStructuredTag.GetAsRef: Il3TagRef;
//#UC START# *53568FCA01E8_533E8F8D0334_var*
//#UC END# *53568FCA01E8_533E8F8D0334_var*
begin
//#UC START# *53568FCA01E8_533E8F8D0334_impl*
 Result := Self;
//#UC END# *53568FCA01E8_533E8F8D0334_impl*
end;//Tk2NotStructuredTag.GetAsRef

end.
