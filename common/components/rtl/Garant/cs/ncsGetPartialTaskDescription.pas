unit ncsGetPartialTaskDescription;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsGetPartialTaskDescription.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::TaskSend::TncsGetPartialTaskDescription
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
  ncsGetTaskDescription,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsGetPartialTaskDescription = class(TncsGetTaskDescription)
 protected
 // property methods
   function pm_GetFileName: AnsiString;
   procedure pm_SetFileName(const aValue: AnsiString);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property FileName: AnsiString
     read pm_GetFileName
     write pm_SetFileName;
 end;//TncsGetPartialTaskDescription
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  csGetPartialTaskDescription_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsGetPartialTaskDescription

function TncsGetPartialTaskDescription.pm_GetFileName: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrFileName]);
end;//TncsGetPartialTaskDescription.pm_GetFileName

procedure TncsGetPartialTaskDescription.pm_SetFileName(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrFileName, nil] := (aValue);
end;//TncsGetPartialTaskDescription.pm_SetFileName

class function TncsGetPartialTaskDescription.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typcsGetPartialTaskDescription;
end;//TncsGetPartialTaskDescription.GetTaggedDataType

{$IfEnd} //not Nemesis

end.