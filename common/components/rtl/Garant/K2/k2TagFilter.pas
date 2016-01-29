unit k2TagFilter;

{ Библиотека "K-2"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: k2TagFilter -   }
{ Начат: 14.05.2004 20:28 }
{ $Id: k2TagFilter.pas,v 1.10 2014/03/27 14:20:07 lulin Exp $ }

// $Log: k2TagFilter.pas,v $
// Revision 1.10  2014/03/27 14:20:07  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.9  2013/10/18 14:11:33  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.8  2011/07/07 15:43:38  lulin
// {RequestLink:271190917}.
//
// Revision 1.7  2006/04/11 17:55:28  lulin
// - оптимизируем при помощи вынесения строк (по следам того как Вован наиграл в фильтрах 20% производительности).
//
// Revision 1.6  2006/01/30 16:36:34  lulin
// - cleanup.
//
// Revision 1.5  2005/06/22 16:18:33  lulin
// - cleanup.
//
// Revision 1.4  2005/02/01 12:48:04  lulin
// - bug fix: на кривой структуре документа падал фильтр, отрезающий блоки - соответственно нельзя было вставить ГК в ГК в качестве комментария.
//
// Revision 1.3  2004/11/26 08:00:02  lulin
// - bug fix: не закрывались пропускаемые параграфы.
//
// Revision 1.2  2004/10/12 15:30:32  lulin
// - bug fix: при вставке из буфера обмена не учитывались блоки и соответственно вставлялись не комментарии (CQ OIT5-10223).
//
// Revision 1.1  2004/05/14 16:58:51  law
// - new units: k2TagTerminator, k2TagFilter.
//

{$Include k2Define.inc }

interface

uses
  l3Types,
  l3Variant,

  k2Types,
  k2TagTerminator,
  k2Prim,
  k2Base
  ;

type
  Tk2TagFilterOpenMode = (k2_tfomOpen, k2_tfomClose, k2_tfomAdd);
  
  Tk2TagFilter = class(Tk2TagTerminator)
   {* Фильтр тегов. }
    private
    // property fields
      f_SkipLevel           : Long;
      f_TagFromSkippedChild : Long;
    protected
    // internal fields
      f_TagSkipLevel : Long;
    protected
    // internal methods
      function  NeedTranslateChildToNext: Boolean;
        virtual;
        {-}
      function  NeedTranslateChildToNextPrim(anOpenMode : Tk2TagFilterOpenMode): Boolean;
        virtual;
        {-}
      procedure DoCloseStructure(NeedUndo: Boolean);
        virtual;
        {-вызывается на закрывающуюся скобку}
      procedure DoStartTag(TagID: Long);
        virtual;
        {-}
      procedure DoStartChild(TypeID: Tk2Type);
        virtual;
        {-}
      procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
        virtual;
        {-}
      procedure CloseStructure(NeedUndo: Boolean);
        override;
        {-}
    public
    // public methods
      procedure StartTag(TagID: Long);
        override;
        {-}
      procedure StartChild(TypeID: Tl3VariantDef);
        override;
        {-}
      procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
        override;
        {-}
      procedure StartSkipTags;
        {* - начать пропускать дочерние теги. }
      procedure IncSkipTags;
        {-}
      procedure DecSkipTags;
        {-}
    public
    //public properties
      property SkipLevel: Long
        read f_SkipLevel;
        {* - текущий уровень пропускаемого тега. }
  end;//Tk2TagFilter
  {* Пропускает через себя все теги. }

implementation

uses
  SysUtils,

  k2Strings
  ;

// start class Tk2TagFilter 

procedure Tk2TagFilter.StartTag(TagID: Long);
  {override;}
  {-}
var
 l_NeedTranslate : Boolean;  
begin
 l_NeedTranslate := (f_TagFromSkippedChild = 0) AND
                    NeedTranslateChildToNextPrim(k2_tfomOpen);
 inherited;
 if (f_TagFromSkippedChild = 0) then
 begin
  if l_NeedTranslate then
  begin
   if (SkipLevel = 0) then
   begin
    if (f_TagSkipLevel <> Pred(CurrentStartLevel)) then
     DoStartTag(TagID)
    else
     Inc(f_SkipLevel);
   end
   else
    Inc(f_SkipLevel);
  end//NeedTranslateChildToNext
  else
   Inc(f_TagFromSkippedChild);
 end//f_TagFromSkippedChild = 0
 else
  Inc(f_TagFromSkippedChild);
end;

procedure Tk2TagFilter.StartChild(TypeID: Tl3VariantDef);
  {override;}
  {-}
begin
 inherited;
 if (f_TagFromSkippedChild = 0) then
 begin
  if (SkipLevel = 0) then
  begin
   if (f_TagSkipLevel <> CurrentStartLevel) then
    DoStartChild(Tk2Type(TypeID));
  end
  else
   Inc(f_SkipLevel);
 end//f_TagFromSkippedChild = 0
 else
  Inc(f_TagFromSkippedChild);
end;

procedure Tk2TagFilter.CloseStructure(NeedUndo: Boolean);
  {override;}
  {-вызывается на закрывающуюся скобку}
begin
 if (f_TagFromSkippedChild = 0) then
 begin
  if NeedTranslateChildToNextPrim(k2_tfomClose) then
  begin
   if (SkipLevel = 0) then begin
    if (Pred(f_TagSkipLevel) <> CurrentStartLevel) then
     DoCloseStructure(NeedUndo)
    else
     f_TagSkipLevel := 0;
     // - сбрасываем признак фильтрации
   end else
    Dec(f_SkipLevel);
   //inherited;
  end;//NeedTranslateChildToNext
 end//f_TagFromSkippedChild = 0
 else
  Dec(f_TagFromSkippedChild);
 inherited;
end;

procedure Tk2TagFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
  {override;}
  {-}
begin
 if (SkipLevel = 0) AND (f_TagSkipLevel <> CurrentStartLevel) then
  DoAddAtomEx(AtomIndex, Value);
end;

procedure Tk2TagFilter.StartSkipTags;
  {-}
begin
 if (SkipLevel = 0) then f_SkipLevel := 1;
end;

procedure Tk2TagFilter.IncSkipTags;
  {-}
begin
 Inc(f_SkipLevel);
end;

procedure Tk2TagFilter.DecSkipTags;
  {-}
  
 procedure RaiseBadSkipLevel;
 begin//RaiseBadSkipLevel
  raise Exception.Create(k2_errBadSkipLevel);
 end;//RaiseBadSkipLevel
  
begin
 if (f_SkipLevel = 0) then
  RaiseBadSkipLevel;
 Dec(f_SkipLevel);
end;

function Tk2TagFilter.NeedTranslateChildToNext: Boolean;
  {-}
begin
 Result := true;
end;

function Tk2TagFilter.NeedTranslateChildToNextPrim(anOpenMode : Tk2TagFilterOpenMode): Boolean;
  //virtual;
  {-}
begin
 Result := NeedTranslateChildToNext; 
end;

procedure Tk2TagFilter.DoCloseStructure(NeedUndo: Boolean);
  //virtual;
  {-вызывается на закрывающуюся скобку}
begin
 if (Generator <> nil) then
  Generator.Finish(NeedUndo);
end;

procedure Tk2TagFilter.DoStartTag(TagID: Long);
  //virtual;
  {-}
begin
 if (Generator <> nil) then
  Generator.StartTag(TagID);
end;

procedure Tk2TagFilter.DoStartChild(TypeID: Tk2Type);
  //virtual;
  {-}
begin
 if (Generator <> nil) AND NeedTranslateChildToNextPrim(k2_tfomOpen) then
    Generator.StartChild(TypeID);
end;

procedure Tk2TagFilter.DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
  //virtual;
  {-}
begin
 if (Generator <> nil) AND (f_TagFromSkippedChild = 0) AND
  NeedTranslateChildToNextPrim(k2_tfomOpen) then
  Generator.AddAtomEx(AtomIndex, Value);
end;

end.

