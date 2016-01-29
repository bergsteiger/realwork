unit RubricatorRes;
{* Ресурсы рубрикатора. }

(*-------------------------------------------------------------------------------
 $Id: RubricatorRes.pas,v 1.1 2009/09/11 12:12:11 lulin Exp $
 $Log: RubricatorRes.pas,v $
 Revision 1.1  2009/09/11 12:12:11  lulin
 - генерируем константы для операций модуля.
 - правим ссылки на файлы с картинками.

 Revision 1.8  2009/09/09 12:14:04  lulin
 - рисуем внутренние опеации формы рубрикатора на модели.

 Revision 1.7  2008/01/10 07:23:43  oman
 Переход на новый адаптер

 Revision 1.5.4.3  2007/11/29 08:26:38  oman
 Перепиливаем на новый адаптер

 Revision 1.5.4.2  2007/11/28 15:56:47  mmorozov
 - MERGE WITH HEAD;

 Revision 1.5.4.1  2007/11/22 10:50:24  oman
 Перепиливаем на новый адаптер

 Revision 1.6  2007/11/28 15:49:42  mmorozov
 - bugfix: неправильно определяли типы элементов (папка | не папка) (CQ: OIT5-27615);

 Revision 1.5  2007/04/10 12:38:28  mmorozov
 - new: использование новых идентификаторов элементов навигатора (CQ: OIT5-24602);

-------------------------------------------------------------------------------*)

interface

uses
  SysUtils,
  Classes,
  ImgList,
  Controls,

  BaseTypesUnit,
  DynamicTreeUnit,

  vtPngImgList
  ;

type
  TnsRubricatorRes = class(TDataModule)
    RubricatorItemsImageList: TvtPngImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
 cimgFolder   = 0;
 cimgList     = 1;
 cimgDocument = 2;

function nsRubricatorRes: TnsRubricatorRes;

function GetRubricatorImageIndex(const aNode: INodeBase) : Integer;

implementation

uses
  Forms,
  bsConst
  ;

var
 g_RubricatorRes : TnsRubricatorRes = nil;
 
function nsRubricatorRes: TnsRubricatorRes;
begin
 if (g_RubricatorRes = nil) then
  g_RubricatorRes := TnsRubricatorRes.Create(Application);
 Result := g_RubricatorRes; 
end;

function GetRubricatorImageIndex(const aNode: INodeBase) : Integer;
begin
 if TNavigatorMenuItemType(aNode.GetType) = NM_DOCUMENT then
  Result := cimgDocument
 else
  if aNode.HasChildren then
   Result := cimgFolder
  else
   Result := cimgList;
end;//GetRubricatorImageIndex

{$R *.dfm}

end.
