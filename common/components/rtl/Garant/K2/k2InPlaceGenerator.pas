unit k2InPlaceGenerator;

{ Библиотека "K-2"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: k2InPlaceGenerator - }
{ Начат: 24.06.2005 21:52 }
{ $Id: k2InPlaceGenerator.pas,v 1.7 2015/02/10 12:22:35 voba Exp $ }

// $Log: k2InPlaceGenerator.pas,v $
// Revision 1.7  2015/02/10 12:22:35  voba
// - Шурины правки
//
// Revision 1.6  2014/04/09 14:19:32  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.5  2014/03/27 14:20:07  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.4  2013/10/18 14:11:32  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.3  2007/08/10 18:27:17  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.2  2005/06/25 12:17:45  lulin
// - сделана возможнось использовать генератор для моногоразовой генерации.
//
// Revision 1.1  2005/06/24 18:12:26  lulin
// - добавлен генератор, который может генерировать внутрь существующего тега.
//

{$Include k2Define.inc }

interface

uses
  l3Types,
  l3Variant,
  
  k2Interfaces,
  k2Base,
  k2DocumentGenerator
  ;

type
  Tk2InPlaceGenerator = class(Tk2DocumentGenerator)
    private
    // internal fields
      f_Root : Tl3Variant;
      f_Type : Tk2Type;
    protected
    // internal methods
      procedure StartChild(TypeID: Tl3VariantDef);
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
      procedure pm_SetRoot(aValue: Tl3Variant);
        {-}
    public
    // public methods
      constructor Make(aType : Tk2Type;
                       aRoot : Tl3Variant); overload;
        {-}
      constructor Make(aRoot : Tl3Variant); overload;
        {-}
    public
    // public properties
      property Root: Tl3Variant
        read f_Root
        write pm_SetRoot;
        {-}
      property TagType: Tk2Type
        read f_Type
        write f_Type;
        {-}
  end;//Tk2InPlaceGenerator

implementation

uses
  SysUtils
  ;

// start class Tk2InPlaceGenerator

constructor Tk2InPlaceGenerator.Make(aType : Tk2Type;
                                     aRoot : Tl3Variant);
  //reintroduce;
  {-}
begin
 inherited Create;
 aRoot.SetRef(f_Root);
 f_Type := aType;
end;

constructor Tk2InPlaceGenerator.Make(aRoot : Tl3Variant);
  //reintroduce;
  {-}
begin
 Make(aRoot.TagType As Tk2Type, aRoot);
end;

procedure Tk2InPlaceGenerator.pm_SetRoot(aValue: Tl3Variant);
  {-}
begin
 aValue.SetRef(f_Root);
end;

procedure Tk2InPlaceGenerator.Cleanup;
  //override;
  {-}
begin
 f_Type := nil;
 FreeAndNil(f_Root);
 inherited;
end;

procedure Tk2InPlaceGenerator.StartChild(TypeID: Tl3VariantDef);
  //override;
  {-}
begin
 inherited;
 if (f_Root <> nil) then
 begin
  f_Tags.Drop;
  f_Tags.Push(f_Type, f_Root, true, -1);
  f_Type := nil;
  FreeAndNil(f_Root);
 end;//f_Root <> nil
end;

end.

