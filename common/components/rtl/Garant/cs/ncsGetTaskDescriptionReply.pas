unit ncsGetTaskDescriptionReply;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsGetTaskDescriptionReply.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ResultDelivery::TncsGetTaskDescriptionReply
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
  ncsFileDescHelper,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsGetTaskDescriptionReply = class(TncsReply)
 protected
 // property methods
   function pm_GetLocalFolder: AnsiString;
   procedure pm_SetLocalFolder(const aValue: AnsiString);
   function pm_GetRemoteFolder: AnsiString;
   procedure pm_SetRemoteFolder(const aValue: AnsiString);
   function pm_GetFileDesc: FileDescHelper;
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property LocalFolder: AnsiString
     read pm_GetLocalFolder
     write pm_SetLocalFolder;
   property RemoteFolder: AnsiString
     read pm_GetRemoteFolder
     write pm_SetRemoteFolder;
   property FileDesc: FileDescHelper
     read pm_GetFileDesc;
 end;//TncsGetTaskDescriptionReply
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  csGetTaskDescriptionReply_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsGetTaskDescriptionReply

function TncsGetTaskDescriptionReply.pm_GetLocalFolder: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrLocalFolder]);
end;//TncsGetTaskDescriptionReply.pm_GetLocalFolder

procedure TncsGetTaskDescriptionReply.pm_SetLocalFolder(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrLocalFolder, nil] := (aValue);
end;//TncsGetTaskDescriptionReply.pm_SetLocalFolder

function TncsGetTaskDescriptionReply.pm_GetRemoteFolder: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrRemoteFolder]);
end;//TncsGetTaskDescriptionReply.pm_GetRemoteFolder

procedure TncsGetTaskDescriptionReply.pm_SetRemoteFolder(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrRemoteFolder, nil] := (aValue);
end;//TncsGetTaskDescriptionReply.pm_SetRemoteFolder

function TncsGetTaskDescriptionReply.pm_GetFileDesc: FileDescHelper;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TFileDescHelper.Make(TaggedData.cAtom(k2_attrFileDesc));
end;//TncsGetTaskDescriptionReply.pm_GetFileDesc

class function TncsGetTaskDescriptionReply.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typcsGetTaskDescriptionReply;
end;//TncsGetTaskDescriptionReply.GetTaggedDataType

{$IfEnd} //not Nemesis

end.