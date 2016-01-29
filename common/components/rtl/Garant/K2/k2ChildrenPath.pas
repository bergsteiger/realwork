unit k2ChildrenPath;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// ������: "w:/common/components/rtl/Garant/K2/k2ChildrenPath.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2PrimObjects::Tk2ChildrenPath
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3Types,
  l3ProtoObject
  ;

type
 Tk2ChildrenPath = class(Tl3ProtoObject)
 private
 // private fields
   f_Path : TLongArray;
    {* ���� ��� �������� Path}
   f_TagType : Integer;
    {* ���� ��� �������� TagType}
 public
 // public methods
   constructor Create(aTagType: Integer;
     const aPath: TLongArray); reintroduce;
 public
 // public properties
   property Path: TLongArray
     read f_Path;
   property TagType: Integer
     read f_TagType;
 end;//Tk2ChildrenPath

implementation

// start class Tk2ChildrenPath

constructor Tk2ChildrenPath.Create(aTagType: Integer;
  const aPath: TLongArray);
//#UC START# *531F1FA70253_531F1D190024_var*
//#UC END# *531F1FA70253_531F1D190024_var*
begin
//#UC START# *531F1FA70253_531F1D190024_impl*
 inherited Create;
 f_TagType := aTagType;
 f_Path := aPath;
//#UC END# *531F1FA70253_531F1D190024_impl*
end;//Tk2ChildrenPath.Create

end.