unit l3CustomRecListView;

// Модуль: "w:\common\components\rtl\Garant\L3\l3CustomRecListView.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3CustomRecListView" MUID: (4DEFC4AE0296)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoPtrRecListPrim
 , l3PureMixIns
 , l3CustomOtherListView
;

type
 PRecForCompare = PItemType;

 _ListType_ = Tl3ProtoPtrRecListPrim;
 _ItemType_ = VOID;
 {$Include w:\common\components\rtl\Garant\L3\l3OtherListView.imp.pas}
 Tl3CustomRecListView = {abstract} class(_l3OtherListView_)
  protected
   function CompareRecs(aRec1: PRecForCompare;
    aRec2: PRecForCompare): Integer; virtual; abstract;
   function CompareData(const anItem1: _ItemType_;
    const anItem2: _ItemType_): Integer; override;
 end;//Tl3CustomRecListView

implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
;

{$Include w:\common\components\rtl\Garant\L3\l3OtherListView.imp.pas}

function Tl3CustomRecListView.CompareData(const anItem1: _ItemType_;
 const anItem2: _ItemType_): Integer;
//#UC START# *4DEFB2D90167_4DEFC4AE0296_var*
//#UC END# *4DEFB2D90167_4DEFC4AE0296_var*
begin
//#UC START# *4DEFB2D90167_4DEFC4AE0296_impl*
 Result := CompareRecs(@anItem1, @anItem2);
//#UC END# *4DEFB2D90167_4DEFC4AE0296_impl*
end;//Tl3CustomRecListView.CompareData

end.
