unit evEmailEdit;
 {* Поле для ввод почтового реквизита - использует проверку правильности ввода }

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evEmailEdit.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevEmailEdit" MUID: (48D25C2B00DC)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evEditControl
 , nevTools
 , nevBase
;

type
 TevEmailEdit = class(TevEditControl)
  {* Поле для ввод почтового реквизита - использует проверку правильности ввода }
  protected
   procedure DoTextChange(const aView: InevView;
    const aPara: InevPara;
    const anOp: InevOp); override;
 end;//TevEmailEdit

implementation

uses
 l3ImplUses
;

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
