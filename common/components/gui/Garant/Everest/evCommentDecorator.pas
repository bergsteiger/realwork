unit evCommentDecorator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evCommentDecorator.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Generators::TevCommentDecorator
//
// Поддержка экспорта стилей для ААК.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

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

 TevPrevClosed = (
   ev_pcNone
 , ev_pcTable
 , ev_pcAACTable
 );//TevPrevClosed

 TevCommentDecorator = class(TevCommentParaDecorator)
  {* Поддержка экспорта стилей для ААК. }
 private
 // private fields
   f_WhatOpen : TevWhatOpen;
   f_InTable : Integer;
   f_AACSample : Integer;
   f_InAACBlock : Integer;
   f_WhatClosed : TevPrevClosed;
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
  TextPara_Const
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  k2Tags,
  evdStyles,
  TableCell_Const,
  ContentsElement_Const
  ;

const
   { CommentDecoratorConsts }
  cnDefIndentValue = 420;
   { Цифра взята от настоящего стиля, но её значение вообщем-то фиолетово, т.к. все равно пересчитывается на уровне RTFWriter'а. }

// start class TevCommentDecorator

procedure TevCommentDecorator.StartAACTable;
//#UC START# *53B27F3E0397_4D88BFEA013A_var*
//#UC END# *53B27F3E0397_4D88BFEA013A_var*
begin
//#UC START# *53B27F3E0397_4D88BFEA013A_impl*
 Generator.StartChild(k2_typTable);
 Generator.AddIntegerAtom(k2_tiStyle, f_AACSample);
 f_WhatOpen := ev_wnoTable;
//#UC END# *53B27F3E0397_4D88BFEA013A_impl*
end;//TevCommentDecorator.StartAACTable

procedure TevCommentDecorator.AddHeaderRow;
//#UC START# *53B27F93031A_4D88BFEA013A_var*
var
 l_Stream: Tl3MemoryStream;
//#UC END# *53B27F93031A_4D88BFEA013A_var*
begin
//#UC START# *53B27F93031A_4D88BFEA013A_impl*
 Generator.StartDefaultChild;
 try
  Generator.StartDefaultChild;
  try
   Generator.AddIntegerAtom(k2_tiWidth, def_inchSBSWidth);
   Generator.AddIntegerAtom(k2_tiFrame, evd_fvEmpty);
   l_Stream := evdStyles_Res.Style2Stream(f_AACSample);
   if l_Stream <> nil then
    try
     Generator.StartChild(k2_typBitmapPara);
     try
      Generator.AddStreamAtom(k2_tiData, l_Stream);
     finally
      Generator.Finish;
     end;//try..finally
    finally
     FreeAndNil(l_Stream);
    end;
  finally
   Generator.Finish;
  end;
 finally
  Generator.Finish;
 end;
//#UC END# *53B27F93031A_4D88BFEA013A_impl*
end;//TevCommentDecorator.AddHeaderRow

procedure TevCommentDecorator.AddSpaceRow;
//#UC START# *53B27FD8022F_4D88BFEA013A_var*
//#UC END# *53B27FD8022F_4D88BFEA013A_var*
begin
//#UC START# *53B27FD8022F_4D88BFEA013A_impl*
 Generator.StartDefaultChild;
 try
  Generator.StartDefaultChild;
  try
   Generator.AddIntegerAtom(k2_tiWidth, def_inchSBSWidth);
   Generator.AddIntegerAtom(k2_tiFrame, evd_fvEmpty);
   Generator.StartDefaultChild;
   try
    Generator.AddStringAtom(k2_tiText, '');
   finally
    Generator.Finish;
   end;
  finally
   Generator.Finish;
  end;
 finally
  Generator.Finish;
 end;
//#UC END# *53B27FD8022F_4D88BFEA013A_impl*
end;//TevCommentDecorator.AddSpaceRow

procedure TevCommentDecorator.StartAACRow;
//#UC START# *53B280110031_4D88BFEA013A_var*
var
 l_Width: Integer;
//#UC END# *53B280110031_4D88BFEA013A_var*
begin
//#UC START# *53B280110031_4D88BFEA013A_impl*
 Generator.StartDefaultChild; // Открываем строку с текстом AAC
 l_Width := def_inchSBSWidth;
 Generator.StartDefaultChild; // Открывам ячейку с шириной левого отступа
 Generator.AddIntegerAtom(k2_tiFrame, evd_fvEmpty);
 Generator.AddIntegerAtom(k2_tiWidth, cnDefIndentValue);
 Generator.Finish;
 Dec(l_Width, 2 * cnDefIndentValue);
 Generator.StartDefaultChild; // Открываем ячейку с текстом ААС
 Generator.AddIntegerAtom(k2_tiFrame, evd_fvEmpty);
 Generator.AddIntegerAtom(k2_tiWidth, l_Width);
 f_WhatOpen := ev_wnoRow;
//#UC END# *53B280110031_4D88BFEA013A_impl*
end;//TevCommentDecorator.StartAACRow

procedure TevCommentDecorator.StartAACRow4Table;
//#UC START# *53B280490098_4D88BFEA013A_var*
var
 l_Width: Integer;
//#UC END# *53B280490098_4D88BFEA013A_var*
begin
//#UC START# *53B280490098_4D88BFEA013A_impl*
 Generator.StartDefaultChild; // Открываем строку с текстом AAC
 l_Width := def_inchSBSWidth;
 Inc(f_InTable);
 Generator.StartDefaultChild; // Открывам ячейку с шириной левого отступа
 Generator.AddIntegerAtom(k2_tiFrame, evd_fvEmpty);
 Generator.AddIntegerAtom(k2_tiWidth, cnDefIndentValue);
 Generator.Finish;
 Dec(l_Width, cnDefIndentValue);
 Generator.StartDefaultChild; // Открываем ячейку с текстом ААС
 Generator.AddIntegerAtom(k2_tiFrame, evd_fvEmpty);
 Generator.AddIntegerAtom(k2_tiWidth, l_Width);
 f_WhatOpen := ev_wnoRow;
//#UC END# *53B280490098_4D88BFEA013A_impl*
end;//TevCommentDecorator.StartAACRow4Table

procedure TevCommentDecorator.StartAACStyle;
//#UC START# *53B280860287_4D88BFEA013A_var*
//#UC END# *53B280860287_4D88BFEA013A_var*
begin
//#UC START# *53B280860287_4D88BFEA013A_impl*
 StartAACTable;
 if f_WhatClosed = ev_pcAACTable then
  f_WhatClosed := ev_pcNone
 else
  AddSpaceRow;
 if f_AACSample <> ev_saFormulaInAAC then
  AddHeaderRow;
 StartAACRow;
//#UC END# *53B280860287_4D88BFEA013A_impl*
end;//TevCommentDecorator.StartAACStyle

procedure TevCommentDecorator.EndRow;
//#UC START# *53B282200211_4D88BFEA013A_var*
//#UC END# *53B282200211_4D88BFEA013A_var*
begin
//#UC START# *53B282200211_4D88BFEA013A_impl*
 if f_WhatOpen <> ev_wnoRow then Exit;
 Generator.Finish; // Закрываем ячейку с текстом ААС
 if f_InTable = 0 then
 begin
  Generator.StartDefaultChild; // Открываем ячейку с шириной правого отступа
  Generator.AddIntegerAtom(k2_tiFrame, evd_fvEmpty);
  Generator.AddIntegerAtom(k2_tiWidth, cnDefIndentValue);
  Generator.Finish;
 end; // if f_InTable = 0 then
 Generator.Finish; // Закрывем строку таблицы
 f_WhatOpen := ev_wnoTable;
//#UC END# *53B282200211_4D88BFEA013A_impl*
end;//TevCommentDecorator.EndRow

procedure TevCommentDecorator.EndRowAndTable;
//#UC START# *53B2824F0246_4D88BFEA013A_var*

 procedure lp_EndTable;
 begin
  AddSpaceRow;
  if f_InAACBlock = 0 then
   f_AACSample := 0;
  Generator.Finish;
  f_WhatOpen := ev_wnoNone;
 end;

//#UC END# *53B2824F0246_4D88BFEA013A_var*
begin
//#UC START# *53B2824F0246_4D88BFEA013A_impl*
 if f_WhatOpen = ev_wnoRow then EndRow;
 lp_EndTable;
 f_WhatClosed := ev_pcAACTable;
//#UC END# *53B2824F0246_4D88BFEA013A_impl*
end;//TevCommentDecorator.EndRowAndTable

procedure TevCommentDecorator.CheckWhatOpen(aForTable: Boolean);
//#UC START# *53B282B3010A_4D88BFEA013A_var*
//#UC END# *53B282B3010A_4D88BFEA013A_var*
begin
//#UC START# *53B282B3010A_4D88BFEA013A_impl*
 if f_WhatOpen = ev_wnoNone then
  StartAACStyle
 else
  if f_WhatOpen = ev_wnoTable then
   if aForTable then
    StartAACRow4Table
   else
    StartAACRow;
//#UC END# *53B282B3010A_4D88BFEA013A_impl*
end;//TevCommentDecorator.CheckWhatOpen

procedure TevCommentDecorator.StartChild(TypeID: Tl3Type);
//#UC START# *4836D4650177_4D88BFEA013A_var*
//#UC END# *4836D4650177_4D88BFEA013A_var*
begin
//#UC START# *4836D4650177_4D88BFEA013A_impl*
 if TypeID.IsKindOf(k2_typTable) then
  if (f_AACSample < 0) then
  begin
   if (f_InAACBlock = 0) then
    EndRowAndTable
   else
    if f_InTable = 0 then
    begin
     EndRow;
     CheckWhatOpen(True);
    end // if f_InTable = 0 then
    else
     Inc(f_InTable);
  end // if (f_AACSample < 0) then
  else
   f_WhatClosed := ev_pcNone
 else
  if TypeID.IsKindOf(k2_typBlock) then
   if (f_AACSample < 0) and (f_InAACBlock = 0) then
    EndRowAndTable;
 inherited;
//#UC END# *4836D4650177_4D88BFEA013A_impl*
end;//TevCommentDecorator.StartChild

procedure TevCommentDecorator.OpenStream;
//#UC START# *4836D49800CA_4D88BFEA013A_var*
//#UC END# *4836D49800CA_4D88BFEA013A_var*
begin
//#UC START# *4836D49800CA_4D88BFEA013A_impl*
 inherited;
 f_AACSample := 0;
 f_InAACBlock := 0;
 f_InTable := 0;
 f_WhatClosed := ev_pcNone;
 f_WhatOpen := ev_wnoNone;
 def_inchSBSWidth := def_inchSBSWidth;
//#UC END# *4836D49800CA_4D88BFEA013A_impl*
end;//TevCommentDecorator.OpenStream

procedure TevCommentDecorator.CloseStructure(NeedUndo: Boolean);
//#UC START# *4836D4C20059_4D88BFEA013A_var*
//#UC END# *4836D4C20059_4D88BFEA013A_var*
begin
//#UC START# *4836D4C20059_4D88BFEA013A_impl*
 if f_AACSample < 0 then
 begin
  if CurrentType.IsKindOf(k2_typDocument) then
   EndRowAndTable;
  if (f_InAACBlock = 0) and (f_WhatOpen = ev_wnoRow) then
   if CurrentType.IsKindOf(k2_typContentsElement) or CurrentType.IsKindOf(k2_typTableCell) then
    EndRowAndTable;
  if CurrentType.IsKindOf(k2_typTable) then
  begin
   if f_InTable = 1 then
    EndRow;
   Dec(f_InTable);
  end; // if CurrentType.IsKindOf(k2_typTable) then
  if CurrentType.IsKindOf(k2_typBlock) then
  begin
   if f_InAACBlock > 0 then
    Dec(f_InAACBlock);
   if (f_InAACBlock = 0) and (f_AACSample < 0) then
   begin
    if f_WhatOpen = ev_wnoNone then
    begin
     f_AACSample := 0;
     Assert(False, 'Пустой стильный блок!');
    end // if f_WhatOpen = ev_wnoNone then
    else
     EndRowAndTable;
   end; // if f_InAACBlock = 0 then
  end; // if CurrentType.IsKindOf(k2_typBlock) then
 end; // if f_AACSample > 0 then
 if CurrentType.IsKindOf(k2_typTable) then
  f_WhatClosed := ev_pcNone;
 inherited;
//#UC END# *4836D4C20059_4D88BFEA013A_impl*
end;//TevCommentDecorator.CloseStructure

procedure TevCommentDecorator.AddAtomEx(AtomIndex: Integer;
  const Value: Ik2Variant);
//#UC START# *4836D52400D9_4D88BFEA013A_var*
//#UC END# *4836D52400D9_4D88BFEA013A_var*
begin
//#UC START# *4836D52400D9_4D88BFEA013A_impl*
 inherited;
 if (AtomIndex = k2_tiStyle) and CurrentType.IsKindOf(k2_typBlock) and not CurrentType.IsKindOf(k2_typDocument) then
  if evAACStyle(Value.AsInteger) then
  begin
   f_AACSample := Value.AsInteger;
   Inc(f_InAACBlock);
  end // if (AtomIndex = k2_tiStyle) and CurrentType.IsKindOf(k2_typBlock) and EvAACStyle(Value.AsInteger) then
  else
   Inc(f_InAACBlock);
//#UC END# *4836D52400D9_4D88BFEA013A_impl*
end;//TevCommentDecorator.AddAtomEx

procedure TevCommentDecorator.DoWritePara(aLeaf: Tl3Variant);
//#UC START# *49E4883E0176_4D88BFEA013A_var*
const
 cnDefaultStyleLeafPara = ev_saNormalTable;

 procedure lp_StartAACStyle;
 begin
  f_AACSample := aLeaf.IntA[k2_tiStyle];
  CheckWhatOpen(False);
  aLeaf.IntW[k2_tiStyle, nil] := cnDefaultStyleLeafPara;
 end;

 function lp_CheckContentsName: Boolean;
 var
  l_Type: Tl3Type{Tk2Type};
 begin
  Result := False;
  l_Type := TopType[2];
  if (l_Type <> nil) and l_Type.IsKindOf(k2_typContentsElement) then
   Result := aLeaf.IntA[k2_tiStyle] = ev_saTxtHeader1; 
 end;

 function lp_CheckAACStyle: Boolean;
 var
  l_Style: Integer;
 begin                                                   
  Result := f_AACSample < 0;
  if Result then
  begin
   l_Style := aLeaf.IntA[k2_tiStyle];
   if EvAACStyle(l_Style) then
   begin
    if l_Style = f_AACSample then
     aLeaf.IntW[k2_tiStyle, nil] := cnDefaultStyleLeafPara
    else
     begin
      EndRowAndTable;
      lp_StartAACStyle;
     end;
   end // if EvAACStyle(l_Style) then
   else
    if f_InAACBlock = 0 then
     EndRowAndTable
    else
     if not lp_CheckContentsName then
      CheckWhatOpen(False);
  end // if f_AACSample then
  else
   if EvAACStyle(aLeaf.IntA[k2_tiStyle]) then
   begin
    Result := True;
    lp_StartAACStyle;
   end // if EvAACStyle(aLeaf.IntA[k2_tiStyle]) then
   else
    f_WhatClosed := ev_pcNone;
 end;

//#UC END# *49E4883E0176_4D88BFEA013A_var*
begin
//#UC START# *49E4883E0176_4D88BFEA013A_impl*
 lp_CheckAACStyle;
 inherited;
//#UC END# *49E4883E0176_4D88BFEA013A_impl*
end;//TevCommentDecorator.DoWritePara

end.