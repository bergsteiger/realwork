unit l3OldInterfaceIDs;

// Модуль: "w:\common\components\rtl\Garant\L3\l3OldInterfaceIDs.pas"
// Стереотип: "Interfaces"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3IID
;

const
 ev_iidCursor: Tl3IID = (IID: 0);
  {* курсор объекта }
 ev_iidBlock: Tl3IID = (IID: 1);
  {* выделение части объекта }

implementation

uses
 l3ImplUses
;

end.
