unit NOT_FINISHED_ObjList;

// Модуль: "w:\archi\source\projects\Archi\Main\NOT_FINISHED_ObjList.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ObjList" MUID: (4F0C09DA02DE)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
;

type
 TDragDataType = (
  ddNone
  , ddDragObj
  , ddHyperLink
  , ddBackHyperLink
  , ddDoc
  , ddSrchObj
  , ddSrchID
  , ddDictItem
  , ddMailDocLink
 );//TDragDataType
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 //#UC START# *4F0C09DA02DEimpl_uses*
 //#UC END# *4F0C09DA02DEimpl_uses*
;
{$IfEnd} // Defined(AppClientSide)

end.
