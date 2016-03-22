unit ddAnnotations;

{ $Id: ddAnnotations.pas,v 1.21 2015/11/11 13:16:41 fireton Exp $ }

// $Log: ddAnnotations.pas,v $
// Revision 1.21  2015/11/11 13:16:41  fireton
// - Нормальная диагностика ошибок при экспорте
// - Считаем пустые документы, справки и аннотации правильно
//
// Revision 1.20  2014/09/08 12:27:51  fireton
// - не выливаем в Прайм комментарии юристов
//
// Revision 1.19  2014/04/07 06:53:46  dinishev
// Bug fix: не компилировались проекты.
//
// Revision 1.18  2014/04/04 06:58:28  dinishev
// Bug fix: не собирался Арчи.
//
// Revision 1.17  2014/02/14 15:33:56  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.16  2013/10/21 15:43:19  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.15  2013/10/21 10:31:07  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.14  2013/10/18 15:39:04  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.13  2013/07/18 09:55:52  fireton
// - убираем технические комментарии из аннотаций Прайма (K 443842668)
//
// Revision 1.12  2013/04/11 16:46:52  lulin
// - отлаживаем под XE3.
//
// Revision 1.11  2012/10/26 07:27:24  narry
// Залить новую партию НСРов (406126937)
//
// Revision 1.10  2010/06/17 09:02:18  narry
// - K206078273
//
// Revision 1.9  2009/03/13 15:12:11  narry
// - рефакторинг
//
// Revision 1.8  2006/04/12 10:54:20  narry
// - обновление
//
// Revision 1.7  2005/10/21 13:20:49  narry
// - исправление: не собиралось
//
// Revision 1.6  2005/09/07 15:07:20  narry
// - update
//
// Revision 1.5  2005/07/14 15:35:16  narry
// - cleanup
//
// Revision 1.4  2005/03/29 15:57:56  narry
// -update: теперь выливаем в Windows-кодировке
//
// Revision 1.3  2005/03/29 08:34:52  lulin
// - bug fix: не компилировалось.
//
// Revision 1.2  2005/03/21 12:59:35  narry
// - не компилировалось
//
// Revision 1.1  2005/03/04 16:08:48  narry
// - новинка: реализация импорта Пучин-нср
//

interface

Uses
 l3Base, l3Filer, l3Types,
 evdLeafParaFilter,
 k2TagGen, k2ForkGenerator, k2Interfaces,
 SewerPipe, Classes;

type
 TddAnnotationPipe = class(Tl3Base)
 private
   FFileName: AnsiString;
   FFiler: Tl3DOSFiler;
   FFork: Tk2ForkGenerator;
   FG: Tk2TagGenerator;
   FPipe: TSewerPipe;
   f_ErrorList: TStringList;
   procedure _DoOnError(const aMsg: String; aCategory: Integer = 0);
   procedure _TopicInit(Sender: TObject; TopicNo: Long);
 protected
   procedure Cleanup; override;
 public
   constructor Create;
   procedure Execute;
   property ErrorList: TStringList read f_ErrorList;
   property FileName: AnsiString read FFileName write FFileName;
   property Pipe: TSewerPipe read FPipe;
 end;

 TddAppearanceEliminator = class(TevdLeafParaFilter)
 { Фильтрация оформления текста и абзаца  }
 protected
  procedure DoWritePara(aLeaf: Tl3Variant); override;
 end;

implementation

Uses
 ddFixFilter, ddNSRC_w,
 k2Tags,
 evParaEliminator, evEvdWriter, evTextFormatter, evHiddenFilter,
 evdStyles,
 l3Chars, k2BaseTypes, TextPara_Const
 ;

constructor TddAnnotationPipe.Create;
var
 l_G2: Tk2TagGenerator;
begin
  inherited Create;
  FPipe := TSewerPipe.Create;
  FPipe.ExportDocument:= False;
  FPipe.ExportAnnotation := True;
  FPipe.ExportEmpty:= False;
  FPipe.ExportKW:= False;
  FPipe.Convert2OEM := False;
  FPipe.SpecialAnnotation := True;
  FFiler := Tl3DOSFiler.Create;
  TddNSRCGenerator.SetTo(FG);
  TddNSRCGenerator(FG).Filer := FFiler;
  TddNSRCGenerator(FG).CodePage := CP_Ansi;//CP_OEMLite;
  TddNSRCGenerator(FG).OnTopicInit := _TopicInit;
  TevTextFormatter.SetTo(FG);
  TddAppearanceEliminator.SetTo(FG);
  TevHiddenFilter.SetTo([Abs(ev_saTechComment), Abs(ev_saTxtComment)], False, FG);
  FPipe.Writer := FG;
  f_ErrorList := TStringList.Create;
end;

procedure TddAnnotationPipe.Cleanup;
begin
 l3Free(FG);
 l3Free(FFiler);
 l3Free(FPipe);
 l3Free(f_ErrorList);
 inherited;
end;

procedure TddAnnotationPipe.Execute;
begin
 f_ErrorList.Clear;
 FPipe.SpecialFiler := FFiler;
 FPipe.OnError := _DoOnError;
 FFiler.FileName := FileName;
 fFiler.Mode := l3_fmWrite;
 FFiler.Open;
 fFiler.CodePage := cp_Ansi;
 FPipe.Execute();
 FFiler.Close;
end;

procedure TddAnnotationPipe._DoOnError(const aMsg: String; aCategory: Integer = 0);
begin
 l3System.Msg2Log(aMsg);
 f_ErrorList.Add(aMsg);
end;

procedure TddAnnotationPipe._TopicInit(Sender: TObject; TopicNo: Long);
begin
 fPipe.WriteSpecialName;
end;

{ TddAppearanceEliminator }

procedure TddAppearanceEliminator.DoWritePara(aLeaf: Tl3Variant);
begin
 Generator.StartChild(aLeaf.TagType);
 try
  { Оставляем все, кроме оформления абзаца }
  if aLeaf.IsKindOf(k2_typTextPara) then
   aLeaf.AsObject.WriteTag(Generator, l3_spfAll, [k2_tiSegments, k2_tiJustification,
                                      k2_tiStyle, k2_tiFirstIndent, k2_tiLeftIndent]);
 finally
  Generator.Finish;
 end;
end;


end.
 