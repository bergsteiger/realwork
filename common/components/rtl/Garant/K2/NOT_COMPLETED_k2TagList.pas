unit NOT_COMPLETED_k2TagList;

// Модуль: "w:\common\components\rtl\Garant\K2\NOT_COMPLETED_k2TagList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2TagList" MUID: (47B9D76B0301)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2TagListPrim
 , l3Types
;

type
 _k2TagByIntegerSearcher_Parent_ = Tk2TagListPrim;
 {$Include w:\common\components\rtl\Garant\K2\k2TagByIntegerSearcher.imp.pas}
 Tk2TagList = class(_k2TagByIntegerSearcher_)
 end;//Tk2TagList

implementation

uses
 l3ImplUses
 , l3Base
 , l3Variant
 , l3Memory
;

type _Instance_R_ = Tk2TagList;

{$Include w:\common\components\rtl\Garant\K2\k2TagByIntegerSearcher.imp.pas}

end.
