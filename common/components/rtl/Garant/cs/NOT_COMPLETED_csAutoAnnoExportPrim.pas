unit NOT_COMPLETED_csAutoAnnoExportPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_COMPLETED_csAutoAnnoExportPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsAutoAnnoExportPrim" MUID: (53BA72D102A5)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csExport
 , evdTasksHelpers
 , k2Base
;

type
 TcsAutoAnnoExportPrim = class(TcsExport)
  protected
   function pm_GetStartDate: TDateTime;
   procedure pm_SetStartDate(aValue: TDateTime);
   function pm_GetEndDate: TDateTime;
   procedure pm_SetEndDate(aValue: TDateTime);
   function pm_GetBelongsIDList: BelongsIDListHelper;
   function GetDescription: AnsiString; override;
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property StartDate: TDateTime
    read pm_GetStartDate
    write pm_SetStartDate;
   property EndDate: TDateTime
    read pm_GetEndDate
    write pm_SetEndDate;
   property BelongsIDList: BelongsIDListHelper
    read pm_GetBelongsIDList;
 end;//TcsAutoAnnoExportPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , AutoAnnoExportTask_Const
;

function TcsAutoAnnoExportPrim.pm_GetStartDate: TDateTime;
//#UC START# *05DE548C59E7_53BA72D102A5get_var*
//#UC END# *05DE548C59E7_53BA72D102A5get_var*
begin
//#UC START# *05DE548C59E7_53BA72D102A5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *05DE548C59E7_53BA72D102A5get_impl*
end;//TcsAutoAnnoExportPrim.pm_GetStartDate

procedure TcsAutoAnnoExportPrim.pm_SetStartDate(aValue: TDateTime);
//#UC START# *05DE548C59E7_53BA72D102A5set_var*
//#UC END# *05DE548C59E7_53BA72D102A5set_var*
begin
//#UC START# *05DE548C59E7_53BA72D102A5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *05DE548C59E7_53BA72D102A5set_impl*
end;//TcsAutoAnnoExportPrim.pm_SetStartDate

function TcsAutoAnnoExportPrim.pm_GetEndDate: TDateTime;
//#UC START# *DF8B66F30ABF_53BA72D102A5get_var*
//#UC END# *DF8B66F30ABF_53BA72D102A5get_var*
begin
//#UC START# *DF8B66F30ABF_53BA72D102A5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *DF8B66F30ABF_53BA72D102A5get_impl*
end;//TcsAutoAnnoExportPrim.pm_GetEndDate

procedure TcsAutoAnnoExportPrim.pm_SetEndDate(aValue: TDateTime);
//#UC START# *DF8B66F30ABF_53BA72D102A5set_var*
//#UC END# *DF8B66F30ABF_53BA72D102A5set_var*
begin
//#UC START# *DF8B66F30ABF_53BA72D102A5set_impl*
 !!! Needs to be implemented !!!
//#UC END# *DF8B66F30ABF_53BA72D102A5set_impl*
end;//TcsAutoAnnoExportPrim.pm_SetEndDate

function TcsAutoAnnoExportPrim.pm_GetBelongsIDList: BelongsIDListHelper;
//#UC START# *70CF313CF481_53BA72D102A5get_var*
//#UC END# *70CF313CF481_53BA72D102A5get_var*
begin
//#UC START# *70CF313CF481_53BA72D102A5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *70CF313CF481_53BA72D102A5get_impl*
end;//TcsAutoAnnoExportPrim.pm_GetBelongsIDList

class function TcsAutoAnnoExportPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53BA72D102A5_var*
//#UC END# *53AC03EE01FD_53BA72D102A5_var*
begin
//#UC START# *53AC03EE01FD_53BA72D102A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53BA72D102A5_impl*
end;//TcsAutoAnnoExportPrim.GetTaggedDataType

function TcsAutoAnnoExportPrim.GetDescription: AnsiString;
//#UC START# *53FB28170339_53BA72D102A5_var*
//#UC END# *53FB28170339_53BA72D102A5_var*
begin
//#UC START# *53FB28170339_53BA72D102A5_impl*
 Result := 'Автоматический экспорт аннотаций';
//#UC END# *53FB28170339_53BA72D102A5_impl*
end;//TcsAutoAnnoExportPrim.GetDescription
{$IfEnd} // NOT Defined(Nemesis)

end.
