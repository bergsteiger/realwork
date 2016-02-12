unit k2TagList;

// Модуль: "w:\common\components\rtl\Garant\K2\k2TagList.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

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
;

type _Instance_R_ = Tk2TagList;

{$Include w:\common\components\rtl\Garant\K2\k2TagByIntegerSearcher.imp.pas}

end.
