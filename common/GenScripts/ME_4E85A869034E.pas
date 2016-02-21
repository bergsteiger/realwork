unit evStyleHeaderAdder;
 {* Фильтр, доклеивающий заголовок стиля перед параграфом
http://mdp.garant.ru/pages/viewpage.action?pageId=278837126 }

// Модуль: "w:\common\components\gui\Garant\Everest\evStyleHeaderAdder.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , k2Base
 , l3Variant
;

type
 TevStyleHeaderAdder = class(TevdLeafParaFilter)
  {* Фильтр, доклеивающий заголовок стиля перед параграфом
http://mdp.garant.ru/pages/viewpage.action?pageId=278837126 }
  protected
   function ParaTypeForFiltering: Tk2Type; override;
    {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
   procedure DoWritePara(aLeaf: Tl3Variant); override;
    {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
 end;//TevStyleHeaderAdder

implementation

uses
 l3ImplUses
 , evTextStyle_Const
 , TextPara_Const
 , k2Tags
 , l3String
 , l3Types
 , nevTools
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
;

function TevStyleHeaderAdder.ParaTypeForFiltering: Tk2Type;
 {* Функция, определяющая тип абзацев, для которых будет выполняться фильтрация }
//#UC START# *49E488070386_4E85A869034E_var*
//#UC END# *49E488070386_4E85A869034E_var*
begin
//#UC START# *49E488070386_4E85A869034E_impl*
 Result := k2_typTextPara;
//#UC END# *49E488070386_4E85A869034E_impl*
end;//TevStyleHeaderAdder.ParaTypeForFiltering

procedure TevStyleHeaderAdder.DoWritePara(aLeaf: Tl3Variant);
 {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
//#UC START# *49E4883E0176_4E85A869034E_var*
var
 l_Style     : Tl3Variant;
 l_Str       : Tl3PCharLen;
 l_Para      : InevPara;
//#UC END# *49E4883E0176_4E85A869034E_var*
begin
//#UC START# *49E4883E0176_4E85A869034E_impl*
 l_Style := aLeaf.Attr[k2_tiStyle];
 if not evAACStyle(l_Style.IntA[k2_tiHandle]) then
  if l_Style.BoolA[k2_tiHeaderHasOwnSpace] then
  begin
   l_Str := l_Style.PCharLenA[k2_tiShortName];
   if not l3IsNil(l_Str) then
   begin
    if aLeaf.BoolA[k2_tiCollapsed] then
     if aLeaf.QT(InevPara, l_Para) then
      if l_Para.TreatCollapsedAsHidden then
      begin
       inherited;
       Exit;
       // - не пишем довесок, к выкидываемому параграфу
      end;//l_Para.TreatCollapsedAsHidden
     Generator.StartChild(k2_typTextPara);
     try
      if (l_Style.IntA[k2_tiHandle] = ev_saChangesInfo) then
       Generator.AddIntegerAtom(k2_tiStyle, ev_saSubHeaderForChangesInfo);
      Generator.AddStringAtom(k2_tiText, l_Str);
     finally
      Generator.Finish;
     end;//try..finally
   end;//not l3IsNil(l_Str)
  end;//l_Style.BoolA[k2_tiHeaderHasOwnSpace]
 inherited;
//#UC END# *49E4883E0176_4E85A869034E_impl*
end;//TevStyleHeaderAdder.DoWritePara

end.
