unit nsAnnotationHeaderTagNode;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Autoreferat\nsAnnotationHeaderTagNode.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsF1DocumentTagNode
 , DocumentUnit
 , l3Variant
;

type
 TnsAnnotationHeaderTagNode = class(TnsF1DocumentTagNode)
  protected
   function NodeChildrenCount: Integer; override;
   function pm_GetChildrenCount: Integer; override;
  public
   constructor Create(anIndex: Integer;
    aLeafCount: Integer;
    const aDoc: IDocument;
    anAnno: Tl3Tag); reintroduce;
   class function Make(anIndex: Integer;
    aLeafCount: Integer;
    const aDoc: IDocument;
    anAnno: Tl3Tag): Il3TagRef;
 end;//TnsAnnotationHeaderTagNode
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsAnnotationHeaderTagData
 , k2Tags
;

constructor TnsAnnotationHeaderTagNode.Create(anIndex: Integer;
 aLeafCount: Integer;
 const aDoc: IDocument;
 anAnno: Tl3Tag);
//#UC START# *4D6E0CA20143_4D6E0C4A001F_var*
//#UC END# *4D6E0CA20143_4D6E0C4A001F_var*
begin
//#UC START# *4D6E0CA20143_4D6E0C4A001F_impl*
 CreatePrim(TnsAnnotationHeaderTagData.Make(anIndex, aDoc, anAnno));
 //IntA[k2_tiExternalHandle] := 0;
 IntA[k2_tiAllChildrenCount] := aLeafCount;
//#UC END# *4D6E0CA20143_4D6E0C4A001F_impl*
end;//TnsAnnotationHeaderTagNode.Create

class function TnsAnnotationHeaderTagNode.Make(anIndex: Integer;
 aLeafCount: Integer;
 const aDoc: IDocument;
 anAnno: Tl3Tag): Il3TagRef;
//#UC START# *4D6E0CDD033D_4D6E0C4A001F_var*
var
 l_Inst : TnsAnnotationHeaderTagNode;
//#UC END# *4D6E0CDD033D_4D6E0C4A001F_var*
begin
//#UC START# *4D6E0CDD033D_4D6E0C4A001F_impl*
 l_Inst := Create(anIndex, aLeafCount, aDoc, anAnno);
 try
  Result := l_Inst.AsRef;
 finally
  l_Inst.Free;
 end;//try..finally
//#UC END# *4D6E0CDD033D_4D6E0C4A001F_impl*
end;//TnsAnnotationHeaderTagNode.Make

function TnsAnnotationHeaderTagNode.NodeChildrenCount: Integer;
//#UC START# *4CED5CEF011A_4D6E0C4A001F_var*
//#UC END# *4CED5CEF011A_4D6E0C4A001F_var*
begin
//#UC START# *4CED5CEF011A_4D6E0C4A001F_impl*
 ParseStyle;
 Result := 0;
//#UC END# *4CED5CEF011A_4D6E0C4A001F_impl*
end;//TnsAnnotationHeaderTagNode.NodeChildrenCount

function TnsAnnotationHeaderTagNode.pm_GetChildrenCount: Integer;
//#UC START# *5335815D03DC_4D6E0C4A001Fget_var*
//#UC END# *5335815D03DC_4D6E0C4A001Fget_var*
begin
//#UC START# *5335815D03DC_4D6E0C4A001Fget_impl*
 ParseStyle;
 Result := BaseChildrenCount;
//#UC END# *5335815D03DC_4D6E0C4A001Fget_impl*
end;//TnsAnnotationHeaderTagNode.pm_GetChildrenCount
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
