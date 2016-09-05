unit f1ExternalHyperlinkEliminator;

// ������: "w:\common\components\gui\Garant\Nemesis\f1ExternalHyperlinkEliminator.pas"
// ���������: "SimpleClass"
// ������� ������: "Tf1ExternalHyperlinkEliminator" MUID: (556ECBCF0396)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , evdLeafParaFilter
 , l3Variant
 , k2Base
;

type
 Tf1ExternalHyperlinkEliminator = class(TevdLeafParaFilter)
  protected
   function ParaTypeForFiltering: Tk2Type; override;
    {* �������, ������������ ��� �������, ��� ������� ����� ����������� ���������� }
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
    {* ���������� ����� �� ����������� ���������� ����� }
  public
   class function SetTo(var theGenerator: Ik2TagGenerator): Ik2TagGenerator;
 end;//Tf1ExternalHyperlinkEliminator
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , k2Tags
 , HyperLink_Const
 , SysUtils
 , evdTypes
 //#UC START# *556ECBCF0396impl_uses*
 //#UC END# *556ECBCF0396impl_uses*
;

class function Tf1ExternalHyperlinkEliminator.SetTo(var theGenerator: Ik2TagGenerator): Ik2TagGenerator;
//#UC START# *556EEA830002_556ECBCF0396_var*
var
 l_G : Tf1ExternalHyperlinkEliminator;
//#UC END# *556EEA830002_556ECBCF0396_var*
begin
//#UC START# *556EEA830002_556ECBCF0396_impl*
 l_G := Create;
 try
  l_G.Generator := theGenerator;
  theGenerator := l_G;
 finally
  FreeAndNil(l_G);
 end;//try..finally
 Result := theGenerator;
//#UC END# *556EEA830002_556ECBCF0396_impl*
end;//Tf1ExternalHyperlinkEliminator.SetTo

function Tf1ExternalHyperlinkEliminator.ParaTypeForFiltering: Tk2Type;
 {* �������, ������������ ��� �������, ��� ������� ����� ����������� ���������� }
//#UC START# *49E488070386_556ECBCF0396_var*
//#UC END# *49E488070386_556ECBCF0396_var*
begin
//#UC START# *49E488070386_556ECBCF0396_impl*
 Result := k2_typHyperlink;
//#UC END# *49E488070386_556ECBCF0396_impl*
end;//Tf1ExternalHyperlinkEliminator.ParaTypeForFiltering

function Tf1ExternalHyperlinkEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
 {* ���������� ����� �� ����������� ���������� ����� }
//#UC START# *49E48829016F_556ECBCF0396_var*
var
 l_TID      : Integer;
 l_Hyperlink: Tl3Variant;
//#UC END# *49E48829016F_556ECBCF0396_var*
begin
//#UC START# *49E48829016F_556ECBCF0396_impl*
 Result := True;
 if (aLeaf.PCharLenA[k2_tiURL].SLen = 0) and (aLeaf.ChildrenCount > 0) then
 begin
  l_Hyperlink := aLeaf.Child[0];
  if l_Hyperlink.IsValid then
  begin
   l_TID := l_Hyperlink.IntA[k2_tiType];
   Result := l_TID <> CI_REF;
  end;//l_Hyperlink.IsValid
 end;//aLeaf.ChilrenCount > 0
//#UC END# *49E48829016F_556ECBCF0396_impl*
end;//Tf1ExternalHyperlinkEliminator.NeedWritePara
{$IfEnd} // Defined(Nemesis)

end.
