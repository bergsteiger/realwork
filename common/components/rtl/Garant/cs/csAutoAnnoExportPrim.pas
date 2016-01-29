unit csAutoAnnoExportPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csAutoAnnoExportPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TcsAutoAnnoExportPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  csExport,
  evdTasksHelpers,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TcsAutoAnnoExportPrim = class(TcsExport)
 protected
 // property methods
   function pm_GetStartDate: TDateTime;
   procedure pm_SetStartDate(aValue: TDateTime);
   function pm_GetEndDate: TDateTime;
   procedure pm_SetEndDate(aValue: TDateTime);
   function pm_GetBelongsIDList: BelongsIDListHelper;
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
   function GetDescription: AnsiString; override;
 public
 // public properties
   property StartDate: TDateTime
     read pm_GetStartDate
     write pm_SetStartDate;
   property EndDate: TDateTime
     read pm_GetEndDate
     write pm_SetEndDate;
   property BelongsIDList: BelongsIDListHelper
     read pm_GetBelongsIDList;
 end;//TcsAutoAnnoExportPrim
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  AutoAnnoExportTask_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TcsAutoAnnoExportPrim

function TcsAutoAnnoExportPrim.pm_GetStartDate: TDateTime;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrStartDate]);
end;//TcsAutoAnnoExportPrim.pm_GetStartDate

procedure TcsAutoAnnoExportPrim.pm_SetStartDate(aValue: TDateTime);
 {-}
begin
 TaggedData.DateTimeW[k2_attrStartDate, nil] := (aValue);
end;//TcsAutoAnnoExportPrim.pm_SetStartDate

function TcsAutoAnnoExportPrim.pm_GetEndDate: TDateTime;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrEndDate]);
end;//TcsAutoAnnoExportPrim.pm_GetEndDate

procedure TcsAutoAnnoExportPrim.pm_SetEndDate(aValue: TDateTime);
 {-}
begin
 TaggedData.DateTimeW[k2_attrEndDate, nil] := (aValue);
end;//TcsAutoAnnoExportPrim.pm_SetEndDate

function TcsAutoAnnoExportPrim.pm_GetBelongsIDList: BelongsIDListHelper;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TBelongsIDListHelper.Make(TaggedData.cAtom(k2_attrBelongsIDList));
end;//TcsAutoAnnoExportPrim.pm_GetBelongsIDList

class function TcsAutoAnnoExportPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typAutoAnnoExportTask;
end;//TcsAutoAnnoExportPrim.GetTaggedDataType

function TcsAutoAnnoExportPrim.GetDescription: AnsiString;
//#UC START# *53FB28170339_53BA72D102A5_var*
//#UC END# *53FB28170339_53BA72D102A5_var*
begin
//#UC START# *53FB28170339_53BA72D102A5_impl*
 Result := 'Автоматический экспорт аннотаций';
//#UC END# *53FB28170339_53BA72D102A5_impl*
end;//TcsAutoAnnoExportPrim.GetDescription

{$IfEnd} //not Nemesis

end.