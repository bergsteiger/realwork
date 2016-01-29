unit vcmStyle;

// Библиотека : "vcm"
// Автор      : Морозов М. А.
// Модуль     : vcmToolbarsImages
// Начат      : 12.12.2006
// Версия     : $Id: vcmStyle.pas,v 1.6 2015/06/03 12:26:27 lulin Exp $

(*-------------------------------------------------------------------------------
 $Log: vcmStyle.pas,v $
 Revision 1.6  2015/06/03 12:26:27  lulin
 - пытаемся разрулить зависимости.

 Revision 1.5  2013/11/11 15:35:23  lulin
 - вычищаем устаревший код.

 Revision 1.4  2011/05/19 12:21:15  lulin
 {RequestLink:266409354}.

 Revision 1.3  2007/01/22 06:40:44  mmorozov
 - change: в стилей панелей инструментов используем интерфейс контейнера, а не класс;

 Revision 1.2  2006/12/27 14:44:59  mmorozov
 - change: механизм объединения панелей инструментов (CQ: OIT5-23903);

 Revision 1.1  2006/12/13 09:34:01  mmorozov
 - new: возможность указывать фиксированный размер для зон стыковки панелей инструментов формы, в рамках работы над CQ: OIT5-13323;
-------------------------------------------------------------------------------*)


{$Include vcmDefine.inc }

interface

{$If not defined(NoVCM)}
uses
  Classes,
  Forms,

  l3Base,
  l3CProtoObject,

  vcmInterfaces,
  vcmBase
  ;

type
  TvcmToolbarStyle = class(Tl3CProtoObject, IvcmToolbarStyle)
  private
  // fields
    f_ImageSize          : TvcmImageSize;
    f_MergeWithContainer : TvcmBool;
    f_Container          : Integer;
  private
  // IvcmToolbarStyle
    function pm_GetImageSize: TvcmImageSize;
      {* - размер иконок. }
    function pm_GetMergeWithContainer: TvcmBool;
      {* - объединять с панелью инструментов контейнера формы. }
    function pm_GetContainer: IvcmEntityForm;
    procedure pm_SetContainer(const aValue: IvcmEntityForm);
      {* - контейнер для размещения панели иснтрументов. }
    procedure Merge(const aStyle: IvcmToolbarStyle);
      {* - объединить стили. }
  private
  // property methods
    procedure pm_SetImageSize(const Value: TvcmImageSize);
      {-}
    procedure pm_SetMergeWithContainer(const Value: TvcmBool);
      {-}
  protected
  // methods
(*    procedure Assign(P: TPersistent);
      override;
      {* - операция присваивания двух объектов. }*)
  public
  // methods
    constructor Create;
      reintroduce;
      {-}
    function IsDefault: Boolean;
      {-}
    procedure ForbidMerge;
      {* - запретить объединение панелей инструментов. }
  public
  // properties
    property Container: IvcmEntityForm
      read pm_GetContainer
      write pm_SetContainer;
      {* - контейнер для размещения панели иснтрументов. }
  published
  // property
    property ImageSize: TvcmImageSize
      read pm_GetImageSize
      write pm_SetImageSize
      default isNone;
      {* - размер иконок. }
    property MergeWithContainer: TvcmBool
      read pm_GetMergeWithContainer
      write pm_SetMergeWithContainer
      default vcm_bNone;
      {* - объединять с панелью инструментов контейнера формы. }
  end;//TvcmToolbarStyle

  TvcmToolbarsStyle = class(Tl3CProtoObject, IvcmToolbarsStyle)
  {* Иконки зоны. }
  private
  // fields
    f_Left   : TvcmToolbarStyle;
    f_Right  : TvcmToolbarStyle;
    f_Top    : TvcmToolbarStyle;
    f_Bottom : TvcmToolbarStyle;
  private
  // IvcmToolbarsStyle
    function pm_GetLeft: IvcmToolbarStyle;
      {-}
    function pm_GetRight: IvcmToolbarStyle;
      {-}
    function pm_GetTop: IvcmToolbarStyle;
      {-}
    function pm_GetBottom: IvcmToolbarStyle;
      {-}
    procedure Merge(const aStyle: IvcmToolbarsStyle);
      {* - объединить стили. }
(*  private
  // methods
    procedure pm_SetBottom(const Value: TvcmToolbarStyle);
      {-}
    procedure pm_SetLeft(const Value: TvcmToolbarStyle);
      {-}
    procedure pm_SetRight(const Value: TvcmToolbarStyle);
      {-}
    procedure pm_SetTop(const Value: TvcmToolbarStyle);
      {-}*)
  protected
  // methods
(*    procedure Assign(P: TPersistent);
      override;
      {* - операция присваивания двух объектов. }*)
    procedure Cleanup;
      override;
      {-}
  public
  // methods
    constructor Create;
      reintroduce;
      {-}
  public
  // IvcmToolbarsStyle
    function IsDefault: Boolean;
      {* - для одной из панелей устновлены иконки. }
    procedure ForbidMerge;
      {* - запретить объединение панелей инструментов. }
  published
  // properties
    property Left: TvcmToolbarStyle
      read f_Left
      //write pm_SetLeft
      ;
      {-}
    property Right: TvcmToolbarStyle
      read f_Right
      //write pm_SetRight
      ;
      {-}
    property Top: TvcmToolbarStyle
      read f_Top
      //write pm_SetTop
      ;
      {-}
    property Bottom: TvcmToolbarStyle
      read f_Bottom
      //write pm_SetBottom
      ;
      {-}
  end;//TvcmToolbarsStyle

  TvcmFormStyle = class(Tl3CProtoObject, IvcmFormStyle)
  private
  // fields
    f_Toolbars: TvcmToolbarsStyle;
  private
  // IvcmFormStyle
    procedure Merge(const aStyle: IvcmFormStyle);
      {* - объединить стили. }
    function pm_GetToolbars: IvcmToolbarsStyle;
      {-}
  private
  // methods
(*    procedure pm_SetToolbars(const Value: TvcmToolbarsStyle);
      {* - иконки для панелей инструментов формы. }*)
    function IsStoredToolbars: Boolean;
      {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  public
  // methods
    constructor Create;
      reintroduce;
      {-}
    class function Make: IvcmFormStyle;
      {-}
    function IsDefault: Boolean;
      {* - были ли изменены настройки. }
  public
  // properties
    property Toolbars: TvcmToolbarsStyle
      read f_Toolbars
//      write pm_SetToolbars
      stored IsStoredToolbars;
      {-}
  end;//TvcmFormStyle
{$IfEnd}

implementation

{$If not defined(NoVCM)}
uses
  SysUtils
  ;

{ TvcmToolbarsStyle }

constructor TvcmToolbarsStyle.Create;
  // reintroduce;
  // virtual;
  {-}
begin
 inherited Create;
 f_Left := TvcmToolbarStyle.Create;
 f_Right := TvcmToolbarStyle.Create;
 f_Top := TvcmToolbarStyle.Create;
 f_Bottom := TvcmToolbarStyle.Create;
end;//Create

(*procedure TvcmToolbarsStyle.Assign(P: TPersistent);
  // override;
  {* - операция присваивания двух объектов. }
begin
 inherited;
 if (P is TvcmToolbarsStyle) then
  with TvcmToolbarsStyle(P) do
  begin
   Self.Left := Left;
   Self.Right := Right;
   Self.Top := Top;
   Self.Bottom := Bottom;
  end;//with TvcmToolbarsStyle(P) do
end;//Assign*)

function TvcmToolbarsStyle.IsDefault: Boolean;
  {* - для одной из панелей устновлены иконки. }
begin
 Result := f_Left.IsDefault and f_Right.IsDefault and f_Top.IsDefault and
  f_Bottom.IsDefault;
end;//IsDefault

function TvcmToolbarsStyle.pm_GetBottom: IvcmToolbarStyle;
begin
 Result := f_Bottom;
end;//pm_GetBottom

function TvcmToolbarsStyle.pm_GetLeft: IvcmToolbarStyle;
begin
 Result := f_Left;
end;//pm_GetLeft

function TvcmToolbarsStyle.pm_GetRight: IvcmToolbarStyle;
begin
 Result := f_Right;
end;//pm_GetRight

function TvcmToolbarsStyle.pm_GetTop: IvcmToolbarStyle;
begin
 Result := f_Top;
end;//pm_GetTop

(*procedure TvcmToolbarsStyle.pm_SetBottom(const Value: TvcmToolbarStyle);
begin
 Value.SetRefTo(f_Bottom);
 //f_Bottom.Assign(Value);
end;//pm_SetBottom

procedure TvcmToolbarsStyle.pm_SetLeft(const Value: TvcmToolbarStyle);
begin
 Value.SetRefTo(f_Left);
 //f_Left.Assign(Value);
end;//pm_SetLeft

procedure TvcmToolbarsStyle.pm_SetRight(const Value: TvcmToolbarStyle);
begin
 Value.SetRefTo(f_Right);
 //f_Right.Assign(Value);
end;//pm_SetRight

procedure TvcmToolbarsStyle.pm_SetTop(const Value: TvcmToolbarStyle);
begin
 Value.SetRefTo(f_Top);
 //f_Top.Assign(Value);
end;//pm_SetTop*)

procedure TvcmToolbarsStyle.Cleanup;
begin
 FreeAndNil(f_Left);
 FreeAndNil(f_Top);
 FreeAndNil(f_Right);
 FreeAndNil(f_Bottom);
 inherited;
end;//Cleanup

procedure TvcmToolbarsStyle.ForbidMerge;
  {* - запретить объединение панелей инструментов. }
begin
 f_Left.ForbidMerge;
 f_Top.ForbidMerge;
 f_Right.ForbidMerge;
 f_Bottom.ForbidMerge;
end;//ForbidMerge

procedure TvcmToolbarsStyle.Merge(const aStyle: IvcmToolbarsStyle);
begin
 with aStyle do
 begin
  f_Left.Merge(aStyle.Left);
  f_Top.Merge(aStyle.Top);
  f_Right.Merge(aStyle.Right);
  f_Bottom.Merge(aStyle.Bottom);
 end;//with aStyle do
end;//Merge

{ TvcmFormStyle }

function TvcmFormStyle.pm_GetToolbars: IvcmToolbarsStyle;
  {* - иконки для панелей инструментов формы. }
begin
 Result := f_Toolbars;
end;//pm_GetToolbars

function TvcmFormStyle.IsStoredToolbars: Boolean;
begin
 Result := not f_Toolbars.IsDefault;
end;//IsStoredToolbars

(*procedure TvcmFormStyle.pm_SetToolbars(const Value: TvcmToolbarsStyle);
begin
 f_Toolbars.Assign(Value);
end;//pm_SetToolbars*)

constructor TvcmFormStyle.Create;
begin
 inherited Create;
 f_Toolbars := TvcmToolbarsStyle.Create;
end;//Create

procedure TvcmFormStyle.Cleanup;
begin
 FreeAndNil(f_Toolbars);
 inherited;
end;//Cleanup

function TvcmFormStyle.IsDefault: Boolean;
  {* - были ли изменены настройки. }
begin
 Result := f_Toolbars.IsDefault;
end;//IsDefault

class function TvcmFormStyle.Make: IvcmFormStyle;
var
 l_Class: TvcmFormStyle;
begin
 l_Class := Create;
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

procedure TvcmFormStyle.Merge(const aStyle: IvcmFormStyle);
begin
 f_Toolbars.Merge(aStyle.Toolbars);
end;//Merge

{ TvcmToolbarStyle }

constructor TvcmToolbarStyle.Create;
begin
 inherited Create;
 f_ImageSize := isNone;
 f_MergeWithContainer := vcm_bNone;
end;//Create

(*procedure TvcmToolbarStyle.Assign(P: TPersistent);
  // override;
  {* - операция присваивания двух объектов. }
begin
 inherited;
 if P is TvcmToolbarStyle then
  with TvcmToolbarStyle(P) do
  begin
   Self.ImageSize := ImageSize;
   Self.MergeWithContainer := MergeWithContainer;
  end;//with TvcmToolbarStyle(P) do
end;//Assign*)

procedure TvcmToolbarStyle.ForbidMerge;
  {* - запретить объединение панелей инструментов. }
begin
 f_MergeWithContainer := vcm_bFalse;
 f_Container := 0;
end;//ForbidMerge

function TvcmToolbarStyle.IsDefault: Boolean;
begin
 Result := (f_ImageSize = isNone) and (f_MergeWithContainer = vcm_bNone);
end;//IsDefault

function TvcmToolbarStyle.pm_GetContainer: IvcmEntityForm;
begin
 Result := IvcmEntityForm(f_Container);
end;//pm_GetContainer

procedure TvcmToolbarStyle.pm_SetContainer(const aValue: IvcmEntityForm);
begin
 f_Container := Integer(aValue);
end;//pm_SetContainer

function TvcmToolbarStyle.pm_GetImageSize: TvcmImageSize;
begin
 Result := f_ImageSize;
end;//pm_GetImageSize

function TvcmToolbarStyle.pm_GetMergeWithContainer: TvcmBool;
begin
 Result := f_MergeWithContainer;
end;//pm_GetMergeWithContainer

procedure TvcmToolbarStyle.pm_SetImageSize(const Value: TvcmImageSize);
begin
 f_ImageSize := Value;
end;//pm_SetImageSize

procedure TvcmToolbarStyle.pm_SetMergeWithContainer(const Value: TvcmBool);
begin
 f_MergeWithContainer := Value;
end;//pm_SetMergeWithContainer

procedure TvcmToolbarStyle.Merge(const aStyle: IvcmToolbarStyle);
begin
 if f_ImageSize = isNone then
  f_ImageSize := aStyle.ImageSize;
 if f_MergeWithContainer = vcm_bNone then
 begin
  f_MergeWithContainer := aStyle.MergeWithContainer;
  f_Container := Integer(aStyle.Container);
 end;//if not f_MergeWithContainer then
end;//Merge

{$IfEnd}

end.
