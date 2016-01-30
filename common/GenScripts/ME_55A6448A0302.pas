unit vcmFormSetFactoryFacade;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFactoryFacade.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoObject
 , vcmInterfaces
 , vcmFormSetFactory
;

type
 TvcmFormSetFactoryFacade = class(Tl3ProtoObject, IvcmFormSetSimpleFactory)
  private
   f_FactoryClass: RvcmFormSetFactory;
  protected
   constructor Create(aFactoryClass: RvcmFormSetFactory); reintroduce;
   function MakeFormset(const aDataSource: IvcmFormSetDataSource;
    const aContainer: IvcmContainer;
    aSaveToHistory: Boolean;
    aLockSetFocusToMainObjectForm: Boolean;
    const aFormSetToClone: IvcmFormSet): IvcmFormSet;
  public
   class function Make(aFactoryClass: RvcmFormSetFactory): IvcmFormSetSimpleFactory; reintroduce;
 end;//TvcmFormSetFactoryFacade
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;

constructor TvcmFormSetFactoryFacade.Create(aFactoryClass: RvcmFormSetFactory);
//#UC START# *55A6455F016C_55A6448A0302_var*
//#UC END# *55A6455F016C_55A6448A0302_var*
begin
//#UC START# *55A6455F016C_55A6448A0302_impl*
 inherited Create;
 f_FactoryClass := aFactoryClass;
//#UC END# *55A6455F016C_55A6448A0302_impl*
end;//TvcmFormSetFactoryFacade.Create

class function TvcmFormSetFactoryFacade.Make(aFactoryClass: RvcmFormSetFactory): IvcmFormSetSimpleFactory;
var
 l_Inst : TvcmFormSetFactoryFacade;
begin
 l_Inst := Create(aFactoryClass);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmFormSetFactoryFacade.Make

function TvcmFormSetFactoryFacade.MakeFormset(const aDataSource: IvcmFormSetDataSource;
 const aContainer: IvcmContainer;
 aSaveToHistory: Boolean;
 aLockSetFocusToMainObjectForm: Boolean;
 const aFormSetToClone: IvcmFormSet): IvcmFormSet;
//#UC START# *55A6442E0050_55A6448A0302_var*
//#UC END# *55A6442E0050_55A6448A0302_var*
begin
//#UC START# *55A6442E0050_55A6448A0302_impl*
 f_FactoryClass.Make(aDataSource, aContainer, Result, aSaveToHistory,
  aLockSetFocusToMainObjectForm, aFormSetToClone);
//#UC END# *55A6442E0050_55A6448A0302_impl*
end;//TvcmFormSetFactoryFacade.MakeFormset
{$IfEnd} // NOT Defined(NoVCM)

end.
