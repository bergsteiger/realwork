unit NOT_FINISHED_InsDWin;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Dlg"
// Модуль: "w:/archi/source/projects/Archi/Dlg/NOT_FINISHED_InsDWin.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi::Dlg::ChildWindow::InsDWin
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide)}
uses
  l3Tree_TLB,
  DictMetaForm
  ;

type
 TInsertTextDictForm = class(TDictMetaForm)
 end;//TInsertTextDictForm
function GetInsTextNode(var anInsText: PAnsiChar): Boolean;
function GetInsText(var aNode: Il3Node): Boolean;
{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
// unit methods

function GetInsTextNode(var anInsText: PAnsiChar): Boolean;
//#UC START# *4E202ADD0180_4E202A8502E6_var*
//#UC END# *4E202ADD0180_4E202A8502E6_var*
begin
//#UC START# *4E202ADD0180_4E202A8502E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E202ADD0180_4E202A8502E6_impl*
end;//GetInsTextNode

function GetInsText(var aNode: Il3Node): Boolean;
//#UC START# *4E202AEC00C0_4E202A8502E6_var*
//#UC END# *4E202AEC00C0_4E202A8502E6_var*
begin
//#UC START# *4E202AEC00C0_4E202A8502E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E202AEC00C0_4E202A8502E6_impl*
end;//GetInsText
{$IfEnd} //AppClientSide

end.