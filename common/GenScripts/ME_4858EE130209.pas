unit arList_Const;

// Модуль: "w:\common\components\gui\Garant\Everest\arList_Const.pas"
// Стереотип: "Tag"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(Archi)}
uses
 l3IntfUses
 , k2Tag_Const
 , k2IUnknown_Const
;

 // ListTag
{$IfEnd} // Defined(Archi)

implementation

{$If Defined(Archi)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Archi)

end.
