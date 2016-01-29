unit csMdpImportDocs;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csMdpImportDocs.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TcsMdpImportDocs
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
  csProcessTask,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TcsMdpImportDocs = class(TddProcessTask)
 protected
 // property methods
   function pm_GetMail: AnsiString;
   procedure pm_SetMail(const aValue: AnsiString);
   function pm_GetErrorMail: AnsiString;
   procedure pm_SetErrorMail(const aValue: AnsiString);
   function pm_GetMaxCount: Integer;
   procedure pm_SetMaxCount(aValue: Integer);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property Mail: AnsiString
     read pm_GetMail
     write pm_SetMail;
   property ErrorMail: AnsiString
     read pm_GetErrorMail
     write pm_SetErrorMail;
   property MaxCount: Integer
     read pm_GetMaxCount
     write pm_SetMaxCount;
 end;//TcsMdpImportDocs
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  mdpImportDocs_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TcsMdpImportDocs

function TcsMdpImportDocs.pm_GetMail: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrMail]);
end;//TcsMdpImportDocs.pm_GetMail

procedure TcsMdpImportDocs.pm_SetMail(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrMail, nil] := (aValue);
end;//TcsMdpImportDocs.pm_SetMail

function TcsMdpImportDocs.pm_GetErrorMail: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrErrorMail]);
end;//TcsMdpImportDocs.pm_GetErrorMail

procedure TcsMdpImportDocs.pm_SetErrorMail(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrErrorMail, nil] := (aValue);
end;//TcsMdpImportDocs.pm_SetErrorMail

function TcsMdpImportDocs.pm_GetMaxCount: Integer;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrMaxCount]);
end;//TcsMdpImportDocs.pm_GetMaxCount

procedure TcsMdpImportDocs.pm_SetMaxCount(aValue: Integer);
 {-}
begin
 TaggedData.IntW[k2_attrMaxCount, nil] := (aValue);
end;//TcsMdpImportDocs.pm_SetMaxCount

class function TcsMdpImportDocs.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typmdpImportDocs;
end;//TcsMdpImportDocs.GetTaggedDataType

{$IfEnd} //not Nemesis

end.