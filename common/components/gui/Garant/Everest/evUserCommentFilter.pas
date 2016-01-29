unit evUserCommentFilter;
{* Фильтр для добавления оформления Комментариям пользователя }

{ $Id: evUserCommentFilter.pas,v 1.10 2014/04/04 17:53:34 lulin Exp $ }
// $Log: evUserCommentFilter.pas,v $
// Revision 1.10  2014/04/04 17:53:34  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.9  2014/04/03 17:10:25  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.8  2013/10/18 14:11:23  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.7  2011/02/25 17:20:56  lulin
// {RequestLink:255492242}.
//
// Revision 1.6  2009/09/02 14:31:29  lulin
// {RequestLink:161122154}.
//
// Revision 1.5  2009/07/20 12:49:32  lulin
// - подготавливаемся к переносу изменений в ветку.
//
// Revision 1.4  2009/03/04 13:32:48  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.3  2009/02/26 10:21:19  lulin
// - <K>: 137465982. №1
//
// Revision 1.2  2008/06/20 14:48:51  lulin
// - используем префиксы элементов.
//
// Revision 1.1  2007/12/04 13:04:55  lulin
// - объединяем два каталога с исходниками Эвереста.
//
// Revision 1.6  2007/08/23 10:36:54  narry
// - Реализация CQ 26458
//
// Revision 1.5  2007/08/21 13:55:32  narry
// - Упрощенное оформление Комментария пользователя
//
// Revision 1.4  2007/07/18 15:07:16  lulin
// - выпрямляем зависимости. Схема документа, теперь не зависит от Эвереста.
//
// Revision 1.3  2007/07/04 08:55:36  narry
// - обновление
//
// Revision 1.2  2007/06/27 08:24:16  narry
// - чехарда с отступами в ячейках
//
// Revision 1.1  2007/06/14 07:23:38  oman
// Перекладываем в другое место
//
// Revision 1.1  2007/06/08 07:49:16  narry
// - заменяет CommentPara на таблицу с похожим оформлением
//

interface

Uses
 k2TagFilter,
 evdStyles, evdBufferedFilter,
 l3Types, l3Base,
 k2TagGen, k2Tags, k2Interfaces, k2Types, l3InternalInterfaces;


type
 TevUserCommentFilter = class(TevdBufferedFilter)
 private
  f_CommentText: Tl3String;
  procedure pm_SetCommentText(const Value: Tl3String);
  procedure StartCommentPara;
  procedure FinishCommentPara;
 protected
  procedure Cleanup; override;
        {* - Определяет нужно ли сбрасывать Тег в трубу.  }
  procedure DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean); override;
    // internal methods
  function NeedStartBuffering(aID : Integer): Boolean; override;
 public
    {public methods}
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  property CommentText: Tl3String
   read f_CommentText
   write pm_SetCommentText;
 end;

implementation

Uses
 Graphics, Math,
 evdTypes, evStyleInterface, evInternalInterfaces, l3UnitsTools, evSectionPara,

 l3String,
 l3ScreenIC, l3Const,
 k2BaseTypes,

 CommentPara_Const,
 TextPara_Const,

 nevInterfaces
 ;

// start class Tk2BaseStackGenerator 

constructor TevUserCommentFilter.Create(anOwner: Tk2TagGeneratorOwner = nil);
  //override;
  {-}
begin
 inherited;
 f_CommentText:= Tl3String.Create;
 f_CommentText.AsWStr := l3Trim(str_nevmmComment.AsCStr).AsWStr;
end;

procedure TevUserCommentFilter.Cleanup;
begin
 l3Free(f_CommentText);
 inherited;
end;

procedure TevUserCommentFilter.DoFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer; aNeedCloseBracket : Boolean);
  //virtual;
  {-}
begin
 StartCommentPara;
 aLeaf.WriteTag(Generator, [l3_spfChildren]);
 if aNeedCloseBracket then
  FinishCommentPara;
end;

// start class TevdBufferedFilter

function TevUserCommentFilter.NeedStartBuffering(aID : Integer): Boolean;
begin
 Result := aID = -k2_idCommentPara;
end;

procedure TevUserCommentFilter.pm_SetCommentText(const Value: Tl3String);
begin
 f_CommentText.Assign(Value);
end;

procedure TevUserCommentFilter.StartCommentPara;
begin
 with Generator do
 begin
  StartChild(k2_typTextPara);
  Finish;
  StartChild(k2_typTextPara);
  try
   StartTag(k2_tiFrame);
   try
    StartTag(k2_tiFrameUP);
    try
    finally
     Finish;
    end; // FrameDown
   finally
    Finish;
   end; // Frame
   AddIntegerAtom(k2_tiStyle, ev_saUserComment);
   AddStringAtom(k2_tiText, f_CommentText.AsWStr);
  finally
   Finish;
  end;
 end;
end;

procedure TevUserCommentFilter.FinishCommentPara;
begin
 with Generator do
 begin
  StartChild(k2_typTextPara);
  try
   StartTag(k2_tiFrame);
   try
    StartTag(k2_tiFrameDown);
    try
    finally
     Finish;
    end; // FrameDown
   finally
    Finish;
   end; // Frame
   AddIntegerAtom(k2_tiStyle, ev_saUserComment);
  finally
   Finish;
  end;
 end;
end;


end.
