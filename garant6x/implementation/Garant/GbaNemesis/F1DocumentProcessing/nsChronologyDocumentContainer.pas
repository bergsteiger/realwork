unit nsChronologyDocumentContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1DocumentProcessing"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1DocumentProcessing/nsChronologyDocumentContainer.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::F1DocumentProcessing::F1DocumentContainers::TnsChronologyDocumentContainer
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
  nsF1DocumentContainer,
  nevTools,
  l3Variant
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsChronologyDocumentContainer = class(TnsF1DocumentContainer)
 protected
 // overridden protected methods
   function CanBePlacedInDocumentsCache: Boolean; override;
   function GetIsSame(const aContainer: InevDocumentContainer): Boolean; override;
   function CanFindParaAsNode: Boolean; override;
   procedure TransformMadeDocument(var theDocument: Tl3Tag); override;
     {* Трансформирует документ к его подмножеству, например как в ААК или Толковом Словаре }
 end;//TnsChronologyDocumentContainer
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsBlockNode,
  F1TagDataProviderInterface,
  k2Base,
  k2Tags,
  SysUtils,
  Block_Const,
  nsTagNodeToolsNew
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsChronologyDocumentContainer

function TnsChronologyDocumentContainer.CanBePlacedInDocumentsCache: Boolean;
//#UC START# *47F10C6E0240_53C65E01039B_var*
//#UC END# *47F10C6E0240_53C65E01039B_var*
begin
//#UC START# *47F10C6E0240_53C65E01039B_impl*
 Result := False;
//#UC END# *47F10C6E0240_53C65E01039B_impl*
end;//TnsChronologyDocumentContainer.CanBePlacedInDocumentsCache

function TnsChronologyDocumentContainer.GetIsSame(const aContainer: InevDocumentContainer): Boolean;
//#UC START# *47F279E9037A_53C65E01039B_var*
//#UC END# *47F279E9037A_53C65E01039B_var*
begin
//#UC START# *47F279E9037A_53C65E01039B_impl*
 Result := False;
//#UC END# *47F279E9037A_53C65E01039B_impl*
end;//TnsChronologyDocumentContainer.GetIsSame

function TnsChronologyDocumentContainer.CanFindParaAsNode: Boolean;
//#UC START# *4A79B7020303_53C65E01039B_var*
//#UC END# *4A79B7020303_53C65E01039B_var*
begin
//#UC START# *4A79B7020303_53C65E01039B_impl*
 Result := False;
//#UC END# *4A79B7020303_53C65E01039B_impl*
end;//TnsChronologyDocumentContainer.CanFindParaAsNode

procedure TnsChronologyDocumentContainer.TransformMadeDocument(var theDocument: Tl3Tag);
//#UC START# *500ED7750045_53C65E01039B_var*
var
 l_D: Tl3Variant;

 procedure MakeBlock(aChild: Tl3Variant);
 var
  l_Child: Tl3Variant;
  l_BlockNode: TnsBlockNode;
  l_Obj: InevObject;
  l_P: If1TagDataProvider;
 begin//MakeBlock
  if not aChild.QI(If1TagDataProvider, l_P) then
   Assert(False);
  l_BlockNode := TnsBlockNode.Create(Tk2Type(aChild.TagType), l_P, l_D, []);
  try
   l_Child := l_BlockNode;
   if not aChild.QT(InevObject, l_Obj) then
    Assert(False);
   l_Child.IntA[k2_tiExternalHandle] := l_Obj.PID; 
   l_D.AddChild(l_Child);
   l_D.IntA[k2_tiAllChildrenCount] := l_Child.IntA[k2_tiAllChildrenCount];
   Assert(l_Child.Owner.IsSame(l_D));
  finally
   FreeAndNil(l_BlockNode);
  end;//try..finally
  //l_D.AddChild(l_Child);
 end;//MakeBlock

 function CheckChild(aChild: Tl3Variant) : Boolean;
 begin//CheckChild
  Result := aChild.IsKindOf(k2_typBlock);
  if Result then
   MakeBlock(aChild);
 end;//CheckChild

var
 l_Child: Tl3Variant;
 l_Parent: Tl3Variant;

const
 c_ChronologyBlock = 548548; // http://mdp.garant.ru/pages/viewpage.action?pageId=513880934
//#UC END# *500ED7750045_53C65E01039B_var*
begin
//#UC START# *500ED7750045_53C65E01039B_impl*
 l_D := theDocument.TagType.MakeTag.AsObject;
 try
  try
   l_Child := NsFindTagByID(theDocument, k2_typBlock, c_ChronologyBlock);
   Assert(Assigned(l_Child));
   while (l_Child <> nil) AND l_Child.IsValid do
   begin
    if CheckChild(l_Child) then
     Exit;
    if not EvInPara(l_Child.Owner, k2_typBlock, l_Parent) then
     Break;
    l_Child := l_Parent;
   end;//l_Child <> nil
  finally
   l_D.IntA[k2_tiExternalHandle] := theDocument.IntA[k2_tiExternalHandle];
   l_D.PCharLenA[k2_tiName] := theDocument.PCharLenA[k2_tiName];
   l_D.PCharLenA[k2_tiShortName] := theDocument.PCharLenA[k2_tiShortName];
   l_D.SetRef(theDocument);
  end;
 finally
  l_D := nil;
 end;//try..finally
//#UC END# *500ED7750045_53C65E01039B_impl*
end;//TnsChronologyDocumentContainer.TransformMadeDocument

{$IfEnd} //not Admin AND not Monitorings

end.