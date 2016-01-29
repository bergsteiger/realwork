unit evdTextToFirstParaAdder;

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , l3Interfaces
 , k2Interfaces
 , l3Variant
;

type
 TevdTextToFirstParaAdder = class(TevdLeafParaFilter)
  {* ‘ильтр, добавл€ющий текст к первому параграфу }
  function SetTo(var theGenerator: Ik2TagGenerator;
   const aText: Il3CString): Ik2TagGenerator;
  procedure Create(const aText: Il3CString);
 end;//TevdTextToFirstParaAdder
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3CustomString
 , HyperLink_Const
 , evdTypes
 , l3String
 , l3Types
 , SysUtils
;

end.
