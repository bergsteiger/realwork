{$IfNDef Para2Point_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest$EditorUsers"
// Модуль: "w:/common/components/gui/Garant/Everest/EditorUsers/Para2Point.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest$EditorUsers::MixIns::Para2Point
//
// Получение точки Tl3Point из мапы параграфа.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define Para2Point_imp}
{$If not defined(NoScripts)}
 _Para2Point_ = {mixin} class(_Para2Point_Parent_)
  {* Получение точки Tl3Point из мапы параграфа. }
 protected
 // protected methods
   function GetInnerPara(const aView: InevInputView;
    const aDocument: InevPara): InevPara; virtual;
     {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
   function GetPoint(const aMap: InevMap): Tl3Point; virtual;
     {* Возвращает точку, на которую нужно спозиционироваться. }
   function TranslatePara2Point(aText: TevCustomEditorWindow): Tl3Point;
     {* Функци получения точки из мапы параграфа. }
 end;//_Para2Point_
{$Else}

 _Para2Point_ = _Para2Point_Parent_;

{$IfEnd} //not NoScripts

{$Else Para2Point_imp}

{$If not defined(NoScripts)}

// start class _Para2Point_

function _Para2Point_.GetInnerPara(const aView: InevInputView;
  const aDocument: InevPara): InevPara;
//#UC START# *4BF4E6A00093_4CED0194038A_var*
//#UC END# *4BF4E6A00093_4CED0194038A_var*
begin
//#UC START# *4BF4E6A00093_4CED0194038A_impl*
 Result := aDocument;
//#UC END# *4BF4E6A00093_4CED0194038A_impl*
end;//_Para2Point_.GetInnerPara

function _Para2Point_.GetPoint(const aMap: InevMap): Tl3Point;
//#UC START# *4C3C927B027E_4CED0194038A_var*
//#UC END# *4C3C927B027E_4CED0194038A_var*
begin
//#UC START# *4C3C927B027E_4CED0194038A_impl*
 Result := l3Point(0, 0);
//#UC END# *4C3C927B027E_4CED0194038A_impl*
end;//_Para2Point_.GetPoint

function _Para2Point_.TranslatePara2Point(aText: TevCustomEditorWindow): Tl3Point;
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

{$IfEnd} //not NoScripts

{$EndIf Para2Point_imp}
