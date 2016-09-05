unit deSelectedAttributes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\deSelectedAttributes.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdeSelectedAttributes" MUID: (4AE593B30288)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , deSearch
 , SearchInterfaces
 , l3Interfaces
;

type
 TdeSelectedAttributes = class(TdeSearch, IdeSelectedAttributes)
  private
   f_RefreshValues: InsSelectedAttributesIterators;
  protected
   function Get_RefreshValues: InsSelectedAttributesIterators;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aRefreshValues: InsSelectedAttributesIterators;
    const aTag: Il3CString); reintroduce;
   class function Make(const aRefreshValues: InsSelectedAttributesIterators;
    const aTag: Il3CString): IdeSelectedAttributes; reintroduce;
 end;//TdeSelectedAttributes
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 //#UC START# *4AE593B30288impl_uses*
 //#UC END# *4AE593B30288impl_uses*
;

constructor TdeSelectedAttributes.Create(const aRefreshValues: InsSelectedAttributesIterators;
 const aTag: Il3CString);
//#UC START# *4AE594B200A2_4AE593B30288_var*
//#UC END# *4AE594B200A2_4AE593B30288_var*
begin
//#UC START# *4AE594B200A2_4AE593B30288_impl*
 inherited Create(aTag, nil);
 f_RefreshValues := aRefreshValues;
//#UC END# *4AE594B200A2_4AE593B30288_impl*
end;//TdeSelectedAttributes.Create

class function TdeSelectedAttributes.Make(const aRefreshValues: InsSelectedAttributesIterators;
 const aTag: Il3CString): IdeSelectedAttributes;
var
 l_Inst : TdeSelectedAttributes;
begin
 l_Inst := Create(aRefreshValues, aTag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdeSelectedAttributes.Make

function TdeSelectedAttributes.Get_RefreshValues: InsSelectedAttributesIterators;
//#UC START# *4AE58AE200AC_4AE593B30288get_var*
//#UC END# *4AE58AE200AC_4AE593B30288get_var*
begin
//#UC START# *4AE58AE200AC_4AE593B30288get_impl*
 Result := f_RefreshValues;
//#UC END# *4AE58AE200AC_4AE593B30288get_impl*
end;//TdeSelectedAttributes.Get_RefreshValues

procedure TdeSelectedAttributes.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AE593B30288_var*
//#UC END# *479731C50290_4AE593B30288_var*
begin
//#UC START# *479731C50290_4AE593B30288_impl*
 f_RefreshValues := nil;
 inherited;
//#UC END# *479731C50290_4AE593B30288_impl*
end;//TdeSelectedAttributes.Cleanup
{$IfEnd} // NOT Defined(Admin)

end.
