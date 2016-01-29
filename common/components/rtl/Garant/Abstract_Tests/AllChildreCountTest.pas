unit AllChildreCountTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/AllChildreCountTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TAllChildreCountTest
//
// Тест для подсчета количества AllChildrenCount у тегов документа.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Abstract_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  l3Filer
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextViaEditorProcessorPrim
  {$IfEnd} //nsTest AND not NoVCM
  ,
  l3Variant
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TAllChildreCountTest = {abstract} class(TTextViaEditorProcessorPrim)
  {* Тест для подсчета количества AllChildrenCount у тегов документа. }
 private
 // private fields
   f_Filer : Tl3CustomFiler;
 private
 // private methods
   procedure CheckTag(aTag: Tl3Tag);
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
 end;//TAllChildreCountTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  l3Types,
  SysUtils,
  k2Tags,
  TestFrameWork
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TAllChildreCountTest

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
 {-}
begin
 Result := 'EditorTests';
end;//TAllChildreCountTest.GetFolder

function TAllChildreCountTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4EBB6A5802A5';
end;//TAllChildreCountTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.