unit TextStyle;

// Модуль: ""
// Стереотип: "TagOverride"

{$Include evDefine.inc}

interface

{$If Defined(Archi)}
uses
 l3IntfUses
;

 // TextStyleTag
{$IfEnd} // Defined(Archi)

implementation

{$If Defined(Archi)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Archi)

end.
