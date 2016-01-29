unit kwImageEnViewerSaveBitmap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$ImageEn"
// Модуль: "kwImageEnViewerSaveBitmap.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi::ScriptEngine$ImageEn::ImageEnView::ImageEnViewer_SaveBitmap
//
// Формат:
// {code}
// aFileName ImageEnViewer:SaveBitmap
// {code}
// где aFileName - имя файла, куда сохранять.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoImageEn) AND not defined(NoScripts)}
uses
  kwImageEnControl,
  imageenview,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoImageEn AND not NoScripts

{$If not defined(NoImageEn) AND not defined(NoScripts)}
type
 TkwImageEnViewerSaveBitmap = {final scriptword} class(TkwImageEnControl)
  {* Формат:
[code]
aFileName ImageEnViewer:SaveBitmap
[code]
где aFileName - имя файла, куда сохранять. }
 protected
 // realized methods
   procedure DoWithImageEn(aControl: TImageEnView;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwImageEnViewerSaveBitmap
{$IfEnd} //not NoImageEn AND not NoScripts

implementation

{$If not defined(NoImageEn) AND not defined(NoScripts)}
uses
  SysUtils
  ;
{$IfEnd} //not NoImageEn AND not NoScripts

{$If not defined(NoImageEn) AND not defined(NoScripts)}

// start class TkwImageEnViewerSaveBitmap

procedure TkwImageEnViewerSaveBitmap.DoWithImageEn(aControl: TImageEnView;
  const aCtx: TtfwContext);
//#UC START# *52E20FD6017C_52E20E70006F_var*
const
 csBMPExt = '.bmp';
var
 l_FileName: AnsiString;
//#UC END# *52E20FD6017C_52E20E70006F_var*
begin
//#UC START# *52E20FD6017C_52E20E70006F_impl*
 l_FileName := ChangeFileExt(aCtx.rStreamFactory.Filename, csBMPExt);
 l_FileName := ExtractFileName(l_FileName);
 l_FileName := aCtx.rCaller.ResolveInputFilePath(l_FileName);
 aControl.Bitmap.SaveToFile(l_FileName);
//#UC END# *52E20FD6017C_52E20E70006F_impl*
end;//TkwImageEnViewerSaveBitmap.DoWithImageEn

class function TkwImageEnViewerSaveBitmap.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ImageEnViewer:SaveBitmap';
end;//TkwImageEnViewerSaveBitmap.GetWordNameForRegister

{$IfEnd} //not NoImageEn AND not NoScripts

initialization
{$If not defined(NoImageEn) AND not defined(NoScripts)}
// Регистрация ImageEnViewer_SaveBitmap
 TkwImageEnViewerSaveBitmap.RegisterInEngine;
{$IfEnd} //not NoImageEn AND not NoScripts

end.