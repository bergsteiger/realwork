unit evdDocumentMarksEliminator;

// ������: "w:\common\components\rtl\Garant\EVD\evdDocumentMarksEliminator.pas"
// ���������: "SimpleClass"
// ������� ������: "TevdDocumentMarksEliminator" MUID: (4E664CB30360)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , k2Base
 , l3Variant
;

type
 TevdDocumentMarksEliminator = class(TevdLeafParaFilter)
  protected
   function ParaTypeForFiltering: Tk2Type; override;
    {* �������, ������������ ��� �������, ��� ������� ����� ����������� ���������� }
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
    {* ���������� ����� �� ����������� ���������� ����� }
 end;//TevdDocumentMarksEliminator

implementation

uses
 l3ImplUses
 , DocSubLayer_Const
 , evdTypes
 , k2Tags
;

function TevdDocumentMarksEliminator.ParaTypeForFiltering: Tk2Type;
 {* �������, ������������ ��� �������, ��� ������� ����� ����������� ���������� }
//#UC START# *49E488070386_4E664CB30360_var*
//#UC END# *49E488070386_4E664CB30360_var*
begin
//#UC START# *49E488070386_4E664CB30360_impl*
 Result := k2_typDocSubLayer;
//#UC END# *49E488070386_4E664CB30360_impl*
end;//TevdDocumentMarksEliminator.ParaTypeForFiltering

function TevdDocumentMarksEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
 {* ���������� ����� �� ����������� ���������� ����� }
//#UC START# *49E48829016F_4E664CB30360_var*
//#UC END# *49E48829016F_4E664CB30360_var*
begin
//#UC START# *49E48829016F_4E664CB30360_impl*
 Result := aLeaf.IntA[k2_tiHandle] <> Ord(ev_sbtMark);
//#UC END# *49E48829016F_4E664CB30360_impl*
end;//TevdDocumentMarksEliminator.NeedWritePara

end.
