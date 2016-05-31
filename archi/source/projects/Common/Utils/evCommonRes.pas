unit evCommonRes;
 {* Общие ресурсы для Эвереста и Арчи. }

// Модуль: "w:\archi\source\projects\Common\Utils\evCommonRes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evCommonRes" MUID: (52E79910011F)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки DialogCaptions }
 str_sidChangeSubToBlock: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidChangeSubToBlock'; rValue : 'Первый параграф блока имеет метку'^M+'Перенести связаную с ней информацию на блок?');
  {* 'Первый параграф блока имеет метку'^M+'Перенести связаную с ней информацию на блок?' }
 str_sidNonValidSubNumber: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidNonValidSubNumber'; rValue : 'Номер метки должен быть больше нуля.');
  {* 'Номер метки должен быть больше нуля.' }
 str_sidNonUniqSubNumberQst: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidNonUniqSubNumberQst'; rValue : 'Не уникальный номер метки.'^M+'Перенести метку с этим номером на текущий абзац?');
  {* 'Не уникальный номер метки.'^M+'Перенести метку с этим номером на текущий абзац?' }
 str_sidNonUniqSubNumber: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidNonUniqSubNumber'; rValue : 'Не уникальный номер метки.');
  {* 'Не уникальный номер метки.' }
 str_sidBlockAlreadyExists: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidBlockAlreadyExists'; rValue : 'Блок с таким типом уже есть в документе.');
  {* 'Блок с таким типом уже есть в документе.' }
 str_sidIEmtyFormula: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidIEmtyFormula'; rValue : 'Попытка вставки пустой формулы.');
  {* 'Попытка вставки пустой формулы.' }
 str_sidTableNotFound: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidTableNotFound'; rValue : 'Таблица не найдена.');
  {* 'Таблица не найдена.' }
 str_sidNoTextSelection: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidNoTextSelection'; rValue : 'Сначала выделите текст.');
  {* 'Сначала выделите текст.' }
 str_sidEWSpellCheckDone: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidEWSpellCheckDone'; rValue : 'Проверка правописания в документе завершена.');
  {* 'Проверка правописания в документе завершена.' }
 str_sidSaveAsk: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidSaveAsk'; rValue : 'Документ "%S" был отредактирован.'^M'Записать?');
  {* 'Документ "%S" был отредактирован.'^M'Записать?' }
 str_sidEmptyViborka: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidEmptyViborka'; rValue : 'Выбранная выборка пустая');
  {* 'Выбранная выборка пустая' }
 str_sidSpellCheckFragmentAsk: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sidSpellCheckFragmentAsk'; rValue : 'Проверить правописание только в выделенном фрагменте?');
  {* 'Проверить правописание только в выделенном фрагменте?' }

implementation

uses
 l3ImplUses
;

initialization
 str_sidChangeSubToBlock.Init;
 {* Инициализация str_sidChangeSubToBlock }
 str_sidNonValidSubNumber.Init;
 {* Инициализация str_sidNonValidSubNumber }
 str_sidNonUniqSubNumberQst.Init;
 {* Инициализация str_sidNonUniqSubNumberQst }
 str_sidNonUniqSubNumber.Init;
 {* Инициализация str_sidNonUniqSubNumber }
 str_sidBlockAlreadyExists.Init;
 {* Инициализация str_sidBlockAlreadyExists }
 str_sidIEmtyFormula.Init;
 {* Инициализация str_sidIEmtyFormula }
 str_sidTableNotFound.Init;
 {* Инициализация str_sidTableNotFound }
 str_sidNoTextSelection.Init;
 {* Инициализация str_sidNoTextSelection }
 str_sidEWSpellCheckDone.Init;
 {* Инициализация str_sidEWSpellCheckDone }
 str_sidSaveAsk.Init;
 {* Инициализация str_sidSaveAsk }
 str_sidEmptyViborka.Init;
 {* Инициализация str_sidEmptyViborka }
 str_sidSpellCheckFragmentAsk.Init;
 {* Инициализация str_sidSpellCheckFragmentAsk }

end.
