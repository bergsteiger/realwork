{$IfNDef Printable_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Printing"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Printing/Printable.imp.pas"
// Начат: 10.11.2010
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Aspects::Printing::Printing::Printing::Printable
//
// Форма с поддержкой печати. [$234366957]
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define Printable_imp}
 _Printable_ = {abstract form} class(_Printable_Parent_)
  {* Форма с поддержкой печати. [$234366957] }
 protected
  procedure InitEntities; override;
 protected
 // property methods
   function pm_GetPreview: IafwDocumentPreview; virtual; abstract;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure File_Print_Test(const aParams: IvcmTestParamsPrim);
     {* Печать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Печать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
     {* Печать... }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Печать... }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
     {* Предварительный просмотр }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Предварительный просмотр }
   {$IfEnd} //not NoVCM
 protected
 // protected methods
   function CanPrint: Boolean;
   function GetCanPrint: Boolean; virtual;
   procedure DoPrintExecute(const aParams: IvcmExecuteParamsPrim); virtual;
   procedure DoPreviewExecute(const aParams: IvcmExecuteParamsPrim); virtual;
 protected
 // protected properties
   property Preview: IafwDocumentPreview
     read pm_GetPreview;
 end;//_Printable_

{$Else Printable_imp}

// start class _Printable_

function _Printable_.CanPrint: Boolean;
//#UC START# *4CDAC581005C_4CDABAD0032E_var*
//#UC END# *4CDAC581005C_4CDABAD0032E_var*
begin
//#UC START# *4CDAC581005C_4CDABAD0032E_impl*
 Result := (afw.Application <> nil) AND
           (afw.Application.PrintManager <> nil) AND
           afw.Application.PrintManager.CanPrint AND
           Self.GetCanPrint;
//#UC END# *4CDAC581005C_4CDABAD0032E_impl*
end;//_Printable_.CanPrint

function _Printable_.GetCanPrint: Boolean;
//#UC START# *4CDAC59301AC_4CDABAD0032E_var*
//#UC END# *4CDAC59301AC_4CDABAD0032E_var*
begin
//#UC START# *4CDAC59301AC_4CDABAD0032E_impl*
 Result := true;
//#UC END# *4CDAC59301AC_4CDABAD0032E_impl*
end;//_Printable_.GetCanPrint

procedure _Printable_.DoPrintExecute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *51A45199015E_4CDABAD0032E_var*
var
 l_Preview : IafwDocumentPreview;
//#UC END# *51A45199015E_4CDABAD0032E_var*
begin
//#UC START# *51A45199015E_4CDABAD0032E_impl*
 l_Preview := Preview;
 if (l_Preview <> nil) then
  l_Preview.Print;
//#UC END# *51A45199015E_4CDABAD0032E_impl*
end;//_Printable_.DoPrintExecute

procedure _Printable_.DoPreviewExecute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *51A451E20376_4CDABAD0032E_var*
var
 l_Preview : IafwDocumentPreview;
//#UC END# *51A451E20376_4CDABAD0032E_var*
begin
//#UC START# *51A451E20376_4CDABAD0032E_impl*
 l_Preview := Preview;
 if (l_Preview <> nil) then
  TdmStdRes.MakePreview(l_Preview);
//#UC END# *51A451E20376_4CDABAD0032E_impl*
end;//_Printable_.DoPreviewExecute

{$If not defined(NoVCM)}
procedure _Printable_.File_Print_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49521D8E0295_4CDABAD0032Etest_var*
//#UC END# *49521D8E0295_4CDABAD0032Etest_var*
begin
//#UC START# *49521D8E0295_4CDABAD0032Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Self.CanPrint;
//#UC END# *49521D8E0295_4CDABAD0032Etest_impl*
end;//_Printable_.File_Print_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure _Printable_.File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49521D8E0295_4CDABAD0032Eexec_var*
//#UC END# *49521D8E0295_4CDABAD0032Eexec_var*
begin
//#UC START# *49521D8E0295_4CDABAD0032Eexec_impl*
 DoPrintExecute(aParams);
//#UC END# *49521D8E0295_4CDABAD0032Eexec_impl*
end;//_Printable_.File_Print_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure _Printable_.File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495220DE0298_4CDABAD0032Etest_var*
//#UC END# *495220DE0298_4CDABAD0032Etest_var*
begin
//#UC START# *495220DE0298_4CDABAD0032Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Self.CanPrint;
//#UC END# *495220DE0298_4CDABAD0032Etest_impl*
end;//_Printable_.File_PrintDialog_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure _Printable_.File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495220DE0298_4CDABAD0032Eexec_var*
var
 l_Preview : IafwDocumentPreview;
//#UC END# *495220DE0298_4CDABAD0032Eexec_var*
begin
//#UC START# *495220DE0298_4CDABAD0032Eexec_impl*
 l_Preview := Preview;
 if (l_Preview <> nil) then
  afw.Application.PrintManager.PrintDialog(l_Preview);
//#UC END# *495220DE0298_4CDABAD0032Eexec_impl*
end;//_Printable_.File_PrintDialog_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure _Printable_.File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495220F2033A_4CDABAD0032Etest_var*
//#UC END# *495220F2033A_4CDABAD0032Etest_var*
begin
//#UC START# *495220F2033A_4CDABAD0032Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Self.CanPrint;
//#UC END# *495220F2033A_4CDABAD0032Etest_impl*
end;//_Printable_.File_PrintPreview_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure _Printable_.File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *495220F2033A_4CDABAD0032Eexec_var*
//#UC END# *495220F2033A_4CDABAD0032Eexec_var*
begin
//#UC START# *495220F2033A_4CDABAD0032Eexec_impl*
 DoPreviewExecute(aParams);
//#UC END# *495220F2033A_4CDABAD0032Eexec_impl*
end;//_Printable_.File_PrintPreview_Execute
{$IfEnd} //not NoVCM

procedure _Printable_.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_File, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_File, op_Print, File_Print_Execute, File_Print_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_PrintDialog, File_PrintDialog_Execute, File_PrintDialog_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_PrintPreview, File_PrintPreview_Execute, File_PrintPreview_Test, nil);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

{$EndIf Printable_imp}
