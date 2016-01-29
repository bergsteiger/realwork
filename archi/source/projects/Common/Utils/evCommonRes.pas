unit evCommonRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Utils"
// Модуль: "w:/archi/source/projects/Common/Utils/evCommonRes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$common::Utils::Tools::evCommonRes
//
// Общие ресурсы для Эвереста и Арчи.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
  l3StringIDEx
  ;

var
  { Локализуемые строки DialogCaptions }
 str_sidChangeSubToBlock : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidChangeSubToBlock'; rValue : 'Первый параграф блока имеет метку'^M+'Перенести связаную с ней информацию на блок?');
  { 'Первый параграф блока имеет метку'^M+'Перенести связаную с ней информацию на блок?' }
 str_sidNonValidSubNumber : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidNonValidSubNumber'; rValue : 'Номер метки должен быть больше нуля.');
  { 'Номер метки должен быть больше нуля.' }
 str_sidNonUniqSubNumberQst : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidNonUniqSubNumberQst'; rValue : 'Не уникальный номер метки.'^M+'Перенести метку с этим номером на текущий абзац?');
  { 'Не уникальный номер метки.'^M+'Перенести метку с этим номером на текущий абзац?' }
 str_sidNonUniqSubNumber : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidNonUniqSubNumber'; rValue : 'Не уникальный номер метки.');
  { 'Не уникальный номер метки.' }
 str_sidBlockAlreadyExists : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidBlockAlreadyExists'; rValue : 'Блок с таким типом уже есть в документе.');
  { 'Блок с таким типом уже есть в документе.' }
 str_sidIEmtyFormula : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidIEmtyFormula'; rValue : 'Попытка вставки пустой формулы.');
  { 'Попытка вставки пустой формулы.' }
 str_sidTableNotFound : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidTableNotFound'; rValue : 'Таблица не найдена.');
  { 'Таблица не найдена.' }
 str_sidNoTextSelection : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidNoTextSelection'; rValue : 'Сначала выделите текст.');
  { 'Сначала выделите текст.' }
 str_sidEWSpellCheckDone : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidEWSpellCheckDone'; rValue : 'Проверка правописания в документе завершена.');
  { 'Проверка правописания в документе завершена.' }
 str_sidSaveAsk : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidSaveAsk'; rValue : 'Документ "%S" был отредактирован.'^M'Записать?');
  { 'Документ "%S" был отредактирован.'^M'Записать?' }
 str_sidEmptyViborka : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidEmptyViborka'; rValue : 'Выбранная выборка пустая');
  { 'Выбранная выборка пустая' }

implementation

uses
  l3MessageID
  ;


initialization
// Инициализация str_sidChangeSubToBlock
 str_sidChangeSubToBlock.Init;
// Инициализация str_sidNonValidSubNumber
 str_sidNonValidSubNumber.Init;
// Инициализация str_sidNonUniqSubNumberQst
 str_sidNonUniqSubNumberQst.Init;
// Инициализация str_sidNonUniqSubNumber
 str_sidNonUniqSubNumber.Init;
// Инициализация str_sidBlockAlreadyExists
 str_sidBlockAlreadyExists.Init;
// Инициализация str_sidIEmtyFormula
 str_sidIEmtyFormula.Init;
// Инициализация str_sidTableNotFound
 str_sidTableNotFound.Init;
// Инициализация str_sidNoTextSelection
 str_sidNoTextSelection.Init;
// Инициализация str_sidEWSpellCheckDone
 str_sidEWSpellCheckDone.Init;
// Инициализация str_sidSaveAsk
 str_sidSaveAsk.Init;
// Инициализация str_sidEmptyViborka
 str_sidEmptyViborka.Init;

end.