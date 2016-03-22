unit dsAACDocumentLeft;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\AAC\dsAACDocumentLeft.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsAACDocumentLeft" MUID: (500E746B0273)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsAACDocumentPrim
 , evdTypes
 , nevTools
;

type
 TdsAACDocumentLeft = class(TdsAACDocumentPrim)
  protected
   function BlockViewKind: TevBlockViewKind; override;
   function MakeContainer: InevDocumentContainer; override;
    {* Конструирует контейнер документа }
 end;//TdsAACDocumentLeft
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsAACLeftDocumentContainer
;

function TdsAACDocumentLeft.BlockViewKind: TevBlockViewKind;
//#UC START# *500E74C30088_500E746B0273_var*
//#UC END# *500E74C30088_500E746B0273_var*
begin
//#UC START# *500E74C30088_500E746B0273_impl*
 Result := ev_bvkLeft;
//#UC END# *500E74C30088_500E746B0273_impl*
end;//TdsAACDocumentLeft.BlockViewKind

function TdsAACDocumentLeft.MakeContainer: InevDocumentContainer;
 {* Конструирует контейнер документа }
//#UC START# *4C6AB38800F3_500E746B0273_var*
//#UC END# *4C6AB38800F3_500E746B0273_var*
begin
//#UC START# *4C6AB38800F3_500E746B0273_impl*
 Result := TnsAACLeftDocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_500E746B0273_impl*
end;//TdsAACDocumentLeft.MakeContainer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
