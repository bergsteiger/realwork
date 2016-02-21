unit l3CustomLongintListView;

// Модуль: "w:\common\components\rtl\Garant\L3\l3CustomLongintListView.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3LongintList
 , l3CustomOtherListView
 , l3PureMixIns
;

type
 _ListType_ = Tl3LongintList;
 _ItemType_ = Integer;
 {$Include w:\common\components\rtl\Garant\L3\l3OtherTypedListView.imp.pas}
 Tl3CustomLongintListView = {abstract} class(_l3OtherTypedListView_)
 end;//Tl3CustomLongintListView

implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
;

{$Include w:\common\components\rtl\Garant\L3\l3OtherTypedListView.imp.pas}

end.
