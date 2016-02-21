unit nscTextSource;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscTextSource.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , eeTextSource
;

type
 TnscTextSource = class(TeeTextSource)
 end;//TnscTextSource
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Nemesis)

end.
