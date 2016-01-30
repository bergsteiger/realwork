{$IfNDef Printable_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Printing\Printable.imp.pas"
// Стереотип: "VCMForm"

{$Define Printable_imp}

 _Printable_ = {abstract} class(_Printable_Parent_)
  {* Форма с поддержкой печати. [$234366957] }
  protected
   function pm_GetPreview: IafwDocumentPreview; virtual; abstract;
   function CanPrint: Boolean;
   function GetCanPrint: Boolean; virtual;
   procedure DoPrintExecute(const aParams: IvcmExecuteParamsPrim); virtual;
   procedure DoPreviewExecute(const aParams: IvcmExecuteParamsPrim); virtual;
  public
   {$If NOT Defined(NoVCM)}
   procedure Print; override;
    {* Печать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintDialog; override;
    {* Печать... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintPreview; override;
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
procedure _Printable_.Print;
 {* Печать }
//#UC START# *49521D8E0295_4CDABAD0032E_var*
//#UC END# *49521D8E0295_4CDABAD0032E_var*
begin
//#UC START# *49521D8E0295_4CDABAD0032E_impl*
 !!! Needs to be implemented !!!
//#UC END# *49521D8E0295_4CDABAD0032E_impl*
end;//_Printable_.Print
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _Printable_.PrintDialog;
 {* Печать... }
//#UC START# *495220DE0298_4CDABAD0032E_var*
//#UC END# *495220DE0298_4CDABAD0032E_var*
begin
//#UC START# *495220DE0298_4CDABAD0032E_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220DE0298_4CDABAD0032E_impl*
end;//_Printable_.PrintDialog
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _Printable_.PrintPreview;
 {* Предварительный просмотр }
//#UC START# *495220F2033A_4CDABAD0032E_var*
//#UC END# *495220F2033A_4CDABAD0032E_var*
begin
//#UC START# *495220F2033A_4CDABAD0032E_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220F2033A_4CDABAD0032E_impl*
end;//_Printable_.PrintPreview
{$IfEnd} // NOT Defined(NoVCM)

{$EndIf Printable_imp_impl}

{$EndIf Printable_imp}

