unit evCommonTypes;

// Модуль: "w:\common\components\gui\Garant\EverestCommon\evCommonTypes.pas"
// Стереотип: "Interfaces"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , nevBase
 , k2CustomReader
 , l3Variant
 , nevTools
 , evdInterfaces
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
