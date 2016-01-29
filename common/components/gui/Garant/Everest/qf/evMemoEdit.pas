unit evMemoEdit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Everest/qf/evMemoEdit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::qf::TevMemoEdit
//
// Изначально многострочный редактор с ограничением на количество символов ввода
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  evEditControl,
  nevBase,
  nevTools,
  l3Interfaces
  ;

type
 TevMemoEdit = class(TevEditControl)
  {* Изначально многострочный редактор с ограничением на количество символов ввода }
 protected
 // overridden protected methods
   function GetIsMultiline: Boolean; override;
   procedure DoTextChange(const aView: InevView;
    const aPara: InevPara;
    const anOp: InevOp); override;
   procedure AfterSetText(const Value: Il3CString); override;
   function GetSelectAllOnFocus: Boolean; override;
 end;//TevMemoEdit

implementation

// start class TevMemoEdit

function TevMemoEdit.GetIsMultiline: Boolean;
//#UC START# *48D13CED0240_48D258F502BF_var*
//#UC END# *48D13CED0240_48D258F502BF_var*
begin
//#UC START# *48D13CED0240_48D258F502BF_impl*
 Result := True;
//#UC END# *48D13CED0240_48D258F502BF_impl*
end;//TevMemoEdit.GetIsMultiline

procedure TevMemoEdit.DoTextChange(const aView: InevView;
  const aPara: InevPara;
  const anOp: InevOp);
//#UC START# *48D14C0E023E_48D258F502BF_var*
//#UC END# *48D14C0E023E_48D258F502BF_var*
begin
//#UC START# *48D14C0E023E_48D258F502BF_impl*
 Get_Req.TextChange(aView);
//#UC END# *48D14C0E023E_48D258F502BF_impl*
end;//TevMemoEdit.DoTextChange

procedure TevMemoEdit.AfterSetText(const Value: Il3CString);
//#UC START# *48D247CA0077_48D258F502BF_var*
//#UC END# *48D247CA0077_48D258F502BF_var*
begin
//#UC START# *48D247CA0077_48D258F502BF_impl*
//#UC END# *48D247CA0077_48D258F502BF_impl*
end;//TevMemoEdit.AfterSetText

function TevMemoEdit.GetSelectAllOnFocus: Boolean;
//#UC START# *48D249F00054_48D258F502BF_var*
//#UC END# *48D249F00054_48D258F502BF_var*
begin
//#UC START# *48D249F00054_48D258F502BF_impl*
 Result := False;
//#UC END# *48D249F00054_48D258F502BF_impl*
end;//TevMemoEdit.GetSelectAllOnFocus

end.