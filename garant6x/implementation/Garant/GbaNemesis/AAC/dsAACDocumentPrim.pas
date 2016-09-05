unit dsAACDocumentPrim;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\AAC\dsAACDocumentPrim.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsAACDocumentPrim" MUID: (500E749D0046)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsDocument
 , evdTypes
;

type
 TdsAACDocumentPrim = class(TdsDocument)
  protected
   function BlockViewKind: TevBlockViewKind; virtual; abstract;
   {$If NOT Defined(NoVCM)}
   function GetIsNeedChangePosition(const aDataSource: _FormDataSourceType_): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TdsAACDocumentPrim
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *500E749D0046impl_uses*
 //#UC END# *500E749D0046impl_uses*
;

{$If NOT Defined(NoVCM)}
function TdsAACDocumentPrim.GetIsNeedChangePosition(const aDataSource: _FormDataSourceType_): Boolean;
//#UC START# *49147B4602C0_500E749D0046_var*
//#UC END# *49147B4602C0_500E749D0046_var*
begin
//#UC START# *49147B4602C0_500E749D0046_impl*
 Result := (_FormDataSourceType_(Self) = aDataSource);
//#UC END# *49147B4602C0_500E749D0046_impl*
end;//TdsAACDocumentPrim.GetIsNeedChangePosition
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
