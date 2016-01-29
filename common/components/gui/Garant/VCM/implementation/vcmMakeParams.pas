unit vcmMakeParams;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmMakeParams.pas"
// Начат: 16.10.2009 20:15
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::Implementation::TvcmMakeParams
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
  Classes,
  l3ProtoObject
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmMakeParams = class(Tl3ProtoObject, IvcmMakeParams)
 private
 // private fields
   f_Container : IvcmContainer;
   f_Aggregate : IvcmAggregate;
   f_Owner : TComponent;
 protected
 // realized methods
   function Get_Owner: TComponent;
   function Get_Aggregate: IvcmAggregate;
   function Get_Container: IvcmContainer;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer;
    anOwner: TComponent); reintroduce;
   class function Make(const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer;
    anOwner: TComponent): IvcmMakeParams; reintroduce;
 end;//TvcmMakeParams
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}

// start class TvcmMakeParams

constructor TvcmMakeParams.Create(const anAggregate: IvcmAggregate;
  const aContainer: IvcmContainer;
  anOwner: TComponent);
//#UC START# *4AD89CFA01E7_4AD89C12030A_var*
//#UC END# *4AD89CFA01E7_4AD89C12030A_var*
begin
//#UC START# *4AD89CFA01E7_4AD89C12030A_impl*
 inherited Create;
 f_Aggregate := anAggregate;
 f_Container := aContainer;
 f_Owner := anOwner;
//#UC END# *4AD89CFA01E7_4AD89C12030A_impl*
end;//TvcmMakeParams.Create

class function TvcmMakeParams.Make(const anAggregate: IvcmAggregate;
  const aContainer: IvcmContainer;
  anOwner: TComponent): IvcmMakeParams;
var
 l_Inst : TvcmMakeParams;
begin
 l_Inst := Create(anAggregate, aContainer, anOwner);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TvcmMakeParams.Get_Owner: TComponent;
//#UC START# *49930FC002C3_4AD89C12030Aget_var*
//#UC END# *49930FC002C3_4AD89C12030Aget_var*
begin
//#UC START# *49930FC002C3_4AD89C12030Aget_impl*
 Result := f_Owner;
//#UC END# *49930FC002C3_4AD89C12030Aget_impl*
end;//TvcmMakeParams.Get_Owner

function TvcmMakeParams.Get_Aggregate: IvcmAggregate;
//#UC START# *49930FD200AC_4AD89C12030Aget_var*
//#UC END# *49930FD200AC_4AD89C12030Aget_var*
begin
//#UC START# *49930FD200AC_4AD89C12030Aget_impl*
 Result := f_Aggregate;
//#UC END# *49930FD200AC_4AD89C12030Aget_impl*
end;//TvcmMakeParams.Get_Aggregate

function TvcmMakeParams.Get_Container: IvcmContainer;
//#UC START# *49930FE602DE_4AD89C12030Aget_var*
//#UC END# *49930FE602DE_4AD89C12030Aget_var*
begin
//#UC START# *49930FE602DE_4AD89C12030Aget_impl*
 Result := f_Container
//#UC END# *49930FE602DE_4AD89C12030Aget_impl*
end;//TvcmMakeParams.Get_Container

procedure TvcmMakeParams.Cleanup;
//#UC START# *479731C50290_4AD89C12030A_var*
//#UC END# *479731C50290_4AD89C12030A_var*
begin
//#UC START# *479731C50290_4AD89C12030A_impl*
 f_Owner := nil;
 inherited;
//#UC END# *479731C50290_4AD89C12030A_impl*
end;//TvcmMakeParams.Cleanup

procedure TvcmMakeParams.ClearFields;
 {-}
begin
 {$If not defined(NoVCM)}
 f_Container := nil;
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
 f_Aggregate := nil;
 {$IfEnd} //not NoVCM
 inherited;
end;//TvcmMakeParams.ClearFields

{$IfEnd} //not NoVCM

end.