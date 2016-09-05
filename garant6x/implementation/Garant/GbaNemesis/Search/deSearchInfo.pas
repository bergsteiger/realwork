unit deSearchInfo;
 {* Информация о запросе }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\deSearchInfo.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdeSearchInfo" MUID: (491D718A00A9)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3ProtoObject
 , PrimPrimListInterfaces
 , l3Interfaces
 , DynamicDocListUnit
;

type
 TdeSearchInfo = class(Tl3ProtoObject, IdeSearchInfo)
  {* Информация о запросе }
  private
   f_NeedApplyPermanentFilters: Boolean;
   f_QueryInfo: Il3CString;
  protected
   function pm_GetNeedApplyPermanentFilters: Boolean;
   function pm_GetQueryInfo: Il3CString;
   procedure ClearFields; override;
  public
   constructor Create(const aList: IDynList;
    aNeedApplyPermanentFilters: Boolean); reintroduce;
   class function Make(const aList: IDynList;
    aNeedApplyPermanentFilters: Boolean): IdeSearchInfo; reintroduce;
 end;//TdeSearchInfo
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , bsUtils
 //#UC START# *491D718A00A9impl_uses*
 //#UC END# *491D718A00A9impl_uses*
;

constructor TdeSearchInfo.Create(const aList: IDynList;
 aNeedApplyPermanentFilters: Boolean);
//#UC START# *4B1E67780224_491D718A00A9_var*
//#UC END# *4B1E67780224_491D718A00A9_var*
begin
//#UC START# *4B1E67780224_491D718A00A9_impl*
 inherited Create;
 f_QueryInfo := bsListName(aList);
 f_NeedApplyPermanentFilters := aNeedApplyPermanentFilters;
//#UC END# *4B1E67780224_491D718A00A9_impl*
end;//TdeSearchInfo.Create

class function TdeSearchInfo.Make(const aList: IDynList;
 aNeedApplyPermanentFilters: Boolean): IdeSearchInfo;
var
 l_Inst : TdeSearchInfo;
begin
 l_Inst := Create(aList, aNeedApplyPermanentFilters);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdeSearchInfo.Make

function TdeSearchInfo.pm_GetNeedApplyPermanentFilters: Boolean;
//#UC START# *4B1D0ED601F5_491D718A00A9get_var*
//#UC END# *4B1D0ED601F5_491D718A00A9get_var*
begin
//#UC START# *4B1D0ED601F5_491D718A00A9get_impl*
 Result := f_NeedApplyPermanentFilters;
//#UC END# *4B1D0ED601F5_491D718A00A9get_impl*
end;//TdeSearchInfo.pm_GetNeedApplyPermanentFilters

function TdeSearchInfo.pm_GetQueryInfo: Il3CString;
//#UC START# *4B1D0F290136_491D718A00A9get_var*
//#UC END# *4B1D0F290136_491D718A00A9get_var*
begin
//#UC START# *4B1D0F290136_491D718A00A9get_impl*
 Result := f_QueryInfo;
//#UC END# *4B1D0F290136_491D718A00A9get_impl*
end;//TdeSearchInfo.pm_GetQueryInfo

procedure TdeSearchInfo.ClearFields;
begin
 f_QueryInfo := nil;
 inherited;
end;//TdeSearchInfo.ClearFields
{$IfEnd} // NOT Defined(Admin)

end.
