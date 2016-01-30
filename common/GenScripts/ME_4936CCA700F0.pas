unit dDiction;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Diction\dDiction.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DictionInterfaces
 , l3InterfaceList
 , bsTypes
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , CommonDictionInterfaces
 , DynamicTreeUnit
 , BaseDocumentWithAttributesInterfaces
 , l3Types
 , DocumentAndListInterfaces
 , DocumentInterfaces
 , l3ProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _IvcmRealData_ = IdDiction;
 {$Include dCommonDiction.imp.pas}
 TdDiction = class(_dCommonDiction_, IdDiction)
  private
   f_IsShowLiteratureList: Boolean;
   f_Languages: TbsLanguages;
   f_ContextMap: InsLangToContextMap;
   f_refTranslationList: Tl3InterfaceList;
    {* Поле для свойства refTranslationList }
  private
   procedure SetRefTranslationCount(aValue: Integer);
  protected
   function pm_GetrefTranslationList: Tl3InterfaceList;
   function pm_GetLanguages: TbsLanguages;
   procedure pm_SetLanguages(aValue: TbsLanguages);
   function pm_GetrefTranslation(aIndex: Integer): IvcmFormDataSourceRef;
   function pm_GetrefTranslationCount: Integer;
   function pm_GetIsShowLiteratureList: Boolean;
   procedure pm_SetIsShowLiteratureList(aValue: Boolean);
   function pm_GetContextMap: InsLangToContextMap;
   procedure pm_SetContextMap(const aValue: InsLangToContextMap);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make: IdDiction; reintroduce;
  protected
   property refTranslationList: Tl3InterfaceList
    read pm_GetrefTranslationList;
 end;//TdDiction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , BaseTypesUnit
 {$If NOT Defined(NoVCM)}
 , vcmFormDataSourceRef
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Utils
;

type _Instance_R_ = TdDiction;

{$Include dCommonDiction.imp.pas}

function TdDiction.pm_GetrefTranslationList: Tl3InterfaceList;
//#UC START# *4B19106100BA_4936CCA700F0get_var*
//#UC END# *4B19106100BA_4936CCA700F0get_var*
begin
//#UC START# *4B19106100BA_4936CCA700F0get_impl*
 if (f_refTranslationList = nil) then
  f_refTranslationList := Tl3InterfaceList.Make;
 Result := f_refTranslationList;
//#UC END# *4B19106100BA_4936CCA700F0get_impl*
end;//TdDiction.pm_GetrefTranslationList

class function TdDiction.Make: IdDiction;
var
 l_Inst : TdDiction;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdDiction.Make

procedure TdDiction.SetRefTranslationCount(aValue: Integer);
//#UC START# *4B1913DE00A8_4936CCA700F0_var*
var
 l_Index: Integer;
//#UC END# *4B1913DE00A8_4936CCA700F0_var*
begin
//#UC START# *4B1913DE00A8_4936CCA700F0_impl*
 refTranslationList.Clear;
 for l_Index := 0 to Pred(aValue) do
  refTranslationList.Add(TvcmFormDataSourceRef.Make);
//#UC END# *4B1913DE00A8_4936CCA700F0_impl*
end;//TdDiction.SetRefTranslationCount

function TdDiction.pm_GetLanguages: TbsLanguages;
//#UC START# *49527E380287_4936CCA700F0get_var*
//#UC END# *49527E380287_4936CCA700F0get_var*
begin
//#UC START# *49527E380287_4936CCA700F0get_impl*
 Result := f_Languages;
//#UC END# *49527E380287_4936CCA700F0get_impl*
end;//TdDiction.pm_GetLanguages

procedure TdDiction.pm_SetLanguages(aValue: TbsLanguages);
//#UC START# *49527E380287_4936CCA700F0set_var*
//#UC END# *49527E380287_4936CCA700F0set_var*
begin
//#UC START# *49527E380287_4936CCA700F0set_impl*
 f_Languages := aValue;
//#UC END# *49527E380287_4936CCA700F0set_impl*
end;//TdDiction.pm_SetLanguages

function TdDiction.pm_GetrefTranslation(aIndex: Integer): IvcmFormDataSourceRef;
//#UC START# *49527E60023F_4936CCA700F0get_var*
//#UC END# *49527E60023F_4936CCA700F0get_var*
begin
//#UC START# *49527E60023F_4936CCA700F0get_impl*
 Supports(refTranslationList.Items[aIndex], IvcmFormDataSourceRef, Result);
//#UC END# *49527E60023F_4936CCA700F0get_impl*
end;//TdDiction.pm_GetrefTranslation

function TdDiction.pm_GetrefTranslationCount: Integer;
//#UC START# *49527E84009B_4936CCA700F0get_var*
//#UC END# *49527E84009B_4936CCA700F0get_var*
begin
//#UC START# *49527E84009B_4936CCA700F0get_impl*
 Result := refTranslationList.Count;
//#UC END# *49527E84009B_4936CCA700F0get_impl*
end;//TdDiction.pm_GetrefTranslationCount

function TdDiction.pm_GetIsShowLiteratureList: Boolean;
//#UC START# *49527E930015_4936CCA700F0get_var*
//#UC END# *49527E930015_4936CCA700F0get_var*
begin
//#UC START# *49527E930015_4936CCA700F0get_impl*
 Result := f_IsShowLiteratureList;
//#UC END# *49527E930015_4936CCA700F0get_impl*
end;//TdDiction.pm_GetIsShowLiteratureList

procedure TdDiction.pm_SetIsShowLiteratureList(aValue: Boolean);
//#UC START# *49527E930015_4936CCA700F0set_var*
//#UC END# *49527E930015_4936CCA700F0set_var*
begin
//#UC START# *49527E930015_4936CCA700F0set_impl*
 f_IsShowLiteratureList := aValue;
//#UC END# *49527E930015_4936CCA700F0set_impl*
end;//TdDiction.pm_SetIsShowLiteratureList

function TdDiction.pm_GetContextMap: InsLangToContextMap;
//#UC START# *52D7CF420184_4936CCA700F0get_var*
//#UC END# *52D7CF420184_4936CCA700F0get_var*
begin
//#UC START# *52D7CF420184_4936CCA700F0get_impl*
 Result := f_ContextMap;
//#UC END# *52D7CF420184_4936CCA700F0get_impl*
end;//TdDiction.pm_GetContextMap

procedure TdDiction.pm_SetContextMap(const aValue: InsLangToContextMap);
//#UC START# *52D7CF420184_4936CCA700F0set_var*
//#UC END# *52D7CF420184_4936CCA700F0set_var*
begin
//#UC START# *52D7CF420184_4936CCA700F0set_impl*
 f_ContextMap := aValue;
//#UC END# *52D7CF420184_4936CCA700F0set_impl*
end;//TdDiction.pm_SetContextMap

procedure TdDiction.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4936CCA700F0_var*
//#UC END# *479731C50290_4936CCA700F0_var*
begin
//#UC START# *479731C50290_4936CCA700F0_impl*
 FreeAndNil(f_refTranslationList);
 f_ContextMap := nil;
 inherited;
//#UC END# *479731C50290_4936CCA700F0_impl*
end;//TdDiction.Cleanup

procedure TdDiction.InitFields;
//#UC START# *47A042E100E2_4936CCA700F0_var*
//#UC END# *47A042E100E2_4936CCA700F0_var*
begin
//#UC START# *47A042E100E2_4936CCA700F0_impl*
 inherited;
 SetRefTranslationCount(Succ(Ord(High(BaseTypesUnit.TLanguages))));
//#UC END# *47A042E100E2_4936CCA700F0_impl*
end;//TdDiction.InitFields

{$If NOT Defined(NoVCM)}
procedure TdDiction.AssignData(const aData: _IvcmRealData_);
//#UC START# *4B16B8CF0307_4936CCA700F0_var*
var
 l_Index   : Integer;
//#UC END# *4B16B8CF0307_4936CCA700F0_var*
begin
//#UC START# *4B16B8CF0307_4936CCA700F0_impl*
 inherited;
 f_Languages := aData.Languages;
 f_ContextMap := aData.ContextMap;
 SetRefTranslationCount(aData.refTranslationCount);
 for l_Index := 0 to Pred(aData.refTranslationCount) do
  pm_GetRefTranslation(l_Index).Assign(aData.refTranslation[l_Index]);
 f_IsShowLiteratureList := aData.IsShowLiteratureList;
//#UC END# *4B16B8CF0307_4936CCA700F0_impl*
end;//TdDiction.AssignData
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
