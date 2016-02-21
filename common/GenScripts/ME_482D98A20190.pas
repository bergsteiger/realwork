unit evCustomMemoTextSource;

// Модуль: "w:\common\components\gui\Garant\Everest\evCustomMemoTextSource.pas"
// Стереотип: "SimpleClass"

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

end.
