unit PreviewTestBefore235875079;
 {* Тест построения Preview }

// Модуль: "w:\common\components\gui\Garant\Daily\PreviewTestBefore235875079.pas"
// Стереотип: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , TextEditorVisitor
 , afwInterfaces
 , nevShapesPaintedSpy
 , afwPreviewPageSpy
 , evHAFPainterEx
 , PrimTextLoad_Form
 , nevTools
 , afwPreviewPage
 , l3PureMixIns
;

type
 _l3CheckStamp_Parent_ = TTextEditorVisitor;
 {$Include w:\common\components\rtl\Garant\L3\l3CheckStamp.imp.pas}
 TPreviewTestBefore235875079 = {abstract} class(_l3CheckStamp_, IafwPreviewPanel, InevShapesLogger, IafwPagesLogger)
  {* Тест построения Preview }
  private
   f_Done: Boolean;
   f_Now: Cardinal;
    {* Время начала теста }
   f_PageCount: Integer;
   f_PrintedPageCount: Integer;
  protected
   f_LogNumber: Integer;
   f_CurrentOutput: AnsiString;
  protected
   function PageFileName(aNumber: Integer;
    aWidthNumber: Integer;
    aCounter: Boolean;
    anEtalon: Boolean): AnsiString;
    {* Имя файла для сохранения страницы }
   function IsBefore235875079: Boolean; virtual;
   function IsBefore278833302: Boolean; virtual;
   function OnlyCheckPageCount: Boolean; virtual;
   procedure ReadColontituls(var theColontituls: TevColontituls); virtual;
   function GetHAFFontSize: Integer; virtual;
    {* Размер колонтитулов. 0 - по-умолчанию }
   procedure SetCurrentPage(aValue: Integer);
   procedure Invalidate;
   procedure Done;
   procedure pm_SetPreviewCanvas(const aValue: IafwPreviewCanvas);
   function pm_GetPainted: Boolean;
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   function OpenLog(const aView: InevView): AnsiString;
   procedure CloseLog(const aLogName: AnsiString);
   function LogScreen(const aView: InevView): Boolean;
   procedure LogPage(aPage: TafwPreviewPage;
    aCounter: Boolean);
   function ShouldStop: Boolean;
   procedure IncCounterPageNumer;
   procedure InitFields; override;
   {$If NOT Defined(NotTunedDUnit)}
   function FileForOutput: AnsiString; override;
    {* Стандартный файл для вывода, для текщего теста }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   function GetNormalFontSize: Integer; override;
    {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$If NOT Defined(NotTunedDUnit)}
   function RaiseIfEtalonCreated: Boolean; override;
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TPreviewTestBefore235875079
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , Windows
 , evStyleInterface
 , evdStyles
 , SysUtils
 , vtPreviewPanel
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3String
 , l3Stream
 , l3Types
 {$If NOT Defined(NoImageEn)}
 , imageenio
 {$IfEnd} // NOT Defined(NoImageEn)
 , l3FileUtils
 , Graphics
 , Classes
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 , evPreviewForTestsTuning
 , l3Defaults
 , l3CanvasPrim
 , TestFrameWork
 , vcmBase
 , l3Base
;

{$If not Declared(_FormClass_)}type _FormClass_ = TPrimTextLoadForm;{$IfEnd}

{$Include w:\common\components\rtl\Garant\L3\l3CheckStamp.imp.pas}

function TPreviewTestBefore235875079.PageFileName(aNumber: Integer;
 aWidthNumber: Integer;
 aCounter: Boolean;
 anEtalon: Boolean): AnsiString;
 {* Имя файла для сохранения страницы }
//#UC START# *4CB808EF02E0_4BE429BA0233_var*
var
 l_Et : String;
 l_C  : String;
 l_WN : String;
//#UC END# *4CB808EF02E0_4BE429BA0233_var*
begin
//#UC START# *4CB808EF02E0_4BE429BA0233_impl*
 if aCounter then
  l_C := 'C_'
 else
  l_C := '';
 if (aWidthNumber = 0) then
  l_WN := ''
 else
  l_WN := '.' + l3LeftPadChar(IntToStr(aWidthNumber), 2, '0');
 if anEtalon then
  l_Et := EtalonSuffix
 else
  l_Et := ''; 
 Result := Format('%s%s.%s%s%s%s.png',
                  [OutputPath,
                   KPage,
                   l_C,
                   l3LeftPadChar(IntToStr(aNumber), 4, '0'),
                   l_WN,
                   l_Et
                  ]);
//#UC END# *4CB808EF02E0_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.PageFileName

function TPreviewTestBefore235875079.IsBefore235875079: Boolean;
//#UC START# *4D18990C0329_4BE429BA0233_var*
//#UC END# *4D18990C0329_4BE429BA0233_var*
begin
//#UC START# *4D18990C0329_4BE429BA0233_impl*
 Result := true;
//#UC END# *4D18990C0329_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.IsBefore235875079

function TPreviewTestBefore235875079.IsBefore278833302: Boolean;
//#UC START# *4E5BD02E029C_4BE429BA0233_var*
//#UC END# *4E5BD02E029C_4BE429BA0233_var*
begin
//#UC START# *4E5BD02E029C_4BE429BA0233_impl*
 Result := true;
//#UC END# *4E5BD02E029C_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.IsBefore278833302

function TPreviewTestBefore235875079.OnlyCheckPageCount: Boolean;
//#UC START# *51AD98E70324_4BE429BA0233_var*
//#UC END# *51AD98E70324_4BE429BA0233_var*
begin
//#UC START# *51AD98E70324_4BE429BA0233_impl*
 Result := False;
//#UC END# *51AD98E70324_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.OnlyCheckPageCount

procedure TPreviewTestBefore235875079.ReadColontituls(var theColontituls: TevColontituls);
//#UC START# *4C221AE002A2_4BE429BA0233_var*
//#UC END# *4C221AE002A2_4BE429BA0233_var*
begin
//#UC START# *4C221AE002A2_4BE429BA0233_impl*
 // - ничего не делаем, всё по-умолчанию
//#UC END# *4C221AE002A2_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.ReadColontituls

function TPreviewTestBefore235875079.GetHAFFontSize: Integer;
 {* Размер колонтитулов. 0 - по-умолчанию }
//#UC START# *4C2224D00159_4BE429BA0233_var*
//#UC END# *4C2224D00159_4BE429BA0233_var*
begin
//#UC START# *4C2224D00159_4BE429BA0233_impl*
 Result := 0; 
//#UC END# *4C2224D00159_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.GetHAFFontSize

procedure TPreviewTestBefore235875079.SetCurrentPage(aValue: Integer);
//#UC START# *473D86B20150_4BE429BA0233_var*
//#UC END# *473D86B20150_4BE429BA0233_var*
begin
//#UC START# *473D86B20150_4BE429BA0233_impl*
 // - ничего не делаем
//#UC END# *473D86B20150_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.SetCurrentPage

procedure TPreviewTestBefore235875079.Invalidate;
//#UC START# *473D86BD03D7_4BE429BA0233_var*
//#UC END# *473D86BD03D7_4BE429BA0233_var*
begin
//#UC START# *473D86BD03D7_4BE429BA0233_impl*
 // - ничего не делаем
 CheckTimeout(f_Now, 120 * 60 * 1000)
 // - проверяем, что зациклились
//#UC END# *473D86BD03D7_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.Invalidate

procedure TPreviewTestBefore235875079.Done;
//#UC START# *473D86C60253_4BE429BA0233_var*
//#UC END# *473D86C60253_4BE429BA0233_var*
begin
//#UC START# *473D86C60253_4BE429BA0233_impl*
 f_Done := true;
//#UC END# *473D86C60253_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.Done

procedure TPreviewTestBefore235875079.pm_SetPreviewCanvas(const aValue: IafwPreviewCanvas);
//#UC START# *473D86D60152_4BE429BA0233set_var*
//#UC END# *473D86D60152_4BE429BA0233set_var*
begin
//#UC START# *473D86D60152_4BE429BA0233set_impl*
 // - ничего не делаем
//#UC END# *473D86D60152_4BE429BA0233set_impl*
end;//TPreviewTestBefore235875079.pm_SetPreviewCanvas

function TPreviewTestBefore235875079.pm_GetPainted: Boolean;
//#UC START# *473D86E601F5_4BE429BA0233get_var*
//#UC END# *473D86E601F5_4BE429BA0233get_var*
begin
//#UC START# *473D86E601F5_4BE429BA0233get_impl*
 Result := false;
//#UC END# *473D86E601F5_4BE429BA0233get_impl*
end;//TPreviewTestBefore235875079.pm_GetPainted

procedure TPreviewTestBefore235875079.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
//#UC START# *4BE419AF0217_4BE429BA0233_var*
var PP : TvtPreviewPanel;
var
 l_OnReadColontituls : TevReadColontitulsEvent;
 l_SI : TevStyleInterface;
 l_Size : Integer;
 l_NewSize : Integer;
 l_OLS : Integer;
//#UC END# *4BE419AF0217_4BE429BA0233_var*
begin
//#UC START# *4BE419AF0217_4BE429BA0233_impl*
 f_PageCount := 0; f_PrintedPageCount := 0;
 l_OLS := l3CanvasPrim.g_PrintingLineSpacing;
 try
  if IsBefore278833302 then
   l3CanvasPrim.g_PrintingLineSpacing := 100
  else
   l3CanvasPrim.g_PrintingLineSpacing := def_BigLineSpacing;
  evPreviewForTestsTuning.OldBehaviourForK235875079 := Self.IsBefore235875079;
  try
   TafwPreviewPageSpy.Instance.SetLogger(Self);
   try
    if not OnlyCheckPageCount then
     TnevShapesPaintedSpy.Instance.SetLogger(Self);
    try
     l_SI := TevStyleInterface.Make;
     try
      l_SI.SelectStyle(ev_saHFRight);
      l_NewSize := GetHAFFontSize;
      l_Size := l_SI.Font.Size;
      try
       if (l_NewSize > 0) then
       begin
        l_SI.SelectStyle(ev_saHFLeft);
        l_SI.Font.Size := l_NewSize;
        l_SI.SelectStyle(ev_saHFRight);
        l_SI.Font.Size := l_NewSize;
       end;//l_NewSize > 0
       l_OnReadColontituls := g_OnReadColontituls;
       try
        g_OnReadColontituls := Self.ReadColontituls;
        // --------------
        // Тут идёт код, который надо раскомментировать если хочется посмотреть
        // на результаты построения preview
    (*    try
         PP := TvtPreviewPanel.Create(aForm);
         PP.Align := alClient;
         PP.Parent := aForm;
         PP.Preview := aForm.Text.Preview;
         PP.ZoomToPage(1,1,true);
        except
        end;//try..except
        repeat
         try
          Application.ProcessMessages;
         except
         end;//try..except
        until Application.Terminated;
        Exit;*)
        // --------------
        StartTimer;
        try
         f_Now := GetTickCount;
         aForm.Text.Preview.Update(Self);
        finally
         StopTimer('Preview.Update');
        end;//try..finally
       finally
        g_OnReadColontituls := l_OnReadColontituls;
       end;//try..finally
       Check(f_Done);
       if OnlyCheckPageCount then
        Check(f_PageCount = f_PrintedPageCount);
      finally
       l_SI.SelectStyle(ev_saHFLeft);
       l_SI.Font.Size := l_Size;
       l_SI.SelectStyle(ev_saHFRight);
       l_SI.Font.Size := l_Size;
      end;//try..finally
     finally
      FreeAndNil(l_SI);
     end;//try..finally
    finally
     if not OnlyCheckPageCount then
      TnevShapesPaintedSpy.Instance.RemoveLogger(Self);
    end;//try..finally
   finally
    TafwPreviewPageSpy.Instance.RemoveLogger(Self);
   end;//try..finally
  finally
   evPreviewForTestsTuning.OldBehaviourForK235875079 := false;
  end;//try..finally
 finally
  l3CanvasPrim.g_PrintingLineSpacing := l_OLS;
 end;//try..finally  
//#UC END# *4BE419AF0217_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.DoVisit

function TPreviewTestBefore235875079.OpenLog(const aView: InevView): AnsiString;
//#UC START# *4CA5D0430096_4BE429BA0233_var*
var
 l_Cnv : InevInfoCanvas;
 l_C : String;
 l_WN : String;
 l_Page : Integer;

 procedure MakeName;
 begin//MakeName
  Result := Format('%s%s.%s%s%s.shapes',
                   [OutputPath,
                    KPage,
                    l_C,
                    l3LeftPadChar(IntToStr(l_Page), 4, '0'),
                    l_WN
                   ]);
 end;//MakeName

//#UC END# *4CA5D0430096_4BE429BA0233_var*
begin
//#UC START# *4CA5D0430096_4BE429BA0233_impl*
 //Inc(f_LogNumber);
 l_Cnv := aView.Metrics.InfoCanvas;
 if l_Cnv.IsPagesCounter then
  l_C := 'C_'
 else
  l_C := '';
 if (f_LogNumber = 0) then
  l_WN := ''
 else
  l_WN := '.' + l3LeftPadChar(IntToStr(f_LogNumber), 2, '0');
 f_LogNumber := l_Cnv.PageWidthNumber;
 l_Page := l_Cnv.PageNumber;
 if (l_Page > 1) then
  Dec(l_Page)
 else
  Assert(l_Page = 1);
 MakeName;
 //Result := OutputPath + KPage + '.' + l3LeftPadChar(IntToStr(f_LogNumber), 4, '0') + '.shapes';
 if (Result = f_CurrentOutput) then
 begin
  Inc(l_Page);
  MakeName;
 end;//Result = f_CurrentOutput
 f_CurrentOutput := Result;
//#UC END# *4CA5D0430096_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.OpenLog

procedure TPreviewTestBefore235875079.CloseLog(const aLogName: AnsiString);
//#UC START# *4CA5D0540033_4BE429BA0233_var*
var
 l_N : String;
 l_Extra : String;
 l_Counter : Boolean;
//#UC END# *4CA5D0540033_4BE429BA0233_var*
begin
//#UC START# *4CA5D0540033_4BE429BA0233_impl*
 l_N := ExtractFileName(aLogName);
 l_Counter := (Pos('.C_', l_N) > 0);
 if l_Counter then
  l_Extra := ''
 else
  l_Extra := ChangeFileExt(l_N, '.png');
 CheckOutputWithInput(ChangeFileExt(l_N, EtalonSuffix + '.shapes'),
                      #0,
                      l_Extra,
                      not l_Counter);
//#UC END# *4CA5D0540033_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.CloseLog

function TPreviewTestBefore235875079.LogScreen(const aView: InevView): Boolean;
//#UC START# *4CACAF4F008D_4BE429BA0233_var*
//#UC END# *4CACAF4F008D_4BE429BA0233_var*
begin
//#UC START# *4CACAF4F008D_4BE429BA0233_impl*
 with aView.Metrics.InfoCanvas do
  Result := Printing AND not IsVirtual;
//#UC END# *4CACAF4F008D_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.LogScreen

procedure TPreviewTestBefore235875079.LogPage(aPage: TafwPreviewPage;
 aCounter: Boolean);
//#UC START# *4CB6E39A019E_4BE429BA0233_var*
var
 l_EN  : String;
 l_N   : String;
 l_IO : TImageEnIO;
 l_B  : Graphics.TBitmap;
 l_CVSPath : String;
 l_CVS : String;
//#UC END# *4CB6E39A019E_4BE429BA0233_var*
begin
//#UC START# *4CB6E39A019E_4BE429BA0233_impl*
 if aCounter then
  Exit
 else
 begin
  Inc(f_PrintedPageCount);
  if OnlyCheckPageCount then Exit;
 end;
 if (aPage.PageNumber <= 0) then
  Exit; 
 l_EN := PageFileName(aPage.PageNumber, aPage.PageWidthNumber, aCounter, true);
 l_N := PageFileName(aPage.PageNumber, aPage.PageWidthNumber, aCounter, false);
 l_IO := TImageEnIO.Create(nil);
 try
  l_B := Graphics.TBitmap.Create;
  try
   l_B.PixelFormat := pf24bit;
   l_B.Width := Trunc(IafwPreviewPage(aPage).GetMMWidth * 0.01 * 96 / 25.4);
   l_B.Height := Trunc(IafwPreviewPage(aPage).GetMMHeight * 0.01 * 96 / 25.4);
   IafwPreviewPage(aPage).DrawTo(Rect(0, 0, l_B.Width, l_B.Height), l_B);
   l_IO.Bitmap := l_B;
   l_IO.Params.BitsPerSample := 8;
   l_IO.Params.SamplesPerPixel := 1;
   l_IO.SaveToFilePNG(l_N);
  finally
   FreeAndNil(l_B);
  end;//try..finally
 finally
  FreeAndNil(l_IO);
 end;//try..finally
 if not IsWritingToK then
 begin
  if not FileExists(l_EN) then
   CopyFile(l_N, l_EN);
  if not IsFakeCVS then
  begin
   l_CVSPath := g_CVSPath + '\' + TestSetFolderName + '\';
   if DirectoryExists(l_CVSPath) then
   begin
    l_CVS := l_CVSPath + ExtractFileName(l_EN);
    if not FileExists(l_CVS) then
    begin
     CopyFile(l_N, l_CVS);
     ToLog(Format('Сделан эталон для помещения в CVS - "%s"', [l_CVS]));
    end;//not FileExists(l_CVS)
   end;//DirectoryExists(l_CVSPath)
  end;//not IsFakeCVS
 end;//not IsWritingToK
//#UC END# *4CB6E39A019E_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.LogPage

function TPreviewTestBefore235875079.ShouldStop: Boolean;
//#UC START# *4DDE0F5C0097_4BE429BA0233_var*
//#UC END# *4DDE0F5C0097_4BE429BA0233_var*
begin
//#UC START# *4DDE0F5C0097_4BE429BA0233_impl*
 Result := inherited ShouldStop;
//#UC END# *4DDE0F5C0097_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.ShouldStop

procedure TPreviewTestBefore235875079.IncCounterPageNumer;
//#UC START# *51ADB60602BB_4BE429BA0233_var*
//#UC END# *51ADB60602BB_4BE429BA0233_var*
begin
//#UC START# *51ADB60602BB_4BE429BA0233_impl*
 Inc(f_PageCount);
//#UC END# *51ADB60602BB_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.IncCounterPageNumer

procedure TPreviewTestBefore235875079.InitFields;
//#UC START# *4B30EEA10210_4BE429BA0233_var*
//#UC END# *4B30EEA10210_4BE429BA0233_var*
begin
//#UC START# *4B30EEA10210_4BE429BA0233_impl*
 inherited;
 f_LogNumber := 0;
 f_CurrentOutput := '';
//#UC END# *4B30EEA10210_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.InitFields

{$If NOT Defined(NotTunedDUnit)}
function TPreviewTestBefore235875079.FileForOutput: AnsiString;
 {* Стандартный файл для вывода, для текщего теста }
//#UC START# *4B4F588B0241_4BE429BA0233_var*
//#UC END# *4B4F588B0241_4BE429BA0233_var*
begin
//#UC START# *4B4F588B0241_4BE429BA0233_impl*
 Assert(f_CurrentOutput <> '');
 Result := f_CurrentOutput;
//#UC END# *4B4F588B0241_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.FileForOutput
{$IfEnd} // NOT Defined(NotTunedDUnit)

function TPreviewTestBefore235875079.GetNormalFontSize: Integer;
 {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
//#UC START# *4C07AC6F036D_4BE429BA0233_var*
//#UC END# *4C07AC6F036D_4BE429BA0233_var*
begin
//#UC START# *4C07AC6F036D_4BE429BA0233_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.GetNormalFontSize

function TPreviewTestBefore235875079.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TPreviewTestBefore235875079.GetFolder

{$If NOT Defined(NotTunedDUnit)}
function TPreviewTestBefore235875079.RaiseIfEtalonCreated: Boolean;
//#UC START# *4CA5DAD4014C_4BE429BA0233_var*
//#UC END# *4CA5DAD4014C_4BE429BA0233_var*
begin
//#UC START# *4CA5DAD4014C_4BE429BA0233_impl*
 Result := false;
//#UC END# *4CA5DAD4014C_4BE429BA0233_impl*
end;//TPreviewTestBefore235875079.RaiseIfEtalonCreated
{$IfEnd} // NOT Defined(NotTunedDUnit)

function TPreviewTestBefore235875079.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BE429BA0233';
end;//TPreviewTestBefore235875079.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
