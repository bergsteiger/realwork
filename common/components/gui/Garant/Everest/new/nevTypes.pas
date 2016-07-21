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
 TnevParaIndex = Integer;

 TnevParaLevel = Integer;

 TnevInch = Integer;

 TevLoadFlag = (
  ev_lfInternal
  , ev_lfNeedJoin
  , ev_lfAtEnd
  , ev_lfSkipSubdocuments
 );//TevLoadFlag

implementation

uses
 l3ImplUses
;

end.
