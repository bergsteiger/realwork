unit nevFormatPoolBase;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevFormatPoolBase.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , nevTools
;

type
 TnevFormatPoolBase = class(Tl3CProtoObject)
  private
   f_Container: Pointer;
  protected
   function pm_GetObj: InevObject;
   function pm_GetContainer: InevObjectHolder;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aDocument: InevObjectHolder); reintroduce;
  public
   property Obj: InevObject
    read pm_GetObj;
   property Container: InevObjectHolder
    read pm_GetContainer;
 end;//TnevFormatPoolBase

implementation

uses
 l3ImplUses
;

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
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48173AD801FF_var*
//#UC END# *479731C50290_48173AD801FF_var*
begin
//#UC START# *479731C50290_48173AD801FF_impl*
 f_Container := nil;
 inherited;
//#UC END# *479731C50290_48173AD801FF_impl*
end;//TnevFormatPoolBase.Cleanup

end.
