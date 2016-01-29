unit evStyleHeaderAdder;

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , k2Base
 , l3Variant
;

type
 TevStyleHeaderAdder = class(TevdLeafParaFilter)
  {* Фильтр, доклеивающий заголовок стиля перед параграфом
http://mdp.garant.ru/pages/viewpage.action?pageId=278837126 }
 end;//TevStyleHeaderAdder
 
implementation

uses
 l3ImplUses
 , evTextStyle_Const
 , TextPara_Const
 , k2Tags
 , l3String
 , l3Types
 , nevTools
 , evParaTools
;

end.
