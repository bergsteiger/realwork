unit evImageIndexProperty;

{ Библиотека "Эверест"    }
{ Начал: Люлин А.В.       }
{ Модуль: evImageIndexProperty - }
{ Начат: 06.03.2007 12:44 }
{ $Id: evImageIndexProperty.pas,v 1.1 2007/03/06 11:59:05 lulin Exp $ }

// $Log: evImageIndexProperty.pas,v $
// Revision 1.1  2007/03/06 11:59:05  lulin
// - сделана возможность выбирать иконки из списка, а не задавать только руками.
//

interface

uses
  DesignEditors,
  DesignIntf,
  Classes,
  ImgList,
  VCLEditors,
  Graphics,
  Types
  ;
  
type
 { TevImageIndexProperty
   Абстракный редактор свойства TImageIndex для классов:
     - TstState;
     - TStateTree;
     - TstEmptyState; }

 TevImageIndexProperty = class(TIntegerProperty, ICustomPropertyDrawing,
  ICustomPropertyListDrawing)
 protected
   function GetImages : TCustomImageList; virtual; abstract;
 public
   function GetAttributes: TPropertyAttributes; override;
   procedure GetValues(Proc: TGetStrProc); override;
   { ICustomPropertyListDrawing }
   procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas;
     var AHeight: Integer);
   procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas;
     var AWidth: Integer);
   procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
     const ARect: TRect; ASelected: Boolean);
   { CustomPropertyDrawing }
   procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect;
     ASelected: Boolean);
   procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
     ASelected: Boolean);
 end;//TevImageIndexProperty

implementation

uses
  SysUtils,
  Math
  ;

{ TstImageIndex }

function TevImageIndexProperty.GetAttributes: TPropertyAttributes;
begin
 Result := inherited GetAttributes;
 Include(Result, paValueList);
end;

procedure TevImageIndexProperty.GetValues(Proc: TGetStrProc);
var
 l_Index : Integer;
 l_Images : TCustomImageList;
begin
 l_Images := GetImages;
 { Иконы пока не установлены }
 if Assigned(l_Images) then
  for l_Index := -1 to Pred(l_Images.Count) do
   Proc(IntToStr(l_Index))
 { "-1" единственное что можно установить }
 else
  Proc('-1');
end;

procedure TevImageIndexProperty.ListDrawValue(const Value: string;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
 l_Right  : Integer;
 l_Index  : Integer;
 l_Images : TCustomImageList;
begin
 l_Right := aRect.Left;
 l_Images := GetImages;
 if Assigned(l_Images) then begin
  Inc(l_Right, l_Images.Width);
  try
   l_Index := StrToInt(Value);
  except
   l_Index := -1;
  end;//try..except
  aCanvas.FillRect(Rect(ARect.Left, ARect.Top, l_Right, aRect.Bottom));
  if (l_Index >= 0) then begin
   l_Images.Draw(aCanvas, aRect.Left, aRect.Top, l_Index);
  end;//l_Index >= 0
 end;//l_Images <> nil
 DefaultPropertyListDrawValue(Value, ACanvas, Rect(l_Right, ARect.Top,
   ARect.Right, ARect.Bottom), ASelected);
end;

procedure TevImageIndexProperty.ListMeasureHeight(const Value: string;
  ACanvas: TCanvas; var AHeight: Integer);
var
 l_Images : TCustomImageList;
begin
 l_Images := GetImages;
 if Assigned(l_Images) then
  AHeight := Max(AHeight, l_Images.Height);
end;

procedure TevImageIndexProperty.ListMeasureWidth(const Value: string;
  ACanvas: TCanvas; var AWidth: Integer);
var
 l_Images : TCustomImageList;
begin
 l_Images := GetImages;
 if Assigned(l_Images) then
  AWidth := l_Images.Width;
end;

procedure TevImageIndexProperty.PropDrawName(ACanvas: TCanvas;
  const ARect: TRect; ASelected: Boolean);
begin
 DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

procedure TevImageIndexProperty.PropDrawValue(ACanvas: TCanvas;
  const ARect: TRect; ASelected: Boolean);
begin
 if GetVisualValue <> '' then
  ListDrawValue(GetVisualValue, ACanvas, ARect, True)
 else
  DefaultPropertyDrawValue(Self, ACanvas, ARect);
end;

end.

