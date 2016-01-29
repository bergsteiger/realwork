unit evCustomControlTool;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Everest/qf/evCustomControlTool.pas"
// Начат: 28.09.1999 10:18
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::qf::TevCustomControlTool
//
// Базовый класс, содержащий ссылку на параграф.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  l3_Base,
  nevTools,
  evQueryCardInt
  ;

type
 TevCustomControlTool = class(Tl3_Base, IevCustomParaTool)
  {* Базовый класс, содержащий ссылку на параграф. }
 private
 // private fields
   f_Para : InevPara;
    {* Поле для свойства Para}
 protected
 // realized methods
   function Get_Para: InevPara;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected methods
   procedure Set_Para(const Value: InevPara); virtual;
 public
 // public methods
   constructor Create(const aPara: InevPara); reintroduce; virtual;
 public
 // public properties
   property Para: InevPara
     read f_Para;
     {* Параграф, связанный с объектом. }
 end;//TevCustomControlTool

implementation

uses
  k2Tags,
  l3InterfacesMisc
  ;

// start class TevCustomControlTool

constructor TevCustomControlTool.Create(const aPara: InevPara);
//#UC START# *47CFE07602FE_47CFDFAB0197_var*
//#UC END# *47CFE07602FE_47CFDFAB0197_var*
begin
//#UC START# *47CFE07602FE_47CFDFAB0197_impl*
 inherited Create;
 Set_Para(aPara);
//#UC END# *47CFE07602FE_47CFDFAB0197_impl*
end;//TevCustomControlTool.Create

procedure TevCustomControlTool.Set_Para(const Value: InevPara);
//#UC START# *47CFE37202A1_47CFDFAB0197_var*
//#UC END# *47CFE37202A1_47CFDFAB0197_var*
begin
//#UC START# *47CFE37202A1_47CFDFAB0197_impl*
 f_Para := Value;
//#UC END# *47CFE37202A1_47CFDFAB0197_impl*
end;//TevCustomControlTool.Set_Para

function TevCustomControlTool.Get_Para: InevPara;
//#UC START# *47CD5D46015B_47CFDFAB0197get_var*
//#UC END# *47CD5D46015B_47CFDFAB0197get_var*
begin
//#UC START# *47CD5D46015B_47CFDFAB0197get_impl*
 Assert(f_Para <> nil);
 Result := f_Para;
//#UC END# *47CD5D46015B_47CFDFAB0197get_impl*
end;//TevCustomControlTool.Get_Para

procedure TevCustomControlTool.Cleanup;
//#UC START# *479731C50290_47CFDFAB0197_var*
//#UC END# *479731C50290_47CFDFAB0197_var*
begin
//#UC START# *479731C50290_47CFDFAB0197_impl*
 if (f_Para <> nil) and f_Para.AsObject.IsValid then
 begin
  if f_Para.AsObject.HasSubAtom(k2_tiModelControl) then
  // - проверка, чтобы в WevReqRow.GetAtomData не попадать
   if l3IEQ(Self, IUnknown(f_Para.AsObject.IntA[k2_tiModelControl])) then
    f_Para.AsObject.AttrW[k2_tiModelControl, nil] := nil;
 end;//f_Para <> nil..
 f_Para := nil;
 inherited;
//#UC END# *479731C50290_47CFDFAB0197_impl*
end;//TevCustomControlTool.Cleanup

procedure TevCustomControlTool.ClearFields;
 {-}
begin
 f_Para := nil;
 inherited;
end;//TevCustomControlTool.ClearFields

end.