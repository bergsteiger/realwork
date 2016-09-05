unit nevDocumentPartAnchor;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevDocumentPartAnchor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevDocumentPartAnchor" MUID: (4ED8C0B600A4)

{$Include w:\common\components\gui\Garant\Everest\new\nevDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevParaListAnchor
;

type
 TnevDocumentPartAnchor = class(TnevParaListAnchor)
  protected
   procedure CheckInner; override;
 end;//TnevDocumentPartAnchor
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , k2Tags
 //#UC START# *4ED8C0B600A4impl_uses*
 //#UC END# *4ED8C0B600A4impl_uses*
;

procedure TnevDocumentPartAnchor.CheckInner;
//#UC START# *4A58C42A029C_4ED8C0B600A4_var*
//#UC END# *4A58C42A029C_4ED8C0B600A4_var*
begin
//#UC START# *4A58C42A029C_4ED8C0B600A4_impl*
 if not ParaX.AsObject.BoolA[k2_tiCollapsed] then
  inherited CheckInner;
//#UC END# *4A58C42A029C_4ED8C0B600A4_impl*
end;//TnevDocumentPartAnchor.CheckInner
{$IfEnd} // Defined(k2ForEditor)

end.
