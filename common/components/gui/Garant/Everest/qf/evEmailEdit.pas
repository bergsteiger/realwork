unit evEmailEdit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Everest/qf/evEmailEdit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::qf::TevEmailEdit
//
// Поле для ввод почтового реквизита - использует проверку правильности ввода
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
  nevTools
  ;

type
 TevEmailEdit = class(TevEditControl)
  {* Поле для ввод почтового реквизита - использует проверку правильности ввода }
 protected
 // overridden protected methods
   procedure DoTextChange(const aView: InevView;
    const aPara: InevPara;
    const anOp: InevOp); override;
 end;//TevEmailEdit

implementation

// start class TevEmailEdit

procedure TevEmailEdit.DoTextChange(const aView: InevView;
  const aPara: InevPara;
  const anOp: InevOp);
//#UC START# *48D14C0E023E_48D25C2B00DC_var*
//#UC END# *48D14C0E023E_48D25C2B00DC_var*
begin
//#UC START# *48D14C0E023E_48D25C2B00DC_impl*
 Set_Valid(Get_Req.CheckEdit(Self));
 inherited;
//#UC END# *48D14C0E023E_48D25C2B00DC_impl*
end;//TevEmailEdit.DoTextChange

end.