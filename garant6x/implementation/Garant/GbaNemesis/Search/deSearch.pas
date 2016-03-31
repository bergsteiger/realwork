unit deSearch;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\deSearch.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdeSearch" MUID: (4AE593970016)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3SimpleObject
 , SearchInterfaces
 , l3Interfaces
 , SearchUnit
;

type
 TdeSearch = class(Tl3SimpleObject, IdeSearch)
  private
   f_Tag: Il3CString;
   f_Query: IQuery;
  protected
   function pm_GetTag: Il3CString;
   function pm_GetQuery: IQuery;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aTag: Il3CString;
    const aQuery: IQuery); reintroduce;
   class function Make(const aTag: Il3CString;
    const aQuery: IQuery): IdeSearch; reintroduce;
   class function Clone(const aSource: IdeSearch): IdeSearch;
 end;//TdeSearch

implementation

uses
 l3ImplUses
;

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
end;//TdeSearch.Make

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
 {* Функция очистки полей объекта. }
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
