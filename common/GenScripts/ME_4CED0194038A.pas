{$IfNDef Para2Point_imp}

// ������: "w:\common\components\gui\Garant\Everest\EditorUsers\Para2Point.imp.pas"
// ���������: "Impurity"

{$Define Para2Point_imp}

{$If NOT Defined(NoScripts)}
 _Para2Point_ = class(_Para2Point_Parent_)
  {* ��������� ����� Tl3Point �� ���� ���������. }
  protected
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; virtual;
    {* ���������� ��������, ������������ �������� ����� �������������� ����� ��� ��������� }
   function GetPoint(const aMap: InevMap): Tl3Point; virtual;
    {* ���������� �����, �� ������� ����� ������������������. }
   function TranslatePara2Point(aText: TevCustomEditorWindow): Tl3Point;
    {* ������ ��������� ����� �� ���� ���������. }
 end;//_Para2Point_

{$Else NOT Defined(NoScripts)}

_Para2Point_ = _Para2Point_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else Para2Point_imp}

{$IfNDef Para2Point_imp_impl}

{$Define Para2Point_imp_impl}

{$If NOT Defined(NoScripts)}
function _Para2Point_.GetInnerPara(const aView: InevInputView;
 const aDocument: InevPara): InevPara;
 {* ���������� ��������, ������������ �������� ����� �������������� ����� ��� ��������� }
//#UC START# *4BF4E6A00093_4CED0194038A_var*
//#UC END# *4BF4E6A00093_4CED0194038A_var*
begin
//#UC START# *4BF4E6A00093_4CED0194038A_impl*
 Result := aDocument;
//#UC END# *4BF4E6A00093_4CED0194038A_impl*
end;//_Para2Point_.GetInnerPara

function _Para2Point_.GetPoint(const aMap: InevMap): Tl3Point;
 {* ���������� �����, �� ������� ����� ������������������. }
//#UC START# *4C3C927B027E_4CED0194038A_var*
//#UC END# *4C3C927B027E_4CED0194038A_var*
begin
//#UC START# *4C3C927B027E_4CED0194038A_impl*
 Result := l3Point(0, 0);
//#UC END# *4C3C927B027E_4CED0194038A_impl*
end;//_Para2Point_.GetPoint

function _Para2Point_.TranslatePara2Point(aText: TevCustomEditorWindow): Tl3Point;
 {* ������ ��������� ����� �� ���� ���������. }
//#UC START# *4CED034C0356_4CED0194038A_var*
var
 l_Map : InevMap;
//#UC END# *4CED034C0356_4CED0194038A_var*
begin
//#UC START# *4CED034C0356_4CED0194038A_impl*
 with aText do
  l_Map := View.MapByPoint(GetInnerPara(View, Document).MakePoint);
 Result := GetPoint(l_Map);
//#UC END# *4CED034C0356_4CED0194038A_impl*
end;//_Para2Point_.TranslatePara2Point
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf Para2Point_imp_impl}

{$EndIf Para2Point_imp}

