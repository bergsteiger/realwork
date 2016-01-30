unit evCustomEditTextSource;

// Модуль: "w:\common\components\gui\Garant\Everest\evCustomEditTextSource.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

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
;

function TevCustomEditTextSource.DoMakeDocumentContainer: InevDocumentContainer;
//#UC START# *482D9A030221_482D988102EC_var*
//#UC END# *482D9A030221_482D988102EC_var*
begin
//#UC START# *482D9A030221_482D988102EC_impl*
 Result := TevEditDocumentContainer.Make;
//#UC END# *482D9A030221_482D988102EC_impl*
end;//TevCustomEditTextSource.DoMakeDocumentContainer

end.
