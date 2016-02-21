unit NOT_FINISHED_nscInterfaces;

// Модуль: "w:\common\components\gui\Garant\Nemesis\NOT_FINISHED_nscInterfaces.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
;

type
 InscArrangeGrid = interface
  ['{CF244F53-75D1-4817-816B-B9E5E9E51FD0}']
 end;//InscArrangeGrid

 InscTabTable = interface
  ['{511A2195-53E3-4933-8061-D46C12DF9B13}']
 end;//InscTabTable
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Nemesis)

end.
