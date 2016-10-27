unit ncsGetTaskDescriptionReply;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsGetTaskDescriptionReply.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsGetTaskDescriptionReply" MUID: (546B442D0343)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2Base
;

type
 TncsGetTaskDescriptionReply = class(TncsReply)
  protected
   function pm_GetLocalFolder: AnsiString;
   procedure pm_SetLocalFolder(const aValue: AnsiString);
   function pm_GetRemoteFolder: AnsiString;
   procedure pm_SetRemoteFolder(const aValue: AnsiString);
   function pm_GetFileDesc: FileDescHelper;
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property LocalFolder: AnsiString
    read pm_GetLocalFolder
    write pm_SetLocalFolder;
   property RemoteFolder: AnsiString
    read pm_GetRemoteFolder
    write pm_SetRemoteFolder;
   property FileDesc: FileDescHelper
    read pm_GetFileDesc;
 end;//TncsGetTaskDescriptionReply
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csGetTaskDescriptionReply_Const
 //#UC START# *546B442D0343impl_uses*
 //#UC END# *546B442D0343impl_uses*
;

function TncsGetTaskDescriptionReply.pm_GetLocalFolder: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrLocalFolder]);
end;//TncsGetTaskDescriptionReply.pm_GetLocalFolder

procedure TncsGetTaskDescriptionReply.pm_SetLocalFolder(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrLocalFolder, nil] := (aValue);
end;//TncsGetTaskDescriptionReply.pm_SetLocalFolder

function TncsGetTaskDescriptionReply.pm_GetRemoteFolder: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrRemoteFolder]);
end;//TncsGetTaskDescriptionReply.pm_GetRemoteFolder

procedure TncsGetTaskDescriptionReply.pm_SetRemoteFolder(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrRemoteFolder, nil] := (aValue);
end;//TncsGetTaskDescriptionReply.pm_SetRemoteFolder

function TncsGetTaskDescriptionReply.pm_GetFileDesc: FileDescHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TFileDescHelper.Make(TaggedData.cAtom(k2_attrFileDesc));
end;//TncsGetTaskDescriptionReply.pm_GetFileDesc

class function TncsGetTaskDescriptionReply.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsGetTaskDescriptionReply;
end;//TncsGetTaskDescriptionReply.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
