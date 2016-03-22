unit nsDocumentWithSnippetNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/nsDocumentWithSnippetNode.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::Document::TnsDocumentWithSnippetNode
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
  nsINodeRootWrap,
  l3Variant,
  l3IID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsDocumentWithSnippetNode = class(TnsINodeRootWrap)
 private
 // private fields
   f_DocPara : Tl3Variant;
   f_SnippetPara : Tl3Variant;
   f_Tag : Tl3Tag;
    {* Поле для свойства Tag}
   f_DocumentId : Integer;
    {* Поле для свойства DocumentId}
 private
 // private methods
   function IsVisited: Boolean;
 protected
 // property methods
   function pm_GetTag: Tl3Tag;
   function pm_GetDocumentId: Integer;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
 protected
 // protected properties
   property Tag: Tl3Tag
     read pm_GetTag;
   property DocumentId: Integer
     read pm_GetDocumentId;
 end;//TnsDocumentWithSnippetNode
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  evNodePainter,
  l3InternalInterfaces,
  SysUtils,
  l3String,
  l3Interfaces,
  DynamicDocListUnit,
  TextPara_Const
  {$If defined(Nemesis)}
  ,
  f1TextStyle_Const
  {$IfEnd} //Nemesis
  ,
  k2Tags,
  nscDocumentHistory,
  Document_Const,
  l3Types,
  evdStyles,
  evdTypes,
  TextSegment_Const,
  DynamicTreeUnit,
  IOUnit,
  nsTypes,
  l3VirtualCanvas,
  nevNodeView,
  nevTools,
  l3Units
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsDocumentWithSnippetNode

function TnsDocumentWithSnippetNode.IsVisited: Boolean;
//#UC START# *5657205D00B4_5645E9920077_var*
//#UC END# *5657205D00B4_5645E9920077_var*
begin
//#UC START# *5657205D00B4_5645E9920077_impl*
 Result := (DocumentId <> 0) and TnscDocumentHistory.Instance.HasDocument(DocumentId);
//#UC END# *5657205D00B4_5645E9920077_impl*
end;//TnsDocumentWithSnippetNode.IsVisited

function TnsDocumentWithSnippetNode.pm_GetTag: Tl3Tag;
//#UC START# *564B1D4702E5_5645E9920077get_var*
const
 c_DocumentStyle: array[Boolean] of Integer = (f1_saDocumentInList, f1_saVisitedDocumentInList);
 c_SnippetStyle: array[Boolean] of Integer = (f1_saSnippet, f1_saVisitedSnippetInList);

 procedure lp_MakeDocumentPara;
 var
  l_W: Tl3WString;
 begin
  l_W := Self.Get_Text;

  k2_typTextPara.MakeTag.AsObject.SetRef(f_DocPara);
  f_DocPara.PCharLenA[k2_tiText] := Tl3PCharLen(l_W);
  l3Replace(f_DocPara.PCharLenA[k2_tiText], [#10], ' ');
  //lp_SetDocumentStyle;
  f_Tag.AddChild(f_DocPara);
 end;

 procedure lp_MakeSnippetPara;
 var
  l_DN: IDynListNode;
  l_W: Tl3WString;
  l_S: IString;

  //l_Segs: Tl3Variant;
  //l_VS: Tl3Variant;
 begin
  if (AdapterNode <> nil) then
   if Supports(AdapterNode, IDynListNode, l_DN) then
   begin
    l_DN.GetSnippetText(l_S);
    if Assigned(l_S) then
    begin
     l_W := nsWStr(l_S);

     k2_typTextPara.MakeTag.AsObject.SetRef(f_SnippetPara);
     f_SnippetPara.PCharLenA[k2_tiText] := Tl3PCharLen(l_W);
     l3Replace(f_SnippetPara.PCharLenA[k2_tiText], [#10], ' ');

     (*
     l_Segs := f_SnippetPara.cAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slView)], nil);
     l_VS := k2_typTextSegment.MakeTag.AsObject;
     l_VS.IntA[k2_tiStyle] := ev_saBoldSelection;
     l_VS.IntA[k2_tiStart] := 10;
     l_VS.IntA[k2_tiFinish] := 20;
     l_Segs.AddChild(l_VS.AsObject);
     *)
     f_SnippetPara.IntA[k2_tiBullet] := 1;
     f_Tag.AddChild(f_SnippetPara);
    end;
   end;
 end;
//#UC END# *564B1D4702E5_5645E9920077get_var*
begin
//#UC START# *564B1D4702E5_5645E9920077get_impl*
 if not Assigned(f_Tag) then
 begin
  k2_typDocument.MakeTag.AsObject.SetRef(f_Tag);
  f_Tag.IntA[k2_tiSpaceBefore] := 0;
  lp_MakeDocumentPara;
  lp_MakeSnippetPara;
 end;//not Assigned(f_Tag)

 f_DocPara.IntA[k2_tiStyle] := c_DocumentStyle[IsVisited];
 if Assigned(f_SnippetPara) then
  f_SnippetPara.IntA[k2_tiStyle] := c_SnippetStyle[IsVisited];

 Result := f_Tag;
//#UC END# *564B1D4702E5_5645E9920077get_impl*
end;//TnsDocumentWithSnippetNode.pm_GetTag

function TnsDocumentWithSnippetNode.pm_GetDocumentId: Integer;
//#UC START# *5657201D02D1_5645E9920077get_var*
var
 l_DN: IDynListNode;
//#UC END# *5657201D02D1_5645E9920077get_var*
begin
//#UC START# *5657201D02D1_5645E9920077get_impl*
 if f_DocumentId = -1 then
  if Supports(AdapterNode, IDynListNode, l_DN) then
   f_DocumentId := l_DN.GetDocumentId - 100000
  else
   f_DocumentId := 0;
 Result := f_DocumentId;
//#UC END# *5657201D02D1_5645E9920077get_impl*
end;//TnsDocumentWithSnippetNode.pm_GetDocumentId

procedure TnsDocumentWithSnippetNode.Cleanup;
//#UC START# *479731C50290_5645E9920077_var*
//#UC END# *479731C50290_5645E9920077_var*
begin
//#UC START# *479731C50290_5645E9920077_impl*
 FreeAndNil(f_Tag);
 FreeAndNil(f_DocPara);
 FreeAndNil(f_SnippetPara);
 inherited;
//#UC END# *479731C50290_5645E9920077_impl*
end;//TnsDocumentWithSnippetNode.Cleanup

procedure TnsDocumentWithSnippetNode.InitFields;
//#UC START# *47A042E100E2_5645E9920077_var*
//#UC END# *47A042E100E2_5645E9920077_var*
begin
//#UC START# *47A042E100E2_5645E9920077_impl*
 f_DocumentId := -1;
 inherited;
//#UC END# *47A042E100E2_5645E9920077_impl*
end;//TnsDocumentWithSnippetNode.InitFields

function TnsDocumentWithSnippetNode.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_5645E9920077_var*
//#UC END# *4A60B23E00C3_5645E9920077_var*
begin
//#UC START# *4A60B23E00C3_5645E9920077_impl*
 if IID.EQ(Il3NodePainter) then
 begin
  Result.SetOk;
  Il3NodePainter(Obj) := TevNodePainter.Make(Tag);
 end//IID.EQ(Il3NodePainter)
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_5645E9920077_impl*
end;//TnsDocumentWithSnippetNode.COMQueryInterface

{$IfEnd} //not Admin AND not Monitorings

end.