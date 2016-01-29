unit PrimEditionsContainer_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Editions/Forms/PrimEditionsContainer_Form.pas"
// Начат: 28.07.2009 13:12
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Пользовательские сервисы::CompareEditions::View::Editions::PrimEditionsContainer
//
// Контейнер для двух редакций
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
  DocumentUnit,
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmContainerForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  EditionsInterfaces,
  Base_Operations_Editions_Controls,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  CompareEditions_Controls,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  afwInterfaces
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  vcmEntityForm {a},
  DocumentAndListInterfaces,
  Common_Strange_Controls,
  PrimEditionsContainer_utEditionsContainer_UserType
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _vcmChromeLikeTabCaptionProvider_Parent_ = TvcmContainerForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabCaptionProvider.imp.pas}
 _StatusBarItems_Parent_ = _vcmChromeLikeTabCaptionProvider_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarItems.imp.pas}
 _EditionsListCaller_Parent_ = _StatusBarItems_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\EditionsListCaller.imp.pas}
 TPrimEditionsContainerForm = {form} class(_EditionsListCaller_, InsVScrollListener)
  {* Контейнер для двух редакций }
 private
 // private fields
   f_InFindChanged : Boolean;
   f_PrevPara : Integer;
   f_ForceDrawFocusRectMoment : Cardinal;
   f_BackgroundPanel : TvtProportionalPanel;
    {* Поле для свойства BackgroundPanel}
   f_pnLeft : TvtSizeablePanel;
    {* Поле для свойства pnLeft}
   f_pnRight : TvtPanel;
    {* Поле для свойства pnRight}
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure UpdateCaptionFromDS;
     {* Обновляет заголовок формы }
   function FindChangedText(aBack: Boolean): TGotoParaResult;
     {* Найти изменённый текст }
   function CanFindChangedText(aBack: Boolean): Boolean;
   function MakePrefixedCaption(const aPrefixStr: Il3CString;
     aShort: Boolean = True): Il3CString;
 protected
 // property methods
   function pm_GetBackgroundPanel: TvtProportionalPanel;
   function pm_GetPnLeft: TvtSizeablePanel;
   function pm_GetPnRight: TvtPanel;
 protected
 // realized methods
   procedure Edition_PrevChange_Test(const aParams: IvcmTestParamsPrim);
     {* Предыдущее изменение }
   procedure Edition_PrevChange_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Предыдущее изменение }
   procedure Edition_NextChange_Test(const aParams: IvcmTestParamsPrim);
     {* Следующее изменение }
   procedure Edition_NextChange_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Следующее изменение }
   procedure FillList(const aList: InscStatusBarItemDefsList); override;
     {* Заполняет список операций. Для перекрытия в потомках }
   procedure Edition_ReturnToDocument_Test(const aParams: IvcmTestParamsPrim);
     {* Вернуться в текст документа }
   procedure Edition_ReturnToDocument_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Вернуться в текст документа }
   procedure Document_ViewChangedFragments_Test(const aParams: IvcmTestParamsPrim);
     {* Обзор изменений документа }
   procedure Document_ViewChangedFragments_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Обзор изменений документа }
 public
 // realized methods
   procedure Sync(const aPara: TnsParaCoord);
     {* Синхронизировать позицию }
   procedure CurrentChangedFragmentChanged(aParaID: Integer);
     {* Изменилось положение текущего изменённого фрагмента. Дёрнули у редактора курсор или скроллер. aParaID == GetParaForPositionning }
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   procedure FormInsertedIntoContainer; override;
    {$IfEnd} //not NoVCM
 protected
 // protected fields
   EditionsContainerData : IdsEditionsContainerData;
 public
 // public properties
   property BackgroundPanel: TvtProportionalPanel
     read pm_GetBackgroundPanel;
   property pnLeft: TvtSizeablePanel
     read pm_GetPnLeft;
   property pnRight: TvtPanel
     read pm_GetPnRight;
 end;//TPrimEditionsContainerForm

 TvcmContainerFormRef = TPrimEditionsContainerForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base,
  l3String
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  Windows,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerFormDispatcher
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If defined(Nemesis)}
  ,
  nscStatusBarOperationDefsList
  {$IfEnd} //Nemesis
  ,
  SysUtils
  {$If defined(Nemesis)}
  ,
  nscStatusBarOperationDef
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TPrimEditionsContainerForm;

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabCaptionProvider.imp.pas}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarItems.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\EditionsListCaller.imp.pas}

var
   { Локализуемые строки utEditionsContainerLocalConstants }
  str_utEditionsContainerCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utEditionsContainerCaption'; rValue : 'Сравнение редакций документа');
   { Заголовок пользовательского типа "Сравнение редакций документа" }

var
   { Локализуемые строки CaptionConst }
  str_EditionsContainerCaptionShortPrefix : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'EditionsContainerCaptionShortPrefix'; rValue : 'Сравнение редакций');
   { 'Сравнение редакций' }

// start class TPrimEditionsContainerForm

procedure TPrimEditionsContainerForm.UpdateCaptionFromDS;
//#UC START# *4A80256B02A5_4A6EC0D0020C_var*
//#UC END# *4A80256B02A5_4A6EC0D0020C_var*
var
 l_P : Il3CString;
 l_S : Il3CString;
begin
//#UC START# *4A80256B02A5_4A6EC0D0020C_impl*
 if (EditionsContainerData <> nil) then
 begin
  l3Split(CCaption, ':', l_P, l_S);
  CCaption := MakePrefixedCaption(l_P, False);
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=571653443
  UpdateTabCaption(MakePrefixedCaption(l_P, False));
 end;//EditionsContainerData <> nil
//#UC END# *4A80256B02A5_4A6EC0D0020C_impl*
end;//TPrimEditionsContainerForm.UpdateCaptionFromDS

function TPrimEditionsContainerForm.FindChangedText(aBack: Boolean): TGotoParaResult;
//#UC START# *4ADC8D5C0182_4A6EC0D0020C_var*
var
 l_Para : TParaNum;
//#UC END# *4ADC8D5C0182_4A6EC0D0020C_var*
var
 l_Form : IvcmEntityForm;
 l_CP : IDiffIterator;
begin
//#UC START# *4ADC8D5C0182_4A6EC0D0020C_impl*
 l_Para := 0;
 Result := gtprFail;
 l_CP := EditionsContainerData.ChangedParas;
 if (l_CP <> nil) then
 begin
  Assert(not f_InFindChanged);
  f_InFindChanged := true;
  try
   while (Result <> gtprOk) do
   begin
    if aBack then
    begin
     if l_CP.HasPrev then
      l_Para := l_CP.Prev
     else
      Exit;
    end//aBack
    else
    //if not aBack then
    begin
     if l_CP.HasNext then
      l_Para := l_CP.Next
     else
      Exit;
    end;//not aBack
    f_PrevPara := l_Para;
    if HasForm(vcm_ztMain, false, @l_Form) then
    begin
     Result := Op_Finder_GotoPara.Call(l_Form, l_Para);
     if (Result = gtprAlready) then
      continue;
    end//HasForm(vcm_ztMain, false, @l_Form)
    else
     Assert(false);
    if HasForm(vcm_ztChild, false, @l_Form) then
    begin
     if (Result = gtprFail) then
     begin
      Result := Op_Finder_GotoPara.Call(l_Form, l_Para);
      if (Result = gtprAlready) then
       continue;
     end//Result = gtprFail
     else
      Op_Finder_DisableForceDrawFocusRect.Call(l_Form);
    end//HasForm(vcm_ztChild, false, @l_Form)
    else
     Assert(false);
    Assert(Result = gtprOk, 'Изменённый параграф не найден');
   end;//while (Result <> gtprOk)
   f_ForceDrawFocusRectMoment := GetTickCount;
  finally
   f_InFindChanged := false;
  end;//try..finally
 end;//l_CP <> nil
//#UC END# *4ADC8D5C0182_4A6EC0D0020C_impl*
end;//TPrimEditionsContainerForm.FindChangedText

function TPrimEditionsContainerForm.CanFindChangedText(aBack: Boolean): Boolean;
//#UC START# *4AE046D4038D_4A6EC0D0020C_var*
//#UC END# *4AE046D4038D_4A6EC0D0020C_var*
var
 l_CP : IDiffIterator;
begin
//#UC START# *4AE046D4038D_4A6EC0D0020C_impl*
 Result := false;
 l_CP := EditionsContainerData.ChangedParas;
 if (l_CP <> nil) then
 begin
  if aBack then
  begin
   Result := l_CP.HasPrev;
   if Result then
   begin
    if Op_RightEdition_IsCurrentPara.Call(Aggregate, l_CP.AcquirePrev) then
    begin
     l_CP.Prev;
     Result := l_CP.HasPrev;
     l_CP.Next;
    end;//Op_RightEdition_IsCurrentPara.Call(Aggregate, l_CP.AcquirePrev)
   end;//Result
  end//aBack
  else
  begin
   Result := l_CP.HasNext;
   if Result then
   begin
    if Op_RightEdition_IsCurrentPara.Call(Aggregate, l_CP.AcquireNext) then
    begin
     f_PrevPara := l_CP.Next;
     Result := l_CP.HasNext;
    end;//Op_RightEdition_IsCurrentPara.Call(Aggregate, l_CP.AcquireNext)
   end;//Result
  end;//aBack
 end;//l_CP <> nil
//#UC END# *4AE046D4038D_4A6EC0D0020C_impl*
end;//TPrimEditionsContainerForm.CanFindChangedText

function TPrimEditionsContainerForm.MakePrefixedCaption(const aPrefixStr: Il3CString;
  aShort: Boolean = True): Il3CString;
//#UC START# *54630D2702E1_4A6EC0D0020C_var*
var
 l_DocName: Il3CString;
//#UC END# *54630D2702E1_4A6EC0D0020C_var*
begin
//#UC START# *54630D2702E1_4A6EC0D0020C_impl*
 if (EditionsContainerData <> nil) then
 begin
  if aShort then
   l_DocName := EditionsContainerData.DocumentNameForCaption
  else
   l_DocName := EditionsContainerData.DocumentFullNameForCaption;
  Result := l3Cat([aPrefixStr, l3CStr(' : '), l_DocName])
 end
 else
  Result := nil;
//#UC END# *54630D2702E1_4A6EC0D0020C_impl*
end;//TPrimEditionsContainerForm.MakePrefixedCaption

function TPrimEditionsContainerForm.pm_GetBackgroundPanel: TvtProportionalPanel;
begin
 if (f_BackgroundPanel = nil) then
  f_BackgroundPanel := FindComponent('BackgroundPanel') As TvtProportionalPanel;
 Result := f_BackgroundPanel;
end;

function TPrimEditionsContainerForm.pm_GetPnLeft: TvtSizeablePanel;
begin
 if (f_pnLeft = nil) then
  f_pnLeft := FindComponent('pnLeft') As TvtSizeablePanel;
 Result := f_pnLeft;
end;

function TPrimEditionsContainerForm.pm_GetPnRight: TvtPanel;
begin
 if (f_pnRight = nil) then
  f_pnRight := FindComponent('pnRight') As TvtPanel;
 Result := f_pnRight;
end;

procedure TPrimEditionsContainerForm.Sync(const aPara: TnsParaCoord);
//#UC START# *4A79AB290196_4A6EC0D0020C_var*
//#UC END# *4A79AB290196_4A6EC0D0020C_var*
begin
//#UC START# *4A79AB290196_4A6EC0D0020C_impl*
 // - ничего не делаем, т.к. эта нотификация нам неинтересна
//#UC END# *4A79AB290196_4A6EC0D0020C_impl*
end;//TPrimEditionsContainerForm.Sync

procedure TPrimEditionsContainerForm.Edition_PrevChange_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A8996E000FF_4A6EC0D0020Ctest_var*
//#UC END# *4A8996E000FF_4A6EC0D0020Ctest_var*
begin
//#UC START# *4A8996E000FF_4A6EC0D0020Ctest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := CanFindChangedText(true);
//#UC END# *4A8996E000FF_4A6EC0D0020Ctest_impl*
end;//TPrimEditionsContainerForm.Edition_PrevChange_Test

procedure TPrimEditionsContainerForm.Edition_PrevChange_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A8996E000FF_4A6EC0D0020Cexec_var*
//#UC END# *4A8996E000FF_4A6EC0D0020Cexec_var*
begin
//#UC START# *4A8996E000FF_4A6EC0D0020Cexec_impl*
 FindChangedText(true);
//#UC END# *4A8996E000FF_4A6EC0D0020Cexec_impl*
end;//TPrimEditionsContainerForm.Edition_PrevChange_Execute

procedure TPrimEditionsContainerForm.Edition_NextChange_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A8996FA03B8_4A6EC0D0020Ctest_var*
//#UC END# *4A8996FA03B8_4A6EC0D0020Ctest_var*
begin
//#UC START# *4A8996FA03B8_4A6EC0D0020Ctest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := CanFindChangedText(false);
//#UC END# *4A8996FA03B8_4A6EC0D0020Ctest_impl*
end;//TPrimEditionsContainerForm.Edition_NextChange_Test

procedure TPrimEditionsContainerForm.Edition_NextChange_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A8996FA03B8_4A6EC0D0020Cexec_var*
//#UC END# *4A8996FA03B8_4A6EC0D0020Cexec_var*
begin
//#UC START# *4A8996FA03B8_4A6EC0D0020Cexec_impl*
 FindChangedText(false);
//#UC END# *4A8996FA03B8_4A6EC0D0020Cexec_impl*
end;//TPrimEditionsContainerForm.Edition_NextChange_Execute

procedure TPrimEditionsContainerForm.FillList(const aList: InscStatusBarItemDefsList);
//#UC START# *4A8E5E4702C6_4A6EC0D0020C_var*
//#UC END# *4A8E5E4702C6_4A6EC0D0020C_var*
begin
//#UC START# *4A8E5E4702C6_4A6EC0D0020C_impl*
 with aList do
 begin
  Add(TnscStatusBarOperationDef.MakeSDefaultCaption(TdmStdRes.opcode_Edition_PrevChange, true, false, 2000, nsc_ttkNone));
  Add(TnscStatusBarOperationDef.MakeSDefaultCaption(TdmStdRes.opcode_Edition_NextChange, true, false, 2000, nsc_ttkNone));
  Add(TnscStatusBarOperationDef.MakeSDefaultCaption(TdmStdRes.opcode_Redactions_OpenRedactionListFrmAct, true, false, 2000, nsc_ttkNone));
  Add(TnscStatusBarOperationDef.MakeSDefaultCaption(TdmStdRes.opcode_Edition_ReturnToDocument, true, false, 2000, nsc_ttkNone));
 end;//with aList
//#UC END# *4A8E5E4702C6_4A6EC0D0020C_impl*
end;//TPrimEditionsContainerForm.FillList

procedure TPrimEditionsContainerForm.Edition_ReturnToDocument_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4B1E37CE00C1_4A6EC0D0020Ctest_var*
//#UC END# *4B1E37CE00C1_4A6EC0D0020Ctest_var*
begin
//#UC START# *4B1E37CE00C1_4A6EC0D0020Ctest_impl*
 // - ничего не делаем
//#UC END# *4B1E37CE00C1_4A6EC0D0020Ctest_impl*
end;//TPrimEditionsContainerForm.Edition_ReturnToDocument_Test

procedure TPrimEditionsContainerForm.Edition_ReturnToDocument_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4B1E37CE00C1_4A6EC0D0020Cexec_var*
//#UC END# *4B1E37CE00C1_4A6EC0D0020Cexec_var*
begin
//#UC START# *4B1E37CE00C1_4A6EC0D0020Cexec_impl*
 Op_RightEdition_ReturnToDocument.Call(Aggregate);
//#UC END# *4B1E37CE00C1_4A6EC0D0020Cexec_impl*
end;//TPrimEditionsContainerForm.Edition_ReturnToDocument_Execute

procedure TPrimEditionsContainerForm.CurrentChangedFragmentChanged(aParaID: Integer);
//#UC START# *4B54676B0132_4A6EC0D0020C_var*
var
 l_CP : IDiffIterator;
//#UC END# *4B54676B0132_4A6EC0D0020C_var*
begin
//#UC START# *4B54676B0132_4A6EC0D0020C_impl*
 if (f_PrevPara <> aParaID) then
 begin
  f_PrevPara := aParaID;
  // - два условия специально расположенны именно в таком порядке
  //   т.к. по любому - раз мы находимся ВНУТРИ позиционирования
  //   на интересующий нас параграф, то состояние итератора будет
  //   указывать за aParaID, т.е. как будто MoveTo таки сделали
  if not f_InFindChanged then
  begin
   if (GetTickCount - f_ForceDrawFocusRectMoment >= 300) then
   begin
    l_CP := EditionsContainerData.ChangedParas;
    if (l_CP <> nil) then
     l_CP.MoveTo(aParaID);
   end;//GetTickCount - f_ForceDrawFocusRectMoment >= 300
  end;//not f_InFindChanged
 end;//f_PrevPara <> aParaID
//#UC END# *4B54676B0132_4A6EC0D0020C_impl*
end;//TPrimEditionsContainerForm.CurrentChangedFragmentChanged

procedure TPrimEditionsContainerForm.Document_ViewChangedFragments_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4DDCBABC03B7_4A6EC0D0020Ctest_var*
//#UC END# *4DDCBABC03B7_4A6EC0D0020Ctest_var*
begin
//#UC START# *4DDCBABC03B7_4A6EC0D0020Ctest_impl*
 // - ничего не делаем
//#UC END# *4DDCBABC03B7_4A6EC0D0020Ctest_impl*
end;//TPrimEditionsContainerForm.Document_ViewChangedFragments_Test

procedure TPrimEditionsContainerForm.Document_ViewChangedFragments_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4DDCBABC03B7_4A6EC0D0020Cexec_var*
//#UC END# *4DDCBABC03B7_4A6EC0D0020Cexec_var*
begin
//#UC START# *4DDCBABC03B7_4A6EC0D0020Cexec_impl*
 TdmStdRes.ViewChangedFragments(EditionsContainerData.Left.Document,
                                EditionsContainerData.Right.Document);
//#UC END# *4DDCBABC03B7_4A6EC0D0020Cexec_impl*
end;//TPrimEditionsContainerForm.Document_ViewChangedFragments_Execute

{$If not defined(NoVCM)}
procedure TPrimEditionsContainerForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_4A6EC0D0020C_var*
//#UC END# *497469C90140_4A6EC0D0020C_var*
begin
//#UC START# *497469C90140_4A6EC0D0020C_impl*
 inherited;
 if (anOld <> nil) then
 begin
  anOld.Unsubscribe(InsVScrollListener(Self));
 end;//anOld <> nil
 if (aNew <> nil) then
 begin
  aNew.Subscribe(InsVScrollListener(Self));
 end;//aNew <> nil
 UpdateCaptionFromDS;
//#UC END# *497469C90140_4A6EC0D0020C_impl*
end;//TPrimEditionsContainerForm.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimEditionsContainerForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_4A6EC0D0020C_var*
//#UC END# *49803F5503AA_4A6EC0D0020C_var*
begin
//#UC START# *49803F5503AA_4A6EC0D0020C_impl*
 inherited;
 UpdateCaptionFromDS;
//#UC END# *49803F5503AA_4A6EC0D0020C_impl*
end;//TPrimEditionsContainerForm.DoInit
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimEditionsContainerForm.InitControls;
//#UC START# *4A8E8F2E0195_4A6EC0D0020C_var*
//#UC END# *4A8E8F2E0195_4A6EC0D0020C_var*
begin
//#UC START# *4A8E8F2E0195_4A6EC0D0020C_impl*
 with pnLeft do
 begin
  Width := Self.ClientWidth div 2;
  SizeableSides := [szRight];
  TabOrder := 0;
  Align := alLeft;
 end;//with pnLeft
 with pnRight do
 begin
  Width := Self.ClientWidth div 2;
  TabOrder := 1;
  Align := alClient;
 end;//with pnRight
 Self.ActiveControl := pnRight;
 inherited;
//#UC END# *4A8E8F2E0195_4A6EC0D0020C_impl*
end;//TPrimEditionsContainerForm.InitControls
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimEditionsContainerForm.FormInsertedIntoContainer;
//#UC START# *4F7C65380244_4A6EC0D0020C_var*
//#UC END# *4F7C65380244_4A6EC0D0020C_var*
begin
//#UC START# *4F7C65380244_4A6EC0D0020C_impl*
 inherited;
//#UC END# *4F7C65380244_4A6EC0D0020C_impl*
end;//TPrimEditionsContainerForm.FormInsertedIntoContainer
{$IfEnd} //not NoVCM

procedure TPrimEditionsContainerForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  EditionsContainerData := nil;
 end//aDsNew = nil
 else
 begin
  Supports(aDsNew, IdsEditionsContainerData, EditionsContainerData);
 end;//aDsNew = nil
end;

procedure TPrimEditionsContainerForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edition, nil);
  PublishFormEntity(en_Document, nil);
  PublishOp(en_Edition, op_PrevChange, Edition_PrevChange_Execute, Edition_PrevChange_Test, nil);
  PublishOp(en_Edition, op_NextChange, Edition_NextChange_Execute, Edition_NextChange_Test, nil);
  PublishOp(en_Edition, op_ReturnToDocument, Edition_ReturnToDocument_Execute, Edition_ReturnToDocument_Test, nil);
  PublishOp(en_Document, op_ViewChangedFragments, Document_ViewChangedFragments_Execute, Document_ViewChangedFragments_Test, nil);
  ShowInContextMenu(en_Document, op_ViewChangedFragments, false);
  ShowInToolbar(en_Document, op_ViewChangedFragments, true);
 end;//with Entities.Entities
end;

procedure TPrimEditionsContainerForm.MakeControls;
begin
 inherited;
 with DefineZone(vcm_ztChild, pnLeft) do
 begin
 end;//with DefineZone(vcm_ztChild, f_pnLeft)
 with DefineZone(vcm_ztMain, pnRight) do
 begin
 end;//with DefineZone(vcm_ztMain, f_pnRight)
 with AddUsertype(utEditionsContainerName,
  str_utEditionsContainerCaption,
  str_utEditionsContainerCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utEditionsContainerName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utEditionsContainerCaption
 str_utEditionsContainerCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_EditionsContainerCaptionShortPrefix
 str_EditionsContainerCaptionShortPrefix.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimEditionsContainer
 TtfwClassRef.Register(TPrimEditionsContainerForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.