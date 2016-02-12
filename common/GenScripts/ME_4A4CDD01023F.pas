unit atListHelper;

// ћодуль: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atListHelper.pas"
// —тереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , BaseTypesUnit
 , DynamicDocListUnit
 , DynamicTreeUnit
 , l3_Base
;

const
 SON_ASCENDING = 'по возрастанию';
 SON_DESCENDING = 'по убыванию';
 STN_CREATE_DATE = 'по дате издани€';
 STN_LAST_EDIT_DATE = 'по дате последнего изменени€';
 STN_PRIORITY = 'по юридической силе';
 STN_RELEVANCE = 'по релевантности';
 STN_NOT_SORTED = 'не сортирован';

type
 _EntityInterface_ = IDynList;
 {$Include w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atEntityWithName.imp.pas}
 TatList = class(_atEntityWithName_)
  private
   f_Root: INodeBase;
    {* ѕоле дл€ свойства Root }
  protected
   function pm_GetHistory: AnsiString;
   function pm_GetRoot: INodeBase;
   function pm_GetFirstElement: INodeBase;
   procedure ClearFields; override;
  public
   property History: AnsiString
    read pm_GetHistory;
   property Root: INodeBase
    read pm_GetRoot;
   property FirstElement: INodeBase
    read pm_GetFirstElement;
 end;//TatList

 TatListHelper = class
  public
   class function ST2Str(const aSortType: TSortType): AnsiString; virtual;
   class function Str2ST(const aStr: AnsiString;
    out theSortType: TSortType): Boolean; virtual;
   class function SO2Str(const aSortOrder: TSortOrder): AnsiString; virtual;
   class function Str2SO(const aStr: AnsiString;
    out theSortOrder: TSortOrder): Boolean; virtual;
   class function IsCanBeSortedBy(const aList: IDynList;
    const aSortType: TSortType): Boolean; virtual;
   class procedure LoadList(const aList: IDynList;
    const aNodesCount: Integer); virtual;
 end;//TatListHelper

implementation

uses
 l3ImplUses
 , SysUtils
 , atNodeHelper
 , atStringHelper
 , StrUtils
 , IOUnit
;

{$Include w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atEntityWithName.imp.pas}

function TatList.pm_GetHistory: AnsiString;
//#UC START# *5051E5520315_4FD24A98029Fget_var*
  const
    SUBSTR = '_title">';
  var
    l_Str : IString;
    i : Integer;
//#UC END# *5051E5520315_4FD24A98029Fget_var*
begin
//#UC START# *5051E5520315_4FD24A98029Fget_impl*
  Entity.GetHistory(l_Str);
  Result := TatStringHelper.AStr2DStr(l_Str);
  //
  Result := AnsiReplaceText(Result, '</pre>', '');
  Result := AnsiReplaceText(Result, '<pre class="rqname">', '');
  Result := AnsiReplaceText(Result, '</span>', '');
  Result := AnsiReplaceText(Result, '</space>', '');
  Result := AnsiReplaceText(Result, '<pre class="space">', '');
  Result := AnsiReplaceText(Result, '<pre class="rqval">', #9);
  i := Pos(SUBSTR, Result);
  if i <> 0 then
    Delete(Result, 1, i - 1 + Length(SUBSTR));
  Result := Trim(Result);
//#UC END# *5051E5520315_4FD24A98029Fget_impl*
end;//TatList.pm_GetHistory

function TatList.pm_GetRoot: INodeBase;
//#UC START# *5051E87C0078_4FD24A98029Fget_var*
//#UC END# *5051E87C0078_4FD24A98029Fget_var*
begin
//#UC START# *5051E87C0078_4FD24A98029Fget_impl*
  if NOT Assigned(f_Root) then
    Entity.GetRoot(f_Root);
  Result := f_Root;  
//#UC END# *5051E87C0078_4FD24A98029Fget_impl*
end;//TatList.pm_GetRoot

function TatList.pm_GetFirstElement: INodeBase;
//#UC START# *5051E8E7028C_4FD24A98029Fget_var*
//#UC END# *5051E8E7028C_4FD24A98029Fget_var*
begin
//#UC START# *5051E8E7028C_4FD24A98029Fget_impl*
  Root.GetFirstChild(Result);
//#UC END# *5051E8E7028C_4FD24A98029Fget_impl*
end;//TatList.pm_GetFirstElement

procedure TatList.ClearFields;
begin
 f_Root := nil;
 inherited;
end;//TatList.ClearFields

class function TatListHelper.ST2Str(const aSortType: TSortType): AnsiString;
//#UC START# *4A4CDE0A001A_4A4CDD01023F_var*
//#UC END# *4A4CDE0A001A_4A4CDD01023F_var*
begin
//#UC START# *4A4CDE0A001A_4A4CDD01023F_impl*
  case aSortType of
    ST_PRIORITY       : Result := STN_PRIORITY;
    ST_CREATE_DATE    : Result := STN_CREATE_DATE;
    ST_LAST_EDIT_DATE : Result := STN_LAST_EDIT_DATE;
    ST_NOT_SORTED     : Result := STN_NOT_SORTED;
    ST_RELEVANCE      : Result := STN_RELEVANCE;
  end;
//#UC END# *4A4CDE0A001A_4A4CDD01023F_impl*
end;//TatListHelper.ST2Str

class function TatListHelper.Str2ST(const aStr: AnsiString;
 out theSortType: TSortType): Boolean;
//#UC START# *4A4CDE1F03C0_4A4CDD01023F_var*
//#UC END# *4A4CDE1F03C0_4A4CDD01023F_var*
begin
//#UC START# *4A4CDE1F03C0_4A4CDD01023F_impl*
  Result := true;
  if AnsiSameText(aStr, STN_CREATE_DATE) then theSortType := ST_CREATE_DATE
  else if AnsiSameText(aStr, STN_LAST_EDIT_DATE) then theSortType := ST_LAST_EDIT_DATE
  else if AnsiSameText(aStr, STN_PRIORITY) then theSortType := ST_PRIORITY
  else if AnsiSameText(aStr, STN_RELEVANCE) then theSortType := ST_RELEVANCE
  else if AnsiSameText(aStr, STN_NOT_SORTED) then theSortType := ST_NOT_SORTED
  else Result := false;
//#UC END# *4A4CDE1F03C0_4A4CDD01023F_impl*
end;//TatListHelper.Str2ST

class function TatListHelper.SO2Str(const aSortOrder: TSortOrder): AnsiString;
//#UC START# *4A4CDE34010F_4A4CDD01023F_var*
//#UC END# *4A4CDE34010F_4A4CDD01023F_var*
begin
//#UC START# *4A4CDE34010F_4A4CDD01023F_impl*
  case aSortOrder of
    SO_ASCENDING  : Result := SON_ASCENDING;
    SO_DESCENDING : Result := SON_DESCENDING;
  end;
//#UC END# *4A4CDE34010F_4A4CDD01023F_impl*
end;//TatListHelper.SO2Str

class function TatListHelper.Str2SO(const aStr: AnsiString;
 out theSortOrder: TSortOrder): Boolean;
//#UC START# *4A4CDE4B033B_4A4CDD01023F_var*
//#UC END# *4A4CDE4B033B_4A4CDD01023F_var*
begin
//#UC START# *4A4CDE4B033B_4A4CDD01023F_impl*
  Result := true;
  if AnsiSameText(aStr, SON_ASCENDING) then theSortOrder := SO_ASCENDING
  else if AnsiSameText(aStr, SON_DESCENDING) then theSortOrder := SO_DESCENDING
  else Result := false;
//#UC END# *4A4CDE4B033B_4A4CDD01023F_impl*
end;//TatListHelper.Str2SO

class function TatListHelper.IsCanBeSortedBy(const aList: IDynList;
 const aSortType: TSortType): Boolean;
//#UC START# *4A4CDEEE00C0_4A4CDD01023F_var*
  var
    l_SortTypes : ISortTypes;
    i : integer;
//#UC END# *4A4CDEEE00C0_4A4CDD01023F_var*
begin
//#UC START# *4A4CDEEE00C0_4A4CDD01023F_impl*
  Result := false;
  aList.GetAvailableSortTypes(l_SortTypes);
  Assert(l_SortTypes <> nil, 'l_SortTypes <> nil');
  i := 0;
  while ((i < l_SortTypes.Count) AND (NOT Result)) do
  begin
    Result := l_SortTypes.Items[i] = aSortType;
    Inc(i);
  end;
//#UC END# *4A4CDEEE00C0_4A4CDD01023F_impl*
end;//TatListHelper.IsCanBeSortedBy

class procedure TatListHelper.LoadList(const aList: IDynList;
 const aNodesCount: Integer);
//#UC START# *4A4DE6530114_4A4CDD01023F_var*
  var
    l_Root : INodeBase;
//#UC END# *4A4DE6530114_4A4CDD01023F_var*
begin
//#UC START# *4A4DE6530114_4A4CDD01023F_impl*
  aList.GetRoot(l_Root);
  TatNodeHelper.LoadNodes(l_Root, 0, aNodesCount, TatNodeCallbacks.CallNodeCaption);
//#UC END# *4A4DE6530114_4A4CDD01023F_impl*
end;//TatListHelper.LoadList

end.
