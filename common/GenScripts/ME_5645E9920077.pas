unit nsDocumentWithSnippetNode;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsDocumentWithSnippetNode.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsINodeRootWrap
 , l3Variant
 , l3IID
;

type
 TnsDocumentWithSnippetNode = class(TnsINodeRootWrap)
  private
   f_DocPara: Tl3Variant;
   f_SnippetPara: Tl3Variant;
   f_Tag: Tl3Tag;
    {* Поле для свойства Tag }
   f_DocumentId: Integer;
    {* Поле для свойства DocumentId }
  private
   function IsVisited: Boolean;
  protected
   function pm_GetTag: Tl3Tag;
   function pm_GetDocumentId: Integer;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
  protected
   property Tag: Tl3Tag
    read pm_GetTag;
   property DocumentId: Integer
    read pm_GetDocumentId;
 end;//TnsDocumentWithSnippetNode
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , evNodePainter
 , l3InternalInterfaces
 , SysUtils
 , l3String
 , l3Interfaces
 , DynamicDocListUnit
 , TextPara_Const
 {$If Defined(Nemesis)}
 , f1TextStyle_Const
 {$IfEnd} // Defined(Nemesis)
 , k2Tags
 , nscDocumentHistory
 , Document_Const
 , l3Types
 , evdStyles
 , evdTypes
 , TextSegment_Const
 , DynamicTreeUnit
 , IOUnit
 , nsTypes
 , l3VirtualCanvas
 , nevNodeView
 , nevTools
 , l3Units
;

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
  l_W: Tl3WString;
  l_N: INodeBase;
  l_S: IString;

  l_Segs: Tl3Variant;
  l_VS: Tl3Variant;
 begin
  if (AdapterNode <> nil) and AdapterNode.HasChildren then
  begin
   AdapterNode.GetFirstChild(l_N);
   l_N.GetCaption(l_S);
   l_W := nsWStr(l_S);

   k2_typTextPara.MakeTag.AsObject.SetRef(f_SnippetPara);
   f_SnippetPara.PCharLenA[k2_tiText] := Tl3PCharLen(l_W);
   l3Replace(f_SnippetPara.PCharLenA[k2_tiText], [#10], ' ');

   l_Segs := f_SnippetPara.cAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slView)], nil);
   l_VS := k2_typTextSegment.MakeTag.AsObject;
   l_VS.IntA[k2_tiStyle] := ev_saBoldSelection;
   l_VS.IntA[k2_tiStart] := 10;
   l_VS.IntA[k2_tiFinish] := 20;
   l_Segs.AddChild(l_VS.AsObject);

   f_SnippetPara.IntA[k2_tiBullet] := 1;
   f_Tag.AddChild(f_SnippetPara);
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

function TnsDocumentWithSnippetNode.IsVisited: Boolean;
//#UC START# *5657205D00B4_5645E9920077_var*
//#UC END# *5657205D00B4_5645E9920077_var*
begin
//#UC START# *5657205D00B4_5645E9920077_impl*
 Result := (DocumentId <> 0) and TnscDocumentHistory.Instance.HasDocument(DocumentId);
//#UC END# *5657205D00B4_5645E9920077_impl*
end;//TnsDocumentWithSnippetNode.IsVisited

procedure TnsDocumentWithSnippetNode.Cleanup;
 {* Функция очистки полей объекта. }
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
 {* Реализация запроса интерфейса }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
