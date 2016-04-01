unit NOT_COMPLETED_csUserEditQueryPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_COMPLETED_csUserEditQueryPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsUserEditQueryPrim" MUID: (53B27AA300BD)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , k2Base
;

type
 TcsUserEditQueryPrim = class(TddProcessTask)
  protected
   function pm_GetID: Integer;
   procedure pm_SetID(aValue: Integer);
   function pm_GetIsGroup: Boolean;
   procedure pm_SetIsGroup(aValue: Boolean);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property ID: Integer
    read pm_GetID
    write pm_SetID;
   property IsGroup: Boolean
    read pm_GetIsGroup
    write pm_SetIsGroup;
 end;//TcsUserEditQueryPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , UserEditQuery_Const
;

function TcsUserEditQueryPrim.pm_GetID: Integer;
//#UC START# *7B63E87AB0BB_53B27AA300BDget_var*
//#UC END# *7B63E87AB0BB_53B27AA300BDget_var*
begin
//#UC START# *7B63E87AB0BB_53B27AA300BDget_impl*
 !!! Needs to be implemented !!!
//#UC END# *7B63E87AB0BB_53B27AA300BDget_impl*
end;//TcsUserEditQueryPrim.pm_GetID

procedure TcsUserEditQueryPrim.pm_SetID(aValue: Integer);
//#UC START# *7B63E87AB0BB_53B27AA300BDset_var*
//#UC END# *7B63E87AB0BB_53B27AA300BDset_var*
begin
//#UC START# *7B63E87AB0BB_53B27AA300BDset_impl*
 !!! Needs to be implemented !!!
//#UC END# *7B63E87AB0BB_53B27AA300BDset_impl*
end;//TcsUserEditQueryPrim.pm_SetID

function TcsUserEditQueryPrim.pm_GetIsGroup: Boolean;
//#UC START# *DD25BA479477_53B27AA300BDget_var*
//#UC END# *DD25BA479477_53B27AA300BDget_var*
begin
//#UC START# *DD25BA479477_53B27AA300BDget_impl*
 !!! Needs to be implemented !!!
//#UC END# *DD25BA479477_53B27AA300BDget_impl*
end;//TcsUserEditQueryPrim.pm_GetIsGroup

procedure TcsUserEditQueryPrim.pm_SetIsGroup(aValue: Boolean);
//#UC START# *DD25BA479477_53B27AA300BDset_var*
//#UC END# *DD25BA479477_53B27AA300BDset_var*
begin
//#UC START# *DD25BA479477_53B27AA300BDset_impl*
 !!! Needs to be implemented !!!
//#UC END# *DD25BA479477_53B27AA300BDset_impl*
end;//TcsUserEditQueryPrim.pm_SetIsGroup

class function TcsUserEditQueryPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53B27AA300BD_var*
//#UC END# *53AC03EE01FD_53B27AA300BD_var*
begin
//#UC START# *53AC03EE01FD_53B27AA300BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53B27AA300BD_impl*
end;//TcsUserEditQueryPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
