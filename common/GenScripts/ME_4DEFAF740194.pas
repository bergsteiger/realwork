unit l3CustomOtherListView;

// Модуль: "w:\common\components\rtl\Garant\L3\l3CustomOtherListView.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3CustomSortIntegerList
;

type
 //#UC START# *4DEFAF2300F9ci*
 Tl3CustomOtherListView = class;
 //#UC END# *4DEFAF2300F9ci*
 //#UC START# *4DEFAF2300F9cit*
 //#UC END# *4DEFAF2300F9cit*
 Tl3OtherListSorter = class(Tl3CustomSortIntegerList)
  private
   f_View: Tl3CustomOtherListView;
  protected
   function CompareItems(A: Integer;
    B: Integer): Integer; override;
    {* Функция сравнения элементов }
  public
   constructor Create(aView: Tl3CustomOtherListView); reintroduce;
 //#UC START# *4DEFAF2300F9publ*
 //#UC END# *4DEFAF2300F9publ*
 end;//Tl3OtherListSorter

 Tl3CustomOtherListView = {abstract} class(Tl3ProtoObject)
  protected
   f_Sorter: Tl3OtherListSorter;
  protected
   function CompareItems(anIndex1: Integer;
    anIndex2: Integer): Integer; virtual; abstract;
   function OtherListCount: Integer; virtual; abstract;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   procedure Sort;
 end;//Tl3CustomOtherListView

implementation

uses
 l3ImplUses
 , SysUtils
;

constructor Tl3OtherListSorter.Create(aView: Tl3CustomOtherListView);
//#UC START# *4DEFB06A0296_4DEFAF2300F9_var*
//#UC END# *4DEFB06A0296_4DEFAF2300F9_var*
begin
//#UC START# *4DEFB06A0296_4DEFAF2300F9_impl*
 inherited Create;
 f_View := aView;
//#UC END# *4DEFB06A0296_4DEFAF2300F9_impl*
end;//Tl3OtherListSorter.Create

function Tl3OtherListSorter.CompareItems(A: Integer;
 B: Integer): Integer;
 {* Функция сравнения элементов }
//#UC START# *4DEFACE1002D_4DEFAF2300F9_var*
//#UC END# *4DEFACE1002D_4DEFAF2300F9_var*
begin
//#UC START# *4DEFACE1002D_4DEFAF2300F9_impl*
 Result := f_View.CompareItems(A, B);
//#UC END# *4DEFACE1002D_4DEFAF2300F9_impl*
end;//Tl3OtherListSorter.CompareItems

//#UC START# *4DEFAF2300F9impl*
//#UC END# *4DEFAF2300F9impl*

procedure Tl3CustomOtherListView.Sort;
//#UC START# *4DEFB88B038D_4DEFAF740194_var*
var
 l_Index : Integer;
//#UC END# *4DEFB88B038D_4DEFAF740194_var*
begin
//#UC START# *4DEFB88B038D_4DEFAF740194_impl*
 if (f_Sorter = nil) then
  f_Sorter := Tl3OtherListSorter.Create(Self)
 else
  f_Sorter.Clear;
 for l_Index := 0 to Pred(OtherListCount) do
  f_Sorter.Add(l_Index);
  // - добавляем индексы и в итоге получаем их в нужном порядке
//#UC END# *4DEFB88B038D_4DEFAF740194_impl*
end;//Tl3CustomOtherListView.Sort

procedure Tl3CustomOtherListView.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4DEFAF740194_var*
//#UC END# *479731C50290_4DEFAF740194_var*
begin
//#UC START# *479731C50290_4DEFAF740194_impl*
 if (f_Sorter <> nil) then
  f_Sorter.f_View := nil;
 FreeAndNil(f_Sorter);
 inherited;
//#UC END# *479731C50290_4DEFAF740194_impl*
end;//Tl3CustomOtherListView.Cleanup

procedure Tl3CustomOtherListView.InitFields;
//#UC START# *47A042E100E2_4DEFAF740194_var*
//#UC END# *47A042E100E2_4DEFAF740194_var*
begin
//#UC START# *47A042E100E2_4DEFAF740194_impl*
 inherited;
 Sort;
//#UC END# *47A042E100E2_4DEFAF740194_impl*
end;//Tl3CustomOtherListView.InitFields

end.
