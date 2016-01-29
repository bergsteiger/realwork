unit NOT_FINISHED_vtSaveDialog;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$Core"
// Модуль: "w:/common/components/gui/Garant/VT/NOT_FINISHED_vtSaveDialog.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT$Core::Dialogs::TvtSaveDialog
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  
  ;

type
 TvtSaveDialog = class(TSaveDialog)
 protected
 // protected methods
   function GetFileNameForAdjust: AnsiString; virtual;
     {* Получить имя файла для корректировки расширения }
   procedure FirstCorrectFileName; virtual;
   procedure SetAdjustedFileName(const aFileName: AnsiString); virtual;
     {* Установить откорректированное имя файла }
 end;//TvtSaveDialog

implementation

uses
  l3Base
  ;

// start class TvtSaveDialog

function TvtSaveDialog.GetFileNameForAdjust: AnsiString;
//#UC START# *4DCAD2B2008F_4C37236E02A1_var*
const
 c_BufferSize = 255;
var
 l_FileName : array [0..c_BufferSize] of Char;
//#UC END# *4DCAD2B2008F_4C37236E02A1_var*
begin
//#UC START# *4DCAD2B2008F_4C37236E02A1_impl*
 l3FillChar(l_FileName, SizeOf(l_FileName));
 Windows.GetDlgItemText(DialogHandle, vtFileNameDlgCtlId(Handle), l_FileName, c_BufferSize);
 Result := StrPas(l_FileName);
//#UC END# *4DCAD2B2008F_4C37236E02A1_impl*
end;//TvtSaveDialog.GetFileNameForAdjust

procedure TvtSaveDialog.FirstCorrectFileName;
//#UC START# *4DCAD9560008_4C37236E02A1_var*
//#UC END# *4DCAD9560008_4C37236E02A1_var*
begin
//#UC START# *4DCAD9560008_4C37236E02A1_impl*
 ChangeExtension;
//#UC END# *4DCAD9560008_4C37236E02A1_impl*
end;//TvtSaveDialog.FirstCorrectFileName

procedure TvtSaveDialog.SetAdjustedFileName(const aFileName: AnsiString);
//#UC START# *4DCBC96000E3_4C37236E02A1_var*
//#UC END# *4DCBC96000E3_4C37236E02A1_var*
begin
//#UC START# *4DCBC96000E3_4C37236E02A1_impl*
 Windows.SetDlgItemText(DialogHandle, vtFileNameDlgCtlId(Handle), PAnsiChar(aFileName));
//#UC END# *4DCBC96000E3_4C37236E02A1_impl*
end;//TvtSaveDialog.SetAdjustedFileName

end.