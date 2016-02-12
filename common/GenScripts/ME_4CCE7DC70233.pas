unit nsEditionFromDTPDocumentContainer;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Editions\nsEditionFromDTPDocumentContainer.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsF1DocumentContainerPrim
 , F1TagDataProviderInterface
 , DocumentUnit
 , EditionsInterfaces
 , nevTools
 , l3Variant
 , nevPrintableDocumentContainer
 , afwInterfaces
 , nevBase
;

type
 _afwApplicationDataUpdate_Parent_ = TnsF1DocumentContainerPrim;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 _nsEditionsDecorationRules_Parent_ = _afwApplicationDataUpdate_;
 {$Include w:\common\components\gui\Garant\Everest\nsEditionsDecorationRules.imp.pas}
 TnsEditionFromDTPDocumentContainer = class(_nsEditionsDecorationRules_, If1EditionDocumentContainer)
  private
   f_Provider: IDocumentTextProvider;
   f_IsLeft: Boolean;
   f_ProviderFactory: InsDocumentTextProviderFactory;
  protected
   function CollapsedTagDefaultValueForPara(aTag: Tl3Tag): Boolean;
   procedure FinishDataUpdate; override;
   function GetDocument: Tl3Tag; override;
   function HAFPainterClass: RevHAFPainter; override;
   procedure ClearFields; override;
  public
   constructor Create(aIsLeft: Boolean;
    const aProviderFactory: InsDocumentTextProviderFactory); reintroduce;
   class function Make(aIsLeft: Boolean;
    const aProviderFactory: InsDocumentTextProviderFactory): InevDocumentContainer; reintroduce;
 end;//TnsEditionFromDTPDocumentContainer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsF1DocumentTagNode
 , nsHAFPainter
 , afwFacade
 , evTextStyle_Const
 , k2Tags
;

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\nsEditionsDecorationRules.imp.pas}

constructor TnsEditionFromDTPDocumentContainer.Create(aIsLeft: Boolean;
 const aProviderFactory: InsDocumentTextProviderFactory);
//#UC START# *4CCE7F0100E8_4CCE7DC70233_var*
//#UC END# *4CCE7F0100E8_4CCE7DC70233_var*
begin
//#UC START# *4CCE7F0100E8_4CCE7DC70233_impl*
 f_IsLeft := aIsLeft;
 f_Provider := aProviderFactory.Node[aIsLeft];
 f_ProviderFactory := aProviderFactory;
 inherited Create;
//#UC END# *4CCE7F0100E8_4CCE7DC70233_impl*
end;//TnsEditionFromDTPDocumentContainer.Create

class function TnsEditionFromDTPDocumentContainer.Make(aIsLeft: Boolean;
 const aProviderFactory: InsDocumentTextProviderFactory): InevDocumentContainer;
var
 l_Inst : TnsEditionFromDTPDocumentContainer;
begin
 l_Inst := Create(aIsLeft, aProviderFactory);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsEditionFromDTPDocumentContainer.Make

function TnsEditionFromDTPDocumentContainer.CollapsedTagDefaultValueForPara(aTag: Tl3Tag): Boolean;
//#UC START# *4E898AC40207_4CCE7DC70233_var*
//#UC END# *4E898AC40207_4CCE7DC70233_var*
begin
//#UC START# *4E898AC40207_4CCE7DC70233_impl*
 Result := false;
//#UC END# *4E898AC40207_4CCE7DC70233_impl*
end;//TnsEditionFromDTPDocumentContainer.CollapsedTagDefaultValueForPara

procedure TnsEditionFromDTPDocumentContainer.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4CCE7DC70233_var*
//#UC END# *47EA4E9002C6_4CCE7DC70233_var*
begin
//#UC START# *47EA4E9002C6_4CCE7DC70233_impl*
 inherited;
 Document := nil;
 f_Provider := nil;
//#UC END# *47EA4E9002C6_4CCE7DC70233_impl*
end;//TnsEditionFromDTPDocumentContainer.FinishDataUpdate

function TnsEditionFromDTPDocumentContainer.GetDocument: Tl3Tag;
//#UC START# *47F27DA80172_4CCE7DC70233_var*
//#UC END# *47F27DA80172_4CCE7DC70233_var*
begin
//#UC START# *47F27DA80172_4CCE7DC70233_impl*
 Result := inherited GetDocument;
 if (Result = nil) then
 begin
  if (f_Provider = nil) then
   f_Provider := f_ProviderFactory.Node[f_IsLeft];
  Result := TnsF1DocumentTagNode.Make(f_Provider).AsObject;
  Document := Result;
 end;//Result = nil
//#UC END# *47F27DA80172_4CCE7DC70233_impl*
end;//TnsEditionFromDTPDocumentContainer.GetDocument

function TnsEditionFromDTPDocumentContainer.HAFPainterClass: RevHAFPainter;
//#UC START# *47F35CAC00E4_4CCE7DC70233_var*
//#UC END# *47F35CAC00E4_4CCE7DC70233_var*
begin
//#UC START# *47F35CAC00E4_4CCE7DC70233_impl*
 Result := TnsHAFPainter;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=562594453&focusedCommentId=564992469#comment-564992469
//#UC END# *47F35CAC00E4_4CCE7DC70233_impl*
end;//TnsEditionFromDTPDocumentContainer.HAFPainterClass

procedure TnsEditionFromDTPDocumentContainer.ClearFields;
begin
 f_Provider := nil;
 f_ProviderFactory := nil;
 inherited;
end;//TnsEditionFromDTPDocumentContainer.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
