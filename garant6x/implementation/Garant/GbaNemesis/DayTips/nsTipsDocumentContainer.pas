unit nsTipsDocumentContainer;
 {* Контейнер документа для советов дня }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\DayTips\nsTipsDocumentContainer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsTipsDocumentContainer" MUID: (4CE53CC80300)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If Defined(Nemesis)}
 , eeDocumentContainer
 {$IfEnd} // Defined(Nemesis)
 , l3Variant
 , DocumentInterfaces
 , F1TagDataProviderInterface
 , DocumentUnit
 , nevTools
 , afwInterfaces
 , nevPrintableDocumentContainer
 , l3IID
 , nevBase
 , l3Interfaces
;

type
 _nsDocumentContainer_Parent_ = TeeDocumentContainer;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsDocumentContainer.imp.pas}
 TnsTipsDocumentContainer = class(_nsDocumentContainer_)
  {* Контейнер документа для советов дня }
  protected
   function GetDocument: Tl3Tag; override;
   procedure AfterCreate(const aDocInfo: IdeDocInfo); override;
 end;//TnsTipsDocumentContainer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , evTypes
 , IOUnit
 , SysUtils
 , nsIDocumentDataObject
 , nsDocumentPreview
 , nsHAFPainter
 , LoggingInterfaces
 , nsDocumentPrintEvent
 , deDocInfo
 , DataAdapter
 , evdTypes
 , nsTypes
 , LeafPara_Const
 , k2Tags
 , nsTagString
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , afwFacade
;

{$If Defined(Nemesis)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsDocumentContainer.imp.pas}

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
{$IfEnd} // Defined(Nemesis)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
