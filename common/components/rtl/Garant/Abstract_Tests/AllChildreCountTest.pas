unit AllChildreCountTest;
 {* Тест для подсчета количества AllChildrenCount у тегов документа. }

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\AllChildreCountTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "TAllChildreCountTest" MUID: (4EBB6A5802A5)

{$Include w:\common\components\rtl\Garant\Abstract_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TextViaEditorProcessorPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Filer
 , l3Variant
;

type
 TAllChildreCountTest = {abstract} class(TTextViaEditorProcessorPrim)
  {* Тест для подсчета количества AllChildrenCount у тегов документа. }
  private
   f_Filer: Tl3CustomFiler;
  private
   procedure CheckTag(aTag: Tl3Tag);
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure DoIt;
 end;//TAllChildreCountTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Types
 , SysUtils
 , k2Tags
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

{$If NOT Defined(NoVCM)}
procedure TAllChildreCountTest.CheckTag(aTag: Tl3Tag);
//#UC START# *4EBB7150025C_4EBB6A5802A5_var*

  function lp_CheckChild(aChild: Tl3Variant; anIndex: Long): Bool;
  begin
   if aChild.ChildrenCount > 0 then
    CheckTag(aChild);
   Result := True;
  end;

//#UC END# *4EBB7150025C_4EBB6A5802A5_var*
begin
//#UC START# *4EBB7150025C_4EBB6A5802A5_impl*
 f_Filer.WriteLn(aTag.TagType.AsString);
 f_Filer.WriteLn(Format('AllChildrenCount = %d', [aTag.IntA[k2_tiAllChildrenCount]]));
 aTag.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_CheckChild));
//#UC END# *4EBB7150025C_4EBB6A5802A5_impl*
end;//TAllChildreCountTest.CheckTag

procedure TAllChildreCountTest.DoIt;
//#UC START# *4EBB83340283_4EBB6A5802A5_var*
var
 l_F : _FormClass_;
//#UC END# *4EBB83340283_4EBB6A5802A5_var*
begin
//#UC START# *4EBB83340283_4EBB6A5802A5_impl*
 l_F := MakeForm;
 try
  l_F.Show;
  Load(l_F, KPage + '.evd', 'Load');
  f_Filer := FilerForOutput;
  try
   f_Filer.Open;
   try
    CheckTag(l_F.TextSource.Document.AsObject);
   finally
    f_Filer.Close;
   end;
  finally
   FreeAndNil(f_Filer);
  end;
 finally
  l_F.Free;
 end;//try..finally
 CheckOutputWithInput(KPage + EtalonSuffix + '.' + 'out', '%');
//#UC END# *4EBB83340283_4EBB6A5802A5_impl*
end;//TAllChildreCountTest.DoIt

function TAllChildreCountTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'EditorTests';
end;//TAllChildreCountTest.GetFolder

function TAllChildreCountTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4EBB6A5802A5';
end;//TAllChildreCountTest.GetModelElementGUID
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
