unit MemoryUsagePrim_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/MemoryUsagePrim_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Оболочка Без Прецедентов::F1 Without Usecases::View::Main::MemoryUsagePrim
//
// Используемые ресурсы
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
  evMemo,
  eeTreeView
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  ,
  vtSizeablePanel,
  vtPanel
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  vtLabel,
  F1_Without_Usecases_DocumentsCacheOperations_Controls,
  l3TreeInterfaces,
  vcmExternalInterfaces {a},
  vcmInterfaces {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TMemoryUsagePrimForm = {form} class(TvcmEntityForm)
  {* Используемые ресурсы }
 private
 // private fields
   f_pnTagTree : TvtPanel;
    {* Поле для свойства pnTagTree}
   f_TagTree : TeeTreeView;
    {* Поле для свойства TagTree}
   f_pnMemClasses : TvtSizeablePanel;
    {* Поле для свойства pnMemClasses}
   f_memClasses : TevMemo;
    {* Поле для свойства memClasses}
   f_pnSummary : TvtSizeablePanel;
    {* Поле для свойства pnSummary}
   f_lbLocalMemory : TvtLabel;
    {* Поле для свойства lbLocalMemory}
   f_lbObjectMemory : TvtLabel;
    {* Поле для свойства lbObjectMemory}
   f_lbObjectCount : TvtLabel;
    {* Поле для свойства lbObjectCount}
   f_lbGlobalMemory : TvtLabel;
    {* Поле для свойства lbGlobalMemory}
   f_lbDocumentsInCacheCount : TvtLabel;
    {* Поле для свойства lbDocumentsInCacheCount}
   f_lbAllLocalMemory : TvtLabel;
    {* Поле для свойства lbAllLocalMemory}
   f_lbTotalMemory : TvtLabel;
    {* Поле для свойства lbTotalMemory}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure UpdateDocumentsInCacheCount;
     {* Сигнатура метода UpdateDocumentsInCacheCount }
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   procedure DocumentsCache_Clear_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Очистить кэш документов }
   procedure DocumentsCache_Disable_Test(const aParams: IvcmTestParamsPrim);
     {* Запретить кэш документов }
   procedure DocumentsCache_Disable_GetState(var State: TvcmOperationStateIndex);
     {* Запретить кэш документов }
   procedure DocumentsCache_Disable_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Запретить кэш документов }
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 public
 // public properties
   property pnTagTree: TvtPanel
     read f_pnTagTree;
   property TagTree: TeeTreeView
     read f_TagTree;
   property pnMemClasses: TvtSizeablePanel
     read f_pnMemClasses;
   property memClasses: TevMemo
     read f_memClasses;
   property pnSummary: TvtSizeablePanel
     read f_pnSummary;
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

 TvcmEntityFormRef = TMemoryUsagePrimForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  evDocumentsCache
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  nevBase,
  l3Base,
  nevTools,
  evOp,
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TMemoryUsagePrimForm

procedure TMemoryUsagePrimForm.UpdateDocumentsInCacheCount;
//#UC START# *5391C4630189_5391A476038A_var*
//#UC END# *5391C4630189_5391A476038A_var*
begin
//#UC START# *5391C4630189_5391A476038A_impl*
 lbDocumentsInCacheCount.CCaption := vcmFmt(str_CachedDocumentsCount, [TevDocumentsCache.Count]);
//#UC END# *5391C4630189_5391A476038A_impl*
end;//TMemoryUsagePrimForm.UpdateDocumentsInCacheCount

{$If not defined(NoVCM)}
procedure TMemoryUsagePrimForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C762A1501FC_5391A476038Aexec_var*
//#UC END# *4C762A1501FC_5391A476038Aexec_var*
begin
//#UC START# *4C762A1501FC_5391A476038Aexec_impl*
 ModalResult := mrOk;
//#UC END# *4C762A1501FC_5391A476038Aexec_impl*
end;//TMemoryUsagePrimForm.Result_Ok_Execute
{$IfEnd} //not NoVCM

procedure TMemoryUsagePrimForm.DocumentsCache_Clear_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *5391D18801D6_5391A476038Aexec_var*
//#UC END# *5391D18801D6_5391A476038Aexec_var*
begin
//#UC START# *5391D18801D6_5391A476038Aexec_impl*
 TevDocumentsCache.Clear;
 UpdateDocumentsInCacheCount;
//#UC END# *5391D18801D6_5391A476038Aexec_impl*
end;//TMemoryUsagePrimForm.DocumentsCache_Clear_Execute

procedure TMemoryUsagePrimForm.DocumentsCache_Disable_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *5391D193004A_5391A476038Atest_var*
//#UC END# *5391D193004A_5391A476038Atest_var*
begin
//#UC START# *5391D193004A_5391A476038Atest_impl*
 //aParams.Op.Flag[vcm_ofChecked] := not g_evDocumentsCacheEnabled;
//#UC END# *5391D193004A_5391A476038Atest_impl*
end;//TMemoryUsagePrimForm.DocumentsCache_Disable_Test

procedure TMemoryUsagePrimForm.DocumentsCache_Disable_GetState(var State: TvcmOperationStateIndex);
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

procedure TMemoryUsagePrimForm.DocumentsCache_Disable_Execute(const aParams: IvcmExecuteParamsPrim);
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

{$If not defined(NoVCM)}
procedure TMemoryUsagePrimForm.DoInit(aFromHistory: Boolean);
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TMemoryUsagePrimForm.InitControls;
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
{$IfEnd} //not NoVCM

procedure TMemoryUsagePrimForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  PublishFormEntity(en_DocumentsCache, nil);
  ToolbarAtBottom(en_Result);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, nil, nil);
  ShowInToolbar(en_Result, op_Ok, true);
  {$IfEnd} //not NoVCM

  PublishOp(en_DocumentsCache, op_Clear, DocumentsCache_Clear_Execute, nil, nil);
  ShowInToolbar(en_DocumentsCache, op_Clear, true);
  PublishOp(en_DocumentsCache, op_Disable, DocumentsCache_Disable_Execute, DocumentsCache_Disable_Test, DocumentsCache_Disable_GetState);
  ShowInToolbar(en_DocumentsCache, op_Disable, true);
 end;//with Entities.Entities
end;

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
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MemoryUsagePrim
 TtfwClassRef.Register(TMemoryUsagePrimForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.