unit evCommonTypes;

// Модуль: "w:\common\components\gui\Garant\EverestCommon\evCommonTypes.pas"
// Стереотип: "Interfaces"
// Элемент модели: "evCommonTypes" MUID: (48EEE9330072)

{$Include w:\common\components\gui\Garant\EverestCommon\evDefine.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , k2Interfaces
 , nevBase
 , nevTools
 , nevInternalInterfaces
 , evdInterfaces
 , k2CustomReader
 , l3Variant
;

type
 TevGenerator = InevTagGenerator;

 TevCustomFileReader = Tk2CustomReader;

 TnevCustomUndoBuffer = Ik2UndoBuffer;

 TnevLocation = InevLocation;

 TnevCursor = InevBasePoint;

 TnevBaseCursor = InevBasePoint;

 InevCommonPoint = InevBasePoint;

 TnevIRange = InevRange;

 TnevBlock = InevRange;

 InevTagSelection = InevRange;

 IevCommonDataObject = IevdDataObject;

 TevFileReader = Tk2CustomReader;

 InevRange = nevTools.InevRange;

 InevPointTool = InevPoint;

 InevSelection = nevTools.InevSelection;

implementation

uses
 l3ImplUses
;

end.
