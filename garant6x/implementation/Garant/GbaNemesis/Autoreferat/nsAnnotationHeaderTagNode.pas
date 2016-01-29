unit nsAnnotationHeaderTagNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Autoreferat"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Autoreferat/nsAnnotationHeaderTagNode.pas"
// Начат: 02.03.2011 12:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Пользовательские сервисы::Autoreferat::Autoreferat::Autoreferat::TnsAnnotationHeaderTagNode
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
  nsF1DocumentTagNode,
  l3Variant
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsAnnotationHeaderTagNode = class(TnsF1DocumentTagNode)
 protected
 // overridden property methods
   function pm_GetChildrenCount: Integer; override;
 protected
 // overridden protected methods
   function NodeChildrenCount: Integer; override;
 public
 // public methods
   constructor Create(anIndex: Integer;
     aLeafCount: Integer;
     const aDoc: IDocument;
     anAnno: Tl3Tag); reintroduce;
   class function Make(anIndex: Integer;
     aLeafCount: Integer;
     const aDoc: IDocument;
     anAnno: Tl3Tag): Il3TagRef;
 end;//TnsAnnotationHeaderTagNode
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsAnnotationHeaderTagData,
  k2Tags
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsAnnotationHeaderTagNode

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

{$IfEnd} //not Admin AND not Monitorings

end.