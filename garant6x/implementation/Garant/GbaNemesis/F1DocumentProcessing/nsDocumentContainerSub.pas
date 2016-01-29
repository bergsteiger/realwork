unit nsDocumentContainerSub;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1DocumentProcessing"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1DocumentProcessing/nsDocumentContainerSub.pas"
// �����: 2005/12/03 21:22:17
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::F1DocumentProcessing::F1DocumentContainers::TnsDocumentContainerSub
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nevBase,
  nsSubPrim,
  nevTools,
  l3Variant,
  evdTypes,
  l3Interfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsDocumentContainerSub = class(TnsSubPrim)
 private
 // private fields
   f_SubPara : Tl3Tag;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   function Tag: Tl3Tag; override;
   function SubPara: Tl3Tag; override;
 public
 // public methods
   constructor Create(aDocument: Tl3Tag;
     const aProcessor: InevProcessor;
     anID: Integer;
     aLayerID: Integer); reintroduce;
   class function Make(aDocument: Tl3Tag;
     const aProcessor: InevProcessor;
     anID: Integer;
     aLayerID: Integer): IevSub; reintroduce;
     {* ��������� ������� TnsDocumentContainerSub.Make }
 end;//TnsDocumentContainerSub
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsTagNodeToolsNew,
  Block_Const,
  CommentPara_Const,
  Sub_Const,
  Mark_Const,
  k2Tags,
  Bookmark_Const,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsDocumentContainerSub

constructor TnsDocumentContainerSub.Create(aDocument: Tl3Tag;
  const aProcessor: InevProcessor;
  anID: Integer;
  aLayerID: Integer);
//#UC START# *4C9B0D0A035C_4A7AA075008F_var*
//#UC END# *4C9B0D0A035C_4A7AA075008F_var*
begin
//#UC START# *4C9B0D0A035C_4A7AA075008F_impl*
 inherited Create(aDocument, aProcessor, anID, aLayerID);
{ if not IsInIndex then
  CheckExists;}
 // ���������. ��� http://mdp.garant.ru/pages/viewpage.action?pageId=217683801&focusedCommentId=217686359#comment-217686359 
//#UC END# *4C9B0D0A035C_4A7AA075008F_impl*
end;//TnsDocumentContainerSub.Create

class function TnsDocumentContainerSub.Make(aDocument: Tl3Tag;
  const aProcessor: InevProcessor;
  anID: Integer;
  aLayerID: Integer): IevSub;
var
 l_Inst : TnsDocumentContainerSub;
begin
 l_Inst := Create(aDocument, aProcessor, anID, aLayerID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TnsDocumentContainerSub.Cleanup;
//#UC START# *479731C50290_4A7AA075008F_var*
//#UC END# *479731C50290_4A7AA075008F_var*
begin
//#UC START# *479731C50290_4A7AA075008F_impl*
 FreeAndNil(f_SubPara);
 inherited;
//#UC END# *479731C50290_4A7AA075008F_impl*
end;//TnsDocumentContainerSub.Cleanup

function TnsDocumentContainerSub.Tag: Tl3Tag;
//#UC START# *4C9B0AD90093_4A7AA075008F_var*
var
 l_Para : Tl3Variant;  
//#UC END# *4C9B0AD90093_4A7AA075008F_var*
begin
//#UC START# *4C9B0AD90093_4A7AA075008F_impl*
 l_Para := SubPara;
 if (l_Para = nil) OR not l_Para.IsValid then
  Result := nil
 else
 if l_Para.IsKindOf(k2_typBlock) then
  Result := l_Para
 else
  Result := l_Para.rAtomEx([k2_tiSubs,
                          k2_tiChildren, k2_tiHandle, LayerID,
                          k2_tiChildren, k2_tiHandle, ID]);
//#UC END# *4C9B0AD90093_4A7AA075008F_impl*
end;//TnsDocumentContainerSub.Tag

function TnsDocumentContainerSub.SubPara: Tl3Tag;
//#UC START# *4C9B0AEF009B_4A7AA075008F_var*
//#UC END# *4C9B0AEF009B_4A7AA075008F_var*
begin
//#UC START# *4C9B0AEF009B_4A7AA075008F_impl*
 if (f_SubPara = nil) then
  Result := nil
 else
  Result := f_SubPara;
 if (Result = nil) then
 begin
  Case LayerID of
   Ord(ev_sbtSub) :
   begin
    Result := nsFindTagByID(Document.AsObject, k2_typBlock, ID);
    if (Result = nil) then
     Result := nsFindTagByID(Document.AsObject, k2_typSub, ID);
   end;//ev_sbtSub
   Ord(ev_sbtBookmark) :
    Result := nsFindTagByID(Document.AsObject, k2_typBookmark, ID);
   Ord(ev_sbtMark) :
   begin
    Result := nsFindTagByID(Document.AsObject, k2_typCommentPara, ID);
(*    if (Result = nil) then
     Result := nsFindTagByID(Document, k2_typMark, ID);*)
// - �� ����� �� ��� ������ �� �����, � nsFindTagByID ����� Assert
//   �� � �������� ���� K278135821 - ������
   end;//ev_sbtMark
   else
    Result := nsFindTagByID(Document.AsObject, k2_typSub, ID);
  end;//Case LayerID
  Result.SetRef(f_SubPara);
 end;//Result = nil
//#UC END# *4C9B0AEF009B_4A7AA075008F_impl*
end;//TnsDocumentContainerSub.SubPara

{$IfEnd} //not Admin AND not Monitorings

end.