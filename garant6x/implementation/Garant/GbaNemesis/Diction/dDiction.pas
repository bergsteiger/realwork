unit dDiction;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Diction"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Diction/dDiction.pas"
// Начат: 12.07.2006
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Diction::Diction::Diction::TdDiction
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3InterfaceList,
  bsTypes,
  DictionInterfaces,
  DynamicTreeUnit,
  CommonDictionInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  l3Types,
  BaseDocumentWithAttributesInterfaces,
  DocumentAndListInterfaces,
  DocumentInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObject
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _IvcmRealData_ = IdDiction;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\dCommonDiction.imp.pas}
 TdDiction = class(_dCommonDiction_, IdDiction)
 private
 // private fields
   f_IsShowLiteratureList : Boolean;
   f_Languages : TbsLanguages;
   f_ContextMap : InsLangToContextMap;
   f_refTranslationList : Tl3InterfaceList;
    {* Поле для свойства refTranslationList}
 private
 // private methods
   procedure SetRefTranslationCount(aValue: Integer);
 protected
 // property methods
   function pm_GetRefTranslationList: Tl3InterfaceList;
 protected
 // realized methods
   function pm_GetLanguages: TbsLanguages;
   procedure pm_SetLanguages(aValue: TbsLanguages);
   function pm_GetRefTranslation(aIndex: Integer): IvcmFormDataSourceRef;
   function pm_GetRefTranslationCount: Integer;
   function pm_GetIsShowLiteratureList: Boolean;
   procedure pm_SetIsShowLiteratureList(aValue: Boolean);
   function pm_GetContextMap: InsLangToContextMap;
   procedure pm_SetContextMap(const aValue: InsLangToContextMap);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If not defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} //not NoVCM
 public
 // public methods
   class function Make: IdDiction; reintroduce;
 protected
 // protected properties
   property refTranslationList: Tl3InterfaceList
     read pm_GetRefTranslationList;
 end;//TdDiction
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmFormDataSourceRef
  {$IfEnd} //not NoVCM
  ,
  SysUtils,
  BaseTypesUnit,
  l3Utils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdDiction;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\dCommonDiction.imp.pas}

// start class TdDiction

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
end;

function TdDiction.pm_GetRefTranslationList: Tl3InterfaceList;
//#UC START# *4B19106100BA_4936CCA700F0get_var*
//#UC END# *4B19106100BA_4936CCA700F0get_var*
begin
//#UC START# *4B19106100BA_4936CCA700F0get_impl*
 if (f_refTranslationList = nil) then
  f_refTranslationList := Tl3InterfaceList.Make;
 Result := f_refTranslationList;
//#UC END# *4B19106100BA_4936CCA700F0get_impl*
end;//TdDiction.pm_GetRefTranslationList

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

function TdDiction.pm_GetRefTranslation(aIndex: Integer): IvcmFormDataSourceRef;
//#UC START# *49527E60023F_4936CCA700F0get_var*
//#UC END# *49527E60023F_4936CCA700F0get_var*
begin
//#UC START# *49527E60023F_4936CCA700F0get_impl*
 Supports(refTranslationList.Items[aIndex], IvcmFormDataSourceRef, Result);
//#UC END# *49527E60023F_4936CCA700F0get_impl*
end;//TdDiction.pm_GetRefTranslation

function TdDiction.pm_GetRefTranslationCount: Integer;
//#UC START# *49527E84009B_4936CCA700F0get_var*
//#UC END# *49527E84009B_4936CCA700F0get_var*
begin
//#UC START# *49527E84009B_4936CCA700F0get_impl*
 Result := refTranslationList.Count;
//#UC END# *49527E84009B_4936CCA700F0get_impl*
end;//TdDiction.pm_GetRefTranslationCount

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

{$If not defined(NoVCM)}
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
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.