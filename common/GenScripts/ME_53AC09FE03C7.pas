unit ddProcessTaskPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\ddProcessTaskPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ddServerTask
 , ProcessTask_Const
 , evdTaskTypes
 , evdTasksHelpers
 , k2Base
 , ddProgressObj
;

type
 TddRunContext = object
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
//#UC START# *1EA09B9A77DE_53AC09FE03C7get_var*
//#UC END# *1EA09B9A77DE_53AC09FE03C7get_var*
begin
//#UC START# *1EA09B9A77DE_53AC09FE03C7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *1EA09B9A77DE_53AC09FE03C7get_impl*
end;//TddProcessTaskPrim.pm_GetComment

procedure TddProcessTaskPrim.pm_SetComment(const aValue: AnsiString);
//#UC START# *1EA09B9A77DE_53AC09FE03C7set_var*
//#UC END# *1EA09B9A77DE_53AC09FE03C7set_var*
begin
//#UC START# *1EA09B9A77DE_53AC09FE03C7set_impl*
 !!! Needs to be implemented !!!
//#UC END# *1EA09B9A77DE_53AC09FE03C7set_impl*
end;//TddProcessTaskPrim.pm_SetComment

function TddProcessTaskPrim.pm_GetStatus: TcsTaskStatus;
//#UC START# *66ED44905989_53AC09FE03C7get_var*
//#UC END# *66ED44905989_53AC09FE03C7get_var*
begin
//#UC START# *66ED44905989_53AC09FE03C7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *66ED44905989_53AC09FE03C7get_impl*
end;//TddProcessTaskPrim.pm_GetStatus

procedure TddProcessTaskPrim.pm_SetStatus(aValue: TcsTaskStatus);
//#UC START# *66ED44905989_53AC09FE03C7set_var*
//#UC END# *66ED44905989_53AC09FE03C7set_var*
begin
//#UC START# *66ED44905989_53AC09FE03C7set_impl*
 !!! Needs to be implemented !!!
//#UC END# *66ED44905989_53AC09FE03C7set_impl*
end;//TddProcessTaskPrim.pm_SetStatus

function TddProcessTaskPrim.pm_GetDocumentIDList: DocumentIDListHelper;
//#UC START# *D9A88AF55146_53AC09FE03C7get_var*
//#UC END# *D9A88AF55146_53AC09FE03C7get_var*
begin
//#UC START# *D9A88AF55146_53AC09FE03C7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *D9A88AF55146_53AC09FE03C7get_impl*
end;//TddProcessTaskPrim.pm_GetDocumentIDList

function TddProcessTaskPrim.pm_GetReplyAddress: AnsiString;
//#UC START# *CFD2E55B7996_53AC09FE03C7get_var*
//#UC END# *CFD2E55B7996_53AC09FE03C7get_var*
begin
//#UC START# *CFD2E55B7996_53AC09FE03C7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *CFD2E55B7996_53AC09FE03C7get_impl*
end;//TddProcessTaskPrim.pm_GetReplyAddress

procedure TddProcessTaskPrim.pm_SetReplyAddress(const aValue: AnsiString);
//#UC START# *CFD2E55B7996_53AC09FE03C7set_var*
//#UC END# *CFD2E55B7996_53AC09FE03C7set_var*
begin
//#UC START# *CFD2E55B7996_53AC09FE03C7set_impl*
 !!! Needs to be implemented !!!
//#UC END# *CFD2E55B7996_53AC09FE03C7set_impl*
end;//TddProcessTaskPrim.pm_SetReplyAddress

class function TddProcessTaskPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53AC09FE03C7_var*
//#UC END# *53AC03EE01FD_53AC09FE03C7_var*
begin
//#UC START# *53AC03EE01FD_53AC09FE03C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53AC09FE03C7_impl*
end;//TddProcessTaskPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
