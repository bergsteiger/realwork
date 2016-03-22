unit evCommentParaDecorator;
 {* Фильтр, довешивающий комментариям юристов специфическое оформление. [$140285546] }

// Модуль: "w:\common\components\gui\Garant\Everest\evCommentParaDecorator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevCommentParaDecorator" MUID: (49E48A670254)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , l3Variant
;

type
 TevCheckStyle = (
  ev_cstNone
  , ev_cstTxtComment
  , ev_cstVerComment
 );//TevCheckStyle

 TevCommentParaDecorator = class(TevdLeafParaFilter)
  {* Фильтр, довешивающий комментариям юристов специфическое оформление. [$140285546] }
  private
   f_CheckComment: TevCheckStyle;
  protected
   procedure OpenStream; override;
    {* вызывается один раз при начале генерации. Для перекрытия в потомках. }
   procedure DoWritePara(aLeaf: Tl3Variant); override;
    {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
 end;//TevCommentParaDecorator

implementation

uses
 l3ImplUses
 , evdStyles
 , k2Tags
 , TextPara_Const
 , Graphics
 , nevInterfaces
;

procedure TevCommentParaDecorator.OpenStream;
 {* вызывается один раз при начале генерации. Для перекрытия в потомках. }
//#UC START# *4836D49800CA_49E48A670254_var*
//#UC END# *4836D49800CA_49E48A670254_var*
begin
//#UC START# *4836D49800CA_49E48A670254_impl*
 inherited;
 f_CheckComment := ev_cstNone;
//#UC END# *4836D49800CA_49E48A670254_impl*
end;//TevCommentParaDecorator.OpenStream

procedure TevCommentParaDecorator.DoWritePara(aLeaf: Tl3Variant);
 {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
//#UC START# *49E4883E0176_49E48A670254_var*

 procedure lp_OutStyleDecor;
 begin
  Generator.StartChild(k2_typTextPara);
  try
   Generator.AddIntegerAtom(k2_tiStyle, ev_saTxtComment);
   Generator.AddStringAtom(k2_tiText, aLeaf.Attr[k2_tiStyle].PCharLenA[k2_tiShortName]);
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=297712959
   Generator.StartTag(k2_tiFont);
   try
    Generator.AddIntegerAtom(k2_tiForeColor, clBlack);
    Generator.AddIntegerAtom(k2_tiSize, 8);
   finally
    Generator.Finish;
   end;//try..finally
  finally
   Generator.Finish;
  end;//try..finally
 end;

var
 l_Style: Integer;
//#UC END# *49E4883E0176_49E48A670254_var*
begin
//#UC START# *49E4883E0176_49E48A670254_impl*
 l_Style := aLeaf.IntA[k2_tiStyle];
 if (l_Style = ev_saTxtComment) then
 begin
  if (f_CheckComment = ev_cstVerComment) or (f_CheckComment = ev_cstNone) then
  begin
   f_CheckComment := ev_cstTxtComment;
   lp_OutStyleDecor;
  end; // if (f_CheckComment = ev_cstVerComment) or (f_CheckComment = ev_cstNone) then
 end
 else
  if (l_Style = ev_saVersionInfo) then
  begin
   if (f_CheckComment = ev_cstTxtComment) or (f_CheckComment = ev_cstNone) then
   begin
    f_CheckComment := ev_cstVerComment;
    lp_OutStyleDecor;
   end; // if (f_CheckComment = ev_cstVerComment) or (f_CheckComment = ev_cstNone) then
  end
  else
   f_CheckComment := ev_cstNone;
 inherited;
//#UC END# *49E4883E0176_49E48A670254_impl*
end;//TevCommentParaDecorator.DoWritePara

end.
