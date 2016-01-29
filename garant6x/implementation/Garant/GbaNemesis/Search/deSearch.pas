unit deSearch;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/deSearch.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::SearchLite::Search::Search::TdeSearch
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  SearchUnit,
  l3Interfaces,
  l3SimpleObject,
  SearchInterfaces
  ;

type
 TdeSearch = class(Tl3SimpleObject, IdeSearch)
 private
 // private fields
   f_Tag : Il3CString;
   f_Query : IQuery;
 protected
 // realized methods
   function pm_GetTag: Il3CString;
   function pm_GetQuery: IQuery;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aTag: Il3CString;
    const aQuery: IQuery); reintroduce;
   class function Make(const aTag: Il3CString;
    const aQuery: IQuery): IdeSearch; reintroduce;
   class function Clone(const aSource: IdeSearch): IdeSearch;
 end;//TdeSearch

implementation

// start class TdeSearch

constructor TdeSearch.Create(const aTag: Il3CString;
  const aQuery: IQuery);
//#UC START# *4AE5940C03BE_4AE593970016_var*
//#UC END# *4AE5940C03BE_4AE593970016_var*
begin
//#UC START# *4AE5940C03BE_4AE593970016_impl*
 inherited Create;
 f_Tag := aTag;
 f_Query := aQuery;
//#UC END# *4AE5940C03BE_4AE593970016_impl*
end;//TdeSearch.Create

class function TdeSearch.Make(const aTag: Il3CString;
  const aQuery: IQuery): IdeSearch;
var
 l_Inst : TdeSearch;
begin
 l_Inst := Create(aTag, aQuery);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

class function TdeSearch.Clone(const aSource: IdeSearch): IdeSearch;
//#UC START# *4AE5AA5F0073_4AE593970016_var*
//#UC END# *4AE5AA5F0073_4AE593970016_var*
begin
//#UC START# *4AE5AA5F0073_4AE593970016_impl*
 if Assigned(aSource) then
  Result := Make(aSource.Tag, aSource.Query)
 else
  Result := nil;
//#UC END# *4AE5AA5F0073_4AE593970016_impl*
end;//TdeSearch.Clone

function TdeSearch.pm_GetTag: Il3CString;
//#UC START# *4AE58AA10134_4AE593970016get_var*
//#UC END# *4AE58AA10134_4AE593970016get_var*
begin
//#UC START# *4AE58AA10134_4AE593970016get_impl*
 Result := f_Tag;
//#UC END# *4AE58AA10134_4AE593970016get_impl*
end;//TdeSearch.pm_GetTag

function TdeSearch.pm_GetQuery: IQuery;
//#UC START# *4AE58ABC034A_4AE593970016get_var*
//#UC END# *4AE58ABC034A_4AE593970016get_var*
begin
//#UC START# *4AE58ABC034A_4AE593970016get_impl*
 Result := f_Query;
//#UC END# *4AE58ABC034A_4AE593970016get_impl*
end;//TdeSearch.pm_GetQuery

procedure TdeSearch.Cleanup;
//#UC START# *479731C50290_4AE593970016_var*
//#UC END# *479731C50290_4AE593970016_var*
begin
//#UC START# *479731C50290_4AE593970016_impl*
 f_Tag := nil;
 f_Query := nil;
 inherited Cleanup;
//#UC END# *479731C50290_4AE593970016_impl*
end;//TdeSearch.Cleanup

end.