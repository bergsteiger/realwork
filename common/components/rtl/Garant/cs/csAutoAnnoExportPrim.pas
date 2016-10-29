unit csAutoAnnoExportPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\csAutoAnnoExportPrim.pas"
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
 //#UC START# *53BA72D102A5impl_uses*
 //#UC END# *53BA72D102A5impl_uses*
;

function TcsAutoAnnoExportPrim.pm_GetStartDate: TDateTime;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrStartDate]);
end;//TcsAutoAnnoExportPrim.pm_GetStartDate

procedure TcsAutoAnnoExportPrim.pm_SetStartDate(aValue: TDateTime);
begin
 TaggedData.DateTimeW[k2_attrStartDate, nil] := (aValue);
end;//TcsAutoAnnoExportPrim.pm_SetStartDate

function TcsAutoAnnoExportPrim.pm_GetEndDate: TDateTime;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrEndDate]);
end;//TcsAutoAnnoExportPrim.pm_GetEndDate

procedure TcsAutoAnnoExportPrim.pm_SetEndDate(aValue: TDateTime);
begin
 TaggedData.DateTimeW[k2_attrEndDate, nil] := (aValue);
end;//TcsAutoAnnoExportPrim.pm_SetEndDate

function TcsAutoAnnoExportPrim.pm_GetBelongsIDList: BelongsIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TBelongsIDListHelper.Make(TaggedData.cAtom(k2_attrBelongsIDList));
end;//TcsAutoAnnoExportPrim.pm_GetBelongsIDList

function TcsAutoAnnoExportPrim.GetDescription: AnsiString;
//#UC START# *53FB28170339_53BA72D102A5_var*
//#UC END# *53FB28170339_53BA72D102A5_var*
begin
//#UC START# *53FB28170339_53BA72D102A5_impl*
 Result := 'Автоматический экспорт аннотаций';
//#UC END# *53FB28170339_53BA72D102A5_impl*
end;//TcsAutoAnnoExportPrim.GetDescription

class function TcsAutoAnnoExportPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typAutoAnnoExportTask;
end;//TcsAutoAnnoExportPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
