unit ncsCorrectFolder;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsCorrectFolder.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ResultDelivery::TncsCorrectFolder
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
  ncsMessage,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsCorrectFolder = class(TncsMessage)
 protected
 // property methods
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
   function pm_GetNewFolder: AnsiString;
   procedure pm_SetNewFolder(const aValue: AnsiString);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property TaskID: AnsiString
     read pm_GetTaskID
     write pm_SetTaskID;
   property NewFolder: AnsiString
     read pm_GetNewFolder
     write pm_SetNewFolder;
 end;//TncsCorrectFolder
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  csCorrectFolder_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsCorrectFolder

function TncsCorrectFolder.pm_GetTaskID: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTaskID]);
end;//TncsCorrectFolder.pm_GetTaskID

procedure TncsCorrectFolder.pm_SetTaskID(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrTaskID, nil] := (aValue);
end;//TncsCorrectFolder.pm_SetTaskID

function TncsCorrectFolder.pm_GetNewFolder: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrNewFolder]);
end;//TncsCorrectFolder.pm_GetNewFolder

procedure TncsCorrectFolder.pm_SetNewFolder(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrNewFolder, nil] := (aValue);
end;//TncsCorrectFolder.pm_SetNewFolder

class function TncsCorrectFolder.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typcsCorrectFolder;
end;//TncsCorrectFolder.GetTaggedDataType

{$IfEnd} //not Nemesis

end.