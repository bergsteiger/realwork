unit alcuDocument;
{ Примитивная реализация доступа к документу }

{ $Id: alcuDocument.pas,v 1.6 2015/11/26 08:45:26 lukyanets Exp $ }

// $Log: alcuDocument.pas,v $
// Revision 1.6  2015/11/26 08:45:26  lukyanets
// КОнстанты переехали
//
// Revision 1.5  2015/05/20 14:02:25  lulin
// - рисуем на модели.
//
// Revision 1.4  2008/05/23 15:22:25  narry
// - не компилировалось
//
// Revision 1.3  2007/11/12 09:11:10  narry
// - накопилось: чистка кода, окошко "О программе",  поддержка внешних словарей, исправление "метки 20005", "Английская база"
//
// Revision 1.2  2007/09/11 12:22:39  narry
// - Расстановка меток 30005 и 20005. Уточненная
//
// Revision 1.1  2007/09/06 06:21:12  narry
// - исправление ошибки доставки больших заданий пользователю (заплатка)
// - Расстановка меток 30005 и 20005
// - Удаленое изменение словарей
//

interface

uses
 evCustomTextSource;

type
 TalcuDocument = class(TevCustomTextSource)
 private
  f_DocID: Integer;
 public
  constructor Make(aDocID: Integer);
  procedure LoadDoc;
  procedure SaveDoc;
  property DocID: Integer read f_DocID write f_DocID;
 end;

implementation

Uses
 l3Base, l3Types,
 daSchemeConsts,
 dt_Serv, dt_CFltr, dt_Const,
 evEvdRd, evdWriter,
 m3DBInterfaces, m3DB,

 m3DBFiler
 ;

constructor TalcuDocument.Make(aDocID: Integer);
begin
 inherited Create(nil);
 f_DocID:= aDocID;
end;

procedure TalcuDocument.LoadDoc;
var
 l_DB : Im3DB;
 l_Filer : Tm3DBFiler;
 l_Reader: TevEVDReader;
begin
 l_Reader := TevEVDReader.Create;
 try
  l_DB := dtGetDB(CurrentFamily);
  try
   l_Filer := Tm3DBFiler.Create(l_DB, f_DocID, m3_dsMain);
  finally
   l_DB := nil;
  end;//try..finally
  try
   l_Reader.Filer := l_Filer;
  finally
   l3Free(l_Filer);
  end;
  Load(l_Reader);
 finally
  l3Free(l_Reader);
 end;
end;

procedure TalcuDocument.SaveDoc;
var
 l_DB          : Im3DB;
 l_Filter      : TUltraLiteSaveDocFilter;
 l_Writer      : TevdNativeWriter;
 l_Filer       : Tm3DBFiler;
begin
 l_Writer := TevdNativeWriter.Create;
 try
  l_DB := dtGetDB(CurrentFamily);
  try
   l_Filer := Tm3DBFiler.Create(l_DB, f_DocID, m3_dsMain);
  finally
   l_DB := nil;
  end;//try..finally
  try
   l_Filer.Mode := l3_fmReadWrite;
   l_Filer.Open;
   try
    l_Writer.Filer := l_Filer;
    l_Writer.Binary := true;
    l_Filter := TUltraLiteSaveDocFilter.Create(nil, CurrentFamily);
    try
     l_Filter.CurDocID := f_DocID;
     l_Filter.Generator := l_Writer;
     Save(l_Filter);
    finally
     l3Free(l_Filter);
    end;//try..finally
   finally
    l_Filer.Close;
   end;//try..finally                            
  finally
   l3Free(l_Filer)
  end;//try..finally
 finally
  l3Free(l_Writer);
 end;//try..finally

end;

end.
