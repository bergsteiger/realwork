(*
  В программе обновления баз данных НЕ ДОЛЖНЫ использоваться константы из DT_CONST,
  описывающие имена таблиц и другую подобную информацию, а также функции оттуда же,
  возвращающие информацию о таблицах. Это нужно для того, чтобы можно было обновить
  базу из любого предыдущего состояния (а DT_CONST меняется в зависимости от текущей
  версии базы.
*)

const
 FamTblNames      = false;
 FamPassIndex     = false;
 FreeRecCount     = false;
 FreeRecIndex     = false;
 MainTblNames     = false;
 MainPassIndex    = false;
 MainFreeRecCount = false;
 MainFreeRecIndex = false;

 FamTblPrefName   = false;
 FamTblName       = false;
 MainTblName      = false;
 TablePassword    = false;
 TblPassW         = false;

