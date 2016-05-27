unit MemoryUsagePrim_Form;
 {* Используемые ресурсы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MemoryUsagePrim_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "MemoryUsagePrim" MUID: (5391A476038A)
// Имя типа: "TMemoryUsagePrimForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , F1_Without_Usecases_DocumentsCacheOperations_Controls
 , vtPanel
 , eeTreeView
 , vtSizeablePanel
 , evMemo
 , vtLabel
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TMemoryUsagePrimForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Используемые ресурсы }
  private
   f_pnTagTree: TvtPanel;
    {* Поле для свойства pnTagTree }
   f_TagTree: TeeTreeView;
    {* Поле для свойства TagTree }
   f_pnMemClasses: TvtSizeablePanel;
    {* Поле для свойства pnMemClasses }
   f_memClasses: TevMemo;
    {* Поле для свойства memClasses }
   f_pnSummary: TvtSizeablePanel;
    {* Поле для свойства pnSummary }
   f_lbLocalMemory: TvtLabel;
    {* Поле для свойства lbLocalMemory }
   f_lbObjectMemory: TvtLabel;
    {* Поле для свойства lbObjectMemory }
   f_lbObjectCount: TvtLabel;
    {* Поле для свойства lbObjectCount }
   f_lbGlobalMemory: TvtLabel;
    {* Поле для свойства lbGlobalMemory }
   f_lbDocumentsInCacheCount: TvtLabel;
    {* Поле для свойства lbDocumentsInCacheCount }
   f_lbAllLocalMemory: TvtLabel;
    {* Поле для свойства lbAllLocalMemory }
   f_lbTotalMemory: TvtLabel;
    {* Поле для свойства lbTotalMemory }
  private
   procedure UpdateDocumentsInCacheCount;
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
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
   {$If NOT Defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure DocumentsCache_Clear_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Очистить кэш документов }
   procedure DocumentsCache_Disable_Test(const aParams: IvcmTestParamsPrim);
    {* Запретить кэш документов }
   procedure DocumentsCache_Disable_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Запретить кэш документов }
   procedure DocumentsCache_Disable_GetState(var State: TvcmOperationStateIndex);
    {* Запретить кэш документов }
  public
   property pnTagTree: TvtPanel
    read f_pnTagTree;
   property pnSummary: TvtSizeablePanel
    read f_pnSummary;
   property TagTree: TeeTreeView
    read f_TagTree;
   property pnMemClasses: TvtSizeablePanel
    read f_pnMemClasses;
   property memClasses: TevMemo
    read f_memClasses;
   property lbLocalMemory: TvtLabel
    read f_lbLocalMemory;
   property lbObjectMemory: TvtLabel
    read f_lbObjectMemory;
   property lbObjectCount: TvtLabel
    read f_lbObjectCount;
   property lbGlobalMemory: TvtLabel
    read f_lbGlobalMemory;
   property lbDocumentsInCacheCount: TvtLabel
    read f_lbDocumentsInCacheCount;
   property lbAllLocalMemory: TvtLabel
    read f_lbAllLocalMemory;
   property lbTotalMemory: TvtLabel
    read f_lbTotalMemory;
 end;//TMemoryUsagePrimForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , evDocumentsCache
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
 , nevBase
 , l3Base
 , nevTools
 , evOp
 , SysUtils
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

{$If NOT Defined(NoVCM)}
procedure TMemoryUsagePrimForm.UpdateDocumentsInCacheCount;
//#UC START# *5391C4630189_5391A476038A_var*
//#UC END# *5391C4630189_5391A476038A_var*
begin
//#UC START# *5391C4630189_5391A476038A_impl*
 lbDocumentsInCacheCount.CCaption := vcmFmt(str_CachedDocumentsCount, [TevDocumentsCache.Count]);
//#UC END# *5391C4630189_5391A476038A_impl*
end;//TMemoryUsagePrimForm.UpdateDocumentsInCacheCount

procedure TMemoryUsagePrimForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
//#UC START# *4C762A1501FC_5391A476038Aexec_var*
//#UC END# *4C762A1501FC_5391A476038Aexec_var*
begin
//#UC START# *4C762A1501FC_5391A476038Aexec_impl*
 ModalResult := mrOk;
//#UC END# *4C762A1501FC_5391A476038Aexec_impl*
end;//TMemoryUsagePrimForm.Result_Ok_Execute

procedure TMemoryUsagePrimForm.DocumentsCache_Clear_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Очистить кэш документов }
//#UC START# *5391D18801D6_5391A476038Aexec_var*
//#UC END# *5391D18801D6_5391A476038Aexec_var*
begin
//#UC START# *5391D18801D6_5391A476038Aexec_impl*
 TevDocumentsCache.Clear;
 UpdateDocumentsInCacheCount;
//#UC END# *5391D18801D6_5391A476038Aexec_impl*
end;//TMemoryUsagePrimForm.DocumentsCache_Clear_Execute

procedure TMemoryUsagePrimForm.DocumentsCache_Disable_Test(const aParams: IvcmTestParamsPrim);
 {* Запретить кэш документов }
//#UC START# *5391D193004A_5391A476038Atest_var*
//#UC END# *5391D193004A_5391A476038Atest_var*
begin
//#UC START# *5391D193004A_5391A476038Atest_impl*
 //aParams.Op.Flag[vcm_ofChecked] := not g_evDocumentsCacheEnabled;
//#UC END# *5391D193004A_5391A476038Atest_impl*
end;//TMemoryUsagePrimForm.DocumentsCache_Disable_Test

procedure TMemoryUsagePrimForm.DocumentsCache_Disable_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Запретить кэш документов }
//#UC START# *5391D193004A_5391A476038Aexec_var*
//#UC END# *5391D193004A_5391A476038Aexec_var*
begin
//#UC START# *5391D193004A_5391A476038Aexec_impl*
 if g_evDocumentsCacheEnabled then
 begin
  TevDocumentsCache.Clear;
  UpdateDocumentsInCacheCount;
  g_evDocumentsCacheEnabled := False;
 end
 else
  g_evDocumentsCacheEnabled := True;
//#UC END# *5391D193004A_5391A476038Aexec_impl*
end;//TMemoryUsagePrimForm.DocumentsCache_Disable_Execute

procedure TMemoryUsagePrimForm.DocumentsCache_Disable_GetState(var State: TvcmOperationStateIndex);
 {* Запретить кэш документов }
//#UC START# *5391D193004A_5391A476038Agetstate_var*
//#UC END# *5391D193004A_5391A476038Agetstate_var*
begin
//#UC START# *5391D193004A_5391A476038Agetstate_impl*
 if g_evDocumentsCacheEnabled then
  State := st_user_DocumentsCache_Disable_Disable
 else
  State := st_user_DocumentsCache_Disable_Enable;
//#UC END# *5391D193004A_5391A476038Agetstate_impl*
end;//TMemoryUsagePrimForm.DocumentsCache_Disable_GetState

procedure TMemoryUsagePrimForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_5391A476038A_var*
 function SepInt(I: Integer): AnsiString;
 var
  D: Double;
  C: AnsiChar;
 begin
  D := I;
  C := {$IfDef XE}FormatSettings.{$EndIf}ThousandSeparator;
  try
   {$IfDef XE}FormatSettings.{$EndIf}ThousandSeparator := ',';
   Result := Format('%n', [D]);
   SetLength(Result, Length(Result)-3);
  finally
   {$IfDef XE}FormatSettings.{$EndIf}ThousandSeparator := C;
  end;{try..finally}
 end;
{$IfDef l3TraceClasses}
var
 i: Integer;
 CL: TStrings;
 l_Op: InevOp;
{$EndIf l3TraceClasses}
//#UC END# *49803F5503AA_5391A476038A_var*
begin
//#UC START# *49803F5503AA_5391A476038A_impl*
 inherited;
 with l3Base.l3System do begin
  lbLocalMemory.CCaption := vcmFmt(str_l3LocalMemory, [SepInt(LocalMemUsed)]);
  lbAllLocalMemory.CCaption := vcmFmt(str_LocalMemory, [SepInt(SysLocalMemUsed)]);
  lbGlobalMemory.CCaption := vcmFmt(str_GlobalMemory, [SepInt(GlobalMemUsed)]);
  lbObjectMemory.CCaption := vcmFmt(str_ObjectMemory, [SepInt(ObjectMemUsed)]);
  lbTotalMemory.CCaption := vcmFmt(str_OverallMemory, [SepInt(LocalMemUsed + SysLocalMemUsed + GlobalMemUsed + ObjectMemUsed)]);
  lbObjectCount.CCaption := vcmFmt(str_ObjectCount, [SepInt(ObjectCount)]);
 end;//with l3Base.l3System
 UpdateDocumentsInCacheCount;
 {$IfDef k2TagTree}
 TagTree.TreeSource := GetStandardTypeTable.TagTree;
 {$Else  k2TagTree}
 TagTree.Visible := false;
 pnMemClasses.Align := alClient;
 pnMemClasses.SizeableSides := [];
 {$EndIf k2TagTree}
 memClasses.Text := '';
 {$IfDef l3TraceClasses}
 with memClasses do
 begin
  Document;
  CL := l3System.ClassList;
  TextSource.Indicator.Start(Pred(CL.Count), vcmCStr(str_LoadingObjectList));
  try
   l_Op := StartOp;
   try
    with Range do
    begin
     for i := 0 to Pred(CL.Count) do
     begin
      TextSource.Indicator.Progress(i);
      InsertString(CL[i] + ' = ' + IntToStr(Integer(CL.Objects[i])));
      InsertParaBreak;
     end;//for i
    end;//with Range
    InevSelection(Selection).Unselect;
    MoveLeafCursor(ev_ocTopLeft, true);
   finally
    l_Op := nil;
   end;//try..finally
  finally
   TextSource.Indicator.Finish;
  end;//try..finally
 end;//with memClasses
 {$Else  l3TraceClasses}
 memClasses.Visible := false;
 {$EndIf l3TraceClasses}
 if not memClasses.Visible AND not TagTree.Visible then begin
  pnTagTree.Visible := false;
  pnSummary.Align := alClient;
 end;//not memClasses.Visible..
//#UC END# *49803F5503AA_5391A476038A_impl*
end;//TMemoryUsagePrimForm.DoInit

procedure TMemoryUsagePrimForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_5391A476038A_var*
//#UC END# *4A8E8F2E0195_5391A476038A_var*
begin
//#UC START# *4A8E8F2E0195_5391A476038A_impl*
 inherited;
 Width := 1024;
 Height := 768;
 with pnTagTree do
 begin
  Align := alClient;
  TabOrder := 0;
 end;
 with TagTree do
 begin
  Align := alClient;
  BorderStyle := bsNone;
  TabOrder := 0;
 end;
 with pnMemClasses do
 begin
  Height := 130;
  ResizeAreaWidth := 5;
  SizeableSides := [szTop];
  SplitterBevel := bvRaised;
  Align := alBottom;
  BevelOuter := bvNone;
  TabOrder := 1;
 end;
 with memClasses do
 begin
  AutoSelect := False;
  Align := alClient;
 end;
 with pnSummary do
 begin
  Width := 305;
  ResizeAreaWidth := 5;
  SizeableSides := [szRight];
  SplitterBevel := bvRaised;
  Align := alLeft;
  BevelOuter := bvNone;
  TabOrder := 1;
 end;;
 with lbLocalMemory do
 begin
   AutoSize := False;
   Left := 14;
   Top := 10;
   Width := 283;
   Height := 16;
   DrawDirection := ddHorizontal;
 end;
 with lbObjectMemory do
 begin
   AutoSize := False;
   Left := 14;
   Top := 70;
   Width := 283;
   Height := 17;
   DrawDirection := ddHorizontal;
 end;
 with lbObjectCount do
 begin
   AutoSize := False;
   Left := 14;
   Top := 110;
   Width := 283;
   Height := 16;
   AutoSize := False;
   DrawDirection := ddHorizontal;
 end;
 with lbGlobalMemory do
 begin
   AutoSize := False;
   Left := 14;
   Top := 50;
   Width := 283;
   Height := 16;
   DrawDirection := ddHorizontal;
 end;
 with lbDocumentsInCacheCount do
 begin
   AutoSize := False;
   Left := 14;
   Top := 130;
   Width := 253;
   Height := 13;
   DrawDirection := ddHorizontal;
 end;
 with lbAllLocalMemory do
 begin
   AutoSize := False;
   Left := 14;
   Top := 30;
   Width := 275;
   Height := 13;
   DrawDirection := ddHorizontal;
 end;
 with lbTotalMemory do
 begin
   AutoSize := False;
   Left := 14;
   Top := 90;
   Width := 275;
   Height := 16;
   DrawDirection := ddHorizontal;
 end;
//#UC END# *4A8E8F2E0195_5391A476038A_impl*
end;//TMemoryUsagePrimForm.InitControls

procedure TMemoryUsagePrimForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  PublishFormEntity(en_DocumentsCache, nil);
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, nil, nil);
  PublishOp(en_DocumentsCache, op_Clear, DocumentsCache_Clear_Execute, nil, nil);
  PublishOp(en_DocumentsCache, op_Disable, DocumentsCache_Disable_Execute, DocumentsCache_Disable_Test, DocumentsCache_Disable_GetState);
 end;//with Entities.Entities
end;//TMemoryUsagePrimForm.InitEntities

procedure TMemoryUsagePrimForm.MakeControls;
begin
 inherited;
 f_pnTagTree := TvtPanel.Create(Self);
 f_pnTagTree.Name := 'pnTagTree';
 f_pnTagTree.Parent := Self;
 f_TagTree := TeeTreeView.Create(Self);
 f_TagTree.Name := 'TagTree';
 f_TagTree.Parent := pnTagTree;
 f_pnMemClasses := TvtSizeablePanel.Create(Self);
 f_pnMemClasses.Name := 'pnMemClasses';
 f_pnMemClasses.Parent := pnTagTree;
 f_memClasses := TevMemo.Create(Self);
 f_memClasses.Name := 'memClasses';
 f_memClasses.Parent := pnMemClasses;
 f_pnSummary := TvtSizeablePanel.Create(Self);
 f_pnSummary.Name := 'pnSummary';
 f_pnSummary.Parent := Self;
 f_lbLocalMemory := TvtLabel.Create(Self);
 f_lbLocalMemory.Name := 'lbLocalMemory';
 f_lbLocalMemory.Parent := pnSummary;
 f_lbObjectMemory := TvtLabel.Create(Self);
 f_lbObjectMemory.Name := 'lbObjectMemory';
 f_lbObjectMemory.Parent := pnSummary;
 f_lbObjectCount := TvtLabel.Create(Self);
 f_lbObjectCount.Name := 'lbObjectCount';
 f_lbObjectCount.Parent := pnSummary;
 f_lbGlobalMemory := TvtLabel.Create(Self);
 f_lbGlobalMemory.Name := 'lbGlobalMemory';
 f_lbGlobalMemory.Parent := pnSummary;
 f_lbDocumentsInCacheCount := TvtLabel.Create(Self);
 f_lbDocumentsInCacheCount.Name := 'lbDocumentsInCacheCount';
 f_lbDocumentsInCacheCount.Parent := pnSummary;
 f_lbAllLocalMemory := TvtLabel.Create(Self);
 f_lbAllLocalMemory.Name := 'lbAllLocalMemory';
 f_lbAllLocalMemory.Parent := pnSummary;
 f_lbTotalMemory := TvtLabel.Create(Self);
 f_lbTotalMemory.Name := 'lbTotalMemory';
 f_lbTotalMemory.Parent := pnSummary;
end;//TMemoryUsagePrimForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMemoryUsagePrimForm);
 {* Регистрация MemoryUsagePrim }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
