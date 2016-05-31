unit csMdpSyncDicts;

// Модуль: "w:\common\components\rtl\Garant\cs\csMdpSyncDicts.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsMdpSyncDicts" MUID: (55E9759603C8)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csMdpSyncPrim
 , k2Base
;

type
 TcsMdpSyncDicts = class(TcsMdpSyncPrim)
  protected
   function pm_GetSyncFolderMask: AnsiString;
   procedure pm_SetSyncFolderMask(const aValue: AnsiString);
   function pm_GetGuardName: AnsiString;
   procedure pm_SetGuardName(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property SyncFolderMask: AnsiString
    read pm_GetSyncFolderMask
    write pm_SetSyncFolderMask;
   property GuardName: AnsiString
    read pm_GetGuardName
    write pm_SetGuardName;
 end;//TcsMdpSyncDicts
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , mdpSyncDicts_Const
;

function TcsMdpSyncDicts.pm_GetSyncFolderMask: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrSyncFolderMask]);
end;//TcsMdpSyncDicts.pm_GetSyncFolderMask

procedure TcsMdpSyncDicts.pm_SetSyncFolderMask(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrSyncFolderMask, nil] := (aValue);
end;//TcsMdpSyncDicts.pm_SetSyncFolderMask

function TcsMdpSyncDicts.pm_GetGuardName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrGuardName]);
end;//TcsMdpSyncDicts.pm_GetGuardName

procedure TcsMdpSyncDicts.pm_SetGuardName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrGuardName, nil] := (aValue);
end;//TcsMdpSyncDicts.pm_SetGuardName

class function TcsMdpSyncDicts.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typmdpSyncDicts;
end;//TcsMdpSyncDicts.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
