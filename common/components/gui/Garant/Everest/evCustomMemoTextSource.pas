unit evCustomMemoTextSource;

// Модуль: "w:\common\components\gui\Garant\Everest\evCustomMemoTextSource.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevCustomMemoTextSource" MUID: (482D98A20190)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evTextSource
 , nevTools
 , Classes
;

type
 TevCustomMemoTextSource = class(TevTextSource)
  protected
   function DoMakeDocumentContainer: InevDocumentContainer; override;
  public
   constructor Create(AOwner: TComponent); override;
 end;//TevCustomMemoTextSource

implementation

uses
 l3ImplUses
 , evCustomMemoContainer
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *482D98A20190impl_uses*
 //#UC END# *482D98A20190impl_uses*
;

constructor TevCustomMemoTextSource.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_482D98A20190_var*
//#UC END# *47D1602000C6_482D98A20190_var*
begin
//#UC START# *47D1602000C6_482D98A20190_impl*
 inherited Create(AOwner);
 LinkEditor(AOwner);
//#UC END# *47D1602000C6_482D98A20190_impl*
end;//TevCustomMemoTextSource.Create

function TevCustomMemoTextSource.DoMakeDocumentContainer: InevDocumentContainer;
//#UC START# *482D9A030221_482D98A20190_var*
//#UC END# *482D9A030221_482D98A20190_var*
begin
//#UC START# *482D9A030221_482D98A20190_impl*
 Result := TevCustomMemoContainer.Make;
//#UC END# *482D9A030221_482D98A20190_impl*
end;//TevCustomMemoTextSource.DoMakeDocumentContainer

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevCustomMemoTextSource);
 {* Регистрация TevCustomMemoTextSource }
{$IfEnd} // NOT Defined(NoScripts)

end.
