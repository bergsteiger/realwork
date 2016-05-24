unit ddTaskItemPrim;

// Модуль: "w:\common\components\rtl\Garant\EVD\ddTaskItemPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddTaskItemPrim" MUID: (53AC018900AE)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , l3Variant
 , evdTaskTypes
 , Classes
 , k2Base
;

type
 _evdTagHolder_Parent_ = Tl3Tag;
 {$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}
 TddTaskItemPrim = class(_evdTagHolder_)
  private
   f_Owner: Tl3Tag;
   f_CanNotifyChange: Boolean;
  protected
   function pm_GetTaskType: TcsTaskType;
   function pm_GetPriority: Integer;
   procedure pm_SetPriority(aValue: Integer);
   function pm_GetVersion: Integer;
   procedure pm_SetVersion(aValue: Integer);
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
   function pm_GetDate: TDateTime;
   procedure pm_SetDate(aValue: TDateTime);
   function pm_GetUser: Cardinal;
   procedure pm_SetUser(aValue: Cardinal);
   function pm_GetDescription: AnsiString;
   procedure pm_SetDescription(const aValue: AnsiString);
   function pm_GetTaskFolder: AnsiString;
   procedure pm_SetTaskFolder(const aValue: AnsiString);
   class function ReadBoolean(aStream: TStream): Boolean;
   class function ReadInteger(aStream: TStream): Integer;
   class procedure WriteBoolean(aStream: TStream;
    aValue: Boolean);
   class procedure WriteInteger(aStream: TStream;
    aValue: Integer);
   class function ReadDateTime(aStream: TStream): TDateTime;
   class procedure WriteDateTime(aStream: TStream;
    aValue: TDateTime);
   class function ReadCardinal(aStream: TStream): Cardinal;
   class procedure WriteCardinal(aStream: TStream;
    aValue: Cardinal);
   procedure InitFields; override;
   function pm_GetTagOwner: Tl3Variant; override;
   procedure pm_SetTagOwner(aValue: Tl3Variant); override;
  public
   procedure Changed(aStatus: TcsTaskStatus);
   class function TaskTaggedDataType: Tk2Type;
   class function CanAsyncRun: Boolean; virtual;
   class function GetTaggedDataType: Tk2Type; override;
  public
   property CanNotifyChange: Boolean
    read f_CanNotifyChange
    write f_CanNotifyChange;
   property TaskType: TcsTaskType
    read pm_GetTaskType;
   property Priority: Integer
    read pm_GetPriority
    write pm_SetPriority;
   property Version: Integer
    read pm_GetVersion
    write pm_SetVersion;
   property TaskID: AnsiString
    read pm_GetTaskID
    write pm_SetTaskID;
    {* Идентификатор задания }
   property Date: TDateTime
    read pm_GetDate
    write pm_SetDate;
   property User: Cardinal
    read pm_GetUser
    write pm_SetUser;
   property Description: AnsiString
    read pm_GetDescription
    write pm_SetDescription;
    {* Description }
   property TaskFolder: AnsiString
    read pm_GetTaskFolder
    write pm_SetTaskFolder;
    {* TaskFolder }
 end;//TddTaskItemPrim

implementation

uses
 l3ImplUses
 , csTaskListening
 , SysUtils
 , evdNativeWriter
 , l3Filer
 , l3Types
 , k2TagGen
 , evdNativeReader
 , k2DocumentBuffer
 , Task_Const
;

{$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}

function TddTaskItemPrim.pm_GetTaskType: TcsTaskType;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TcsTaskType(TaggedData.IntA[k2_attrTaskType]);
end;//TddTaskItemPrim.pm_GetTaskType

function TddTaskItemPrim.pm_GetPriority: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrPriority]);
end;//TddTaskItemPrim.pm_GetPriority

procedure TddTaskItemPrim.pm_SetPriority(aValue: Integer);
begin
 TaggedData.IntW[k2_attrPriority, nil] := (aValue);
end;//TddTaskItemPrim.pm_SetPriority

function TddTaskItemPrim.pm_GetVersion: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrVersion]);
end;//TddTaskItemPrim.pm_GetVersion

procedure TddTaskItemPrim.pm_SetVersion(aValue: Integer);
begin
 TaggedData.IntW[k2_attrVersion, nil] := (aValue);
end;//TddTaskItemPrim.pm_SetVersion

function TddTaskItemPrim.pm_GetTaskID: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTaskID]);
end;//TddTaskItemPrim.pm_GetTaskID

procedure TddTaskItemPrim.pm_SetTaskID(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrTaskID, nil] := (aValue);
end;//TddTaskItemPrim.pm_SetTaskID

function TddTaskItemPrim.pm_GetDate: TDateTime;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 if not TaggedData.HasSubAtom(k2_attrDate) then
  if not Tk2Type(TaggedData.TagType).Prop[k2_attrDate].ReadOnly then
  begin
   pm_SetDate(Now);
  end;//not Tk2Type(TaggedData.TagType).Prop[k2_attrDate].ReadOnly then
 Result := (TaggedData.DateTimeA[k2_attrDate]);
end;//TddTaskItemPrim.pm_GetDate

procedure TddTaskItemPrim.pm_SetDate(aValue: TDateTime);
begin
 TaggedData.DateTimeW[k2_attrDate, nil] := (aValue);
end;//TddTaskItemPrim.pm_SetDate

function TddTaskItemPrim.pm_GetUser: Cardinal;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := Cardinal(TaggedData.IntA[k2_attrUser]);
end;//TddTaskItemPrim.pm_GetUser

procedure TddTaskItemPrim.pm_SetUser(aValue: Cardinal);
begin
 TaggedData.IntW[k2_attrUser, nil] := Integer(aValue);
end;//TddTaskItemPrim.pm_SetUser

function TddTaskItemPrim.pm_GetDescription: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrDescription]);
end;//TddTaskItemPrim.pm_GetDescription

procedure TddTaskItemPrim.pm_SetDescription(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrDescription, nil] := (aValue);
end;//TddTaskItemPrim.pm_SetDescription

function TddTaskItemPrim.pm_GetTaskFolder: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTaskFolder]);
end;//TddTaskItemPrim.pm_GetTaskFolder

procedure TddTaskItemPrim.pm_SetTaskFolder(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrTaskFolder, nil] := (aValue);
end;//TddTaskItemPrim.pm_SetTaskFolder

class function TddTaskItemPrim.ReadBoolean(aStream: TStream): Boolean;
//#UC START# *53AC4F14023A_53AC018900AE_var*
//#UC END# *53AC4F14023A_53AC018900AE_var*
begin
//#UC START# *53AC4F14023A_53AC018900AE_impl*
 aStream.ReadBuffer(Result, SizeOf(Result));
//#UC END# *53AC4F14023A_53AC018900AE_impl*
end;//TddTaskItemPrim.ReadBoolean

class function TddTaskItemPrim.ReadInteger(aStream: TStream): Integer;
//#UC START# *53AC4F360358_53AC018900AE_var*
//#UC END# *53AC4F360358_53AC018900AE_var*
begin
//#UC START# *53AC4F360358_53AC018900AE_impl*
 aStream.ReadBuffer(Result, SizeOf(Result));
//#UC END# *53AC4F360358_53AC018900AE_impl*
end;//TddTaskItemPrim.ReadInteger

class procedure TddTaskItemPrim.WriteBoolean(aStream: TStream;
 aValue: Boolean);
//#UC START# *53AC4F7D023D_53AC018900AE_var*
//#UC END# *53AC4F7D023D_53AC018900AE_var*
begin
//#UC START# *53AC4F7D023D_53AC018900AE_impl*
 aStream.WriteBuffer(aValue, SizeOf(aValue));
//#UC END# *53AC4F7D023D_53AC018900AE_impl*
end;//TddTaskItemPrim.WriteBoolean

class procedure TddTaskItemPrim.WriteInteger(aStream: TStream;
 aValue: Integer);
//#UC START# *53AC4FA30300_53AC018900AE_var*
//#UC END# *53AC4FA30300_53AC018900AE_var*
begin
//#UC START# *53AC4FA30300_53AC018900AE_impl*
 aStream.WriteBuffer(aValue, SizeOf(aValue));
//#UC END# *53AC4FA30300_53AC018900AE_impl*
end;//TddTaskItemPrim.WriteInteger

class function TddTaskItemPrim.ReadDateTime(aStream: TStream): TDateTime;
//#UC START# *53B2732302DA_53AC018900AE_var*
//#UC END# *53B2732302DA_53AC018900AE_var*
begin
//#UC START# *53B2732302DA_53AC018900AE_impl*
 aStream.ReadBuffer(Result, SizeOf(Result));
//#UC END# *53B2732302DA_53AC018900AE_impl*
end;//TddTaskItemPrim.ReadDateTime

class procedure TddTaskItemPrim.WriteDateTime(aStream: TStream;
 aValue: TDateTime);
//#UC START# *53B273660031_53AC018900AE_var*
//#UC END# *53B273660031_53AC018900AE_var*
begin
//#UC START# *53B273660031_53AC018900AE_impl*
 aStream.WriteBuffer(aValue, SizeOf(aValue));
//#UC END# *53B273660031_53AC018900AE_impl*
end;//TddTaskItemPrim.WriteDateTime

class function TddTaskItemPrim.ReadCardinal(aStream: TStream): Cardinal;
//#UC START# *53B3F2B20177_53AC018900AE_var*
//#UC END# *53B3F2B20177_53AC018900AE_var*
begin
//#UC START# *53B3F2B20177_53AC018900AE_impl*
 aStream.ReadBuffer(Result, SizeOf(Result));
//#UC END# *53B3F2B20177_53AC018900AE_impl*
end;//TddTaskItemPrim.ReadCardinal

class procedure TddTaskItemPrim.WriteCardinal(aStream: TStream;
 aValue: Cardinal);
//#UC START# *53B3F2C902F8_53AC018900AE_var*
//#UC END# *53B3F2C902F8_53AC018900AE_var*
begin
//#UC START# *53B3F2C902F8_53AC018900AE_impl*
 aStream.WriteBuffer(aValue, SizeOf(aValue));
//#UC END# *53B3F2C902F8_53AC018900AE_impl*
end;//TddTaskItemPrim.WriteCardinal

procedure TddTaskItemPrim.Changed(aStatus: TcsTaskStatus);
//#UC START# *53C4F9A602B8_53AC018900AE_var*
//#UC END# *53C4F9A602B8_53AC018900AE_var*
begin
//#UC START# *53C4F9A602B8_53AC018900AE_impl*
 if f_CanNotifyChange then
  if TcsTaskListeners.Exists then
   TcsTaskListeners.Instance.TaskChanged(Self, aStatus);
//#UC END# *53C4F9A602B8_53AC018900AE_impl*
end;//TddTaskItemPrim.Changed

class function TddTaskItemPrim.TaskTaggedDataType: Tk2Type;
//#UC START# *53E36D310050_53AC018900AE_var*
//#UC END# *53E36D310050_53AC018900AE_var*
begin
//#UC START# *53E36D310050_53AC018900AE_impl*
 Result := GetTaggedDataType;
//#UC END# *53E36D310050_53AC018900AE_impl*
end;//TddTaskItemPrim.TaskTaggedDataType

class function TddTaskItemPrim.CanAsyncRun: Boolean;
//#UC START# *53E379480169_53AC018900AE_var*
//#UC END# *53E379480169_53AC018900AE_var*
begin
//#UC START# *53E379480169_53AC018900AE_impl*
 Result := False;
//#UC END# *53E379480169_53AC018900AE_impl*
end;//TddTaskItemPrim.CanAsyncRun

class function TddTaskItemPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typTask;
end;//TddTaskItemPrim.GetTaggedDataType

procedure TddTaskItemPrim.InitFields;
//#UC START# *47A042E100E2_53AC018900AE_var*
//#UC END# *47A042E100E2_53AC018900AE_var*
begin
//#UC START# *47A042E100E2_53AC018900AE_impl*
 inherited;
 f_CanNotifyChange := false;
//#UC END# *47A042E100E2_53AC018900AE_impl*
end;//TddTaskItemPrim.InitFields

function TddTaskItemPrim.pm_GetTagOwner: Tl3Variant;
//#UC START# *53343980014A_53AC018900AEget_var*
//#UC END# *53343980014A_53AC018900AEget_var*
begin
//#UC START# *53343980014A_53AC018900AEget_impl*
 Result := f_Owner;
//#UC END# *53343980014A_53AC018900AEget_impl*
end;//TddTaskItemPrim.pm_GetTagOwner

procedure TddTaskItemPrim.pm_SetTagOwner(aValue: Tl3Variant);
//#UC START# *53343980014A_53AC018900AEset_var*
//#UC END# *53343980014A_53AC018900AEset_var*
begin
//#UC START# *53343980014A_53AC018900AEset_impl*
 f_Owner := aValue;
//#UC END# *53343980014A_53AC018900AEset_impl*
end;//TddTaskItemPrim.pm_SetTagOwner

end.
