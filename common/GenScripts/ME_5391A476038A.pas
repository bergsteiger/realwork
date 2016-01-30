unit MemoryUsagePrim_Form;
 {* Используемые ресурсы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MemoryUsagePrim_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

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
;

type
 TMemoryUsagePrimForm = class(TvcmEntityForm)
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
  public
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Clear; override;
    {* Очистить кэш документов }
   procedure Disable; override;
    {* Запретить кэш документов }
  public
   property pnTagTree: TvtPanel
    read f_pnTagTree;
   property pnSummary: TvtSizeablePanel
    read f_pnSummary;
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
;

procedure TMemoryUsagePrimForm.UpdateDocumentsInCacheCount;
//#UC START# *5391C4630189_5391A476038A_var*
//#UC END# *5391C4630189_5391A476038A_var*
begin
//#UC START# *5391C4630189_5391A476038A_impl*
 lbDocumentsInCacheCount.CCaption := vcmFmt(str_CachedDocumentsCount, [TevDocumentsCache.Count]);
//#UC END# *5391C4630189_5391A476038A_impl*
end;//TMemoryUsagePrimForm.UpdateDocumentsInCacheCount

{$If NOT Defined(NoVCM)}
procedure TMemoryUsagePrimForm.Ok;
 {* OK }
//#UC START# *4C762A1501FC_5391A476038A_var*
//#UC END# *4C762A1501FC_5391A476038A_var*
begin
//#UC START# *4C762A1501FC_5391A476038A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762A1501FC_5391A476038A_impl*
end;//TMemoryUsagePrimForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

procedure TMemoryUsagePrimForm.Clear;
 {* Очистить кэш документов }
//#UC START# *5391D18801D6_5391A476038A_var*
//#UC END# *5391D18801D6_5391A476038A_var*
begin
//#UC START# *5391D18801D6_5391A476038A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5391D18801D6_5391A476038A_impl*
end;//TMemoryUsagePrimForm.Clear

procedure TMemoryUsagePrimForm.Disable;
 {* Запретить кэш документов }
//#UC START# *5391D193004A_5391A476038A_var*
//#UC END# *5391D193004A_5391A476038A_var*
begin
//#UC START# *5391D193004A_5391A476038A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5391D193004A_5391A476038A_impl*
end;//TMemoryUsagePrimForm.Disable

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMemoryUsagePrimForm);
 {* Регистрация MemoryUsagePrim }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
