unit dsDiction;
 {* перевод толкового словаря на сборку }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Diction\dsDiction.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsDiction" MUID: (4925526600D0)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DictionInterfaces
 , bsTypes
 , l3TreeInterfaces
 , DocumentInterfaces
 , CommonDictionInterfaces
 , DocumentUnit
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DynamicTreeUnit
 , DocumentAndListInterfaces
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , l3Interfaces
 , TreeInterfaces
 , bsInterfaces
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3InternalInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3NotifyPtrList
;

type
 _InitDataType_ = IdeDiction;
 _FormDataSourceType_ = IdsDiction;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\dsCommonDiction.imp.pas}
 TdsDiction = {final} class(_dsCommonDiction_, IdsDiction)
  {* перевод толкового словаря на сборку }
  private
   dDiction: IdDiction;
   f_ContextMap: InsLangToContextMap;
   ucc_Diction: IsdsDiction;
   f_Language: TbsLanguage;
  protected
   function MakeSimpleTree: Il3SimpleTree; override;
    {* Создать данные дерева }
   function MakeDocInfoForCurrentChanged(const aDoc: IDocument): IdeDocInfo; override;
   function pm_GetLanguage: TbsLanguage;
   procedure pm_SetLanguage(aValue: TbsLanguage);
   function pm_GetContextMap: InsLangToContextMap;
   procedure pm_SetContextMap(const aValue: InsLangToContextMap);
   function pm_GetDictionKind: TnsDictionKind; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure FormSetDataChanged; override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure AfterChangeCurrent; override;
   {$If NOT Defined(NoVCM)}
   procedure GotData; override;
    {* - данные изменились. }
   {$IfEnd} // NOT Defined(NoVCM)
   function ForceChangeInCurrentChanged: Boolean; override;
   {$If NOT Defined(NoVCM)}
   function GetIsDataAvailable: Boolean; override;
    {* существуют ли данные }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitRefs(const aDS: IvcmFormSetDataSource); override;
    {* Инициализирует ссылки на различные представления прецедента }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ClearRefs; override;
    {* Очищает ссылки на различные представления прецедента }
   {$IfEnd} // NOT Defined(NoVCM)
  private
   property Language: TbsLanguage
    read f_Language
    write f_Language;
 end;//TdsDiction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , deDiction
 , nsLangToContextMap
 , DataAdapter
 , BaseTypesUnit
 , l3Base
 , vtUtils
 , vtStdRes
 , nsNewCachableNode
 , Windows
 , l3InterfacesMisc
;

type _Instance_R_ = TdsDiction;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\dsCommonDiction.imp.pas}

function TdsDiction.MakeSimpleTree: Il3SimpleTree;
 {* Создать данные дерева }
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
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4925526600D0_var*
//#UC END# *479731C50290_4925526600D0_var*
begin
//#UC START# *479731C50290_4925526600D0_impl*
 f_ContextMap := nil;
 inherited;
//#UC END# *479731C50290_4925526600D0_impl*
end;//TdsDiction.Cleanup

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

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

{$If NOT Defined(NoVCM)}
procedure TdsDiction.GotData;
 {* - данные изменились. }
//#UC START# *492ACF630072_4925526600D0_var*
//#UC END# *492ACF630072_4925526600D0_var*
begin
//#UC START# *492ACF630072_4925526600D0_impl*
 inherited;
 Language := PartData.DictLanguage;
 f_ContextMap := PartData.ContextMap;
//#UC END# *492ACF630072_4925526600D0_impl*
end;//TdsDiction.GotData
{$IfEnd} // NOT Defined(NoVCM)

function TdsDiction.ForceChangeInCurrentChanged: Boolean;
//#UC START# *4A9E6599035A_4925526600D0_var*
//#UC END# *4A9E6599035A_4925526600D0_var*
begin
//#UC START# *4A9E6599035A_4925526600D0_impl*
 Result := (ucc_Diction <> nil) and ucc_Diction.IsShowLiteratureList;
//#UC END# *4A9E6599035A_4925526600D0_impl*
end;//TdsDiction.ForceChangeInCurrentChanged

{$If NOT Defined(NoVCM)}
function TdsDiction.GetIsDataAvailable: Boolean;
 {* существуют ли данные }
//#UC START# *55097FF5008E_4925526600D0_var*
//#UC END# *55097FF5008E_4925526600D0_var*
begin
//#UC START# *55097FF5008E_4925526600D0_impl*
 Result := DefDataAdapter.IsExplanatoryExists;
//#UC END# *55097FF5008E_4925526600D0_impl*
end;//TdsDiction.GetIsDataAvailable
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TdsDiction.InitRefs(const aDS: IvcmFormSetDataSource);
 {* Инициализирует ссылки на различные представления прецедента }
begin
 inherited;
 Supports(aDS, IdDiction, dDiction);
 Supports(aDS, IsdsDiction, ucc_Diction);
end;//TdsDiction.InitRefs
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TdsDiction.ClearRefs;
 {* Очищает ссылки на различные представления прецедента }
begin
 inherited;
 dDiction := nil;
 ucc_Diction := nil;
end;//TdsDiction.ClearRefs
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
