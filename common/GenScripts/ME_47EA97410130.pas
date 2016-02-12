unit evDocumentPreviewPrim;
 {* Предварительный просмотр печати документа }

// Модуль: "w:\common\components\gui\Garant\Everest\evDocumentPreviewPrim.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , nevObjectHolderPrim
 , afwInterfaces
 , nevTools
 , l3InternalInterfaces
 , nevBase
 , Windows
 , l3Interfaces
 , l3TimeEstimation
 , afwPreviewNotifierPtrList
 , l3Variant
 , k2TagGen
 , nevRealTools
 , l3PrinterInterfaces
 , afwTypes
 , l3Units
 , evExcept
 , k2DocumentBuffer
 , afwPreviewCanvas
 , l3Core
;

type
 _afwSettingChanged_Parent_ = TnevObjectHolderPrim;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingChanged.imp.pas}
 _afwSettingsReplace_Parent_ = _afwSettingChanged_;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingsReplace.imp.pas}
 _afwStatusElement_Parent_ = _afwSettingsReplace_;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwStatusElement.imp.pas}
 TevDocumentPreviewPrim = class(_afwStatusElement_, IafwDocumentPreview, IafwPreviewNotificationSource, IevDocumentPreviewInfo, Il3AbortChecker)
  {* Предварительный просмотр печати документа }
  private
   f_MakingCanvas: Boolean;
   f_Stopped: Boolean;
   f_InAquareText: Boolean;
   f_AbortFilter: IafwAbortableProcess;
   f_PrinterIndex: Integer;
   f_InPagesCounting: Boolean;
   f_HAF: IafwHAFPainter;
   f_CacheKey: TevPreviewCacheKey;
   f_CurrentPagePara: Integer;
   f_OriginalCurrentPage: Integer;
   f_CurrentPageNumber: Integer;
   f_CalcCurrentPageByPara: Boolean;
   f_Counter: IafwPreviewCanvas;
   f_Panel: IafwPreviewPanel;
   f_MaxPages: Integer;
   f_PreviewResetting: Boolean;
   f_WndToClose: THandle;
   f_Msg: Il3CString;
   f_Max: Integer;
   f_Current: Integer;
   f_InUpdate: Boolean;
   f_InPrinting: Boolean;
   f_CurrentPage: IUnknown;
   f_Time: Tl3TimeEstimation;
   f_PreviewSubscribers: TafwPreviewNotifierPtrList;
   f_OriginalText: InevDocumentProvider;
   f_TextOwner: Tl3Variant;
    {* Владелец текста, отличный от нас }
   f_Preview: IafwPreviewCanvas;
    {* Поле для свойства Preview }
   f_Text: InevObject;
    {* Поле для свойства Text }
   f_Printer: IafwPrinter;
    {* Поле для свойства Printer }
   f_Processor: InevProcessor;
    {* Поле для свойства Processor }
   f_PagesInfo: TafwPagesInfo;
    {* Поле для свойства PagesInfo }
  private
   function GetText: InevObject;
    {* Получаем текст документа для просмотра }
   function GetPreviewCanvas(const aPagesInfo: TafwPagesInfo;
    aCounter: Boolean): IafwPreviewCanvas;
    {* Подготавливает виртуальную канву }
   procedure TryClose;
    {* Пытается прервать печать и закрыть окно }
   procedure AbortPreviewPrepare;
    {* Прекратить подготовку и очистить превью - что-то поменялось и надо его переделывать заново }
   function CurrentPageForUpdate: Integer;
   function GetPreviewForCurrentPage: IafwPreviewCanvas;
   procedure NotifyPreviewSubscribers;
   procedure DoSetFilters(var theGenerator: Tk2TagGenerator);
   function HasPreviewBuilder: Boolean;
  protected
   function pm_GetPreview: IafwPreviewCanvas;
   function pm_GetText: InevObject;
   function pm_GetPrinter: IafwPrinter;
   procedure pm_SetPrinter(const aValue: IafwPrinter);
   function pm_GetProcessor: InevProcessor;
   function pm_GetPagesInfo: TafwPagesInfo;
   function DoPrint(const aCanvas: InevCanvas;
    const aPagesArray: TafwPrintPagesArray = nil): Boolean;
    {* Собственно процесс печати }
   procedure UnformatView(const aView: InevView);
    {* Сбрасывает информацию о форматировании для конкретного View }
   procedure SetFilters(var theGenerator: Tk2TagGenerator); virtual;
   procedure ClearPreview;
   function InClose: Boolean;
   function PrePrint(anIndex: Integer): TafwPagesInfo;
   procedure ProgressProcEv(aState: Byte;
    aValue: Integer;
    const aMsg: AnsiString);
   procedure CheckAborted(var Aborted: Boolean);
   function IsSettingAffectsUs(const aSettingId: TafwSettingId): Boolean; virtual;
   procedure AfterPrint; virtual;
   function NeedAddBlockNames: Boolean; virtual;
    {* Нужно ли добавлять имена блоков }
   function DocumentName: IafwCString;
    {* имя документа для preview. }
   function InProcess: Boolean;
    {* идет процесс? }
   function InPagesCounting: Boolean;
    {* сейчас в процессе подсчета страниц? }
   function InUpdate: Boolean;
    {* находимся в процессе построения preview? }
   function InPrinting: Boolean;
    {* находимся в процессе построения печати? }
   procedure Update(const aPanel: IafwPreviewPanel);
    {* установить preview на панель для отображения. }
   procedure Print(anInterval: TafwPagesInterval = afwTypes.afw_piAll;
    const aRange: Il3RangeManager = nil;
    aCopies: Integer = 1;
    const aFileName: AnsiString = '';
    aCollate: Boolean = True);
    {* напечатать на принтер. }
   procedure Stop(aWnd: THandle = 0);
    {* остановит процесс построение preview/печати. }
   function Stopped: Boolean;
    {* процесс остановлен? }
   function CloseRequested: Boolean;
    {* при остановке процесса был запрос на закрытие превью }
   function PreviewResetting: Boolean;
    {* канва отсутствует, но будет передалываться }
   procedure SetCurrentPage(const aCursor: IUnknown);
    {* устанавливает курсор на текущую страницу. }
   procedure SetCurrentPagePara(aParaID: Integer);
    {* устанавливает курсор на текущую страницу. }
   procedure SetCurrentPageNumber(aPageNumber: Integer);
    {* устанавливает курсор на текущую страницу. }
   function CurrentPage: Integer;
    {* текущая страница для печати. }
   function HasCurrentPage: Boolean;
    {* установлена ли текущая страница. }
   function pm_GetHasText: Boolean;
   procedure Subscribe(const aNotifier: IafwPreviewNotifier);
   procedure UnSubscribe(const aNotifier: IafwPreviewNotifier);
   function pm_GetHAFMacroReplacer: IafwHAFMacroReplacer;
   function Get_Preview: IafwDocumentPreview;
   procedure DoInvalidateShape(const aShape: InevObject;
    aParts: TnevShapeParts); override;
   function GetTagReader: InevTagReader; override;
   function GetTagWriter: InevTagWriter; override;
   function Get_CacheKey: TevPreviewCacheKey;
   procedure DoGetStatusInfo(out theString: IafwCString;
    out theNeedProgress: Boolean); override;
    {* Собственно процесс получения информации }
   function IsAborted: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function DoSettingChanged(const aSettingId: TafwSettingId): Boolean; override;
    {* Обработчик изменения указанной настройки }
   procedure SettingsReplaceFinish; override;
   function GetObj: InevObject; override;
   procedure UnformatAll; override;
   function NeedUpdateOnUnsubscribe: Boolean; override;
   {$If NOT Defined(DesignTimeLibrary)}
   procedure DoStyleTableChanged; override;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure ClearFields; override;
  public
   constructor Create(const aText: InevStorable;
    const aKey: TevPreviewCacheKey;
    const aHAF: IafwHAFPainter = nil); reintroduce; overload;
   constructor Create(const aText: InevDocumentProvider;
    const aKey: TevPreviewCacheKey;
    const aHAF: IafwHAFPainter = nil); reintroduce; overload;
   procedure Print2PDF(const aCanvas: Il3Canvas);
  public
   property Preview: IafwPreviewCanvas
    read pm_GetPreview;
   property Text: InevObject
    read pm_GetText;
   property Printer: IafwPrinter
    read pm_GetPrinter
    write pm_SetPrinter;
   property Processor: InevProcessor
    read pm_GetProcessor;
   property PagesInfo: TafwPagesInfo
    read pm_GetPagesInfo;
 end;//TevDocumentPreviewPrim

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Printer
 , evPreviewProcessor
 , k2Tags
 , l3Base
 , l3MinMax
 , nevInterfaces
 , l3String
 , l3Math
 , l3Defaults
 , l3Const
 , evParaDrawTools
 , Graphics
 , l3SimpleObject
 , evdBlockNameAdder
 , nevDocumentProvider
 , evPreviewForTestsTuning
 {$If Defined(nsTest)}
 , PrintRowHeightsSpy
 {$IfEnd} // Defined(nsTest)
 , l3FileUtils
 {$If Defined(InsiderTest)}
 , evCustomPrintDataSaver
 {$IfEnd} // Defined(InsiderTest)
 {$If NOT Defined(NoScripts)}
 , afwAnswer
 {$IfEnd} // NOT Defined(NoScripts)
 , l3BatchService
 , afwFacade
 , afwSettingsChangePublisher
 , k2Except
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , afwCanvasEx
 , nevPrintView
 , l3Prg
 , DecorTextPara_Const
 , evAbortFilter
 , l3Except
 , evMsgCode
 , Messages
 , evHiddenFilter
 , evdPageParamsFilter
 , PageBreak_Const
 , Table_Const
 , SectionBreak_Const
 , evSectionPara
;

{$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingChanged.imp.pas}

{$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingsReplace.imp.pas}

{$Include w:\common\components\gui\Garant\AFW\implementation\afwStatusElement.imp.pas}

function TevDocumentPreviewPrim.pm_GetPreview: IafwPreviewCanvas;
//#UC START# *47EB82040062_47EA97410130get_var*
var
 l_Count : TafwPagesInfo;
//#UC END# *47EB82040062_47EA97410130get_var*
begin
//#UC START# *47EB82040062_47EA97410130get_impl*
 if (f_Preview = nil) then
 begin
  f_MakingCanvas := True;
  try
   l_Count := PagesInfo;
   if not Stopped then
   begin
    DoSubscribe;
    try
     f_Preview := GetPreviewCanvas(l_Count, false);
    finally
     DoUnSubscribe;
    end;//try..finally
   end;//not Stopped
  finally
   f_MakingCanvas := False;
  end;
 end;//f_Preview = nil
 Result := f_Preview;
//#UC END# *47EB82040062_47EA97410130get_impl*
end;//TevDocumentPreviewPrim.pm_GetPreview

function TevDocumentPreviewPrim.pm_GetText: InevObject;
//#UC START# *47EB8227023D_47EA97410130get_var*
//#UC END# *47EB8227023D_47EA97410130get_var*
begin
//#UC START# *47EB8227023D_47EA97410130get_impl*
 Result := GetText;
//#UC END# *47EB8227023D_47EA97410130get_impl*
end;//TevDocumentPreviewPrim.pm_GetText

function TevDocumentPreviewPrim.pm_GetPrinter: IafwPrinter;
//#UC START# *47EB823F010A_47EA97410130get_var*
//#UC END# *47EB823F010A_47EA97410130get_var*
begin
//#UC START# *47EB823F010A_47EA97410130get_impl*
 if (f_Printer = nil) then
  f_Printer := Tl3Printer.Make;
 Result := f_Printer;
//#UC END# *47EB823F010A_47EA97410130get_impl*
end;//TevDocumentPreviewPrim.pm_GetPrinter

procedure TevDocumentPreviewPrim.pm_SetPrinter(const aValue: IafwPrinter);
//#UC START# *47EB823F010A_47EA97410130set_var*
//#UC END# *47EB823F010A_47EA97410130set_var*
begin
//#UC START# *47EB823F010A_47EA97410130set_impl*
 if (f_Printer <> aValue) then
 begin
  f_Printer := aValue;
  ClearPreview;
 end;//f_Printer <> aValue
//#UC END# *47EB823F010A_47EA97410130set_impl*
end;//TevDocumentPreviewPrim.pm_SetPrinter

function TevDocumentPreviewPrim.pm_GetProcessor: InevProcessor;
//#UC START# *47EB8280024B_47EA97410130get_var*
//#UC END# *47EB8280024B_47EA97410130get_var*
begin
//#UC START# *47EB8280024B_47EA97410130get_impl*
 if (f_Processor = nil) then
  f_Processor := TevPreviewProcessor.Make(Self);
 Result := f_Processor;
//#UC END# *47EB8280024B_47EA97410130get_impl*
end;//TevDocumentPreviewPrim.pm_GetProcessor

function TevDocumentPreviewPrim.pm_GetPagesInfo: TafwPagesInfo;
//#UC START# *4CC6A35900D0_47EA97410130get_var*
var
 l_Index : Integer;
//#UC END# *4CC6A35900D0_47EA97410130get_var*
begin
//#UC START# *4CC6A35900D0_47EA97410130get_impl*
 l_Index := Printer.PrinterIndex;
 if (l_Index <> f_PrinterIndex) or Stopped then
  ClearPreview;
 if not f_PagesInfo.IsValid then
 begin
  if f_InPagesCounting OR InClose then
   Result := f_PagesInfo
  else
  begin
   if (f_HAF = nil) OR not f_HAF.NeedPagesCount then
   begin
    f_PagesInfo := TafwPagesInfo_H;
    Result := f_PagesInfo;
    f_PrinterIndex := l_Index;
   end//f_HAF = nil..
   else
    Result := PrePrint(l_Index);
  end;//f_InPagesCounting
 end//f_PagesCount <= 0
 else
  Result := f_PagesInfo;
//#UC END# *4CC6A35900D0_47EA97410130get_impl*
end;//TevDocumentPreviewPrim.pm_GetPagesInfo

function TevDocumentPreviewPrim.DoPrint(const aCanvas: InevCanvas;
 const aPagesArray: TafwPrintPagesArray = nil): Boolean;
 {* Собственно процесс печати }
var l_Width: Integer;
 {* Запоминаемая ширина документа }
var l_Area: TnevShapeAreaEx;
var l_Ind: InevProgress;
var l_Canvas: InevCanvas;
var l_Printer: Il3Printer;
var l_View: InevPrintView;
var l_Text: InevObject;

 procedure DocumentPrint(const anArea: TnevShapeArea;
  const aDocument: InevObject;
  const aProgress: Il3Progress);
  {* Печать документа }
 var l_Aborted: Boolean;
  {* Печать прервана }
 var l_PaperWidth: Integer;
  {* Ширина бумаги }
 var l_Info: TnevShapeInfo;
  {* Информация для отрисовки }
 var l_Width2Print: Integer;
  {* Ширина печатаемой секции }
 var l_PrintableWidth: Integer;
  {* Ширина печатаемого куска }
 var l_Top: Tl3Point;
  {* Смещение текущего куска }
 var l_NextPage: InevBasePoint;
  {* Якорь на следующую страницу }
 var l_Anchor: InevAnchor;
  {* Якорь на начало документа }
 var l_PageHeight: Integer;
  {* Высота страницы }
 var l_SomethingPrinted: Boolean;
  {* Напечатали ли чего за итерацию цикла }
 var l_BottomPoint: InevBasePoint;
  {* Самая нижняя точка при печати по ширине. }
 var l_PrevHeight: Integer;
  {* Высота вычисленная на предыдущей странице }
 var l_DisableUnformat: Boolean;
  {* http://mdp.garant.ru/pages/viewpage.action?pageId=210043454&focusedCommentId=210436611#comment-210436611 }
 var l_WidthExtent: Tl3Point;
  {* По ширине }
 var l_HeightExtent: Tl3Point;
  {* Расширение страницы }

  function PrintPara(const aPara: InevObject;
   const aTop: InevBasePoint;
   aPrevHeight: Integer): TnevShapeInfo;
   {* Печатает параграф }
  //#UC START# *49CB7CF103B6__var*
  //#UC END# *49CB7CF103B6__var*
  begin
  //#UC START# *49CB7CF103B6__impl*
   Result := evDrawPara(anArea, aPara, aTop, aPara.Range, aPrevHeight);
  //#UC END# *49CB7CF103B6__impl*
  end;//PrintPara


  function DocumentHeight: Integer;
   {* Высота документа }
  //#UC START# *49CB8C8B02C7__var*
  //#UC END# *49CB8C8B02C7__var*
  begin
  //#UC START# *49CB8C8B02C7__impl*
   Result := aDocument.ToList.LeafShapeCount * nev_ParaListFakeParaEx.Y;
  //#UC END# *49CB8C8B02C7__impl*
  end;//DocumentHeight


  procedure CheckSectionBreak;

   procedure SkipSectionBreak(const anAnchor: InevAnchor);
   var l_Line: Integer;
   //#UC START# *49CB8FF602C5__var*
   //#UC END# *49CB8FF602C5__var*
   begin
   //#UC START# *49CB8FF602C5__impl*
    l_Line := 1;
    anAnchor.IncLine(anArea.rView.As_InevView, l_Line, False);
   //#UC END# *49CB8FF602C5__impl*
   end;//SkipSectionBreak

  //#UC START# *49CB8D7B02A2__var*
  var
   l_Para : InevObject; // Текущий параграф

   function lp_IsParaSectionBreak(const anAnchor: InevAnchor): Boolean;
   begin
    Result := False;
    l_Para := anAnchor.MostInner.Obj^;
    with l_Para do
     if IsKindOf(k2_typSectionBreak) then
     begin
      anArea.rCanvas.SectionExtent := evSectionExtent(l_Para.AsObject);
      SkipSectionBreak(anAnchor);
      Result := True;
     end//IsKindOf(k2_typSectionBreak)
   end;

   {$IFDEF Nemesis}
   function lp_CheckDecorPara: Boolean;
   var
    l_CheckAnchor: InevAnchor;
   begin
    Result := False;
    if l_Para.IsKindOf(k2_typDecorTextPara) then
    begin
     l_CheckAnchor := l_Anchor.Obj.MakeAnchor;
     l_CheckAnchor.AssignPoint(anArea.rView.As_InevView, l_Anchor);
     SkipSectionBreak(l_CheckAnchor);
     if lp_IsParaSectionBreak(l_CheckAnchor) then
     begin
      Result := True;
      l_Anchor.AssignPoint(anArea.rView.As_InevView, l_CheckAnchor);
     end; // if lp_IsParaSectionBreak(l_CheckAnchor) then
    end; // if l_Para.IsKindOf(k2_typDecorTextPara) then
   end;
   {$ENDIF Nemesis}
  //#UC END# *49CB8D7B02A2__var*
  begin
  //#UC START# *49CB8D7B02A2__impl*
    if not lp_IsParaSectionBreak(l_Anchor) then
    {$IFDEF Nemesis}
     if not lp_CheckDecorPara then
    {$ENDIF Nemesis}
      anArea.rCanvas.SectionExtent := l3Point(aDocument.AsObject.IntA[k2_tiWidth],
                                             anArea.rCanvas.SectionExtent.Y);
  //#UC END# *49CB8D7B02A2__impl*
  end;//CheckSectionBreak

 //#UC START# *49CB801A037F__var*
 var
  l_PageSetup : IafwPageSetup;
  l_Margins   : Tl3_Rect;
  l_MarginsWidth: Integer;
 //#UC END# *49CB801A037F__var*
 begin
 //#UC START# *49CB801A037F__impl*
  if (aProgress <> nil) then
   aProgress.ChangeIO(True);
  try
   with anArea.rCanvas do
   begin
    DrawEnabled := True;
    if (aProgress <> nil) then
     aProgress.Start(DocumentHeight, str_nevpmPrinting.AsCStr);
    try
     l_Top := l3Point0;
     l_Anchor := aDocument.MakeAnchor;
     CheckSectionBreak;
     l_NextPage := l_Anchor;

     l_PageSetup := f_OriginalText.PageSetup;
     {$IF not Defined(Archi) and not Defined(EverestLite)}
     // http://mdp.garant.ru/pages/viewpage.action?pageId=252512973
     Assert({$IfDef nsTest}
            OldBehaviourForK235875079 OR
            {$EndIf nsTest}
            (l_PageSetup <> nil));
     {$IfEnd}//{$IF not Defined(Archi) and not Defined(EverestLite)}
     if (l_PageSetup <> nil) then
      l_Margins := l_PageSetup.Margins
     else
     {$If Defined(nsTest) OR Defined(Archi) or Defined(EverestLite)}
      with Text.AsObject.Attr[k2_tiParas] do
       l_Margins := l3Rect(IntA[k2_tiLeftIndent],
                           IntA[k2_tiSpaceBefore],
                           IntA[k2_tiRightIndent],
                           IntA[k2_tiSpaceAfter]);
     {$Else}//Defined(nsTest) OR Defined(Archi)
     begin
      l3FillChar(l_Margins, SizeOf(l_Margins));
      Assert(false);
     end;//l_PageSetup <> nil
     {$IfEnd}//Defined(nsTest) OR Defined(Archi)
     with PageSetup do
     begin
      if (Min(PaperWidth, PaperHeight) -
         (l_Margins.Top + l_Margins.Bottom)) <
         (def_inchMinPrintArea - l3Epsilon) then
       raise EevInvalidPrintMargins.Create(ev_warInvalidMargins);
      Margins := l_Margins;
     end;//with PageSetup
     BackColor := clWhite;
     try
      BeginPaint;
     except
      on Ek2ConversionError do
      begin
       // - Прервали печать - надо корректно это отработать
       EndPaint;
       Exit;
      end;//on Ek2ConversionError
     end;//try..except
      try
       l_Aborted := False;
       CheckAborted(l_Aborted);
       if l_Aborted then
        Exit;
       l_MarginsWidth := 0; 
       l_HeightExtent := anArea.rCanvas.SectionExtent;
       repeat
        // - Цикл по страницам в высоту
        with PageSetup do
        begin
         // - Берем настройки текущего раздела
         l_PaperWidth := PaperWidth;
         l_PrintableWidth := Width;
         l_MarginsWidth := l_PaperWidth - l_PrintableWidth;
        end;//with PageSetup
        l_PageHeight := 0;
        l_Width2Print := SectionExtent.X;
        l_Top.X := 0;                                                   

        l_BottomPoint := nil;
        l_PrevHeight := 0;
        l_WidthExtent := l3Point(l_HeightExtent.X - l_MarginsWidth, l_HeightExtent.Y);;
        repeat
         // - Цикл по страницам в ширину
         MoveWindowOrg(l3PointX(l_Top.X));
         l_Info := PrintPara(aDocument, l_NextPage, l_PrevHeight);
         //  V - http://mdp.garant.ru/pages/viewpage.action?pageId=517787896
         if anArea.rCanvas.SectionExtent.X <> l_WidthExtent.X then
          // V- http://mdp.garant.ru/pages/viewpage.action?pageId=330700128
          l_HeightExtent := anArea.rCanvas.SectionExtent; // - Здесь может быть размер секции от страницы снизу, если был разрыв раздела!
         if (l_PageHeight = 0) then
          l_PageHeight := l_Info.rMap.Bounds.Bottom;
         CheckAborted(l_Aborted);
         Dec(l_Width2Print, l_PaperWidth);
         if (l_BottomPoint = nil) or l_BottomPoint.AfterEnd then
          l_BottomPoint := l_Info.rBottom
         else
          begin
           l_BottomPoint.MergeTo(anArea.rView.As_InevView, l_Info.rBottom);
           l_BottomPoint := l_Info.rBottom;
          end;
         if l_Aborted or (l_Width2Print <= l3Epsilon) then
          Break
         else
         begin
          Inc(l_Top.P.X, l_PrintableWidth);
          NewPage(True);
          // V- http://mdp.garant.ru/pages/viewpage.action?pageId=330700128
          anArea.rCanvas.SectionExtent := l_WidthExtent; // - Нам нужен размер секции от страницы слева, а не от страницы снизу!
         end;//l_Aborted..
         if l_Info.rCalculatedHeight <> 0 then
          l_PrevHeight := l_Info.rCalculatedHeight;
        until False;
        anArea.rCanvas.SectionExtent := l_HeightExtent;
        {$IFDEF nsTest}
        if TPrintRowHeightsSpy.Exists then
         TPrintRowHeightsSpy.Instance.ClearData;
        {$ENDIF nsTest}
        Inc(l_Top.P.Y, l_PageHeight);
        if (aProgress <> nil) then
         aProgress.Progress(l_Top.Y);
        if l_Aborted OR Printed then
         Break
        else
        if not NewPage then
         Break;
        l_Top.X := 0;
        // Сдвинулся ли якорь с которого печатать следующую страницу?
        try
         l_DisableUnformat := l_BottomPoint.MostInner.AsObject.Owner.IsKindOf(k2_typTable) AND
                              l_BottomPoint.MostInner.AsObject.Owner.IsSame(l_NextPage.MostInner.AsObject.Owner);
         l_SomethingPrinted := l_NextPage.Diff(anArea.rView.As_InevView,
                                               l_Info.rBottom,
                                               anArea.rView.RootMap.FI){$IfOpt D-} <> {$Else} < {$EndIf} 0;
         l_NextPage := l_BottomPoint;//l_Info.rBottom;
         if l_NextPage.AtEnd(anArea.rView.As_InevView) AND
            l_NextPage.MostInner.AsObject.IsKindOf(k2_typPageBreak) then
         // - нечего печатать пустую страницу
          Break;
         // Если якорь не сдвинулся и из цикла не вышли - зациклились..
         if not l_SomethingPrinted then
         begin
          try
           {$IfDef nsTest}
           f_Stopped := true;
           {$Else  nsTest}
           {$IfOpt D-}
           f_Stopped := true;
           {$EndIf D-}
           {$EndIf nsTest}
           Assert(False,'Cycling on printing');
           raise EevInvalidPrintMargins.Create(ev_warInvalidMargins);
          except
           {$IfDef nsTest}
           raise;
           {$Else  nsTest}
           {$IfOpt D+}
           break;
           {$Else}
           raise;
           {$EndIf}
           {$EndIf nsTest}
          end;//try..except
         end;//not l_SomethingPrinted
         anArea.rView.ClearShapes;
         if not l_DisableUnformat then
          UnformatView(anArea.rView.As_InevView);
         // - сбрасываем информацию о форматировании, т.к. вместе с новой страницей могла изменится LimitWidth
        except
         on EnevMaybeBaseSwitched do
         // http://mdp.garant.ru/pages/viewpage.action?pageId=258608212
         begin
          f_Stopped := true;
          break;
         end;//on EnevMaybeBaseSwitched
        end;//try..except
       until False;
     finally
      EndPaint;
     end;//try..finally
    finally
     if (aProgress <> nil) then
      aProgress.Finish;
    end;//try..finally
   end;//with anArea.rCanvas
  finally
   if (aProgress <> nil) then
    aProgress.ChangeIO(False);
  end;//try..finally
 //#UC END# *49CB801A037F__impl*
 end;//DocumentPrint

//#UC START# *49CB4BD701C9_47EA97410130_var*
(*var
 l_F : Tl3FileStream;
 l_W : TevdNativeWriter;*)
//#UC END# *49CB4BD701C9_47EA97410130_var*
begin
//#UC START# *49CB4BD701C9_47EA97410130_impl*
 Result := false;
 l_Text := Text;
 if (l_Text <> nil) then
 begin
(*  l_F := Tl3FileStream.Create('c:\xxx.evd', l3_fmWrite);
  try
   l_W := TevdNativeWriter.Create;
   try
    l_W.Filer.Stream := l_F;
    l_W.Start;
    l_W.StartChild(k2_idDocument);
    l_Text.Write(l_W);
    l_W.Finish;
    l_W.Finish;
    l_W.Filer.Stream := nil;
   finally
    FreeAndNil(l_W);
   end;//try.finally
  finally
   FreeAndNil(l_F);
  end;//try..finally*)
  if not f_InPagesCounting AND (f_HAF <> nil) then
   f_HAF.SetPagesCount(PagesInfo.rPagesCount);
  try
   l_Printer := Printer;
   l_Printer.Title := l3CStr(Application.Title);
   if (aCanvas = nil) then
    l_Canvas := TafwCanvasEx.Make(l_Printer, aPagesArray)
   else
    l_Canvas := aCanvas;
   try
    l_View := TnevPrintView.Make(l_Text, l_Canvas, f_CacheKey.HiddenStyles);
    try
     try
      Result := true;
      // - будем оптимистами
      if (aCanvas = nil) then
       l_Ind := Tl3ProgressIndicator.Make
      else
       l_Ind := Tl3ProgressIndicator.Make(ProgressProcEv);
      try
       l_Width := l_Text.AsObject.IntA[k2_tiWidth];
       try
        l_Canvas.Painter := f_HAF;
        l_Area.Init(l_View, l_Canvas, true);
        try
         l_Area{$IfDef XE4}.rTnevShapeArea{$EndIf}.rCanvas.AbortChecker := Self;
         try
          DocumentPrint(l_Area{$IfDef XE4}.rTnevShapeArea{$EndIf}, l_Text, l_Ind);
         finally
          l_Area{$IfDef XE4}.rTnevShapeArea{$EndIf}.rCanvas.AbortChecker := nil;
         end;
        finally
         l_Area.Free;
        end;//try..finally
       finally
        l_Text.AsObject.IntA[k2_tiWidth] := l_Width;
       end;//try..finally
      finally
       l_View.ClearShapes;
      end;//try..finally
     finally
      UnformatView(l_View);
      // - сбрасываем информацию о форматировании, т.к. вместе с новой страницей могла изменится LimitWidth,
      //   а также ориентация страницы http://mdp.garant.ru/pages/viewpage.action?pageId=139436530&focusedCommentId=139438485#comment-139438485
     end;//try..finally
    finally
     l_View := nil;
    end;//try..finally
   finally
    l_Canvas := nil;
   end;//try..finally
  except
   on Ek2ConversionError do
   begin
    // - прервали печать - надо корректно это отработать
    Result := false;
   end;//on Ek2ConversionError
  end;//try..except
 end;//l_Text <> nil
//#UC END# *49CB4BD701C9_47EA97410130_impl*
end;//TevDocumentPreviewPrim.DoPrint

function TevDocumentPreviewPrim.GetText: InevObject;
 {* Получаем текст документа для просмотра }
var l_Buffer: Tk2DocumentBuffer;
 {* Буфер документа }
var l_Generator: Tk2TagGenerator;
 {* Генератор документа }
var l_Pack: InevOp;
 {* Пачка операций }
//#UC START# *49CBC3B1026E_47EA97410130_var*
//#UC END# *49CBC3B1026E_47EA97410130_var*
begin
//#UC START# *49CBC3B1026E_47EA97410130_impl*
 if (f_Text = nil) AND (f_OriginalText <> nil) then
 begin
  if f_OriginalText.CanProvideOriginalDocument then
  begin
   if not f_OriginalText.OriginalDocument.QT(InevObject, f_Text, Processor) then
    Assert(false);
   f_TextOwner := f_Text.AsObject.Owner;
   Assert(f_TextOwner <> nil);
   // - м.б. тут нужен не Assert, а честная установка себя в качестве Owner'а если такового нету
  end//f_OriginalText.CanProvideOriginalText
  else
  begin
   f_InAquareText := True;
   if Assigned(Status) then
    Status.Update;
   try
    l_Buffer := Tk2DocumentBuffer.Create;
    try
     l_Pack := Processor.StartOp(ev_msgInsertBlock, true);
     try
      l_Pack.InIOProcess := true;
      l_Pack.SaveUndo := false;
      l_Pack.DeleteMapped := false;
      if (l_Buffer <> nil) then
      begin
       l_Buffer.Context := l_Pack;
       l_Generator := l_Buffer.Use;
       try
        SetFilters(l_Generator);
        TevAbortFilter.SetTo(l_Generator);
        Supports(l_Generator, IafwAbortableProcess, f_AbortFilter);
        try
         l_Generator.Start;
         try
          try
           f_OriginalText.Store(nil, l_Generator, []);
          except
           on El3AbortLoad do
           begin
            f_Text := nil;
            if not f_Stopped then
             Stop;
            l_Generator.RollBack;
            NotifyPreviewSubscribers;
           end;
          end;
         finally
          if not f_Stopped then
           l_Generator.Finish;
         end;//try..finally
        finally
         f_AbortFilter := nil;
        end;//try..finally
       finally
        FreeAndNil(l_Generator);
       end;//try..finally
       if not f_Stopped then
       begin
        if (l_Buffer.Root = nil) then
        begin
         f_Text := nil;
         Stop;
         // - не удалось получить текст
        end//l_Buffer.Root = nil
        else
        if not l_Buffer.Root.QT(InevObject, f_Text, Processor) then
         Assert(false);
        f_Text.AsObject.Owner := Self;
        //(f_Text.AsObject As _Tl3SimpleObject).Owner := Self;
       end;//not f_Stopped
      end;//l_Buffer <> nil
     finally
      l_Pack := nil;
     end;//try..finally
    finally
     FreeAndNil(l_Buffer);
    end;//try..finally
   finally
    f_InAquareText := False;
    if Assigned(Status) then
     Status.Update;
   end;//try..finally
  end;//f_OriginalText.CanProvideOriginalText 
 end;//f_Text = nil
 Result := f_Text;
//#UC END# *49CBC3B1026E_47EA97410130_impl*
end;//TevDocumentPreviewPrim.GetText

function TevDocumentPreviewPrim.GetPreviewCanvas(const aPagesInfo: TafwPagesInfo;
 aCounter: Boolean): IafwPreviewCanvas;
 {* Подготавливает виртуальную канву }
var l_Max: Integer;
var l_PageHeight: Integer;
var l_PreviewCanvas: TafwPreviewCanvas;
 {* Виртуальная канва }
var l_Text: InevObject;
 {* Текст }
//#UC START# *49CBC90C017F_47EA97410130_var*
//#UC END# *49CBC90C017F_47EA97410130_var*
begin
//#UC START# *49CBC90C017F_47EA97410130_impl*
 f_PreviewResetting := false;
 l_Text := Text;
 if (l_Text = nil) then
  Result := nil
 else
 begin
  if not aCounter AND not aPagesInfo.IsValid then
   Result := nil
  else
  begin
   l_PreviewCanvas := TafwPreviewCanvas.Create(Printer, aCounter, aPagesInfo);
   try
    if aCounter then
     f_Counter := l_PreviewCanvas
    else
     f_Preview := l_PreviewCanvas;
    if (f_Panel <> nil) then
     f_Panel.PreviewCanvas := l_PreviewCanvas;
    l_Max := aPagesInfo.rPagesCount;
    if (l_Max <= 0) then
     l_Max := High(Integer);
    if (l_Max = High(Integer)) then
    begin
     l_PageHeight := l_PreviewCanvas.PageSetup.PaperHeight;
     if (l_PageHeight > 0) then
     begin
      l_Max := (l_Text.ToList.LeafShapeCount * nev_ParaListFakeParaEx.Y div l_PageHeight) + 3;
      // - прикидываем хуй к носу
      if (l_Max > 20) then
       l_Max := l_Max div 2;
     end;//l_PageHeight > 0
    end;//l_Max := High(Integer)
    f_MaxPages := l_Max;
    if (f_Time <> nil) then
     FreeAndNil(f_Time);
    f_Time := Tl3TimeEstimation.Create(l_Max, 7);
    try
     if DoPrint(l_PreviewCanvas) then
      Result := l_PreviewCanvas
     else
      Result := nil;
    finally
     FreeAndNil(f_Time);
    end;//try..finally
   finally
    FreeAndNil(l_PreviewCanvas);
   end;//try..finally
  end;//not aCounter..
 end;//l_Text = nil
//#UC END# *49CBC90C017F_47EA97410130_impl*
end;//TevDocumentPreviewPrim.GetPreviewCanvas

procedure TevDocumentPreviewPrim.TryClose;
 {* Пытается прервать печать и закрыть окно }
var l_Wnd: THandle;
 {* Окно для закрытия }
//#UC START# *49CBCAB8037B_47EA97410130_var*
//#UC END# *49CBCAB8037B_47EA97410130_var*
begin
//#UC START# *49CBCAB8037B_47EA97410130_impl*
 if InClose then
 begin
  l_Wnd := f_WndToClose;
  f_WndToClose := 0;
  PostMessage(l_Wnd, WM_Close, 0, 0);
 end;//f_WndToClose <> 0
//#UC END# *49CBCAB8037B_47EA97410130_impl*
end;//TevDocumentPreviewPrim.TryClose

procedure TevDocumentPreviewPrim.AbortPreviewPrepare;
 {* Прекратить подготовку и очистить превью - что-то поменялось и надо его переделывать заново }
//#UC START# *49CCF80301C7_47EA97410130_var*
//#UC END# *49CCF80301C7_47EA97410130_var*
begin
//#UC START# *49CCF80301C7_47EA97410130_impl*
 {$IfNDef DesignTimeLibrary}
 inherited DoStyleTableChanged;
 // Это чтобы очистить кеш форматирования, иначе падает - http://mdp.garant.ru/pages/viewpage.action?pageId=115802894
 {$EndIf}
 if InProcess then
  Stop;
 f_Text := nil;
 f_TextOwner := nil;
 f_PreviewResetting := Assigned(f_Preview) and HasPreviewBuilder;
 ClearPreview;
 NotifyPreviewSubscribers;
//#UC END# *49CCF80301C7_47EA97410130_impl*
end;//TevDocumentPreviewPrim.AbortPreviewPrepare

function TevDocumentPreviewPrim.CurrentPageForUpdate: Integer;
var l_Preview: IafwPreviewCanvas;
//#UC START# *49CCF962005D_47EA97410130_var*
//#UC END# *49CCF962005D_47EA97410130_var*
begin
//#UC START# *49CCF962005D_47EA97410130_impl*
 Result := 0;
 if f_OriginalCurrentPage <> 0 then
 begin
  l_Preview := GetPreviewForCurrentPage;
  if Assigned(l_Preview) then
   Result := l_Preview.GetPageByObject(f_OriginalCurrentPage);
 end;
//#UC END# *49CCF962005D_47EA97410130_impl*
end;//TevDocumentPreviewPrim.CurrentPageForUpdate

function TevDocumentPreviewPrim.GetPreviewForCurrentPage: IafwPreviewCanvas;
var l_Index: Integer;
//#UC START# *49CCFAD0019C_47EA97410130_var*
//#UC END# *49CCFAD0019C_47EA97410130_var*
begin
//#UC START# *49CCFAD0019C_47EA97410130_impl*
 Result := Nil;
 l_Index := Printer.PrinterIndex;
 if (l_Index <> f_PrinterIndex) then
  ClearPreview;
 Result := f_Preview;
 if (Result = nil) then
  Result := f_Counter;
 if (Result = nil) then
 begin
  PrePrint(l_Index);
  Result := f_Counter;
 end;//l_Preview = nil
//#UC END# *49CCFAD0019C_47EA97410130_impl*
end;//TevDocumentPreviewPrim.GetPreviewForCurrentPage

procedure TevDocumentPreviewPrim.NotifyPreviewSubscribers;
var l_Idx: Integer;
//#UC START# *49CCFC8403A6_47EA97410130_var*
//#UC END# *49CCFC8403A6_47EA97410130_var*
begin
//#UC START# *49CCFC8403A6_47EA97410130_impl*
 if Assigned(f_PreviewSubscribers) then
  for l_Idx := f_PreviewSubscribers.Hi downto f_PreviewSubscribers.Lo do
   f_PreviewSubscribers[l_Idx].ContentChanged;
//#UC END# *49CCFC8403A6_47EA97410130_impl*
end;//TevDocumentPreviewPrim.NotifyPreviewSubscribers

procedure TevDocumentPreviewPrim.DoSetFilters(var theGenerator: Tk2TagGenerator);
//#UC START# *49CCFF22004A_47EA97410130_var*
//#UC END# *49CCFF22004A_47EA97410130_var*
begin
//#UC START# *49CCFF22004A_47EA97410130_impl*
 if NeedAddBlockNames then
  TevdBlockNameAdder.SetTo(theGenerator);
 if (f_OriginalText.PageSetup <> nil) then
  TevdPageParamsFilter.SetTo(f_OriginalText.PageSetup, Printer, theGenerator)
 else
 if (afw.Application <> nil) AND
    (afw.Application.PrintManager <> nil) then
  TevdPageParamsFilter.SetTo(afw.Application.PrintManager.PageSetup, Printer, theGenerator);
 TevHiddenFilter.SetTo(f_CacheKey.HiddenStyles, false, theGenerator);
//#UC END# *49CCFF22004A_47EA97410130_impl*
end;//TevDocumentPreviewPrim.DoSetFilters

function TevDocumentPreviewPrim.HasPreviewBuilder: Boolean;
//#UC START# *4B7E6CC30112_47EA97410130_var*
var
 l_IDX: Integer;
//#UC END# *4B7E6CC30112_47EA97410130_var*
begin
//#UC START# *4B7E6CC30112_47EA97410130_impl*
 Result := True;
 if Assigned(f_PreviewSubscribers) then
  for l_IDX := 0 to f_PreviewSubscribers.Count - 1 do
   if Supports(f_PreviewSubscribers[l_IDX], IafwPreviewPanel) then
    Exit;
 Result := False;
//#UC END# *4B7E6CC30112_47EA97410130_impl*
end;//TevDocumentPreviewPrim.HasPreviewBuilder

constructor TevDocumentPreviewPrim.Create(const aText: InevStorable;
 const aKey: TevPreviewCacheKey;
 const aHAF: IafwHAFPainter = nil);
//#UC START# *4CB57D480244_47EA97410130_var*
//#UC END# *4CB57D480244_47EA97410130_var*
begin
//#UC START# *4CB57D480244_47EA97410130_impl*
 Create(TnevDocumentProvider.Make(aText), aKey, aHAF);
//#UC END# *4CB57D480244_47EA97410130_impl*
end;//TevDocumentPreviewPrim.Create

constructor TevDocumentPreviewPrim.Create(const aText: InevDocumentProvider;
 const aKey: TevPreviewCacheKey;
 const aHAF: IafwHAFPainter = nil);
//#UC START# *4CB57D6601C4_47EA97410130_var*
//#UC END# *4CB57D6601C4_47EA97410130_var*
begin
//#UC START# *4CB57D6601C4_47EA97410130_impl*
 inherited Create;
 f_CacheKey := aKey;
 f_OriginalText := aText;
 f_PagesInfo := TafwPagesInfo_E;
 f_PrinterIndex := -1;
 f_HAF := aHAF;
 f_CurrentPagePara := 0;
 f_OriginalCurrentPage := 0;
 f_CurrentPageNumber := -1;
 f_CalcCurrentPageByPara := true;
//#UC END# *4CB57D6601C4_47EA97410130_impl*
end;//TevDocumentPreviewPrim.Create

procedure TevDocumentPreviewPrim.UnformatView(const aView: InevView);
 {* Сбрасывает информацию о форматировании для конкретного View }
//#UC START# *4CB5E99001D6_47EA97410130_var*
var
 l_H : InevObjectHolder;
 l_Pool : InevFormatPool;
//#UC END# *4CB5E99001D6_47EA97410130_var*
begin
//#UC START# *4CB5E99001D6_47EA97410130_impl*
 if (f_TextOwner = nil) then
  UnformatAll
 else
 if (aView <> nil) then
 begin
  if Supports(f_TextOwner, InevObjectHolder, l_H) then
   try
    l_Pool := l_H.FormatPool;
    if (l_Pool <> nil) then
    begin
     l_Pool.ClearFormatInfoForView(aView);
    end;//l_Pool <> nil
   finally
    l_H := nil;
   end;//try,,finally
 end;//f_TextOwner = nil
//#UC END# *4CB5E99001D6_47EA97410130_impl*
end;//TevDocumentPreviewPrim.UnformatView

procedure TevDocumentPreviewPrim.Print2PDF(const aCanvas: Il3Canvas);
//#UC START# *53FF037803DA_47EA97410130_var*
//#UC END# *53FF037803DA_47EA97410130_var*
begin
//#UC START# *53FF037803DA_47EA97410130_impl*
 DoPrint(aCanvas);
//#UC END# *53FF037803DA_47EA97410130_impl*
end;//TevDocumentPreviewPrim.Print2PDF

procedure TevDocumentPreviewPrim.SetFilters(var theGenerator: Tk2TagGenerator);
//#UC START# *47ECAB7602A2_47EA97410130_var*
//#UC END# *47ECAB7602A2_47EA97410130_var*
begin
//#UC START# *47ECAB7602A2_47EA97410130_impl*
 DoSetFilters(theGenerator);
//#UC END# *47ECAB7602A2_47EA97410130_impl*
end;//TevDocumentPreviewPrim.SetFilters

procedure TevDocumentPreviewPrim.ClearPreview;
//#UC START# *47ECAE160005_47EA97410130_var*
//#UC END# *47ECAE160005_47EA97410130_var*
begin
//#UC START# *47ECAE160005_47EA97410130_impl*
 f_PagesInfo := TafwPagesInfo_E;
 f_Counter := nil;
 f_Preview := nil;
//#UC END# *47ECAE160005_47EA97410130_impl*
end;//TevDocumentPreviewPrim.ClearPreview

function TevDocumentPreviewPrim.InClose: Boolean;
//#UC START# *47ECAE6D0036_47EA97410130_var*
//#UC END# *47ECAE6D0036_47EA97410130_var*
begin
//#UC START# *47ECAE6D0036_47EA97410130_impl*
 Result := (f_WndToClose <> 0);
//#UC END# *47ECAE6D0036_47EA97410130_impl*
end;//TevDocumentPreviewPrim.InClose

function TevDocumentPreviewPrim.PrePrint(anIndex: Integer): TafwPagesInfo;
//#UC START# *47ECAFF802EA_47EA97410130_var*
var
 l_Preview : IafwPreviewCanvas;
//#UC END# *47ECAFF802EA_47EA97410130_var*
begin
//#UC START# *47ECAFF802EA_47EA97410130_impl*
 afw.BeginOp;
 try
  // Лукьянец:
  // Смысл этого присвоения не очень понятен. Если прервать превью во время
  // подсчета страниц и потом вызвать CurrentPage (Preprint), в результате
  // получится "битый" превью, весь серый, но считающий себя готовым.
  // Да и до PreviewPanel не доедет, то что превью прерывали (именно поэтому
  // превью и не чинится). Пока зафиксил минималистски (при прерывании подсчета
  // страниц не вызываю CurrentPage. Чуть позже надо опространствить (и м.б. переделать)
  // именно этот сброс f_Stopped.
  f_Stopped := false;
  try
   f_InPagesCounting := true;
   try
    DoSubscribe;
    try
     l_Preview := GetPreviewCanvas(TafwPagesInfo_E, true);
     if (l_Preview = nil) then
      Result := TafwPagesInfo_E
     else
     begin
      Result := l_Preview.PagesInfo;
      if (Result.rPagesCount <= 0) then
       Result.rPagesCount := l_Preview.GetPagesCount;
     end;//l_Preview = nil
     f_PagesInfo := Result;
     f_PrinterIndex := anIndex;
    finally
     DoUnSubscribe
    end;//try..finally
   finally
    if Stopped then
    begin
     f_PrinterIndex := -1;
     f_PagesInfo := TafwPagesInfo_E;
     Result := f_PagesInfo;
     TryClose;
    end;//Stopped
   end;//try..finally
  finally
   f_InPagesCounting := false;
  end;//try..finally
 finally
  afw.EndOp;
 end;//try..finally
//#UC END# *47ECAFF802EA_47EA97410130_impl*
end;//TevDocumentPreviewPrim.PrePrint

procedure TevDocumentPreviewPrim.ProgressProcEv(aState: Byte;
 aValue: Integer;
 const aMsg: AnsiString);
//#UC START# *47ECDB670389_47EA97410130_var*
//#UC END# *47ECDB670389_47EA97410130_var*
begin
//#UC START# *47ECDB670389_47EA97410130_impl*
 if (aMsg <> '') then
  f_Msg := l3CStr(aMsg);
 if (Status <> nil) then
  Status.Update;
 if (aState = piStart) then
  f_Max := aValue
 else
 if (aState = piCurrent) then
 begin
  f_Current := aValue;
  if (f_Panel <> nil) then
  begin
   if (aValue = 1) OR (aValue mod 10 = 0) then
    f_Panel.Invalidate;
  end;//f_Panel <> nil
  {$IFDEF InsiderTest}
  if g_PrintDataSaver.IsWaitingPrint then
   if (aValue = 1) OR (aValue mod 10 = 0) then
    g_PrintDataSaver.GetPanel.Invalidate;
  {$ENDIF InsiderTest}
 end//aState = piCurrent
 else
 if (aState = piEnd) then
 begin
  f_Msg := nil;
  if (f_Panel <> nil) then
   f_Panel.Invalidate;
  {$IFDEF InsiderTest}
  if g_PrintDataSaver.IsWaitingPrint then
   g_PrintDataSaver.GetPanel.Invalidate;
  {$ENDIF InsiderTest}
 end;//aState = piEnd
//#UC END# *47ECDB670389_47EA97410130_impl*
end;//TevDocumentPreviewPrim.ProgressProcEv

procedure TevDocumentPreviewPrim.CheckAborted(var Aborted: Boolean);
//#UC START# *47ECE7EC02A0_47EA97410130_var*
//#UC END# *47ECE7EC02A0_47EA97410130_var*
begin
//#UC START# *47ECE7EC02A0_47EA97410130_impl*
 if Stopped then
  Aborted := true;
//#UC END# *47ECE7EC02A0_47EA97410130_impl*
end;//TevDocumentPreviewPrim.CheckAborted

function TevDocumentPreviewPrim.IsSettingAffectsUs(const aSettingId: TafwSettingId): Boolean;
//#UC START# *47ECFAD101B9_47EA97410130_var*
//#UC END# *47ECFAD101B9_47EA97410130_var*
begin
//#UC START# *47ECFAD101B9_47EA97410130_impl*
 Result := false;
//#UC END# *47ECFAD101B9_47EA97410130_impl*
end;//TevDocumentPreviewPrim.IsSettingAffectsUs

procedure TevDocumentPreviewPrim.AfterPrint;
//#UC START# *48FD8A1C0307_47EA97410130_var*
//#UC END# *48FD8A1C0307_47EA97410130_var*
begin
//#UC START# *48FD8A1C0307_47EA97410130_impl*
 // Do nothing
//#UC END# *48FD8A1C0307_47EA97410130_impl*
end;//TevDocumentPreviewPrim.AfterPrint

function TevDocumentPreviewPrim.NeedAddBlockNames: Boolean;
 {* Нужно ли добавлять имена блоков }
//#UC START# *4A2E97A4021B_47EA97410130_var*
//#UC END# *4A2E97A4021B_47EA97410130_var*
begin
//#UC START# *4A2E97A4021B_47EA97410130_impl*
 Result := false;
//#UC END# *4A2E97A4021B_47EA97410130_impl*
end;//TevDocumentPreviewPrim.NeedAddBlockNames

function TevDocumentPreviewPrim.DocumentName: IafwCString;
 {* имя документа для preview. }
//#UC START# *473D8C450198_47EA97410130_var*
//#UC END# *473D8C450198_47EA97410130_var*
begin
//#UC START# *473D8C450198_47EA97410130_impl*
 if (f_HAF = nil) then
  Result := nil
 else
  Result := f_HAF.DocumentName;
//#UC END# *473D8C450198_47EA97410130_impl*
end;//TevDocumentPreviewPrim.DocumentName

function TevDocumentPreviewPrim.InProcess: Boolean;
 {* идет процесс? }
//#UC START# *473D8C5C0187_47EA97410130_var*
//#UC END# *473D8C5C0187_47EA97410130_var*
begin
//#UC START# *473D8C5C0187_47EA97410130_impl*
 Result := InUpdate OR InPagesCounting or InPrinting;
//#UC END# *473D8C5C0187_47EA97410130_impl*
end;//TevDocumentPreviewPrim.InProcess

function TevDocumentPreviewPrim.InPagesCounting: Boolean;
 {* сейчас в процессе подсчета страниц? }
//#UC START# *473D8C6C0266_47EA97410130_var*
//#UC END# *473D8C6C0266_47EA97410130_var*
begin
//#UC START# *473D8C6C0266_47EA97410130_impl*
 Result := f_InPagesCounting;
//#UC END# *473D8C6C0266_47EA97410130_impl*
end;//TevDocumentPreviewPrim.InPagesCounting

function TevDocumentPreviewPrim.InUpdate: Boolean;
 {* находимся в процессе построения preview? }
//#UC START# *473D8C7C01B5_47EA97410130_var*
//#UC END# *473D8C7C01B5_47EA97410130_var*
begin
//#UC START# *473D8C7C01B5_47EA97410130_impl*
 Result := f_InUpdate;
//#UC END# *473D8C7C01B5_47EA97410130_impl*
end;//TevDocumentPreviewPrim.InUpdate

function TevDocumentPreviewPrim.InPrinting: Boolean;
 {* находимся в процессе построения печати? }
//#UC START# *473D8C90022C_47EA97410130_var*
//#UC END# *473D8C90022C_47EA97410130_var*
begin
//#UC START# *473D8C90022C_47EA97410130_impl*
 Result := f_InPrinting;
//#UC END# *473D8C90022C_47EA97410130_impl*
end;//TevDocumentPreviewPrim.InPrinting

procedure TevDocumentPreviewPrim.Update(const aPanel: IafwPreviewPanel);
 {* установить preview на панель для отображения. }
//#UC START# *473D8CA002D9_47EA97410130_var*
var
 l_Panel: IafwPreviewPanel;
//#UC END# *473D8CA002D9_47EA97410130_var*
begin
//#UC START# *473D8CA002D9_47EA97410130_impl*
 {$IFDEF InsiderTest}
 if g_PrintDataSaver.IsWaitingPrint and (aPanel = nil) then // Для тестов в Арчи
  l_Panel := g_PrintDataSaver.GetPanel
 else
 {$ENDIF InsiderTest}
  l_Panel := aPanel;
 try
  if (l_Panel <> nil) then
  begin
   if not f_InUpdate AND not InClose and not f_InPrinting then
   begin
    Use;
    try
     if RefCount <= 1 then
      Exit;
     afw.BeginOp;
     try
      f_Stopped := false;
      try
       f_InUpdate := true;
       try
        f_Panel := l_Panel;
        try
         l_Panel.PreviewCanvas := Preview;
         // Лукьянец:
         // Если надо переделать превью без его закрытия => preprint дергать больше нельзя...
         {$IFDEF EverestLite}
         if not f_Stopped then
         {$ELSE}
         if not f_Stopped or InClose then
         {$ENDIF EverestLite}
          f_Panel.SetCurrentPage(CurrentPageForUpdate);
        finally
         f_Panel := nil;
        end;//try..finally
       finally
        f_InUpdate := false;
       end;//try..finally
      finally
       if f_Stopped then
       begin
        l_Panel.PreviewCanvas := nil;
        f_Preview := nil;
        TryClose;
       end;//f_Stopped
      end;//try..finally
      l_Panel.Done;
     {$IFDEF InsiderTest}
     if g_PrintDataSaver.IsWaitingPrint then
      g_PrintDataSaver.GetPanel.Done;
     {$ENDIF InsiderTest}
     finally
      afw.EndOp;
     end;//afw.BeginOp;
    finally
     Free;
    end;//Use
   end;//not f_InUpdate
  end//l_Panel <> nil
 finally
  l_Panel := nil;
 end;
//#UC END# *473D8CA002D9_47EA97410130_impl*
end;//TevDocumentPreviewPrim.Update

procedure TevDocumentPreviewPrim.Print(anInterval: TafwPagesInterval = afwTypes.afw_piAll;
 const aRange: Il3RangeManager = nil;
 aCopies: Integer = 1;
 const aFileName: AnsiString = '';
 aCollate: Boolean = True);
 {* напечатать на принтер. }
//#UC START# *473D8CAF028B_47EA97410130_var*
var
 l_PagesCount : TafwPagesInfo;
 l_Pages      : TafwPrintPagesArray;
//#UC END# *473D8CAF028B_47EA97410130_var*
begin
//#UC START# *473D8CAF028B_47EA97410130_impl*
 if (Printer = nil) OR (Printer.Printers.Count = 0) then
  Exit;
 f_InPrinting := true;
 try
  l_Pages := nil;
  // - это чтобы компилятор не выебывался
  l_PagesCount := PagesInfo;
  // - это надо для подсчета числа страниц
  if l_PagesCount.IsValid then
  begin
   {$If defined(InsiderTest) AND defined(nsTest)}
   if (aFileName = '') AND Tl3BatchService.Instance.IsBatchMode then
    Printer.FileName := l3GetTempFileName('print')
    // - чтобы в тестах не печатать на реальный принтер
   else
   {$IfEnd}
    Printer.FileName := aFileName;
   // Диапазон не задан - печатаем все
   if (aRange = nil) and (f_Counter = nil) then
    l_Pages := nil
   else
   begin
    // Диапазон задан - надо пересчитать страницы
    if f_Counter = nil then
     PrePrint(f_PrinterIndex);
    l_Pages := f_Counter.GetIntervalPages(anInterval, aRange);
    if ((anInterval <> afw_piAll) or Assigned(aRange)) AND (Length(l_Pages) <= 0) then
    {$IFDEF NEMESIS}
     raise EevNothingToPrint.Create('');
    {$ELSE}
     Exit;
    {$ENDIF}
     // - печатать нечего
   end;//(aRange = nil) and (f_Counter = nil)
   Printer.Copies := Max(1, aCopies);
   Printer.Collate := aCollate;
   try
    DoPrint(nil, l_Pages);
    AfterPrint;
   finally
    Printer.Copies := 1;
    if f_Stopped then TryClose;
   end;//try..finally
  end;//l_PagesCount > 0
 finally
  f_InPrinting := false;
 end;
//#UC END# *473D8CAF028B_47EA97410130_impl*
end;//TevDocumentPreviewPrim.Print

procedure TevDocumentPreviewPrim.Stop(aWnd: THandle = 0);
 {* остановит процесс построение preview/печати. }
//#UC START# *473D8CE9007C_47EA97410130_var*
//#UC END# *473D8CE9007C_47EA97410130_var*
begin
//#UC START# *473D8CE9007C_47EA97410130_impl*
 f_Stopped := true;
 f_WndToClose := aWnd;
 DoUnsubscribe;
 if Assigned(f_AbortFilter) then
  f_AbortFilter.Abort;
//#UC END# *473D8CE9007C_47EA97410130_impl*
end;//TevDocumentPreviewPrim.Stop

function TevDocumentPreviewPrim.Stopped: Boolean;
 {* процесс остановлен? }
//#UC START# *473D8CF80037_47EA97410130_var*
//#UC END# *473D8CF80037_47EA97410130_var*
begin
//#UC START# *473D8CF80037_47EA97410130_impl*
 Result := f_Stopped OR InClose OR (f_InUpdate and (RefCount <= 1))
   {$IFDEF nsTest}
   OR ((f_Panel <> nil) AND f_Panel.ShouldStop)
   {$ENDIF};
 {$IFDEF InsiderTest}
 if not Result and g_PrintDataSaver.IsWaitingPrint then
  Result := g_PrintDataSaver.GetPanel.ShouldStop;
 {$ENDIF InsiderTest} 
//#UC END# *473D8CF80037_47EA97410130_impl*
end;//TevDocumentPreviewPrim.Stopped

function TevDocumentPreviewPrim.CloseRequested: Boolean;
 {* при остановке процесса был запрос на закрытие превью }
//#UC START# *473D8D0A01D7_47EA97410130_var*
//#UC END# *473D8D0A01D7_47EA97410130_var*
begin
//#UC START# *473D8D0A01D7_47EA97410130_impl*
 Result := InClose;
//#UC END# *473D8D0A01D7_47EA97410130_impl*
end;//TevDocumentPreviewPrim.CloseRequested

function TevDocumentPreviewPrim.PreviewResetting: Boolean;
 {* канва отсутствует, но будет передалываться }
//#UC START# *473D8D1E01B8_47EA97410130_var*
//#UC END# *473D8D1E01B8_47EA97410130_var*
begin
//#UC START# *473D8D1E01B8_47EA97410130_impl*
 Result := f_PreviewResetting;
//#UC END# *473D8D1E01B8_47EA97410130_impl*
end;//TevDocumentPreviewPrim.PreviewResetting

procedure TevDocumentPreviewPrim.SetCurrentPage(const aCursor: IUnknown);
 {* устанавливает курсор на текущую страницу. }
//#UC START# *473D8D3800B1_47EA97410130_var*
var
 l_Target    : InevPara;
 l_OldTarget : InevPara;
 l_NewParaID : Integer;
//#UC END# *473D8D3800B1_47EA97410130_var*
begin
//#UC START# *473D8D3800B1_47EA97410130_impl*
 if (f_CurrentPage <> aCursor) then
 begin
  Supports(aCursor, InevPara, l_Target);
  try
   if Supports(f_CurrentPage, InevPara, l_OldTarget) then
    try
     if (l_OldTarget <> nil) and (l_Target <> nil) AND l_Target.AsObject.IsSame(l_OldTarget.AsObject) then
      Exit;
       // - не надо ничего трогать
    finally
     l_OldTarget := nil;
    end;//try..finally
   f_CurrentPage := aCursor;
   if (l_Target <> nil) then
   begin
    l_NewParaID := l_Target.AsObject.IntA[k2_tiHandle];
    Assert(l_NewParaID <> 0);
   end//l_Target <> nil
   else
    l_NewParaID := 0;
  finally
   l_Target := nil;
  end;//try..finally
  f_CurrentPagePara := l_NewParaID;
  f_OriginalCurrentPage := l_NewParaID;
  f_CurrentPageNumber := -1;
  f_CalcCurrentPageByPara := true;
 end;//f_CurrentPage <> aCursor
//#UC END# *473D8D3800B1_47EA97410130_impl*
end;//TevDocumentPreviewPrim.SetCurrentPage

procedure TevDocumentPreviewPrim.SetCurrentPagePara(aParaID: Integer);
 {* устанавливает курсор на текущую страницу. }
//#UC START# *473D8D4A019D_47EA97410130_var*
//#UC END# *473D8D4A019D_47EA97410130_var*
begin
//#UC START# *473D8D4A019D_47EA97410130_impl*
 f_CurrentPage := nil;
 f_CurrentPagePara := aParaID;
 f_OriginalCurrentPage := aParaID;
 f_CurrentPageNumber := -1;
 f_CalcCurrentPageByPara := true;
//#UC END# *473D8D4A019D_47EA97410130_impl*
end;//TevDocumentPreviewPrim.SetCurrentPagePara

procedure TevDocumentPreviewPrim.SetCurrentPageNumber(aPageNumber: Integer);
 {* устанавливает курсор на текущую страницу. }
//#UC START# *473D8D5D032B_47EA97410130_var*
//#UC END# *473D8D5D032B_47EA97410130_var*
begin
//#UC START# *473D8D5D032B_47EA97410130_impl*
 f_CurrentPage := nil;
 f_CurrentPagePara := 0;
 f_CurrentPageNumber := aPageNumber;
 f_CalcCurrentPageByPara := false;
//#UC END# *473D8D5D032B_47EA97410130_impl*
end;//TevDocumentPreviewPrim.SetCurrentPageNumber

function TevDocumentPreviewPrim.CurrentPage: Integer;
 {* текущая страница для печати. }
//#UC START# *473D8D72010F_47EA97410130_var*
var
 l_Preview : IafwPreviewCanvas;
//#UC END# *473D8D72010F_47EA97410130_var*
begin
//#UC START# *473D8D72010F_47EA97410130_impl*
 Result := 0;
 if HasCurrentPage then
 begin
  l_Preview := GetPreviewForCurrentPage;
  if (l_Preview = nil) then
   Result := 0
  else
   if f_CalcCurrentPageByPara then
    Result := l_Preview.GetPageByObject(f_CurrentPagePara)
   else
    Result := f_CurrentPageNumber;
 end;//HasCurrentPage
//#UC END# *473D8D72010F_47EA97410130_impl*
end;//TevDocumentPreviewPrim.CurrentPage

function TevDocumentPreviewPrim.HasCurrentPage: Boolean;
 {* установлена ли текущая страница. }
//#UC START# *473D8D830163_47EA97410130_var*
//#UC END# *473D8D830163_47EA97410130_var*
begin
//#UC START# *473D8D830163_47EA97410130_impl*
 if f_CalcCurrentPageByPara then
  Result := (f_CurrentPagePara <> 0)
 else
  Result := (f_CurrentPageNumber <> -1);
//#UC END# *473D8D830163_47EA97410130_impl*
end;//TevDocumentPreviewPrim.HasCurrentPage

function TevDocumentPreviewPrim.pm_GetHasText: Boolean;
//#UC START# *473D8DB10141_47EA97410130get_var*
//#UC END# *473D8DB10141_47EA97410130get_var*
begin
//#UC START# *473D8DB10141_47EA97410130get_impl*
 Result := (f_OriginalText <> nil);
//#UC END# *473D8DB10141_47EA97410130get_impl*
end;//TevDocumentPreviewPrim.pm_GetHasText

procedure TevDocumentPreviewPrim.Subscribe(const aNotifier: IafwPreviewNotifier);
//#UC START# *475E827F01CB_47EA97410130_var*
//#UC END# *475E827F01CB_47EA97410130_var*
begin
//#UC START# *475E827F01CB_47EA97410130_impl*
 if f_PreviewSubscribers = nil then
  f_PreviewSubscribers := TafwPreviewNotifierPtrList.Make;
 f_PreviewSubscribers.Add(aNotifier);
//#UC END# *475E827F01CB_47EA97410130_impl*
end;//TevDocumentPreviewPrim.Subscribe

procedure TevDocumentPreviewPrim.UnSubscribe(const aNotifier: IafwPreviewNotifier);
//#UC START# *475E828B0231_47EA97410130_var*
//#UC END# *475E828B0231_47EA97410130_var*
begin
//#UC START# *475E828B0231_47EA97410130_impl*
 f_PreviewSubscribers.Remove(aNotifier);
 if f_PreviewSubscribers.Count = 0 then
  FreeAndNil(f_PreviewSubscribers);
//#UC END# *475E828B0231_47EA97410130_impl*
end;//TevDocumentPreviewPrim.UnSubscribe

function TevDocumentPreviewPrim.pm_GetHAFMacroReplacer: IafwHAFMacroReplacer;
//#UC START# *47EA993A0208_47EA97410130get_var*
//#UC END# *47EA993A0208_47EA97410130get_var*
begin
//#UC START# *47EA993A0208_47EA97410130get_impl*
 Result := f_HAF.MacroReplacer;
//#UC END# *47EA993A0208_47EA97410130get_impl*
end;//TevDocumentPreviewPrim.pm_GetHAFMacroReplacer

function TevDocumentPreviewPrim.Get_Preview: IafwDocumentPreview;
//#UC START# *47ED128D02A7_47EA97410130get_var*
//#UC END# *47ED128D02A7_47EA97410130get_var*
begin
//#UC START# *47ED128D02A7_47EA97410130get_impl*
 Result := Self;
//#UC END# *47ED128D02A7_47EA97410130get_impl*
end;//TevDocumentPreviewPrim.Get_Preview

procedure TevDocumentPreviewPrim.DoInvalidateShape(const aShape: InevObject;
 aParts: TnevShapeParts);
//#UC START# *4918253C0297_47EA97410130_var*
//#UC END# *4918253C0297_47EA97410130_var*
begin
//#UC START# *4918253C0297_47EA97410130_impl*
 Assert(false);
//#UC END# *4918253C0297_47EA97410130_impl*
end;//TevDocumentPreviewPrim.DoInvalidateShape

function TevDocumentPreviewPrim.GetTagReader: InevTagReader;
//#UC START# *491829480128_47EA97410130_var*
//#UC END# *491829480128_47EA97410130_var*
begin
//#UC START# *491829480128_47EA97410130_impl*
 Result := nil;
 Assert(false);
//#UC END# *491829480128_47EA97410130_impl*
end;//TevDocumentPreviewPrim.GetTagReader

function TevDocumentPreviewPrim.GetTagWriter: InevTagWriter;
//#UC START# *491829620101_47EA97410130_var*
//#UC END# *491829620101_47EA97410130_var*
begin
//#UC START# *491829620101_47EA97410130_impl*
 Result := nil;
 Assert(false);
//#UC END# *491829620101_47EA97410130_impl*
end;//TevDocumentPreviewPrim.GetTagWriter

function TevDocumentPreviewPrim.Get_CacheKey: TevPreviewCacheKey;
//#UC START# *494F76F60234_47EA97410130get_var*
//#UC END# *494F76F60234_47EA97410130get_var*
begin
//#UC START# *494F76F60234_47EA97410130get_impl*
 Result := f_CacheKey;
//#UC END# *494F76F60234_47EA97410130get_impl*
end;//TevDocumentPreviewPrim.Get_CacheKey

procedure TevDocumentPreviewPrim.DoGetStatusInfo(out theString: IafwCString;
 out theNeedProgress: Boolean);
 {* Собственно процесс получения информации }
//#UC START# *49CCA2480360_47EA97410130_var*
var
 l_Count   : Integer;
 l_Counted : Integer;
 l_Secs    : Int64;
 l_Left    : Il3CString;
 l_S       : String;
//#UC END# *49CCA2480360_47EA97410130_var*
begin
//#UC START# *49CCA2480360_47EA97410130_impl*
 if Stopped then
 begin
  theString := nil;
  theNeedProgress := False;
  Exit;
 end;
 theNeedProgress := f_MakingCanvas and ((f_Panel = nil) or not f_Panel.Painted);
 l_Left := nil;
 if f_InAquareText then
  theString := str_nevpmProcessText.AsCStr 
 else
 begin
  if InPagesCounting AND (f_Counter <> nil) then
   l_Count := f_Counter.GetPagesCount
  else
  if InUpdate AND (f_Preview <> nil) then
   l_Count := f_Preview.GetPagesCount
  else
   l_Count := 0;
  if (f_Time <> nil) then
  begin
   f_Time.CurrentValue(l_Count);
   if f_Time.LeftToFinish(l_Secs) then
   l_Left := l3Fmt(str_nevpmTimeLeft.AsCStr, [l_Secs]);
  end;//f_Time <> nil
  if (l_Count = 0) then
  begin
   theString := f_Msg;
   if (f_Max > 0) AND (theString <> nil) AND (f_Current <= f_Max) then
    theString := l3Cat([theString, l3Fmt(' %d%%', [l3MulDiv(f_Current, 100, f_Max)])]);
  end//l_Count = 0
  else
  begin
   if InPagesCounting then
    theString := l3Fmt(str_nevpmCounting.AsCStr, [l_Count, f_MaxPages])
   else
   if InUpdate AND (f_Preview <> nil) then
   begin
    l_Counted := f_Preview.PagesInfo.rPagesCount;
    if (l_Counted = High(l_Counted)) then
    begin
     l_Counted := f_MaxPages;
     l_S := '~';
    end
    else
     l_S := '';
    if (l_Counted = High(l_Counted)) then
     theString := l3Fmt(str_nevpmPreparing.AsCStr, [l_Count])
    else
     theString := l3Fmt(str_nevpmPreparingExt.AsCStr, [l_Count, l_S, l_Counted]);
   end//InUpdate AND (f_Preview <> nil)
   else
    theString := nil;
  end;//l_Count = 0
 end;
 if f_MakingCanvas and l3IsNil(theString ) then
  theString := str_nevpmProcessPreview.AsCStr;
 if not l3IsNil(theString) AND not l3IsNil(l_Left) then
  theString := l3Cat([theString, l_Left]);
//#UC END# *49CCA2480360_47EA97410130_impl*
end;//TevDocumentPreviewPrim.DoGetStatusInfo

function TevDocumentPreviewPrim.IsAborted: Boolean;
//#UC START# *5229D8390137_47EA97410130_var*
//#UC END# *5229D8390137_47EA97410130_var*
begin
//#UC START# *5229D8390137_47EA97410130_impl*
 Result := False;
 CheckAborted(Result);
//#UC END# *5229D8390137_47EA97410130_impl*
end;//TevDocumentPreviewPrim.IsAborted

procedure TevDocumentPreviewPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47EA97410130_var*
//#UC END# *479731C50290_47EA97410130_var*
begin
//#UC START# *479731C50290_47EA97410130_impl*
 Assert(not f_InUpdate);
 f_Stopped := False;
 DoUnsubscribe;
 l3Free(f_PreviewSubscribers);
 l3Free(f_Time);
 f_CurrentPage := nil;
 f_HAF := nil;
 f_Panel := nil;
 f_Printer := nil;
 f_OriginalText := nil;
 f_Text := nil;
 f_TextOwner := nil;
 f_Counter := nil;
 f_Preview := nil;
 f_Processor := nil;
 f_Msg := nil;
 f_AbortFilter := nil;
 inherited;
//#UC END# *479731C50290_47EA97410130_impl*
end;//TevDocumentPreviewPrim.Cleanup

function TevDocumentPreviewPrim.DoSettingChanged(const aSettingId: TafwSettingId): Boolean;
 {* Обработчик изменения указанной настройки }
//#UC START# *47EA863A035C_47EA97410130_var*
var
 l_SL: IafwSettingListener;
//#UC END# *47EA863A035C_47EA97410130_var*
begin
//#UC START# *47EA863A035C_47EA97410130_impl*
 Result := false;
 if Supports(f_HAF, IafwSettingListener, l_SL) then
  try
   if l_SL.SettingChanged(aSettingId) then
    Result := true;
  finally
   l_SL := nil;
  end;//try..finally
 if not Result then
  Result := IsSettingAffectsUs(aSettingId);
 if Result then
  AbortPreviewPrepare;
//#UC END# *47EA863A035C_47EA97410130_impl*
end;//TevDocumentPreviewPrim.DoSettingChanged

procedure TevDocumentPreviewPrim.SettingsReplaceFinish;
//#UC START# *47EA8B9601FE_47EA97410130_var*
var
 l_SL: IafwSettingsReplaceListener;
//#UC END# *47EA8B9601FE_47EA97410130_var*
begin
//#UC START# *47EA8B9601FE_47EA97410130_impl*
 if Supports(f_HAF, IafwSettingsReplaceListener, l_SL) then
  try
   l_SL.Finish;
  finally
   l_SL := nil;
  end;//try..finally
 AbortPreviewPrepare;
//#UC END# *47EA8B9601FE_47EA97410130_impl*
end;//TevDocumentPreviewPrim.SettingsReplaceFinish

function TevDocumentPreviewPrim.GetObj: InevObject;
//#UC START# *48185EEB0234_47EA97410130_var*
//#UC END# *48185EEB0234_47EA97410130_var*
begin
//#UC START# *48185EEB0234_47EA97410130_impl*
 Result := Text;
//#UC END# *48185EEB0234_47EA97410130_impl*
end;//TevDocumentPreviewPrim.GetObj

procedure TevDocumentPreviewPrim.UnformatAll;
//#UC START# *49182CD402C9_47EA97410130_var*
//#UC END# *49182CD402C9_47EA97410130_var*
begin
//#UC START# *49182CD402C9_47EA97410130_impl*
 inherited;
//#UC END# *49182CD402C9_47EA97410130_impl*
end;//TevDocumentPreviewPrim.UnformatAll

function TevDocumentPreviewPrim.NeedUpdateOnUnsubscribe: Boolean;
//#UC START# *49CCA4C90343_47EA97410130_var*
//#UC END# *49CCA4C90343_47EA97410130_var*
begin
//#UC START# *49CCA4C90343_47EA97410130_impl*
 Result := Stopped;
//#UC END# *49CCA4C90343_47EA97410130_impl*
end;//TevDocumentPreviewPrim.NeedUpdateOnUnsubscribe

{$If NOT Defined(DesignTimeLibrary)}
procedure TevDocumentPreviewPrim.DoStyleTableChanged;
//#UC START# *4A485B710126_47EA97410130_var*
//#UC END# *4A485B710126_47EA97410130_var*
begin
//#UC START# *4A485B710126_47EA97410130_impl*
 AbortPreviewPrepare;
 // - это, чтобы текст переформатировался. И переразбились разделы.
 inherited;
//#UC END# *4A485B710126_47EA97410130_impl*
end;//TevDocumentPreviewPrim.DoStyleTableChanged
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TevDocumentPreviewPrim.ClearFields;
begin
 f_OriginalText := nil;
 f_Preview := nil;
 f_Text := nil;
 Printer := nil;
 f_Processor := nil;
 Finalize(f_PagesInfo);
 inherited;
end;//TevDocumentPreviewPrim.ClearFields

end.
