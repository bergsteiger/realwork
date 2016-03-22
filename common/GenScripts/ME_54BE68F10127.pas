unit DecorTextPara;

// Модуль: ""
// Стереотип: "TagOverride"
// Элемент модели: "DecorTextPara" MUID: (54BE68F10127)
// Имя типа: "DecorTextParaTag"

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
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
