unit ddRegSeacherOwner;

// Модуль: "w:\common\components\rtl\Garant\dd\ddRegSeacherOwner.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , k2CustomFileParser
 , l3RegEx
;

type
 TddRegSeacherOwner = class(Tk2CustomFileParser)
  private
   f_HREFSearcher: Tl3RegularSearch;
    {* Поле для свойства HREFSearcher }
  private
   procedure InitRegSearcher;
  protected
   function pm_GetHREFSearcher: Tl3RegularSearch;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   property HREFSearcher: Tl3RegularSearch
    read pm_GetHREFSearcher;
 end;//TddRegSeacherOwner

implementation

uses
 l3ImplUses
 , l3Base
;

function TddRegSeacherOwner.pm_GetHREFSearcher: Tl3RegularSearch;
//#UC START# *52456E6703B3_5245698300DCget_var*
//#UC END# *52456E6703B3_5245698300DCget_var*
begin
//#UC START# *52456E6703B3_5245698300DCget_impl*
 if f_HREFSearcher = nil then InitRegSearcher;
 Result := f_HREFSearcher;
//#UC END# *52456E6703B3_5245698300DCget_impl*
end;//TddRegSeacherOwner.pm_GetHREFSearcher

procedure TddRegSeacherOwner.InitRegSearcher;
//#UC START# *52456E7802FA_5245698300DC_var*
const
 carSearcPattern: AnsiString = ('^garantf1:\/\/{\d+}\.?{\-?\d*}\/$');
var
 l_Search: Tl3RegularSearch;
//#UC END# *52456E7802FA_5245698300DC_var*
begin
//#UC START# *52456E7802FA_5245698300DC_impl*
 l_Search := Tl3RegularSearch.Create;
 l_Search.IgnoreCase := True;
 l_Search.SearchPattern := carSearcPattern;
 f_HREFSearcher := l_Search;
//#UC END# *52456E7802FA_5245698300DC_impl*
end;//TddRegSeacherOwner.InitRegSearcher

procedure TddRegSeacherOwner.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5245698300DC_var*
//#UC END# *479731C50290_5245698300DC_var*
begin
//#UC START# *479731C50290_5245698300DC_impl*
 l3Free(f_HREFSearcher);
 inherited;
//#UC END# *479731C50290_5245698300DC_impl*
end;//TddRegSeacherOwner.Cleanup

end.
