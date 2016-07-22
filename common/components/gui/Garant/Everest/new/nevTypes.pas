unit nevTypes;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevTypes.pas"
// Стереотип: "Interfaces"
// Элемент модели: "nevTypes" MUID: (578F62050180)

{$Include w:\common\components\gui\Garant\Everest\new\nevDefine.inc}

interface

uses
 l3IntfUses
;

type
 TnevParaIndex = type Integer;

 TnevParaLevel = type Integer;

 TnevInch = type Integer;

 TevLoadFlag = (
  ev_lfInternal
  , ev_lfNeedJoin
  , ev_lfAtEnd
  , ev_lfSkipSubdocuments
 );//TevLoadFlag

 TevInsertParaFlag = (
  ev_ipfCheckPrev
  , ev_ipfNeedFire
  , ev_ipfForce
  , ev_ipfAtEnd
 );//TevInsertParaFlag

 TevInsertParaFlags = set of TevInsertParaFlag;

implementation

uses
 l3ImplUses
;

end.
