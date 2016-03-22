unit l3LongintListReverseSorter;
 {* ѕример списка, который сортирует исходный список в обратном пор€дке }

// ћодуль: "w:\common\components\rtl\Garant\L3\l3LongintListReverseSorter.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "Tl3LongintListReverseSorter" MUID: (4DEFC02E01CF)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3CustomLongintListView
 , l3PureMixIns
;

type
 Tl3LongintListReverseSorter = class(Tl3CustomLongintListView)
  {* ѕример списка, который сортирует исходный список в обратном пор€дке }
  protected
   function CompareData(const anItem1: _ItemType_;
    const anItem2: _ItemType_): Integer; override;
 end;//Tl3LongintListReverseSorter

implementation

uses
 l3ImplUses
;

function Tl3LongintListReverseSorter.CompareData(const anItem1: _ItemType_;
 const anItem2: _ItemType_): Integer;
//#UC START# *4DEFB2D90167_4DEFC02E01CF_var*
//#UC END# *4DEFB2D90167_4DEFC02E01CF_var*
begin
//#UC START# *4DEFB2D90167_4DEFC02E01CF_impl*
 Result := (anItem2 - anItem1);
//#UC END# *4DEFB2D90167_4DEFC02E01CF_impl*
end;//Tl3LongintListReverseSorter.CompareData

end.
