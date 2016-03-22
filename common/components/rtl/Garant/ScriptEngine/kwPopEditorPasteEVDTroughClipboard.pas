unit kwPopEditorPasteEVDTroughClipboard;
 {* Описание: загружает EVD'файл в виде текста в буфер обмена, а потом вставляет в редактор.
Формат: 
[code]
anEditor aFileName pop:editor:PasteEVDTroughClipboard
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPasteEVDTroughClipboard.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_editor_PasteEVDTroughClipboard" MUID: (53957B0E024C)
// Имя типа: "TkwPopEditorPasteEVDTroughClipboard"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorPasteEVDTroughClipboard = {final} class(TkwEditorFromStackWord)
  {* Описание: загружает EVD'файл в виде текста в буфер обмена, а потом вставляет в редактор.
Формат: 
[code]
anEditor aFileName pop:editor:PasteEVDTroughClipboard
[code] }
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorPasteEVDTroughClipboard
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Types
 , l3Memory
 , l3Stream
 , l3Base
 , evTypes
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwPopEditorPasteEVDTroughClipboard.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_53957B0E024C_var*
var
 l_Filer       : Tl3FileStream;
 l_FileName    : AnsiString;
 l_MemoryStream: Tl3MemoryStream;
//#UC END# *4F4CB81200CA_53957B0E024C_var*
begin
//#UC START# *4F4CB81200CA_53957B0E024C_impl*
 RunnerAssert(aCtx.rEngine.IsTopString, 'Мне нужна строка!', aCtx);
 l_FileName := aCtx.rEngine.PopDelphiString;
 l_FileName := aCtx.rCaller.ResolveInputFilePath(l_FileName);
 l_Filer := Tl3FileStream.Create(l_FileName, l3_fmRead);
 try
  l_MemoryStream := Tl3MemoryStream.Create;
  try
   l_MemoryStream.CopyFrom(l_Filer, l_Filer.Size);
   Win32Check(OpenClipboard(anEditor.Handle));
   try
    SetClipboardData(cf_EverestTxt, l3System.ReleaseHandle(l_MemoryStream.MemoryPool.ReleaseHandle));
   finally
    Win32Check(CloseClipboard);
   end;//try..finally
   anEditor.Paste;
  finally
   FreeAndNil(l_MemoryStream);
  end;//try..finally
 finally
  FreeAndNil(l_Filer);
 end;//try..finally
//#UC END# *4F4CB81200CA_53957B0E024C_impl*
end;//TkwPopEditorPasteEVDTroughClipboard.DoWithEditor

class function TkwPopEditorPasteEVDTroughClipboard.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:PasteEVDTroughClipboard';
end;//TkwPopEditorPasteEVDTroughClipboard.GetWordNameForRegister

initialization
 TkwPopEditorPasteEVDTroughClipboard.RegisterInEngine;
 {* Регистрация pop_editor_PasteEVDTroughClipboard }
{$IfEnd} // NOT Defined(NoScripts)

end.
