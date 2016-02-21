unit k2CustomTagView;

// Модуль: "w:\common\components\rtl\Garant\K2\k2CustomTagView.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3Variant
 , l3CustomOtherListView
 , l3PureMixIns
;

 {$Define l3ViewListIsTag}

type
 _ListType_ = Tl3Variant;
 _ItemType_ = Tl3Variant;
 {$Include w:\common\components\rtl\Garant\L3\l3OtherTypedListView.imp.pas}
 Tk2CustomTagView = {abstract} class(_l3OtherTypedListView_)
 end;//Tk2CustomTagView

implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
;

{$Include w:\common\components\rtl\Garant\L3\l3OtherTypedListView.imp.pas}

end.
