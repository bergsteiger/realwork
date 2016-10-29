unit kwImageEnViewerSaveBitmap;
 {* Формат:
[code]
aFileName ImageEnViewer:SaveBitmap
[code]
где aFileName - имя файла, куда сохранять. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwImageEnViewerSaveBitmap.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "ImageEnViewer_SaveBitmap" MUID: (52E20E70006F)
// Имя типа: "TkwImageEnViewerSaveBitmap"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoImageEn)}
uses
 l3IntfUses
 , kwImageEnControl
 , imageenview
 , tfwScriptingInterfaces
;

type
 TkwImageEnViewerSaveBitmap = {final} class(TkwImageEnControl)
  {* Формат:
[code]
aFileName ImageEnViewer:SaveBitmap
[code]
где aFileName - имя файла, куда сохранять. }
  protected
   procedure DoWithImageEn(aControl: TImageEnView;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwImageEnViewerSaveBitmap
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoImageEn)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoImageEn)}
uses
 l3ImplUses
 , SysUtils
 , l3ImageUtils
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *52E20E70006Fimpl_uses*
 //#UC END# *52E20E70006Fimpl_uses*
;

procedure TkwImageEnViewerSaveBitmap.DoWithImageEn(aControl: TImageEnView;
 const aCtx: TtfwContext);
//#UC START# *52E20FD6017C_52E20E70006F_var*
var
 l_FileName: AnsiString;
//#UC END# *52E20FD6017C_52E20E70006F_var*
begin
//#UC START# *52E20FD6017C_52E20E70006F_impl*
 l_FileName := ChangeFileExt(aCtx.rStreamFactory.Filename, l3PNGExt);
 l_FileName := ExtractFileName(l_FileName);
 l_FileName := aCtx.rCaller.ResolveOutputFilePath(l_FileName);
 l3SaveBitmap2Png(aControl.Bitmap, l_FileName);
//#UC END# *52E20FD6017C_52E20E70006F_impl*
end;//TkwImageEnViewerSaveBitmap.DoWithImageEn

class function TkwImageEnViewerSaveBitmap.GetWordNameForRegister: AnsiString;
begin
 Result := 'ImageEnViewer:SaveBitmap';
end;//TkwImageEnViewerSaveBitmap.GetWordNameForRegister

initialization
 TkwImageEnViewerSaveBitmap.RegisterInEngine;
 {* Регистрация ImageEnViewer_SaveBitmap }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoImageEn)

end.
