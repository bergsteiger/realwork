unit DecorTextPara;

// Модуль: ""
// Стереотип: "TagOverride"

{$Include eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , DecorTextPara_Const
 , f1TextStyle_Const
;

 // DecorTextParaTag
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Nemesis)

end.
