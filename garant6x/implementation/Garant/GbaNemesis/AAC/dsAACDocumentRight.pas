unit dsAACDocumentRight;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\AAC\dsAACDocumentRight.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsAACDocumentRight" MUID: (500E747B0047)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsAACDocumentPrim
 , nevTools
 , evdTypes
;

type
 TdsAACDocumentRight = class(TdsAACDocumentPrim)
  protected
   function BlockViewKind: TevBlockViewKind; override;
   function GetIsReadOnly: Boolean; override;
   function MakeContainer: InevDocumentContainer; override;
    {* Конструирует контейнер документа }
 end;//TdsAACDocumentRight
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsAACRightDocumentContainer
;

function TdsAACDocumentRight.BlockViewKind: TevBlockViewKind;
//#UC START# *500E74C30088_500E747B0047_var*
//#UC END# *500E74C30088_500E747B0047_var*
begin
//#UC START# *500E74C30088_500E747B0047_impl*
 Result := ev_bvkRight;
//#UC END# *500E74C30088_500E747B0047_impl*
end;//TdsAACDocumentRight.BlockViewKind

function TdsAACDocumentRight.GetIsReadOnly: Boolean;
//#UC START# *491C263E03AF_500E747B0047_var*
//#UC END# *491C263E03AF_500E747B0047_var*
begin
//#UC START# *491C263E03AF_500E747B0047_impl*
 Result := True;
//#UC END# *491C263E03AF_500E747B0047_impl*
end;//TdsAACDocumentRight.GetIsReadOnly

function TdsAACDocumentRight.MakeContainer: InevDocumentContainer;
 {* Конструирует контейнер документа }
//#UC START# *4C6AB38800F3_500E747B0047_var*
//#UC END# *4C6AB38800F3_500E747B0047_var*
begin
//#UC START# *4C6AB38800F3_500E747B0047_impl*
 Result := TnsAACRightDocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_500E747B0047_impl*
end;//TdsAACDocumentRight.MakeContainer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
