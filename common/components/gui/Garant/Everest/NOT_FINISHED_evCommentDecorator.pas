unit NOT_FINISHED_evCommentDecorator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/NOT_FINISHED_evCommentDecorator.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Generators::TevCommentDecorator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evCommentParaDecorator,
  l3Variant
  ;

type
 TevWhatOpen = (
   ev_wnoNone
 , ev_wnoRow
 , ev_wnoTable
 );//TevWhatOpen

 TevCommentDecorator = class(TevCommentParaDecorator)
 private
 // private fields
   f_WhatOpen : TevWhatOpen;
   f_InTable : Integer;
   f_AACSample : Integer;
   f_InAACBlock : Integer;
 private
 // private methods
   procedure StartAACTable;
     {* Начало таблицы-обертки. }
   procedure AddHeaderRow; virtual;
     {* Строка табилцы с картинкой. }
   procedure AddSpaceRow;
     {* Добавляем отступ перед стилем. }
   procedure StartAACRow;
     {* Начинаем строку с основным текстом. }
   procedure StartAACRow4Table;
     {* Начинаем строку для талицы (нет правого отступа) }
   procedure StartAACStyle;
     {* Начинает таблицу и предварительные строки. }
   procedure EndRow;
     {* Закрываем строку оберточной таблицы. }
   procedure EndRowAndTable;
     {* Закрывает строку и таблицу. }
   procedure CheckWhatOpen(aForTable: Boolean);
     {* Открытие обертночной таблицы или строки таблицы с проверкой, что уже было открыто. }
 protected
 // overridden protected methods
   procedure StartChild(TypeID: Tl3Type); override;
   procedure OpenStream; override;
     {* вызывается один раз при начале генерации. Для перекрытия в потомках. }
   procedure CloseStructure(NeedUndo: Boolean); override;
     {* вызывается на закрывающуюся "скобку". Для перекрытия в потомках. }
   procedure AddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
   procedure DoWritePara(aLeaf: Tl3Variant); override;
     {* Запись конкретного абзаца в генератор. Позволяет вносить изменения в содержание абзаца }
 end;//TevCommentDecorator

implementation

uses
  SysUtils,
  evDef,
  evdFrame_Const,
  l3Memory,
  Block_Const,
  Document_Const,
  evdStylesRes,
  BitmapPara_Const,
  Table_Const,
  SectionBreak_Const,
  TextPara_Const,
  evParaTools,
  k2Tags,
  evdStyles
  ;

const
   { CommentDecoratorConsts }
  cnDefIndentValue = 420;

// start class TevCommentDecorator

procedure TevCommentDecorator.StartAACTable;
//#UC START# *53B27F3E0397_4D88BFEA013A_var*
//#UC END# *53B27F3E0397_4D88BFEA013A_var*
begin
//#UC START# *53B27F3E0397_4D88BFEA013A_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B27F3E0397_4D88BFEA013A_impl*
end;//TevCommentDecorator.StartAACTable

procedure TevCommentDecorator.AddHeaderRow;
//#UC START# *53B27F93031A_4D88BFEA013A_var*
//#UC END# *53B27F93031A_4D88BFEA013A_var*
begin
//#UC START# *53B27F93031A_4D88BFEA013A_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B27F93031A_4D88BFEA013A_impl*
end;//TevCommentDecorator.AddHeaderRow

procedure TevCommentDecorator.AddSpaceRow;
//#UC START# *53B27FD8022F_4D88BFEA013A_var*
//#UC END# *53B27FD8022F_4D88BFEA013A_var*
begin
//#UC START# *53B27FD8022F_4D88BFEA013A_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B27FD8022F_4D88BFEA013A_impl*
end;//TevCommentDecorator.AddSpaceRow

procedure TevCommentDecorator.StartAACRow;
//#UC START# *53B280110031_4D88BFEA013A_var*
//#UC END# *53B280110031_4D88BFEA013A_var*
begin
//#UC START# *53B280110031_4D88BFEA013A_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B280110031_4D88BFEA013A_impl*
end;//TevCommentDecorator.StartAACRow

procedure TevCommentDecorator.StartAACRow4Table;
//#UC START# *53B280490098_4D88BFEA013A_var*
//#UC END# *53B280490098_4D88BFEA013A_var*
begin
//#UC START# *53B280490098_4D88BFEA013A_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B280490098_4D88BFEA013A_impl*
end;//TevCommentDecorator.StartAACRow4Table

procedure TevCommentDecorator.StartAACStyle;
//#UC START# *53B280860287_4D88BFEA013A_var*
//#UC END# *53B280860287_4D88BFEA013A_var*
begin
//#UC START# *53B280860287_4D88BFEA013A_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B280860287_4D88BFEA013A_impl*
end;//TevCommentDecorator.StartAACStyle

procedure TevCommentDecorator.EndRow;
//#UC START# *53B282200211_4D88BFEA013A_var*
//#UC END# *53B282200211_4D88BFEA013A_var*
begin
//#UC START# *53B282200211_4D88BFEA013A_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B282200211_4D88BFEA013A_impl*
end;//TevCommentDecorator.EndRow

procedure TevCommentDecorator.EndRowAndTable;
//#UC START# *53B2824F0246_4D88BFEA013A_var*
//#UC END# *53B2824F0246_4D88BFEA013A_var*
begin
//#UC START# *53B2824F0246_4D88BFEA013A_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B2824F0246_4D88BFEA013A_impl*
end;//TevCommentDecorator.EndRowAndTable

procedure TevCommentDecorator.CheckWhatOpen(aForTable: Boolean);
//#UC START# *53B282B3010A_4D88BFEA013A_var*
//#UC END# *53B282B3010A_4D88BFEA013A_var*
begin
//#UC START# *53B282B3010A_4D88BFEA013A_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B282B3010A_4D88BFEA013A_impl*
end;//TevCommentDecorator.CheckWhatOpen

procedure TevCommentDecorator.StartChild(TypeID: Tl3Type);
//#UC START# *4836D4650177_4D88BFEA013A_var*
//#UC END# *4836D4650177_4D88BFEA013A_var*
begin
//#UC START# *4836D4650177_4D88BFEA013A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4836D4650177_4D88BFEA013A_impl*
end;//TevCommentDecorator.StartChild

procedure TevCommentDecorator.OpenStream;
//#UC START# *4836D49800CA_4D88BFEA013A_var*
//#UC END# *4836D49800CA_4D88BFEA013A_var*
begin
//#UC START# *4836D49800CA_4D88BFEA013A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4836D49800CA_4D88BFEA013A_impl*
end;//TevCommentDecorator.OpenStream

procedure TevCommentDecorator.CloseStructure(NeedUndo: Boolean);
//#UC START# *4836D4C20059_4D88BFEA013A_var*
//#UC END# *4836D4C20059_4D88BFEA013A_var*
begin
//#UC START# *4836D4C20059_4D88BFEA013A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4836D4C20059_4D88BFEA013A_impl*
end;//TevCommentDecorator.CloseStructure

procedure TevCommentDecorator.AddAtomEx(AtomIndex: Integer;
  const Value: Ik2Variant);
//#UC START# *4836D52400D9_4D88BFEA013A_var*
//#UC END# *4836D52400D9_4D88BFEA013A_var*
begin
//#UC START# *4836D52400D9_4D88BFEA013A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4836D52400D9_4D88BFEA013A_impl*
end;//TevCommentDecorator.AddAtomEx

procedure TevCommentDecorator.DoWritePara(aLeaf: Tl3Variant);
//#UC START# *49E4883E0176_4D88BFEA013A_var*
//#UC END# *49E4883E0176_4D88BFEA013A_var*
begin
//#UC START# *49E4883E0176_4D88BFEA013A_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E4883E0176_4D88BFEA013A_impl*
end;//TevCommentDecorator.DoWritePara

end.