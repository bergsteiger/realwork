unit NOT_FINISHED_vtSaveDialog;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_FINISHED_vtSaveDialog.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvtSaveDialog" MUID: (4C37236E02A1)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TvtSaveDialog = class({$If NOT Defined(NoVCL)}
 TSaveDialog
 {$IfEnd} // NOT Defined(NoVCL)
 )
  protected
   function GetFileNameForAdjust: AnsiString; virtual;
   procedure FirstCorrectFileName; virtual;
   procedure SetAdjustedFileName(const aFileName: AnsiString); virtual;
    {* Установить откорректированное имя файла }
 end;//TvtSaveDialog

implementation

uses
 l3ImplUses
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4C37236E02A1impl_uses*
 //#UC END# *4C37236E02A1impl_uses*
;

{$If NOT Defined(NoVCL)}
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
 {* Установить откорректированное имя файла }
//#UC START# *4DCBC96000E3_4C37236E02A1_var*
//#UC END# *4DCBC96000E3_4C37236E02A1_var*
begin
//#UC START# *4DCBC96000E3_4C37236E02A1_impl*
 Windows.SetDlgItemText(DialogHandle, vtFileNameDlgCtlId(Handle), PAnsiChar(aFileName));
//#UC END# *4DCBC96000E3_4C37236E02A1_impl*
end;//TvtSaveDialog.SetAdjustedFileName

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtSaveDialog);
 {* Регистрация TvtSaveDialog }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
