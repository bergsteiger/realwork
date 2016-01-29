unit dd_lcFileNameInserter;
{ Добавление имени файла внутрь документа }

{ $Id: dd_lcFileNameInserter.pas,v 1.5 2014/04/07 10:01:56 lulin Exp $ }

// $Log: dd_lcFileNameInserter.pas,v $
// Revision 1.5  2014/04/07 10:01:56  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.4  2013/10/18 16:01:26  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.3  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.2  2011/11/10 06:03:39  narry
// Указание пути к исходному файлу (295666339)
//
// Revision 1.1  2011/11/09 12:39:18  narry
// Указание пути к исходному файлу (295666339)
//

interface

uses
  k2TagFilter, dd_lcBaseFilter, k2Interfaces;

type
 TGetFileNameEvent = procedure (var aFileName: AnsiString) of object;
 Tdd_lcFileNameInserter = class(Tdd_lcBaseHeaderFilter)
 private
  f_OnGetFileNameEvent: TGetFileNameEvent;
 protected
  procedure AfterFlushHeader(aHeaderRoot: Tl3Variant); override;
  procedure GetFileNameEvent;
 public
  property OnGetFileNameEvent: TGetFileNameEvent read f_OnGetFileNameEvent write
      f_OnGetFileNameEvent;
 end;

implementation

uses
 TextPara_Const, k2tags, evdStyles;

procedure Tdd_lcFileNameInserter.AfterFlushHeader(aHeaderRoot: Tl3Variant);
begin
 GetFileNameEvent;
end;

procedure Tdd_lcFileNameInserter.GetFileNameEvent;
var
 l_FileName: AnsiString;
begin
 if Assigned(f_OnGetFileNameEvent) then
 begin
  f_OnGetFileNameEvent(l_FileName);
  Generator.StartChild(k2_typTextPara);
  try
   Generator.AddIntegerAtom(k2_tiStyle, ev_saTechComment);
   Generator.AddStringAtom(k2_tiText, l_FileName);
  finally
   Generator.Finish;
  end;
 end;
end;

end.
