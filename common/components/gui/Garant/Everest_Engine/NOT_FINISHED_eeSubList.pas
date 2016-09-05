unit NOT_FINISHED_eeSubList;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\NOT_FINISHED_eeSubList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TeeSubList" MUID: (54BE41340249)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , eeTagEditorTool
 , eeInterfaces
 , l3Interfaces
 , eeConst
;

type
 TeeSubList = class(TeeTagEditorTool, IeeSubList)
  protected
   function Get_Count: Integer;
   function Get_Subs(anIndex: Integer): IeeSub;
   function Get_SubsByID(anID: Integer): IeeSub;
   function Add(anID: Integer = eeConst.ee_SubAutoID;
    const aName: Il3CString = nil): IeeSub;
 end;//TeeSubList
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *54BE41340249impl_uses*
 //#UC END# *54BE41340249impl_uses*
;

function TeeSubList.Get_Count: Integer;
//#UC START# *5481993E00BB_54BE41340249get_var*
//#UC END# *5481993E00BB_54BE41340249get_var*
begin
//#UC START# *5481993E00BB_54BE41340249get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481993E00BB_54BE41340249get_impl*
end;//TeeSubList.Get_Count

function TeeSubList.Get_Subs(anIndex: Integer): IeeSub;
//#UC START# *5481994701A7_54BE41340249get_var*
//#UC END# *5481994701A7_54BE41340249get_var*
begin
//#UC START# *5481994701A7_54BE41340249get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481994701A7_54BE41340249get_impl*
end;//TeeSubList.Get_Subs

function TeeSubList.Get_SubsByID(anID: Integer): IeeSub;
//#UC START# *54819961006C_54BE41340249get_var*
//#UC END# *54819961006C_54BE41340249get_var*
begin
//#UC START# *54819961006C_54BE41340249get_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819961006C_54BE41340249get_impl*
end;//TeeSubList.Get_SubsByID

function TeeSubList.Add(anID: Integer = eeConst.ee_SubAutoID;
 const aName: Il3CString = nil): IeeSub;
//#UC START# *5481997C03DD_54BE41340249_var*
//#UC END# *5481997C03DD_54BE41340249_var*
begin
//#UC START# *5481997C03DD_54BE41340249_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481997C03DD_54BE41340249_impl*
end;//TeeSubList.Add
{$IfEnd} // Defined(Nemesis)

end.
