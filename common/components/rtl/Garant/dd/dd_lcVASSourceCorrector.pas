unit dd_lcVASSourceCorrector;
{ Меняет Орган для постановлений Президиума ВАС }

{ $Id: dd_lcVASSourceCorrector.pas,v 1.3 2014/04/07 09:34:04 lulin Exp $ }

// $Log: dd_lcVASSourceCorrector.pas,v $
// Revision 1.3  2014/04/07 09:34:04  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.2  2011/03/29 07:41:06  narry
// K259170852. Президиум ВАС РФ
//
// Revision 1.1  2011/03/28 11:01:17  narry
// K259169921. Изменение органа для Президиума ВАС РФ
//

interface

uses
 ddHeaderFilter, k2Interfaces;

type
 Tdd_lcVASSourceCorrector = class(TddHeaderFilter)
 protected
  procedure BeforeFlushHeader(aHeaderRoot: Tl3Variant); override;
 end;

implementation

uses
 StrUtils, k2Tags, dt_types, NumAndDate_Const, k2Base, SysUtils;

procedure Tdd_lcVASSourceCorrector.BeforeFlushHeader(aHeaderRoot: Tl3Variant);
var
 l_Sources, l_Types: Tl3Variant;
 i: Integer;
 l_CorrectSource: Boolean;
begin
 l_Types:= aHeaderRoot.Attr[k2_tiTypes];
 if l_Types.IsValid then
 begin
  l_CorrectSource:= False;
  for i:= 0 to Pred(l_Types.ChildrenCount) do
  begin
   l_CorrectSource:= AnsiContainsText(l_Types.Child[i].StrA[k2_tiName], 'Постановление Президиума ВАС РФ');
   if AnsiSameText(l_Types.Child[i].StrA[k2_tiName], 'Постановление') then
   begin
    l_Sources:= aHeaderRoot.Attr[k2_tiSources];
    if (l_Sources.IsValid) and (l_Sources.ChildrenCount > 0) then
     l_CorrectSource:= AnsiContainsText(l_Sources.Child[0].StrA[k2_tiName], 'ВАС РФ');
   end; // AnsiSameText(l_Types.Child[i].StrA[k2_tiName], 'Постановление')
   if l_CorrectSource then
   begin // Наш случай, ищем орган
    l_Sources:= aHeaderRoot.Attr[k2_tiSources];
    if (l_Sources.IsValid) and (l_Sources.ChildrenCount > 0) then
     l_Sources.Child[0].StrA[k2_tiName]:= 'Органы судебной власти РФ и СССР\Высший Арбитражный Суд России\Президиум ВАС РФ';
    break
   end; // AnsiContainsText(l_Sources.Child[i].StrA[k2_tiName], 'ВАС')
  end; // for i
 end; // l_Types.IsValid
end;


end.
