unit TextPara;

// Модуль: ""
// Стереотип: "TagOverride"

{$Include eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , TextPara_Const
;

 // TextParaTag
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Nemesis)

end.
