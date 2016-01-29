unit kwIncludesInChildren;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// ������: "kwIncludesInChildren.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine::IncludesAndUses::IncludesAndUsesPack::IncludesInChildren
//
// ��� USES, �� ��������� �������� ����� �� ���������� ������� - � ������� ����� (%C) - ������
// ����� ���� �������
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwUsesLike,
  tfwScriptingInterfaces,
  kwIncluded
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwIncludesInChildren = {final scriptword} class(TkwUsesLike)
  {* ��� USES, �� ��������� �������� ����� �� ���������� ������� - � ������� ����� (%C) - ������ ����� ���� ������� }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function MakeIncluded(const aFileName: AnsiString;
     const aContext: TtfwContext): TkwIncluded; override;
 end;//TkwIncludesInChildren
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  kwInnerIncludedInChildren,
  kwCompiledProcedure,
  kwCompiledWord,
  kwCompiledWordPrim,
  SysUtils,
  tfwScriptingTypes
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwIncludesInChildren

class function TkwIncludesInChildren.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '%INCLUDES';
end;//TkwIncludesInChildren.GetWordNameForRegister

function TkwIncludesInChildren.MakeIncluded(const aFileName: AnsiString;
  const aContext: TtfwContext): TkwIncluded;
//#UC START# *4F47673F03B0_4F476A0301B8_var*
var
 l_C  : TtfwCompiler;
 l_W  : TtfwWord;
 l_KW : TtfwKeyWord;
 l_WC : TtfwWord;
 l_ProducerKW : TtfwKeyWord;
 l_ClassToCreate : RkwCompiledWordPrim;
//#UC END# *4F47673F03B0_4F476A0301B8_var*
begin
//#UC START# *4F47673F03B0_4F476A0301B8_impl*
 l_C := aContext.rCompiler;
 l_C := aContext.rCompiler.KeywordFinder(aContext).ParentFinder;
 l_W := l_C;
 l_KW := l_W.CheckWord(TtfwCStringFactory.C('%C'));
 if (l_KW.Word = nil) then
 begin
  l_ProducerKW := TtfwKeyWord(l_W.KeywordFinder(aContext).KeywordByName(TtfwCStringFactory.C('%CHILDREN')));
  CompilerAssert(l_ProducerKW <> nil, '����� %CHILDREN �� �������', aContext);
  CompilerAssert(l_ProducerKW.Word <> nil, '����� %CHILDREN �� �������', aContext);
  l_ClassToCreate := RkwCompiledWordPrim(l_ProducerKW.Word.
                          CompiledWordClassPrim(aContext));
  if (l_ClassToCreate = nil) then
   l_ClassToCreate := TkwCompiledProcedure;                         
  l_WC := l_ClassToCreate.Create(l_ProducerKW.Word,
                                 // - ����� ���������� ����� ������ "���������"
                                 //   ��� �������, ���� ���-�� ��������� ���� �� �������,
                                 l_W{PrevFinder},
                                 TtfwWordInfo.Make(nil, [tfw_wmCanBeMerged], tfw_atNone, tfw_ltNone),
                                 aContext,
                                 l_KW);
  try
   l_KW.SetWord(aContext, l_WC);
  finally
   FreeAndNil(l_WC);
  end;//try..finally
  l_WC := l_KW.Word;
 end//l_KW.Word = nil
 else
  l_WC := l_KW.Word;
 Result := TkwInnerIncludedInChildren.Create(aFileName, l_WC); 
//#UC END# *4F47673F03B0_4F476A0301B8_impl*
end;//TkwIncludesInChildren.MakeIncluded

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� IncludesInChildren
 TkwIncludesInChildren.RegisterInEngine;
{$IfEnd} //not NoScripts

end.