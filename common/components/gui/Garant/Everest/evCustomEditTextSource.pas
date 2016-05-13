unit evCustomEditTextSource;

// Модуль: "w:\common\components\gui\Garant\Everest\evCustomEditTextSource.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevCustomEditTextSource" MUID: (482D988102EC)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomMemoTextSource
 , nevTools
;

type
 TevCustomEditTextSource = class(TevCustomMemoTextSource)
  protected
   function DoMakeDocumentContainer: InevDocumentContainer; override;
 end;//TevCustomEditTextSource

implementation

uses
 l3ImplUses
 , evEditDocumentContainer
 , evCustomMemo
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TevCustomEditTextSource.DoMakeDocumentContainer: InevDocumentContainer;
//#UC START# *482D9A030221_482D988102EC_var*
//#UC END# *482D9A030221_482D988102EC_var*
begin
//#UC START# *482D9A030221_482D988102EC_impl*
 Result := TevEditDocumentContainer.Make;
//#UC END# *482D9A030221_482D988102EC_impl*
end;//TevCustomEditTextSource.DoMakeDocumentContainer

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevCustomEditTextSource);
 {* Регистрация TevCustomEditTextSource }
{$IfEnd} // NOT Defined(NoScripts)

end.
