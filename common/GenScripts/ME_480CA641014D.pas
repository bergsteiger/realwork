unit evSectionBreakPainter;
 {* Реализация инструмента рисования для разрыва секций. }

// Модуль: "w:\common\components\gui\Garant\Everest\evSectionBreakPainter.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evNeedPainters)}
uses
 l3IntfUses
 , evPageBreakPainter
 , l3Interfaces
 , l3Units
 , l3StringIDEx
;

type
 TevSectionBreakPainter = class(TevPageBreakPainter)
  {* Реализация инструмента рисования для разрыва секций. }
  protected
   function GetString: Il3CString; override;
    {* вернуть строчку для отображения. }
   procedure NewPage; override;
    {* вызывается перед началом новой страницы. }
   procedure DrawLine(const A: Tl3Point;
    const B: Tl3Point); override;
    {* нарисовать линию разрыва. }
 end;//TevSectionBreakPainter
{$IfEnd} // Defined(evNeedPainters)

implementation

{$If Defined(evNeedPainters)}
uses
 l3ImplUses
 , nevInterfaces
 , k2Tags
 , l3String
 , evdTypes
 , evSectionPara
 , l3Defaults
 , l3Variant
 , l3MessageID
;

const
 {* Локализуемые строки Local }
 str_nevPortaitSection: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevPortaitSection'; rValue : ' Начало раздела. (%s, книжная) ');
  {* ' Начало раздела. (%s, книжная) ' }
 str_nevLandscapeSection: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevLandscapeSection'; rValue : ' Начало раздела. (%s, альбомная) ');
  {* ' Начало раздела. (%s, альбомная) ' }

function TevSectionBreakPainter.GetString: Il3CString;
 {* вернуть строчку для отображения. }
//#UC START# *480C9DC4032F_480CA641014D_var*
var
 l_PageOrientation : Tl3PageOrientation;
 l_Paras           : Tl3Variant;
//#UC END# *480C9DC4032F_480CA641014D_var*
begin
//#UC START# *480C9DC4032F_480CA641014D_impl*
 l_Paras := ParaX.AsObject.Attr[k2_tiParas];
 with l_Paras do
  if IsValid then 
  begin
   if (IntA[k2_tiOrientation] = Ord(ev_poLandscape)) then
    l_PageOrientation := l3_poLandscape
   else
    l_PageOrientation := l3_poPortrait;
  end 
  else
   l_PageOrientation := l3_poPortrait;
 if (l_PageOrientation = l3_poPortrait) then
  Result := l3Fmt(str_nevPortaitSection.AsCStr,
                   [evGetPaperSizeName(l_Paras)])
 else
  Result := l3Fmt(str_nevLandscapeSection.AsCStr,
                   [evGetPaperSizeName(l_Paras)]);
//#UC END# *480C9DC4032F_480CA641014D_impl*
end;//TevSectionBreakPainter.GetString

procedure TevSectionBreakPainter.NewPage;
 {* вызывается перед началом новой страницы. }
//#UC START# *480C9DDD01B0_480CA641014D_var*
//#UC END# *480C9DDD01B0_480CA641014D_var*
begin
//#UC START# *480C9DDD01B0_480CA641014D_impl*
 inherited;
 Area.rCanvas.SectionExtent := evSectionExtent(ParaX.AsObject);
//#UC END# *480C9DDD01B0_480CA641014D_impl*
end;//TevSectionBreakPainter.NewPage

procedure TevSectionBreakPainter.DrawLine(const A: Tl3Point;
 const B: Tl3Point);
 {* нарисовать линию разрыва. }
//#UC START# *480C9DEF0099_480CA641014D_var*
var
 l_Delta  : Tl3Point;  
//#UC END# *480C9DEF0099_480CA641014D_var*
begin
//#UC START# *480C9DEF0099_480CA641014D_impl*
 l_Delta := l3PointY(10);
 with Area.rCanvas do
 begin
  Line(A.Sub(l_Delta), B.Sub(l_Delta));
  Line(A.Add(l_Delta), B.Add(l_Delta));
 end;//with Area.rCanvas
//#UC END# *480C9DEF0099_480CA641014D_impl*
end;//TevSectionBreakPainter.DrawLine

initialization
 str_nevPortaitSection.Init;
 {* Инициализация str_nevPortaitSection }
 str_nevLandscapeSection.Init;
 {* Инициализация str_nevLandscapeSection }
{$IfEnd} // Defined(evNeedPainters)

end.
