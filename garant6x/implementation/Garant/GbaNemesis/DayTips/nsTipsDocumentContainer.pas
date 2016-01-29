unit nsTipsDocumentContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DayTips"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/DayTips/nsTipsDocumentContainer.pas"
// Начат: 18.11.2010 17:49
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Интерфейсные элементы::DayTips::DayTips::DayTips::TnsTipsDocumentContainer
//
// Контейнер документа для советов дня
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
  Classes
  {$If defined(Nemesis)}
  ,
  eeDocumentContainer
  {$IfEnd} //Nemesis
  ,
  DocumentUnit,
  nevTools,
  DocumentInterfaces,
  F1TagDataProviderInterface,
  afwInterfaces,
  l3Interfaces,
  nevBase,
  l3Variant,
  k2Base,
  nevPrintableDocumentContainer,
  l3IID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _nsDocumentContainer_Parent_ = TeeDocumentContainer;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsDocumentContainer.imp.pas}
 TnsTipsDocumentContainer = class(_nsDocumentContainer_)
  {* Контейнер документа для советов дня }
 protected
 // overridden protected methods
   function GetDocument: Tl3Tag; override;
   procedure AfterCreate(const aDocInfo: IdeDocInfo); override;
 end;//TnsTipsDocumentContainer
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  evTypes,
  IOUnit,
  SysUtils,
  nsIDocumentDataObject,
  nsDocumentPreview,
  nsHAFPainter,
  LoggingInterfaces,
  nsDocumentPrintEvent,
  deDocInfo,
  DataAdapter,
  evdTypes,
  nsTypes,
  LeafPara_Const,
  k2Tags,
  nsTagString
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  afwFacade
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsDocumentContainer.imp.pas}

// start class TnsTipsDocumentContainer

function TnsTipsDocumentContainer.GetDocument: Tl3Tag;
//#UC START# *47F27DA80172_4CE53CC80300_var*
//#UC END# *47F27DA80172_4CE53CC80300_var*
begin
//#UC START# *47F27DA80172_4CE53CC80300_impl*
 Result := inherited GetDocument;
//#UC END# *47F27DA80172_4CE53CC80300_impl*
end;//TnsTipsDocumentContainer.GetDocument

procedure TnsTipsDocumentContainer.AfterCreate(const aDocInfo: IdeDocInfo);
//#UC START# *4B1FBF87020C_4CE53CC80300_var*
var
 l_S : IStream;
 l_N : IString;
 l_Text : TnsTagString;
//#UC END# *4B1FBF87020C_4CE53CC80300_var*
begin
//#UC START# *4B1FBF87020C_4CE53CC80300_impl*
 inherited;
 aDocInfo.Doc.GetEvdStream(l_S);
 Assert(l_S <> nil);
 try
  Self.WriteTag(nil, cf_EverestBin, l_S, nil);
 finally
  l_S := nil;
 end;//try..finally
 aDocInfo.Doc.GetName(l_N);
 if (l_N <> nil) then
 begin
  l_Text := TnsTagString.Create(l_N);
  try
   Document.AttrW[k2_tiName, nil] := l_Text;
  finally
   FreeAndNil(l_Text);
  end;//try..finally
 end;//l_String <> nil
//#UC END# *4B1FBF87020C_4CE53CC80300_impl*
end;//TnsTipsDocumentContainer.AfterCreate

{$IfEnd} //not Admin AND not Monitorings

end.