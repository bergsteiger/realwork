unit kwDiffIteratorHasNext;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Shell Words"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwDiffIteratorHasNext.pas"
// �����: 03.11.2011 13:30
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Shell Words::F1 Shell Words::TkwDiffIteratorHasNext
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwDiffIteratorWord,
  DocumentUnit,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwDiffIteratorHasNext = {scriptword} class(TkwDiffIteratorWord)
 protected
 // realized methods
   procedure DoIterator(const anIterator: IDiffIterator;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDiffIteratorHasNext
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Windows
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwDiffIteratorHasNext

procedure TkwDiffIteratorHasNext.DoIterator(const anIterator: IDiffIterator;
  const aCtx: TtfwContext);
//#UC START# *4EB2634D0118_4EB25F2501B3_var*
//#UC END# *4EB2634D0118_4EB25F2501B3_var*
begin
//#UC START# *4EB2634D0118_4EB25F2501B3_impl*
 aCtx.rEngine.PushBool(anIterator.HasNext);
//#UC END# *4EB2634D0118_4EB25F2501B3_impl*
end;//TkwDiffIteratorHasNext.DoIterator

class function TkwDiffIteratorHasNext.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'DiffIterator:HasNext';
end;//TkwDiffIteratorHasNext.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwDiffIteratorHasNext
 TkwDiffIteratorHasNext.RegisterInEngine;
{$IfEnd} //not NoScripts

end.