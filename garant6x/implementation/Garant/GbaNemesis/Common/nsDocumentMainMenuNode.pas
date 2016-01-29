unit nsDocumentMainMenuNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Common$Lib"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsDocumentMainMenuNode.pas"
// Начат: 21.10.2009 17:51
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::MainMenu::TnsDocumentMainMenuNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  l3Tree_TLB,
  nsMainMenuNode,
  MainMenuDomainInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsDocumentMainMenuNode = class(TnsMainMenuNode, InsDocumentNode)
 private
 // private fields
   f_Document : IDocument;
 protected
 // realized methods
   function pm_GetData: IDocument;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aType: Integer;
    const aDocument: IDocument); reintroduce;
   class function Make(aType: Integer;
    const aDocument: IDocument): Il3Node; reintroduce;
 end;//TnsDocumentMainMenuNode
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsDocumentTools
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsDocumentMainMenuNode

constructor TnsDocumentMainMenuNode.Create(aType: Integer;
  const aDocument: IDocument);
//#UC START# *4ADF118F03DB_4ADDF4FA01C8_var*
//#UC END# *4ADF118F03DB_4ADDF4FA01C8_var*
begin
//#UC START# *4ADF118F03DB_4ADDF4FA01C8_impl*
 inherited Create(aType, nsGetDocumentShortName(aDocument), nil);
 f_Document := aDocument;
//#UC END# *4ADF118F03DB_4ADDF4FA01C8_impl*
end;//TnsDocumentMainMenuNode.Create

class function TnsDocumentMainMenuNode.Make(aType: Integer;
  const aDocument: IDocument): Il3Node;
var
 l_Inst : TnsDocumentMainMenuNode;
begin
 l_Inst := Create(aType, aDocument);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsDocumentMainMenuNode.pm_GetData: IDocument;
//#UC START# *49904BAA013F_4ADDF4FA01C8get_var*
//#UC END# *49904BAA013F_4ADDF4FA01C8get_var*
begin
//#UC START# *49904BAA013F_4ADDF4FA01C8get_impl*
 Result := f_Document;
//#UC END# *49904BAA013F_4ADDF4FA01C8get_impl*
end;//TnsDocumentMainMenuNode.pm_GetData

procedure TnsDocumentMainMenuNode.Cleanup;
//#UC START# *479731C50290_4ADDF4FA01C8_var*
//#UC END# *479731C50290_4ADDF4FA01C8_var*
begin
//#UC START# *479731C50290_4ADDF4FA01C8_impl*
 f_Document := nil;
 inherited;
//#UC END# *479731C50290_4ADDF4FA01C8_impl*
end;//TnsDocumentMainMenuNode.Cleanup

{$IfEnd} //not Admin AND not Monitorings

end.