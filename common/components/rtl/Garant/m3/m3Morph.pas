unit m3Morph;
{* Нормализатор с использованием морфологии. }

{ Библиотека "M3"         }
{ Автор: Люлин А.В. ©     }
{ Модуль: m3Morph -       }
{ Начат: 20.12.2001 16:01 }
{ $Id: m3Morph.pas,v 1.8 2014/02/13 10:31:39 lulin Exp $ }

// $Log: m3Morph.pas,v $
// Revision 1.8  2014/02/13 10:31:39  lulin
// - рефакторим безликие списки.
//
// Revision 1.7  2013/04/12 16:25:08  lulin
// - отлаживаем под XE3.
//
// Revision 1.6  2013/04/05 12:04:33  lulin
// - портируем.
//
// Revision 1.5  2012/11/01 07:09:33  lulin
// - вычищаем мусор.
//
// Revision 1.4  2009/07/20 11:22:23  lulin
// - заставляем работать F1 после - {RequestLink:141264340}. №7, 32, 33.
//
// Revision 1.3  2009/03/19 16:28:30  lulin
// [$139443095].
//
// Revision 1.2  2004/09/21 11:22:27  lulin
// - Release заменил на Cleanup.
//
// Revision 1.1  2004/09/02 08:09:48  law
// - cleanup.
//
// Revision 1.11  2004/05/27 14:32:17  law
// - new methods: _Tl3_CBase.IsCacheable, _NeedStoreInPool.
//
// Revision 1.10  2002/10/30 14:12:22  voba
// no message
//
// Revision 1.9  2002/10/30 13:51:08  law
// - bug fix.
//
// Revision 1.8  2002/09/03 08:22:17  law
// - new behavior: нормализация с отбрасыванием частицы НЕ.
//
// Revision 1.7  2002/04/15 12:20:38  law
// - new method: GetFlags.
//
// Revision 1.6  2002/04/12 11:30:39  law
// - new behavior: возможность задания флагов нормализации.
//
// Revision 1.5  2002/04/11 14:35:43  law
// - new param: UseAlternate.
// - new method: IsAlternate.
//
// Revision 1.4  2002/03/28 16:51:12  law
// - bug fix: несовпадение прямого и обратного индексов.
//
// Revision 1.3  2002/02/26 15:48:10  law
// - optimization: попытка оптимизации путем уменьшения фрагментации выделяемой памяти.
//
// Revision 1.2  2002/02/26 08:31:54  law
// - new method: Im3NormalizaterResult.Reset.
// - bug fix: Catastrophic Fail при загрузке индекса.
//
// Revision 1.1  2001/12/20 14:12:11  law
// - new behavior: сделано использование морфологического разбора при поиске и индексации.
//

{$I m3Define.inc}

interface

uses
  l3Types,
  l3Base,
  l3ProtoObject,

  mgLngObj,
  
  m3IdxInt
  ;

type
  Tm3MorphNormalizater = class(Tl3ProtoObject, Im3Normalizater)
   {* Нормализатор с использованием морфологии. }
    private
    // internal fields
      f_Flags : Long;
      f_Temp  : PAnsiChar;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-} 
    public
    // public methods
      constructor Create(aFlags: Long = 0);
        reintroduce;
        {-}
      class function MakeInterface: Im3Normalizater;
        {* - создает нормализатор. }
      function GetResult(const AValue : WideString;
                         UsePseudo    : Boolean = true;
                         UseAlternate : Boolean = false): Im3NormalizaterResult;
        {* - возвращает список нормальных форм. }
  end;//Tm3MorphNormalizater

  Tm3MorphNormalizaterResult = class(TmgLangBuilder, Im3NormalizaterResult)
   {* Результат нормализации. }
    private
    // internal fields
      f_Flags       : Tm3NormFlags;
      f_Current     : Long;
    public
    // public methods
      constructor Create(AFlags   : LongInt;
                         ABuff    : PAnsiChar;
                         ASize    : LongInt;
                         AOemCp   : LongBool;
                         aWithDot : Bool = false;
                         aTemp    : PPointer = nil);
        override;
        {-}
      procedure BeforeAddToCache;
        override;
        {-}
      class function IsCacheable: Bool;
        override;
        {-}
      function GetFlags: Tm3NormFlags;
        {* - флаги результата нормализации. }
      function GetCount: Integer;
        {* - возвращает количество нормальных форм. }
      function GetValue: WideString;
        {* - возвращает текущую нормальную форму. }
      procedure Reset;
        {-}
  end;//Tm3MorphNormalizaterResult

implementation

uses
  m0LNGLib
  ;

// start class Tm3MorphNormalizater

constructor Tm3MorphNormalizater.Create(aFlags: Long = 0);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_Flags := aFlags;
end;

procedure Tm3MorphNormalizater.Cleanup;
  //override;
  {-}
begin
 inherited;
 l3System.FreeLocalMem(f_Temp);
end;

class function Tm3MorphNormalizater.MakeInterface: Im3Normalizater;
  {* - создает нормализатор. }
var
 l_Norm : Tm3MorphNormalizater;
begin
 l_Norm := Create;
 try
  Result := l_Norm;
 finally
  l3Free(l_Norm);
 end;//try..finally
end;

function Tm3MorphNormalizater.GetResult(const AValue : WideString;
                                        UsePseudo    : Boolean = true;
                                        UseAlternate : Boolean = false): Im3NormalizaterResult;
  {* - возвращает список нормальных форм. }
const
 cFlags = Cm0LNGLibFlagORIG_FORM or
          Cm0LNGLibFlagNORM_FORM or
          Cm0LNGLibFlagUSET_FORM;
var
 l_Result : Tm3MorphNormalizaterResult;
 l_Word   : AnsiString;
 l_Flags  : Integer;
begin
 l_Word := aValue;
 if (f_Flags = 0) then begin
  l_Flags := cFlags;
  if UsePseudo then
   l_Flags := l_Flags or Cm0LNGLibFlagUPNF_FORM;
  if UseAlternate then
   l_Flags := l_Flags or Cm0LNGLibFlagALTV_FORM;
 end else
  l_Flags := f_Flags;  
 l_Result := Tm3MorphNormalizaterResult.Create(l_Flags, PAnsiChar(l_Word), Length(l_Word), false, false, @f_Temp);
 try
  Result := l_Result;
 finally
  l3Free(l_Result);
 end;//try..finally
end;

// start class Tm3MorphNormalizaterResult

constructor Tm3MorphNormalizaterResult.Create(AFlags   : LongInt;
                                              ABuff    : PAnsiChar;
                                              ASize    : LongInt;
                                              AOemCp   : LongBool;
                                              aWithDot : Bool = false;
                                              aTemp    : PPointer = nil);
  //override;
  {-}
begin
 inherited;
 f_Flags := [];
 if (Count > 0) then begin
  if (Handles[0].Status AND Cm0LNGLibStatusPNRM_FORM <> 0) then
   Include(f_Flags, m3_nfPseudo);
  if (Handles[0].Status AND Cm0LNGLibStatusALTV_FORM <> 0) then
   Include(f_Flags, m3_nfAlternate);
  if (Handles[0].Status AND Cm0LNGLibStatusToo_Long <> 0) then
   Include(f_Flags, m3_nfError);
 end;//Count > 0
end;

procedure Tm3MorphNormalizaterResult.BeforeAddToCache;
  //override;
  {-}
begin
 f_Current := 0;
 inherited;
end;

class function Tm3MorphNormalizaterResult.IsCacheable: Bool;
  //override;
  {-}
begin
 Result := true;
end;

function Tm3MorphNormalizaterResult.GetFlags: Tm3NormFlags;
  {* - флаги результата нормализации. }
begin
 Result := f_Flags;
end;

function Tm3MorphNormalizaterResult.GetCount: Integer;
  {* - возвращает количество нормальных форм. }
begin
 Result := Count;
end;

function Tm3MorphNormalizaterResult.GetValue: WideString;
  {* - возвращает текущую нормальную форму. }
begin
 if (f_Current < Count) then begin
  Result := Handles[f_Current].Value;
  Inc(f_Current);
 end else
  Result := '';
end;

procedure Tm3MorphNormalizaterResult.Reset;
  {-}
begin
 f_Current := 0;
end;

end.

