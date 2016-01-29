unit deSelectedAttributes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/deSelectedAttributes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Common For Shell And Monitoring::Search::Search::Search::TdeSelectedAttributes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  l3Interfaces,
  SearchInterfaces,
  deSearch
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TdeSelectedAttributes = class(TdeSearch, IdeSelectedAttributes)
 private
 // private fields
   f_RefreshValues : InsSelectedAttributesIterators;
 protected
 // realized methods
   function Get_RefreshValues: InsSelectedAttributesIterators;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aRefreshValues: InsSelectedAttributesIterators;
    const aTag: Il3CString); reintroduce;
   class function Make(const aRefreshValues: InsSelectedAttributesIterators;
    const aTag: Il3CString): IdeSelectedAttributes; reintroduce;
 end;//TdeSelectedAttributes
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}

// start class TdeSelectedAttributes

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
end;

function TdeSelectedAttributes.Get_RefreshValues: InsSelectedAttributesIterators;
//#UC START# *4AE58AE200AC_4AE593B30288get_var*
//#UC END# *4AE58AE200AC_4AE593B30288get_var*
begin
//#UC START# *4AE58AE200AC_4AE593B30288get_impl*
 Result := f_RefreshValues;
//#UC END# *4AE58AE200AC_4AE593B30288get_impl*
end;//TdeSelectedAttributes.Get_RefreshValues

procedure TdeSelectedAttributes.Cleanup;
//#UC START# *479731C50290_4AE593B30288_var*
//#UC END# *479731C50290_4AE593B30288_var*
begin
//#UC START# *479731C50290_4AE593B30288_impl*
 f_RefreshValues := nil;
 inherited;
//#UC END# *479731C50290_4AE593B30288_impl*
end;//TdeSelectedAttributes.Cleanup

{$IfEnd} //not Admin

end.