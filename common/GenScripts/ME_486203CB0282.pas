unit Meta_Schema;

// Модуль: "w:\common\components\SandBox\Meta_Schema.pas"
// Стереотип: "TagTable"

{$Include w:\common\components\SandBox\sbDefine.inc}

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
