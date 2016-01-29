unit ddLawCaseNameGenerator;
{ Создание названий для судебных дел }

{ $Id: ddLawCaseNameGenerator.pas,v 1.19 2014/04/07 09:59:25 lulin Exp $ }

// $Log: ddLawCaseNameGenerator.pas,v $
// Revision 1.19  2014/04/07 09:59:25  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.18  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.17  2012/10/03 07:43:45  fireton
// - отвязываем от HyTech
//
// Revision 1.16  2011/06/17 07:04:34  narry
// Формирование Названия (265388524)
//
// Revision 1.15  2011/06/07 14:13:50  narry
// В постановлениях ФАС в заголовках отсутствует номер постановления (268350079)
//
// Revision 1.14  2011/06/06 12:10:40  narry
// Ошибка в неймах постановлений ФАС и ААС (268346653)
//


interface
Uses
 Classes,
 ddTypes, DT_Types, dd_lcBaseHeaderFilter,
 k2Interfaces;

type
 Tdd_lcNameGenerator = class(Tdd_lcBaseHeaderFilter)
 private
 protected
  procedure BeforeFlushHeader(aHeaderRoot: Tl3Variant); override;
 public
 end;

implementation

uses
 SysUtils, StrUtils, l3LingLib, l3Date, k2Tags, l3Base,
 l3DateSt, l3Chars, l3String,
 Math, dd_lcUtils, dd_lcSourceUtils, dd_lcCodeCorrector;


procedure Tdd_lcNameGenerator.BeforeFlushHeader(aHeaderRoot: Tl3Variant);
var
 l_Name: AnsiString;
 l_Court: AnsiString;
 i, j, l_Pos, l_MaxLen: Integer;
 l_C: AnsiString;
 l_ConstPart: AnsiString;
 l_Type: Tdd_lcDossierType;
 l_Tag: Tl3Variant;
// необходимые данные
 l_DocSource: AnsiString;
 l_DocType: AnsiString;
 l_DocPubNumber: AnsiString;
 l_DocPubDate: Integer;
 l_DocCaseCode: AnsiString;
begin
 l_DocSource:= '';
 l_DocType:= '';
 l_DocPubNumber:= '';
 l_DocPubDate:= 0;
 l_DocCaseCode:= '';
 // Собираем данные
 l_Tag:= aHeaderRoot.Attr[k2_tiSources];
 if l_Tag.IsValid then
  l_DocSource:= l_Tag.Child[0].StrA[k2_tiName];

 l_Tag:= aHeaderRoot.Attr[k2_tiTypes];
 if l_Tag.IsValid then
  l_DocType:= l_Tag.Child[0].StrA[k2_tiName];

 l_Tag:= aHeaderRoot.Attr[k2_tiNumANDDates];
 if l_Tag.IsValid then
  for i:= 0 to Pred(l_tag.ChildrenCount) do
  begin
   if (l_Tag.Child[i].IntA[k2_tiType] = Ord(dnPublish)) and (l_DocPubNumber = '') then
   begin
    // Номер должен быть с двумя цифрами
    if IsTwoDigitsNumber(l_Tag.Child[i].StrA[k2_tiNumber]) then
    begin
     l_DocPubDate:=  l_Tag.Child[i].IntA[k2_tiStart];
     l_DocPubNumber:= l_Tag.Child[i].StrA[k2_tiNumber];
    end 
   end
   else
   if (l_Tag.Child[i].IntA[k2_tiType] = Ord(dnLawCaseNum)) and (l_DocCaseCode = '') then
    l_DocCaseCode:= l_Tag.Child[i].StrA[k2_tiNumber];
  end; // for i

  // Формируем название
 l_Type:= Source2DossierType(l_DocSource);
 if (l_DocSource <> '') and (l_Type <> lc_dtVAC) then
 begin
  // name <!TYPE > <!SOURCE в родительном падеже> от <!DATE в формате "22 апреля 2009 г."> № <!CODE> Истец: <название истца из данных БРАС>. Ответчик: <название ответчика из данных БРАС>
  l_Pos:= LastDelimiter('\', l_DocSource);
  l_Court:= DeBracketStr(IfThen(l_Pos > 0, Copy(l_DocSource, Succ(l_pos), Length(l_DocSource)-l_Pos), l_DocSource));
  l_C:= l_Court[1];
  l_Court:= mlmaRusDeclensionStr(l_Court, rdRodit);
  l_Court[1]:= AnsiUpperCase(l_C)[1];

  if l_Type = lc_dtFirst then
   l_ConstPart:= Format('%s %s от %s г.', [l_DocType, l_Court, l3DateToStr(l_DocPubDate, 'd mmmm yyyy')])
  else
   l_ConstPart:= Format('%s %s от %s г. № %s', [l_DocType, l_Court, l3DateToStr(l_DocPubDate, 'd mmmm yyyy'), l_DocPubNumber]);
  if l_type in [lc_dtFAC, lc_dtFirst] then
   l_ConstPart:= l_ConstPart + ' по делу № ' + l_DocCaseCode;
  l_Name:= l_ConstPart;

  aHeaderRoot.StrW[k2_tiName, nil]:= l_Name;
 end; // (l_DocSource <> '') and (l_Type <> lc_dtVAC)
end;

end.
