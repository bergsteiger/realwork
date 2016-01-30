unit kwStringArray;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwStringArray.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwStringListPrim
;

type
 _l3OpenArray_Parent_ = TkwStringListPrim;
 {$Include l3OpenArray.imp.pas}
 TkwStringArray = class(_l3OpenArray_)
 end;//TkwStringArray
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
;

type _Instance_R_ = TkwStringArray;

{$Include l3OpenArray.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
