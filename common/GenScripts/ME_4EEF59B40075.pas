unit FormulaRender;

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\FormulaRender.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TextEditorVisitor
 {$IfEnd} // NOT Defined(NoVCM)
 , eeRenderFormula
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TFormulaRender = {abstract} class(TTextEditorVisitor)
  private
   f_ParaNumber: Integer;
   f_FormulaNumber: Integer;
   f_RenderTarget: TeeRenderTarget;
  protected
   function GetZoom: Integer; virtual;
   {$If NOT Defined(NoVCM)}
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
    {* Обработать текст }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NotTunedDUnit)}
   function FileForOutput: AnsiString; override;
    {* Стандартный файл для вывода, для текщего теста }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$If NOT Defined(NotTunedDUnit)}
   function RaiseIfEtalonCreated: Boolean; override;
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
   function EtalonNeedsXE: Boolean; override;
   {$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)
 end;//TFormulaRender
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Memory
 , l3Stream
 , nevTools
 , evTypes
 , SysUtils
 , l3Interfaces
 , l3Filer
 , evdInterfaces
 , Formula_Const
 , k2Tags
 , evdTypes
 , ObjectSegment_Const
 , l3Variant
 , evOp
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 , l3ImageUtils
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

function TFormulaRender.GetZoom: Integer;
//#UC START# *4EF0A04A0286_4EEF59B40075_var*
//#UC END# *4EF0A04A0286_4EEF59B40075_var*
begin
//#UC START# *4EF0A04A0286_4EEF59B40075_impl*
 Result := 100;
//#UC END# *4EF0A04A0286_4EEF59B40075_impl*
end;//TFormulaRender.GetZoom

{$If NOT Defined(NoVCM)}
procedure TFormulaRender.DoVisit(aForm: TPrimTextLoadForm);
 {* Обработать текст }
//#UC START# *4BE419AF0217_4EEF59B40075_var*

 function FormulaCount(aPara: Tl3Tag): Integer;

 var
  l_FormulaCount : Integer absolute Result;

  function CheckSegment(aSegment: Tl3Variant; Index: Integer): Boolean;
  begin//CheckSegment
   Result := true;
   if aSegment.IsKindOf(k2_typObjectSegment) and
      aSegment.Child[0].IsKindOf(k2_typFormula) then
    Inc(l_FormulaCount);
  end;//CheckSegment

 var
  l_Layer : Tl3Tag;
 begin//FormulaCount
  Result := 0;
  l_Layer := aPara.rAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slObjects)]);
  with l_Layer do
   if IsValid then
    IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@CheckSegment));
 end;//FormulaCount

var
 l_EVD : Tl3SizedMemoryPool;
 l_Range : InevRange;
 l_F : Tl3CustomFiler;
 l_N : String;
 l_Out : IStream;
 l_FormulaCount : Integer;
 L_RenderedCount : Integer;
 l_Para : Tl3Tag;
 l_FormulaNumber : Integer;
 l_AsBitmap : TeeRenderTarget;
 l_FN : String;
//#UC END# *4BE419AF0217_4EEF59B40075_var*
begin
//#UC START# *4BE419AF0217_4EEF59B40075_impl*
 L_RenderedCount := 0;
 f_ParaNumber := 0;
 while true do
 begin
  f_FormulaNumber := 0;
  l_Para := aForm.Text.Selection.Cursor.MostInner.Obj.AsObject;
  l_FormulaCount := FormulaCount(l_Para);
  if (l_FormulaCount > 0) then
  begin
   for l_FormulaNumber := 0 to Pred(l_FormulaCount) do
   begin
    f_FormulaNumber := l_FormulaNumber;
    for l_AsBitmap := Low(TeeRenderTarget) to High(TeeRenderTarget) do
    begin
     f_RenderTarget := l_AsBitmap;
(*     if (l_AsBitmap = ee_rtPNG) then
      continue; // - пока не разберёмся с выливкой в PNG*)
     l_EVD := Tl3SizedMemoryPool.Create;
     try
      l_Range := aForm.Text.Selection.Cursor.MostInner.Obj.Range;
      l_Range.Data.Store(cf_EverestBinForceAndUnpacked, l_EVD As IStream, nil, [{evd_sfChildrenOnly}]);
      l_F := FilerForOutput;
      try
       l_F.Open;
       try
        l_Out := l_F.COMStream;
        try
         Check(eeRenderFormula.RenderFormulaPrim(l_EVD.AsPointer + 3,
                                       l_EVD.Size -
                                                    {$IfDef XE}6{$Else}6{$EndIf}
                                                    // - с этим шаманством - надо бы разобраться - почему там разное число байт
                                                    ,
                                       f_FormulaNumber{0}, Self.GetZoom, l_Out, l_AsBitmap), 'Формула не отрендерилась');
          Inc(L_RenderedCount);
        finally
         l_Out := nil;
        end;//try..finally
       finally
        l_F.Close;
       end;//try..finally
       l_FN := l_F.Identifier;
       l_N := ChangeFileExt(ExtractFileName(l_FN), EtalonSuffix + ExtractFileExt(l_FN));
      finally
       FreeAndNil(l_F);
      end;//try..finally
     finally
      FreeAndNil(l_EVD);
     end;//try..finally
(*     if f_AsBitmap then*)
      CheckOutputWithInput(l_N, #0, '', true{IsWritingToK})
(*     else
      Check(l3IsImageEqual(FileFromCurrent(l_N), l_FN, ChangeFileExt(l_FN, '.diff' + ExtractFileExt(l_FN))) = l3_rImagesEqual, 'Эталоны не совпали: ' + l_FN + ' и ' + FileFromCurrent(l_N));*)
    end;//for l_AsBitmap
   end;//for f_FormulaNumber
  end;//l_FormulaCount > 0
  if not aForm.Text.Selection.Cursor.MostInner.Move(aForm.Text.View, ev_ocNextParaTopLeft) then
   break;
  Check(not l_Para.IsSame(aForm.Text.Selection.Cursor.MostInner.Obj.AsObject), 'Похоже, что не сместились на следующий параграф');
  Inc(f_ParaNumber);  
 end;//while
 Check(L_RenderedCount > 0, 'Похоже, что не отрендерили ни одной формулы');
//#UC END# *4BE419AF0217_4EEF59B40075_impl*
end;//TFormulaRender.DoVisit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NotTunedDUnit)}
function TFormulaRender.FileForOutput: AnsiString;
 {* Стандартный файл для вывода, для текщего теста }
//#UC START# *4B4F588B0241_4EEF59B40075_var*
var
 l_Suff : String;
//#UC END# *4B4F588B0241_4EEF59B40075_var*
begin
//#UC START# *4B4F588B0241_4EEF59B40075_impl*
 l_Suff := '';
 if (f_ParaNumber > 0) then
  l_Suff := l_Suff + '_' + IntToStr(f_ParaNumber);
 if (f_FormulaNumber > 0) then
  l_Suff := l_Suff + '_' + IntToStr(f_FormulaNumber);
 Result := OutputPath + KPage + l_Suff;
 Case f_RenderTarget of
  ee_rtPNG:
   Result := Result + '.png';
  ee_rtBMP:
   Result := Result + '.bmp';
  ee_rtRawBMP:
   Result := Result + '.raw_bmp';
  else
   Assert(false);
 end;//Case f_RenderTarget
//#UC END# *4B4F588B0241_4EEF59B40075_impl*
end;//TFormulaRender.FileForOutput
{$IfEnd} // NOT Defined(NotTunedDUnit)

function TFormulaRender.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'RenderEVD';
end;//TFormulaRender.GetFolder

{$If NOT Defined(NotTunedDUnit)}
function TFormulaRender.RaiseIfEtalonCreated: Boolean;
//#UC START# *4CA5DAD4014C_4EEF59B40075_var*
//#UC END# *4CA5DAD4014C_4EEF59B40075_var*
begin
//#UC START# *4CA5DAD4014C_4EEF59B40075_impl*
 Result := false;
//#UC END# *4CA5DAD4014C_4EEF59B40075_impl*
end;//TFormulaRender.RaiseIfEtalonCreated
{$IfEnd} // NOT Defined(NotTunedDUnit)

function TFormulaRender.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4EEF59B40075';
end;//TFormulaRender.GetModelElementGUID

{$If Defined(XE) AND NOT Defined(NotTunedDUnit)}
function TFormulaRender.EtalonNeedsXE: Boolean;
//#UC START# *51AF49E5001B_4EEF59B40075_var*
//#UC END# *51AF49E5001B_4EEF59B40075_var*
begin
//#UC START# *51AF49E5001B_4EEF59B40075_impl*
 Result := true;
//#UC END# *51AF49E5001B_4EEF59B40075_impl*
end;//TFormulaRender.EtalonNeedsXE
{$IfEnd} // Defined(XE) AND NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
