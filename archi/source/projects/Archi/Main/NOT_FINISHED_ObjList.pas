unit NOT_FINISHED_ObjList;

// Модуль: "w:\archi\source\projects\Archi\Main\NOT_FINISHED_ObjList.pas"
// Стереотип: "UtilityPack"

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
;
{$IfEnd} // Defined(AppClientSide)

end.
