unit dsDiction;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Diction"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Diction/dsDiction.pas"
// Начат: 2005/10/07 17:03:27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Встроенные продукты::Diction::Diction::Diction::TdsDiction
//
// перевод толкового словаря на сборку
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
  bsTypes,
  DictionInterfaces,
  DocumentUnit,
  DynamicTreeUnit,
  l3TreeInterfaces
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  DocumentAndListInterfaces,
  CommonDictionInterfaces,
  DocumentInterfaces,
  l3InternalInterfaces,
  bsInterfaces
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  vcmControllers {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsDiction;
 _InitDataType_ = IdeDiction;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\dsCommonDiction.imp.pas}
 TdsDiction = {final vac} class(_dsCommonDiction_, IdsDiction)
  {* перевод толкового словаря на сборку }
 private
 // private fields
   dDiction : IdDiction;
   f_ContextMap : InsLangToContextMap;
   ucc_Diction : IsdsDiction;
   f_Language : TbsLanguage;
    {* Поле для свойства Language}
 protected

  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // realized methods
   function MakeSimpleTree: Il3SimpleTree; override;
     {* Создать данные дерева }
   function MakeDocInfoForCurrentChanged(const aDoc: IDocument): IdeDocInfo; override;
   function pm_GetLanguage: TbsLanguage;
   procedure pm_SetLanguage(aValue: TbsLanguage);
   function pm_GetContextMap: InsLangToContextMap;
   procedure pm_SetContextMap(const aValue: InsLangToContextMap);
   function pm_GetDictionKind: TnsDictionKind; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   procedure FormSetDataChanged; override;
   {$IfEnd} //not NoVCM
   procedure AfterChangeCurrent; override;
   {$If not defined(NoVCM)}
   procedure GotData; override;
     {* - данные изменились. }
   {$IfEnd} //not NoVCM
   function ForceChangeInCurrentChanged: Boolean; override;
    {$If not defined(NoVCM)}
   function GetIsDataAvailable: Boolean; override;
     {* существуют ли данные }
    {$IfEnd} //not NoVCM
 private
 // private properties
   property Language: TbsLanguage
     read f_Language
     write f_Language;
 end;//TdsDiction
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils,
  deDiction,
  nsLangToContextMap,
  DataAdapter,
  BaseTypesUnit,
  l3Base,
  vtUtils,
  vtStdRes,
  nsNewCachableNode,
  Windows,
  l3InterfacesMisc
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsDiction;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\dsCommonDiction.imp.pas}

// start class TdsDiction

function TdsDiction.MakeSimpleTree: Il3SimpleTree;
//#UC START# *47F4C2B9014A_4925526600D0_var*
//#UC END# *47F4C2B9014A_4925526600D0_var*
begin
//#UC START# *47F4C2B9014A_4925526600D0_impl*
 Result := nil;
 // Читаем http://mdp.garant.ru/pages/viewpage.action?pageId=135605187
//#UC END# *47F4C2B9014A_4925526600D0_impl*
end;//TdsDiction.MakeSimpleTree

function TdsDiction.MakeDocInfoForCurrentChanged(const aDoc: IDocument): IdeDocInfo;
//#UC START# *49254515003C_4925526600D0_var*
//#UC END# *49254515003C_4925526600D0_var*
begin
//#UC START# *49254515003C_4925526600D0_impl*
 Result := TdeDiction.Make(aDoc, Language, pm_GetContextMap);
//#UC END# *49254515003C_4925526600D0_impl*
end;//TdsDiction.MakeDocInfoForCurrentChanged

function TdsDiction.pm_GetLanguage: TbsLanguage;
//#UC START# *49254FF103A4_4925526600D0get_var*
//#UC END# *49254FF103A4_4925526600D0get_var*
begin
//#UC START# *49254FF103A4_4925526600D0get_impl*
 Result := f_Language;
//#UC END# *49254FF103A4_4925526600D0get_impl*
end;//TdsDiction.pm_GetLanguage

procedure TdsDiction.pm_SetLanguage(aValue: TbsLanguage);
//#UC START# *49254FF103A4_4925526600D0set_var*
//#UC END# *49254FF103A4_4925526600D0set_var*
begin
//#UC START# *49254FF103A4_4925526600D0set_impl*
 f_Language := aValue;
//#UC END# *49254FF103A4_4925526600D0set_impl*
end;//TdsDiction.pm_SetLanguage

function TdsDiction.pm_GetContextMap: InsLangToContextMap;
//#UC START# *52D3BECC00A6_4925526600D0get_var*
//#UC END# *52D3BECC00A6_4925526600D0get_var*
begin
//#UC START# *52D3BECC00A6_4925526600D0get_impl*
 if (f_ContextMap = nil) then
  f_ContextMap := TnsLangToContextMap.Make(nil);
 Result := f_ContextMap;
//#UC END# *52D3BECC00A6_4925526600D0get_impl*
end;//TdsDiction.pm_GetContextMap

procedure TdsDiction.pm_SetContextMap(const aValue: InsLangToContextMap);
//#UC START# *52D3BECC00A6_4925526600D0set_var*
//#UC END# *52D3BECC00A6_4925526600D0set_var*
begin
//#UC START# *52D3BECC00A6_4925526600D0set_impl*
 f_ContextMap := aValue;
//#UC END# *52D3BECC00A6_4925526600D0set_impl*
end;//TdsDiction.pm_SetContextMap

function TdsDiction.pm_GetDictionKind: TnsDictionKind;
//#UC START# *5571EB84007F_4925526600D0get_var*
//#UC END# *5571EB84007F_4925526600D0get_var*
begin
//#UC START# *5571EB84007F_4925526600D0get_impl*
 Result := ns_dkDiction; 
//#UC END# *5571EB84007F_4925526600D0get_impl*
end;//TdsDiction.pm_GetDictionKind

procedure TdsDiction.Cleanup;
//#UC START# *479731C50290_4925526600D0_var*
//#UC END# *479731C50290_4925526600D0_var*
begin
//#UC START# *479731C50290_4925526600D0_impl*
 f_ContextMap := nil;
 inherited;
//#UC END# *479731C50290_4925526600D0_impl*
end;//TdsDiction.Cleanup

{$If not defined(NoVCM)}
procedure TdsDiction.FormSetDataChanged;
//#UC START# *491482DC0216_4925526600D0_var*

  procedure lp_NotifyCurrentChanged;
  var
   l_Index    : Integer;
   l_Listener : IbsDictionListener;
   l_Item     : IUnknown;
  begin
   if (NotifiedObjList <> nil) and (NotifiedObjList.Count > 0) then
    for l_Index := 0 to Pred(NotifiedObjList.Count) do
    begin
     l_Item := NotifiedObjList.Items[l_Index];
     if Supports(l_Item, IbsDictionListener, l_Listener) and
       (l_Item = l_Listener) then
      with l_Listener do
      begin
       UpdateLanguage((dDiction.DocInfo as IdeDiction).DictLanguage);
       DictionNotify(l_Listener);
      end;//with l_Listener do
    end;//if (NotifiedObjList <> nil)
  end;//lp_NotifyCurrentChanged

//#UC END# *491482DC0216_4925526600D0_var*
begin
//#UC START# *491482DC0216_4925526600D0_impl*
 inherited;
 lp_NotifyCurrentChanged;
//#UC END# *491482DC0216_4925526600D0_impl*
end;//TdsDiction.FormSetDataChanged
{$IfEnd} //not NoVCM

procedure TdsDiction.AfterChangeCurrent;
//#UC START# *492546330316_4925526600D0_var*
//#UC END# *492546330316_4925526600D0_var*
begin
//#UC START# *492546330316_4925526600D0_impl*
 with dDiction do
 begin
  (DocInfo as IdeDiction).DictLanguage := Language;
  // http://mdp.garant.ru/pages/viewpage.action?pageId=382410166
  (DocInfo as IdeDiction).ContextMap := f_ContextMap;
 end;
 inherited;
//#UC END# *492546330316_4925526600D0_impl*
end;//TdsDiction.AfterChangeCurrent

{$If not defined(NoVCM)}
procedure TdsDiction.GotData;
//#UC START# *492ACF630072_4925526600D0_var*
//#UC END# *492ACF630072_4925526600D0_var*
begin
//#UC START# *492ACF630072_4925526600D0_impl*
 inherited;
 Language := PartData.DictLanguage;
 f_ContextMap := PartData.ContextMap;
//#UC END# *492ACF630072_4925526600D0_impl*
end;//TdsDiction.GotData
{$IfEnd} //not NoVCM

function TdsDiction.ForceChangeInCurrentChanged: Boolean;
//#UC START# *4A9E6599035A_4925526600D0_var*
//#UC END# *4A9E6599035A_4925526600D0_var*
begin
//#UC START# *4A9E6599035A_4925526600D0_impl*
 Result := (ucc_Diction <> nil) and ucc_Diction.IsShowLiteratureList;
//#UC END# *4A9E6599035A_4925526600D0_impl*
end;//TdsDiction.ForceChangeInCurrentChanged

{$If not defined(NoVCM)}
function TdsDiction.GetIsDataAvailable: Boolean;
//#UC START# *55097FF5008E_4925526600D0_var*
//#UC END# *55097FF5008E_4925526600D0_var*
begin
//#UC START# *55097FF5008E_4925526600D0_impl*
 Result := DefDataAdapter.IsExplanatoryExists;
//#UC END# *55097FF5008E_4925526600D0_impl*
end;//TdsDiction.GetIsDataAvailable
{$IfEnd} //not NoVCM

procedure TdsDiction.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 Supports(aDS, IdDiction, dDiction);
 Supports(aDS, IsdsDiction, ucc_Diction);
end;

procedure TdsDiction.ClearRefs;
begin
 inherited;
 dDiction := nil;
 ucc_Diction := nil;
end;

{$IfEnd} //not Admin AND not Monitorings

end.