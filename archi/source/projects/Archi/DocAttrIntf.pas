unit DocAttrIntf;

{ $Id: DocAttrIntf.pas,v 1.13 2014/06/18 17:01:15 voba Exp $ }

{$I l3Define.inc}

interface

 Uses
  l3Variant,
  k2Interfaces,

  l3Types,
  l3DatLst,
  m3DBInterfaces,
  dt_Types,
  dt_AttrSchema;
  {DocAttrImpl}
 Type
  IDocAttribute = interface
  ['{5997F6E1-E850-4E6F-81AC-E85271F66602}']
   procedure Copy(aSrcAttr : IDocAttribute);
   function  Get_AttrID : TdtAttribute;
   procedure Delete(aIndex : Integer = 0);
   procedure DeleteByHandle(aHandle : Integer);
   procedure DeleteAll;
   procedure DeleteAllforPart(aDocPart : Tm3DocPartSelector);

   //function  GetViewString(aIndex : Integer = 0) : String;
   function  Get_Modified : Boolean;
   procedure Set_Modified(aValue : Boolean);
   function  Get_DocPart : Tm3DocPartSelector;

   procedure Load;
   //function  Save : boolean;
   function  IsEmpty : Boolean;
   property  AttrID : TdtAttribute read Get_AttrID;
   property  DocPart : Tm3DocPartSelector read Get_DocPart;

   property  Modified : Boolean read Get_Modified write Set_Modified;
  end;

  (*
  IOrdinalDocAttribute = interface(IDocAttribute)
  ['{1FA0761A-A5EC-41CB-B96E-39592CC4DA49}']
   procedure Set_Integer(aValue : Integer);
   function  Get_Integer : Integer;

   procedure Set_String(aValue : String);
   function  Get_String : String;

   function Get_Handle : Integer;

   property AsInteger : Integer read Get_Integer write Set_Integer;
   property AsString  : String  read Get_String  write Set_String;
   property Handle : Integer read Get_Handle;
  end;

  *)

  IIntegerDocAttribute = interface(IDocAttribute)
   ['{3ECA1677-C582-4B1B-889C-23D206A909CA}']
    procedure Set_Value(aValue : Integer);
    function  Get_Value : Integer;

    property Value : Integer read Get_Value write Set_Value;
  end;

  IListDocAttribute = interface(IDocAttribute)
   ['{6F3840F9-B21A-4D2F-8428-7FF0C56A5CE0}']
    function  Get_ViewString(aIndex: Longint) : Tl3PCharLen;
    procedure Set_ViewString(aIndex: Longint; aValue : Tl3PCharLen);

    function  Add(aTag : Tl3Tag) : Integer;

    function  Get_Handle(aIndex : Integer) : Integer;
    function  Get_Child(aIndex : Integer) : Tl3Tag;

    function  GetIndexByHandle(aHandle : Integer) : Integer;

    function  Get_Count : Integer;

    function  EditData(aHandle : Integer; aValue : Pointer) : Boolean;
    function  EditItem(aIndex : Integer) : Boolean;

    property ViewString[aIndex: Longint] : Tl3PCharLen read Get_ViewString write Set_ViewString;

    property Child[aIndex: Longint] : Tl3Tag read Get_Child;
    property Handle[aIndex: Longint] : Integer read Get_Handle;

    property Count : Integer read Get_Count;
  end;

implementation
end.


