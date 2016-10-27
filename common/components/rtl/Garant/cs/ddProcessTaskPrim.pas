unit ddProcessTaskPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\ddProcessTaskPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddProcessTaskPrim" MUID: (53AC09FE03C7)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ddServerTask
 , k2Base
 , ddProgressObj
;

type
 TddRunContext = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rProgressor: TddProgressObject;
 end;//TddRunContext

 TddProcessTaskPrim = class(TddTaskItem)
  protected
   function pm_GetComment: AnsiString;
   procedure pm_SetComment(const aValue: AnsiString);
   function pm_GetStatus: TcsTaskStatus;
   procedure pm_SetStatus(aValue: TcsTaskStatus);
   function pm_GetDocumentIDList: DocumentIDListHelper;
   function pm_GetReplyAddress: AnsiString;
   procedure pm_SetReplyAddress(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
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

function TddRunContext_C(aProgressor: TddProgressObject): TddRunContext;
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , ProcessTask_Const
 //#UC START# *53AC09FE03C7impl_uses*
 //#UC END# *53AC09FE03C7impl_uses*
;

function TddRunContext_C(aProgressor: TddProgressObject): TddRunContext;
//#UC START# *53CCC5AA01BD_53CCC56502C7_var*
//#UC END# *53CCC5AA01BD_53CCC56502C7_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *53CCC5AA01BD_53CCC56502C7_impl*
 Result.rProgressor := aProgressor;
//#UC END# *53CCC5AA01BD_53CCC56502C7_impl*
end;//TddRunContext_C

function TddProcessTaskPrim.pm_GetComment: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrComment]);
end;//TddProcessTaskPrim.pm_GetComment

procedure TddProcessTaskPrim.pm_SetComment(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrComment, nil] := (aValue);
end;//TddProcessTaskPrim.pm_SetComment

function TddProcessTaskPrim.pm_GetStatus: TcsTaskStatus;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TcsTaskStatus(TaggedData.IntA[k2_attrStatus]);
end;//TddProcessTaskPrim.pm_GetStatus

procedure TddProcessTaskPrim.pm_SetStatus(aValue: TcsTaskStatus);
begin
 TaggedData.IntW[k2_attrStatus, nil] := Ord(aValue);
end;//TddProcessTaskPrim.pm_SetStatus

function TddProcessTaskPrim.pm_GetDocumentIDList: DocumentIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TDocumentIDListHelper.Make(TaggedData.cAtom(k2_attrDocumentIDList));
end;//TddProcessTaskPrim.pm_GetDocumentIDList

function TddProcessTaskPrim.pm_GetReplyAddress: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrReplyAddress]);
end;//TddProcessTaskPrim.pm_GetReplyAddress

procedure TddProcessTaskPrim.pm_SetReplyAddress(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrReplyAddress, nil] := (aValue);
end;//TddProcessTaskPrim.pm_SetReplyAddress

class function TddProcessTaskPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typProcessTask;
end;//TddProcessTaskPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
