unit nevFormatPoolBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevFormatPoolBase.pas"
// Начат: 29.04.2008 19:18
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Rendering::TnevFormatPoolBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevTools,
  l3CProtoObject
  ;

type
 TnevFormatPoolBase = class(Tl3CProtoObject)
 private
 // private fields
   f_Container : Pointer;
 protected
 // property methods
   function pm_GetObj: InevObject;
   function pm_GetContainer: InevObjectHolder;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aDocument: InevObjectHolder); reintroduce;
 public
 // public properties
   property Obj: InevObject
     read pm_GetObj;
   property Container: InevObjectHolder
     read pm_GetContainer;
 end;//TnevFormatPoolBase

implementation

// start class TnevFormatPoolBase

function TnevFormatPoolBase.pm_GetObj: InevObject;
//#UC START# *4810DE6F0396_48173AD801FFget_var*
//#UC END# *4810DE6F0396_48173AD801FFget_var*
begin
//#UC START# *4810DE6F0396_48173AD801FFget_impl*
 Result := InevDocumentContainer(f_Container).Obj;
//#UC END# *4810DE6F0396_48173AD801FFget_impl*
end;//TnevFormatPoolBase.pm_GetObj

function TnevFormatPoolBase.pm_GetContainer: InevObjectHolder;
//#UC START# *48173E5D0124_48173AD801FFget_var*
//#UC END# *48173E5D0124_48173AD801FFget_var*
begin
//#UC START# *48173E5D0124_48173AD801FFget_impl*
 Result := InevDocumentContainer(f_Container);
//#UC END# *48173E5D0124_48173AD801FFget_impl*
end;//TnevFormatPoolBase.pm_GetContainer

constructor TnevFormatPoolBase.Create(const aDocument: InevObjectHolder);
//#UC START# *48173B5102C8_48173AD801FF_var*
//#UC END# *48173B5102C8_48173AD801FF_var*
begin
//#UC START# *48173B5102C8_48173AD801FF_impl*
 inherited Create;
 f_Container := Pointer(aDocument);
//#UC END# *48173B5102C8_48173AD801FF_impl*
end;//TnevFormatPoolBase.Create

procedure TnevFormatPoolBase.Cleanup;
//#UC START# *479731C50290_48173AD801FF_var*
//#UC END# *479731C50290_48173AD801FF_var*
begin
//#UC START# *479731C50290_48173AD801FF_impl*
 f_Container := nil;
 inherited;
//#UC END# *479731C50290_48173AD801FF_impl*
end;//TnevFormatPoolBase.Cleanup

end.