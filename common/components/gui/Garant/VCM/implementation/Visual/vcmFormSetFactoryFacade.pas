unit vcmFormSetFactoryFacade;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmFormSetFactoryFacade.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::FormSets::TvcmFormSetFactoryFacade
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmInterfaces,
  vcmFormSetFactory,
  l3ProtoObject
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmFormSetFactoryFacade = class(Tl3ProtoObject, IvcmFormSetSimpleFactory)
 private
 // private fields
   f_FactoryClass : RvcmFormSetFactory;
 protected
 // realized methods
   function MakeFormset(const aDataSource: IvcmFormSetDataSource;
    const aContainer: IvcmContainer;
    aSaveToHistory: Boolean;
    aLockSetFocusToMainObjectForm: Boolean;
    const aFormSetToClone: IvcmFormSet): IvcmFormSet;
 protected
 // protected methods
   constructor Create(aFactoryClass: RvcmFormSetFactory); reintroduce;
 public
 // public methods
   class function Make(aFactoryClass: RvcmFormSetFactory): IvcmFormSetSimpleFactory; reintroduce;
     {* Сигнатура фабрики TvcmFormSetFactoryFacade.Make }
 end;//TvcmFormSetFactoryFacade
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}

// start class TvcmFormSetFactoryFacade

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
end;

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

{$IfEnd} //not NoVCM

end.