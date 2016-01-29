unit SimpleDocumentTextPara_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/SimpleDocumentTextPara_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::SimpleDocumentTextPara
//
// текстовый параграф в "простых документах"
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега SimpleDocumentTextPara - "текстовый параграф в "простых документах"".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idSimpleDocumentTextPara = 52;

function k2_typSimpleDocumentTextPara: SimpleDocumentTextParaTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_SimpleDocumentTextPara : SimpleDocumentTextParaTag = nil;

// start class SimpleDocumentTextParaTag

function k2_typSimpleDocumentTextPara: SimpleDocumentTextParaTag;
begin
 if (g_SimpleDocumentTextPara = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_SimpleDocumentTextPara := TevNativeSchema(Tk2TypeTable.GetInstance).t_SimpleDocumentTextPara;
 end;//g_SimpleDocumentTextPara = nil
 Result := g_SimpleDocumentTextPara;
end;

end.