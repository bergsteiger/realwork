unit ddProcessTaskPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ddProcessTaskPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TddProcessTaskPrim
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
  ddServerTask,
  ddProgressObj,
  evdTaskTypes,
  evdTasksHelpers,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TddRunContext = {$IfDef XE4}record{$Else}object{$EndIf}
 public
   rProgressor : TddProgressObject;
 end;//TddRunContext

 TddProcessTaskPrim = class(TddTaskItem)
 protected
 // property methods
   function pm_GetComment: AnsiString;
   procedure pm_SetComment(const aValue: AnsiString);
   function pm_GetStatus: TcsTaskStatus;
   procedure pm_SetStatus(aValue: TcsTaskStatus);
   function pm_GetDocumentIDList: DocumentIDListHelper;
   function pm_GetReplyAddress: AnsiString;
   procedure pm_SetReplyAddress(const aValue: AnsiString);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property Comment: AnsiString
     read pm_GetComment
     write pm_SetComment;
   property Status: TcsTaskStatus
     read pm_GetStatus
     write pm_SetStatus;
   property DocumentIDList: DocumentIDListHelper
     read pm_GetDocumentIDList;
   property ReplyAddress: AnsiString
     read pm_GetReplyAddress
     write pm_SetReplyAddress;
 end;//TddProcessTaskPrim
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
function TddRunContext_C(aProgressor: TddProgressObject): TddRunContext;
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  ProcessTask_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}


function TddRunContext_C(aProgressor: TddProgressObject): TddRunContext;
//#UC START# *53CCC5AA01BD_53CCC56502C7_var*
//#UC END# *53CCC5AA01BD_53CCC56502C7_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *53CCC5AA01BD_53CCC56502C7_impl*
 Result.rProgressor := aProgressor;
//#UC END# *53CCC5AA01BD_53CCC56502C7_impl*
end;//TddRunContext.C

// start class TddProcessTaskPrim

function TddProcessTaskPrim.pm_GetComment: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrComment]);
end;//TddProcessTaskPrim.pm_GetComment

procedure TddProcessTaskPrim.pm_SetComment(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrComment, nil] := (aValue);
end;//TddProcessTaskPrim.pm_SetComment

function TddProcessTaskPrim.pm_GetStatus: TcsTaskStatus;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TcsTaskStatus(TaggedData.IntA[k2_attrStatus]);
end;//TddProcessTaskPrim.pm_GetStatus

procedure TddProcessTaskPrim.pm_SetStatus(aValue: TcsTaskStatus);
 {-}
begin
 TaggedData.IntW[k2_attrStatus, nil] := Ord(aValue);
end;//TddProcessTaskPrim.pm_SetStatus

function TddProcessTaskPrim.pm_GetDocumentIDList: DocumentIDListHelper;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TDocumentIDListHelper.Make(TaggedData.cAtom(k2_attrDocumentIDList));
end;//TddProcessTaskPrim.pm_GetDocumentIDList

function TddProcessTaskPrim.pm_GetReplyAddress: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrReplyAddress]);
end;//TddProcessTaskPrim.pm_GetReplyAddress

procedure TddProcessTaskPrim.pm_SetReplyAddress(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrReplyAddress, nil] := (aValue);
end;//TddProcessTaskPrim.pm_SetReplyAddress

class function TddProcessTaskPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typProcessTask;
end;//TddProcessTaskPrim.GetTaggedDataType

{$IfEnd} //not Nemesis

end.