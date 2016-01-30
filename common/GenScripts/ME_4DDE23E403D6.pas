unit kwPopEditorTextToFile;
 {* Сохраняет содержимое редактора в evd-файл. 
Пример:
'C:\MyFile.evd' editor:TextToFile }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorTextToFile.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorTextToFile = class(TkwEditorFromStackWord)
  {* Сохраняет содержимое редактора в evd-файл. 
Пример:
'C:\MyFile.evd' editor:TextToFile }
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorTextToFile
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evTypes
 , l3Interfaces
 , l3Stream
 , l3Types
 , SysUtils
 , evdMarkEliminator
 , evdDocumentMarksEliminator
 , l3Variant
 , evdDocumentBookmarksEliminator
 , evdDocumentSubsEliminator
 , evDocumentSubsChildrenCountEliminator
 , evdHypelinkDocIDEliminator
 , evdEmptySubsEliminator
 , evdStartAndTimeEliminator
 , evBitmapEliminator4Tests
;

procedure TkwPopEditorTextToFile.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4DDE23E403D6_var*
var
 l_S : AnsiString;
 l_F : Tl3NamedTextStream;
 l_G : Ik2TagGenerator;
//#UC END# *4F4CB81200CA_4DDE23E403D6_var*
begin
//#UC START# *4F4CB81200CA_4DDE23E403D6_impl*
 l_S := aCtx.rCaller.ResolveOutputFilePath(aCtx.rEngine.PopDelphiString);
 l_S := ChangeFileExt(l_S, '.evd');
 l_F := Tl3NamedTextStream.Create(l_S, l3_fmWrite);
 try
  l_G := TevdEmptySubsEliminator.Make;
  TevdMarkEliminator.SetTo(l_G);
  TevdDocumentMarksEliminator.SetTo(l_G);
  TevdDocumentBookmarksEliminator.SetTo(l_G);
  TevdDocumentSubsEliminator.SetTo(l_G);
  TevDocumentSubsChildrenCountEliminator.SetTo(l_G);
  TevBitmapEliminator4Tests.SetTo(l_G);
  {$IF Defined(Archi) and Defined(InsiderTest)}
  TevdHypelinkDocIDEliminator.SetTo(l_G);
  TevdStartAndTimeEliminator.SetTo(l_G);
  {$IFEND}
  //TevdEmptySubsEliminator.SetTo(l_G);
  try
   anEditor.TextSource.DocumentContainer.TagReader.
    ReadTag(cf_EverestTxt,
            l_F,
            l_G);
  finally
   l_G := nil;
  end;//try..finally
 finally
  FreeAndNil(l_F);
 end;//try..finally
//#UC END# *4F4CB81200CA_4DDE23E403D6_impl*
end;//TkwPopEditorTextToFile.DoWithEditor

class function TkwPopEditorTextToFile.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:TextToFile';
end;//TkwPopEditorTextToFile.GetWordNameForRegister

initialization
 TkwPopEditorTextToFile.RegisterInEngine;
 {* Регистрация pop_editor_TextToFile }
{$IfEnd} // NOT Defined(NoScripts)

end.
