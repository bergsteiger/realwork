unit l3ProtoPtrRecList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ProtoPtrRecList.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3RecListWithPartialFind
 , l3Types
;

type
 Tl3ProtoPtrRecList = class(Tl3RecListWithPartialFind)
  private
   f_SortIndex: Tl3SortIndex;
  protected
   procedure InitFields; override;
   function DoGetSortIndex: Tl3SortIndex; override;
   procedure DoSetSortIndex(Value: Tl3SortIndex); override;
 end;//Tl3ProtoPtrRecList

implementation

uses
 l3ImplUses
;

procedure Tl3ProtoPtrRecList.InitFields;
//#UC START# *47A042E100E2_479DF9D50043_var*
//#UC END# *47A042E100E2_479DF9D50043_var*
begin
//#UC START# *47A042E100E2_479DF9D50043_impl*
 inherited;
 f_SortIndex := l3_siUnsorted;
//#UC END# *47A042E100E2_479DF9D50043_impl*
end;//Tl3ProtoPtrRecList.InitFields

function Tl3ProtoPtrRecList.DoGetSortIndex: Tl3SortIndex;
//#UC START# *47B9841B03AD_479DF9D50043_var*
//#UC END# *47B9841B03AD_479DF9D50043_var*
begin
//#UC START# *47B9841B03AD_479DF9D50043_impl*
 Result := f_SortIndex;
//#UC END# *47B9841B03AD_479DF9D50043_impl*
end;//Tl3ProtoPtrRecList.DoGetSortIndex

procedure Tl3ProtoPtrRecList.DoSetSortIndex(Value: Tl3SortIndex);
//#UC START# *47B9843903DB_479DF9D50043_var*
//#UC END# *47B9843903DB_479DF9D50043_var*
begin
//#UC START# *47B9843903DB_479DF9D50043_impl*
 f_SortIndex := Value;
//#UC END# *47B9843903DB_479DF9D50043_impl*
end;//Tl3ProtoPtrRecList.DoSetSortIndex

end.
