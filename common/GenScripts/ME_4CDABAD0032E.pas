{$IfNDef Printable_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Printing\Printable.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "Printable" MUID: (4CDABAD0032E)
// Имя типа: "_Printable_"

{$Define Printable_imp}

 _Printable_ = {abstract} class(_Printable_Parent_)
  {* Форма с поддержкой печати. [$234366957] }
  protected
   function pm_GetPreview: IafwDocumentPreview; virtual; abstract;
   function CanPrint: Boolean;
   function GetCanPrint: Boolean; virtual;
   procedure DoPrintExecute(const aParams: IvcmExecuteParamsPrim); virtual;
   procedure DoPreviewExecute(const aParams: IvcmExecuteParamsPrim); virtual;
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure File_Print_Test(const aParams: IvcmTestParamsPrim);
    {* Печать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Печать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
    {* Печать... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Печать... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
    {* Предварительный просмотр }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Предварительный просмотр }
   {$IfEnd} // NOT Defined(NoVCM)
  protected
   property Preview: IafwDocumentPreview
    read pm_GetPreview;
 end;//_Printable_

{$Else Printable_imp}

{$IfNDef Printable_imp_impl}

{$Define Printable_imp_impl}

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

{$If NOT Defined(NoVCM)}
procedure _Printable_.File_Print_Test(const aParams: IvcmTestParamsPrim);
 {* Печать }
//#UC START# *49521D8E0295_4CDABAD0032Etest_var*
//#UC END# *49521D8E0295_4CDABAD0032Etest_var*
begin
//#UC START# *49521D8E0295_4CDABAD0032Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Self.CanPrint;
//#UC END# *49521D8E0295_4CDABAD0032Etest_impl*
end;//_Printable_.File_Print_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _Printable_.File_Print_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Печать }
//#UC START# *49521D8E0295_4CDABAD0032Eexec_var*
//#UC END# *49521D8E0295_4CDABAD0032Eexec_var*
begin
//#UC START# *49521D8E0295_4CDABAD0032Eexec_impl*
 DoPrintExecute(aParams);
//#UC END# *49521D8E0295_4CDABAD0032Eexec_impl*
end;//_Printable_.File_Print_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _Printable_.File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
 {* Печать... }
//#UC START# *495220DE0298_4CDABAD0032Etest_var*
//#UC END# *495220DE0298_4CDABAD0032Etest_var*
begin
//#UC START# *495220DE0298_4CDABAD0032Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Self.CanPrint;
//#UC END# *495220DE0298_4CDABAD0032Etest_impl*
end;//_Printable_.File_PrintDialog_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _Printable_.File_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Печать... }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _Printable_.File_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
 {* Предварительный просмотр }
//#UC START# *495220F2033A_4CDABAD0032Etest_var*
//#UC END# *495220F2033A_4CDABAD0032Etest_var*
begin
//#UC START# *495220F2033A_4CDABAD0032Etest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Self.CanPrint;
//#UC END# *495220F2033A_4CDABAD0032Etest_impl*
end;//_Printable_.File_PrintPreview_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _Printable_.File_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Предварительный просмотр }
//#UC START# *495220F2033A_4CDABAD0032Eexec_var*
//#UC END# *495220F2033A_4CDABAD0032Eexec_var*
begin
//#UC START# *495220F2033A_4CDABAD0032Eexec_impl*
 DoPreviewExecute(aParams);
//#UC END# *495220F2033A_4CDABAD0032Eexec_impl*
end;//_Printable_.File_PrintPreview_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _Printable_.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_File, nil);
  PublishOp(en_File, op_Print, File_Print_Execute, File_Print_Test, nil);
  PublishOp(en_File, op_PrintDialog, File_PrintDialog_Execute, File_PrintDialog_Test, nil);
  PublishOp(en_File, op_PrintPreview, File_PrintPreview_Execute, File_PrintPreview_Test, nil);
 end;//with Entities.Entities
end;//_Printable_.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

{$EndIf Printable_imp_impl}

{$EndIf Printable_imp}

