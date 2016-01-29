unit NOT_FINISHED_eeSubList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/NOT_FINISHED_eeSubList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Everest Engine::Engine Core::TeeSubList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

{$If defined(Nemesis)}
uses
  eeInterfaces,
  eeTagEditorTool,
  l3Interfaces
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TeeSubList = class(TeeTagEditorTool, IeeSubList)
 protected
 // realized methods
   function Get_Count: Integer;
   function Get_Subs(anIndex: Integer): IeeSub;
   function Get_SubsByID(anID: Integer): IeeSub;
   function Add(anID: Integer = ee_SubAutoID;
     const aName: Il3CString = nil): IeeSub;
 end;//TeeSubList
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}

// start class TeeSubList

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

function TeeSubList.Add(anID: Integer = ee_SubAutoID;
  const aName: Il3CString = nil): IeeSub;
//#UC START# *5481997C03DD_54BE41340249_var*
//#UC END# *5481997C03DD_54BE41340249_var*
begin
//#UC START# *5481997C03DD_54BE41340249_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481997C03DD_54BE41340249_impl*
end;//TeeSubList.Add

{$IfEnd} //Nemesis

end.