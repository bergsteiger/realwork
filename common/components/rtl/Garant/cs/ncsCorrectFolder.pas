unit ncsCorrectFolder;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsCorrectFolder.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsCorrectFolder" MUID: (549AA9CE0345)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2Base
;

type
 TncsCorrectFolder = class(TncsMessage)
  protected
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
   function pm_GetNewFolder: AnsiString;
   procedure pm_SetNewFolder(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property TaskID: AnsiString
    read pm_GetTaskID
    write pm_SetTaskID;
   property NewFolder: AnsiString
    read pm_GetNewFolder
    write pm_SetNewFolder;
 end;//TncsCorrectFolder
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csCorrectFolder_Const
 //#UC START# *549AA9CE0345impl_uses*
 //#UC END# *549AA9CE0345impl_uses*
;

function TncsCorrectFolder.pm_GetTaskID: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTaskID]);
end;//TncsCorrectFolder.pm_GetTaskID

procedure TncsCorrectFolder.pm_SetTaskID(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrTaskID, nil] := (aValue);
end;//TncsCorrectFolder.pm_SetTaskID

function TncsCorrectFolder.pm_GetNewFolder: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrNewFolder]);
end;//TncsCorrectFolder.pm_GetNewFolder

procedure TncsCorrectFolder.pm_SetNewFolder(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrNewFolder, nil] := (aValue);
end;//TncsCorrectFolder.pm_SetNewFolder

class function TncsCorrectFolder.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsCorrectFolder;
end;//TncsCorrectFolder.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
