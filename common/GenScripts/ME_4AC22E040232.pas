unit OldTreeInterfaces;
 {* Интерфейсы для работы со старыми деревьями }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Model\OldTreeInterfaces.pas"
// Стереотип: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3Interfaces
;

type
 InsWrapperNode = interface
  {* описывает общее для объектов оберток адаптерных интерфейсов поведение }
  ['{056B6F80-4891-4D37-AA3B-0979EC152427}']
  function pm_GetName: Tl3WString;
  procedure pm_SetName(const aValue: Tl3WString);
  function pm_GetComment: Tl3WString;
  procedure pm_SetComment(const aValue: Tl3WString);
  property Name: Tl3WString
   read pm_GetName
   write pm_SetName;
  property Comment: Tl3WString
   read pm_GetComment
   write pm_SetComment;
 end;//InsWrapperNode
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin)

end.
