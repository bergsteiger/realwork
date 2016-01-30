unit TextPara;

// Модуль: ""
// Стереотип: "TagOverride"

{$Include evDefine.inc}

interface

{$If Defined(Archi)}
uses
 l3IntfUses
 , TextPara_Const
;

 // TextParaTag
{$IfEnd} // Defined(Archi)

implementation

{$If Defined(Archi)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Archi)

end.
