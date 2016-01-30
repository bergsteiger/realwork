unit Meta_Schema;

// ������: "w:\common\components\SandBox\Meta_Schema.pas"
// ���������: "TagTable"

{$Include sbDefine.inc}

interface

uses
 l3IntfUses
;

type
 Visibility = (
  public
  , private
  , protected
 );//Visibility

 Abstract = (
  regular
  , abstract
  , final
 );//Abstract

 // TMetaSchema

implementation

uses
 l3ImplUses
;

initialization
 TMetaSchema.SetAsDefault;

end.
