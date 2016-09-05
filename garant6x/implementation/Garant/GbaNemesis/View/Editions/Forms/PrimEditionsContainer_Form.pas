unit PrimEditionsContainer_Form;
 {* Контейнер для двух редакций }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\PrimEditionsContainer_Form.pas"
// Стереотип: "VCMContainer"
// Элемент модели: "PrimEditionsContainer" MUID: (4A6EC0D0020C)
// Имя типа: "TPrimEditionsContainerForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 , EditionsInterfaces
 , CompareEditions_Controls
 , Base_Operations_Editions_Controls
 , vtProportionalPanel
 , l3Interfaces
 , vtSizeablePanel
 , vtPanel
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentUnit
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , afwInterfaces
 , Common_Strange_Controls
 , DocumentAndListInterfaces
;

type
 _vcmChromeLikeTabCaptionProvider_Parent_ = TvcmContainerForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabCaptionProvider.imp.pas}
 _StatusBarItems_Parent_ = _vcmChromeLikeTabCaptionProvider_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarItems.imp.pas}
 _EditionsListCaller_Parent_ = _StatusBarItems_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\EditionsListCaller.imp.pas}
 TPrimEditionsContainerForm = class(_EditionsListCaller_, InsVScrollListener)
  {* Контейнер для двух редакций }
  private
   f_InFindChanged: Boolean;
   f_PrevPara: Integer;
   f_ForceDrawFocusRectMoment: Cardinal;
   f_BackgroundPanel: TvtProportionalPanel;
   f_pnLeft: TvtSizeablePanel;
   f_pnRight: TvtPanel;
  protected
   EditionsContainerData: IdsEditionsContainerData;
  private
   procedure UpdateCaptionFromDS;
    {* Обновляет заголовок формы }
   function FindChangedText(aBack: Boolean): TGotoParaResult;
    {* Найти изменённый текст }
   function CanFindChangedText(aBack: Boolean): Boolean;
   function MakePrefixedCaption(const aPrefixStr: Il3CString;
    aShort: Boolean = True): Il3CString;
  protected
   procedure FillList(const aList: InscStatusBarItemDefsList); override;
    {* Заполняет список операций. Для перекрытия в потомках }
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FormInsertedIntoContainer; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure Sync(const aPara: TnsParaCoord);
    {* Синхронизировать позицию }
   procedure Edition_PrevChange_Test(const aParams: IvcmTestParamsPrim);
    {* Предыдущее изменение }
   procedure Edition_PrevChange_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Предыдущее изменение }
   procedure Edition_NextChange_Test(const aParams: IvcmTestParamsPrim);
    {* Следующее изменение }
   procedure Edition_NextChange_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Следующее изменение }
   procedure Edition_ReturnToDocument_Test(const aParams: IvcmTestParamsPrim);
    {* Вернуться в текст документа }
   procedure Edition_ReturnToDocument_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Вернуться в текст документа }
   procedure CurrentChangedFragmentChanged(aParaID: Integer);
    {* Изменилось положение текущего изменённого фрагмента. Дёрнули у редактора курсор или скроллер. aParaID == GetParaForPositionning }
   procedure Document_ViewChangedFragments_Test(const aParams: IvcmTestParamsPrim);
    {* Обзор изменений документа }
   procedure Document_ViewChangedFragments_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Обзор изменений документа }
  public
   property BackgroundPanel: TvtProportionalPanel
    read f_BackgroundPanel;
   property pnLeft: TvtSizeablePanel
    read f_pnLeft;
   property pnRight: TvtPanel
    read f_pnRight;
 end;//TPrimEditionsContainerForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Windows
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If Defined(Nemesis)}
 , nscStatusBarOperationDefsList
 {$IfEnd} // Defined(Nemesis)
 , SysUtils
 {$If Defined(Nemesis)}
 , nscStatusBarOperationDef
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_F1Services_Contracts
 , l3Base
 , l3String
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimEditionsContainer_utEditionsContainer_UserType
 //#UC START# *4A6EC0D0020Cimpl_uses*
 //#UC END# *4A6EC0D0020Cimpl_uses*
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки CaptionConst }
 str_EditionsContainerCaptionShortPrefix: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'EditionsContainerCaptionShortPrefix'; rValue : 'Сравнение редакций');
  {* 'Сравнение редакций' }

type _Instance_R_ = TPrimEditionsContainerForm;

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabCaptionProvider.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarItems.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\EditionsListCaller.imp.pas}

procedure TPrimEditionsContainerForm.UpdateCaptionFromDS;
 {* Обновляет заголовок формы }
var l_P: Il3CString;
var l_S: Il3CString;
//#UC START# *4A80256B02A5_4A6EC0D0020C_var*
//#UC END# *4A80256B02A5_4A6EC0D0020C_var*
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
 {* Найти изменённый текст }
var l_Form: IvcmEntityForm;
var l_CP: IDiffIterator;
//#UC START# *4ADC8D5C0182_4A6EC0D0020C_var*
var
 l_Para : TParaNum;
//#UC END# *4ADC8D5C0182_4A6EC0D0020C_var*
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
var l_CP: IDiffIterator;
//#UC START# *4AE046D4038D_4A6EC0D0020C_var*
//#UC END# *4AE046D4038D_4A6EC0D0020C_var*
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

procedure TPrimEditionsContainerForm.Sync(const aPara: TnsParaCoord);
 {* Синхронизировать позицию }
//#UC START# *4A79AB290196_4A6EC0D0020C_var*
//#UC END# *4A79AB290196_4A6EC0D0020C_var*
begin
//#UC START# *4A79AB290196_4A6EC0D0020C_impl*
 // - ничего не делаем, т.к. эта нотификация нам неинтересна
//#UC END# *4A79AB290196_4A6EC0D0020C_impl*
end;//TPrimEditionsContainerForm.Sync

procedure TPrimEditionsContainerForm.Edition_PrevChange_Test(const aParams: IvcmTestParamsPrim);
 {* Предыдущее изменение }
//#UC START# *4A8996E000FF_4A6EC0D0020Ctest_var*
//#UC END# *4A8996E000FF_4A6EC0D0020Ctest_var*
begin
//#UC START# *4A8996E000FF_4A6EC0D0020Ctest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := CanFindChangedText(true);
//#UC END# *4A8996E000FF_4A6EC0D0020Ctest_impl*
end;//TPrimEditionsContainerForm.Edition_PrevChange_Test

procedure TPrimEditionsContainerForm.Edition_PrevChange_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Предыдущее изменение }
//#UC START# *4A8996E000FF_4A6EC0D0020Cexec_var*
//#UC END# *4A8996E000FF_4A6EC0D0020Cexec_var*
begin
//#UC START# *4A8996E000FF_4A6EC0D0020Cexec_impl*
 FindChangedText(true);
//#UC END# *4A8996E000FF_4A6EC0D0020Cexec_impl*
end;//TPrimEditionsContainerForm.Edition_PrevChange_Execute

procedure TPrimEditionsContainerForm.Edition_NextChange_Test(const aParams: IvcmTestParamsPrim);
 {* Следующее изменение }
//#UC START# *4A8996FA03B8_4A6EC0D0020Ctest_var*
//#UC END# *4A8996FA03B8_4A6EC0D0020Ctest_var*
begin
//#UC START# *4A8996FA03B8_4A6EC0D0020Ctest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := CanFindChangedText(false);
//#UC END# *4A8996FA03B8_4A6EC0D0020Ctest_impl*
end;//TPrimEditionsContainerForm.Edition_NextChange_Test

procedure TPrimEditionsContainerForm.Edition_NextChange_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Следующее изменение }
//#UC START# *4A8996FA03B8_4A6EC0D0020Cexec_var*
//#UC END# *4A8996FA03B8_4A6EC0D0020Cexec_var*
begin
//#UC START# *4A8996FA03B8_4A6EC0D0020Cexec_impl*
 FindChangedText(false);
//#UC END# *4A8996FA03B8_4A6EC0D0020Cexec_impl*
end;//TPrimEditionsContainerForm.Edition_NextChange_Execute

procedure TPrimEditionsContainerForm.FillList(const aList: InscStatusBarItemDefsList);
 {* Заполняет список операций. Для перекрытия в потомках }
//#UC START# *4A8E5E4702C6_4A6EC0D0020C_var*
//#UC END# *4A8E5E4702C6_4A6EC0D0020C_var*
begin
//#UC START# *4A8E5E4702C6_4A6EC0D0020C_impl*
 with aList do
 begin
  Add(TnscStatusBarOperationDef.MakeSDefaultCaption(opcode_Edition_PrevChange, true, false, 2000, nsc_ttkNone));
  Add(TnscStatusBarOperationDef.MakeSDefaultCaption(opcode_Edition_NextChange, true, false, 2000, nsc_ttkNone));
  Add(TnscStatusBarOperationDef.MakeSDefaultCaption(opcode_Redactions_OpenRedactionListFrmAct, true, false, 2000, nsc_ttkNone));
  Add(TnscStatusBarOperationDef.MakeSDefaultCaption(opcode_Edition_ReturnToDocument, true, false, 2000, nsc_ttkNone));
 end;//with aList
//#UC END# *4A8E5E4702C6_4A6EC0D0020C_impl*
end;//TPrimEditionsContainerForm.FillList

procedure TPrimEditionsContainerForm.Edition_ReturnToDocument_Test(const aParams: IvcmTestParamsPrim);
 {* Вернуться в текст документа }
//#UC START# *4B1E37CE00C1_4A6EC0D0020Ctest_var*
//#UC END# *4B1E37CE00C1_4A6EC0D0020Ctest_var*
begin
//#UC START# *4B1E37CE00C1_4A6EC0D0020Ctest_impl*
 // - ничего не делаем
//#UC END# *4B1E37CE00C1_4A6EC0D0020Ctest_impl*
end;//TPrimEditionsContainerForm.Edition_ReturnToDocument_Test

procedure TPrimEditionsContainerForm.Edition_ReturnToDocument_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Вернуться в текст документа }
//#UC START# *4B1E37CE00C1_4A6EC0D0020Cexec_var*
//#UC END# *4B1E37CE00C1_4A6EC0D0020Cexec_var*
begin
//#UC START# *4B1E37CE00C1_4A6EC0D0020Cexec_impl*
 Op_RightEdition_ReturnToDocument.Call(Aggregate);
//#UC END# *4B1E37CE00C1_4A6EC0D0020Cexec_impl*
end;//TPrimEditionsContainerForm.Edition_ReturnToDocument_Execute

procedure TPrimEditionsContainerForm.CurrentChangedFragmentChanged(aParaID: Integer);
 {* Изменилось положение текущего изменённого фрагмента. Дёрнули у редактора курсор или скроллер. aParaID == GetParaForPositionning }
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
 {* Обзор изменений документа }
//#UC START# *4DDCBABC03B7_4A6EC0D0020Ctest_var*
//#UC END# *4DDCBABC03B7_4A6EC0D0020Ctest_var*
begin
//#UC START# *4DDCBABC03B7_4A6EC0D0020Ctest_impl*
 // - ничего не делаем
//#UC END# *4DDCBABC03B7_4A6EC0D0020Ctest_impl*
end;//TPrimEditionsContainerForm.Document_ViewChangedFragments_Test

procedure TPrimEditionsContainerForm.Document_ViewChangedFragments_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Обзор изменений документа }
//#UC START# *4DDCBABC03B7_4A6EC0D0020Cexec_var*
//#UC END# *4DDCBABC03B7_4A6EC0D0020Cexec_var*
begin
//#UC START# *4DDCBABC03B7_4A6EC0D0020Cexec_impl*
 TChangesBetweenEditionsService.Instance.ViewChangedFragments(EditionsContainerData.Left.Document,
                                EditionsContainerData.Right.Document);
//#UC END# *4DDCBABC03B7_4A6EC0D0020Cexec_impl*
end;//TPrimEditionsContainerForm.Document_ViewChangedFragments_Execute

procedure TPrimEditionsContainerForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
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

procedure TPrimEditionsContainerForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4A6EC0D0020C_var*
//#UC END# *49803F5503AA_4A6EC0D0020C_var*
begin
//#UC START# *49803F5503AA_4A6EC0D0020C_impl*
 inherited;
 UpdateCaptionFromDS;
//#UC END# *49803F5503AA_4A6EC0D0020C_impl*
end;//TPrimEditionsContainerForm.DoInit

procedure TPrimEditionsContainerForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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

procedure TPrimEditionsContainerForm.FormInsertedIntoContainer;
//#UC START# *4F7C65380244_4A6EC0D0020C_var*
//#UC END# *4F7C65380244_4A6EC0D0020C_var*
begin
//#UC START# *4F7C65380244_4A6EC0D0020C_impl*
 inherited;
//#UC END# *4F7C65380244_4A6EC0D0020C_impl*
end;//TPrimEditionsContainerForm.FormInsertedIntoContainer

procedure TPrimEditionsContainerForm.SignalDataSourceChanged(const anOld: IvcmFormDataSource;
 const aNew: IvcmFormDataSource);
begin
 inherited;
 if (aNew = nil) then
 begin
  EditionsContainerData := nil;
 end//aNew = nil
 else
 begin
  Supports(aNew, IdsEditionsContainerData, EditionsContainerData);
 end;//aNew = nil
end;//TPrimEditionsContainerForm.SignalDataSourceChanged

procedure TPrimEditionsContainerForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
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
  ShowInContextMenu(en_Document, op_ViewChangedFragments, False);
  ShowInToolbar(en_Document, op_ViewChangedFragments, True);
 end;//with Entities.Entities
end;//TPrimEditionsContainerForm.InitEntities

procedure TPrimEditionsContainerForm.MakeControls;
begin
 inherited;
 with AddUsertype(utEditionsContainerName,
  str_utEditionsContainerCaption,
  str_utEditionsContainerCaption,
  True,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utEditionsContainerName
 f_BackgroundPanel := TvtProportionalPanel.Create(Self);
 f_BackgroundPanel.Name := 'BackgroundPanel';
 f_BackgroundPanel.Parent := Self;
 f_pnLeft := TvtSizeablePanel.Create(Self);
 f_pnLeft.Name := 'pnLeft';
 f_pnLeft.Parent := BackgroundPanel;
 with DefineZone(vcm_ztChild, pnLeft) do
 begin
 end;//with DefineZone(vcm_ztChild
 f_pnRight := TvtPanel.Create(Self);
 f_pnRight.Name := 'pnRight';
 f_pnRight.Parent := BackgroundPanel;
 with DefineZone(vcm_ztMain, pnRight) do
 begin
 end;//with DefineZone(vcm_ztMain
end;//TPrimEditionsContainerForm.MakeControls

initialization
 str_EditionsContainerCaptionShortPrefix.Init;
 {* Инициализация str_EditionsContainerCaptionShortPrefix }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimEditionsContainerForm);
 {* Регистрация PrimEditionsContainer }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
