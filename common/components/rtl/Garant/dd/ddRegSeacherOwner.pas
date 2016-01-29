unit ddRegSeacherOwner;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddRegSeacherOwner.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::HTMLSupport::TddRegSeacherOwner
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3RegEx,
  k2CustomFileParser
  ;

type
 TddRegSeacherOwner = class(Tk2CustomFileParser)
 private
 // private fields
   f_HREFSearcher : Tl3RegularSearch;
    {* Поле для свойства HREFSearcher}
 private
 // private methods
   procedure InitRegSearcher;
 protected
 // property methods
   function pm_GetHREFSearcher: Tl3RegularSearch;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public properties
   property HREFSearcher: Tl3RegularSearch
     read pm_GetHREFSearcher;
 end;//TddRegSeacherOwner

implementation

uses
  l3Base
  ;

// start class TddRegSeacherOwner

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

function TddRegSeacherOwner.pm_GetHREFSearcher: Tl3RegularSearch;
//#UC START# *52456E6703B3_5245698300DCget_var*
//#UC END# *52456E6703B3_5245698300DCget_var*
begin
//#UC START# *52456E6703B3_5245698300DCget_impl*
 if f_HREFSearcher = nil then InitRegSearcher;
 Result := f_HREFSearcher;
//#UC END# *52456E6703B3_5245698300DCget_impl*
end;//TddRegSeacherOwner.pm_GetHREFSearcher

procedure TddRegSeacherOwner.Cleanup;
//#UC START# *479731C50290_5245698300DC_var*
//#UC END# *479731C50290_5245698300DC_var*
begin
//#UC START# *479731C50290_5245698300DC_impl*
 l3Free(f_HREFSearcher);
 inherited;
//#UC END# *479731C50290_5245698300DC_impl*
end;//TddRegSeacherOwner.Cleanup

end.