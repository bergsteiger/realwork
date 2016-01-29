unit TableTextPara_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/TableTextPara_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::TableTextPara
//
// Текстовый параграф в таблице
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега TableTextPara - "Текстовый параграф в таблице".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idTableTextPara = 53;

function k2_typTableTextPara: TableTextParaTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_TableTextPara : TableTextParaTag = nil;

// start class TableTextParaTag

function k2_typTableTextPara: TableTextParaTag;
begin
 if (g_TableTextPara = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_TableTextPara := TevNativeSchema(Tk2TypeTable.GetInstance).t_TableTextPara;
 end;//g_TableTextPara = nil
 Result := g_TableTextPara;
end;

end.