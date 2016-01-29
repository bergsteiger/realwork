// ОБЩИЕ ФУНКЦИИ
var gbl_FSO_Cache;
var ForReading = 1;
var ForWriting = 2;

function FSO()
{
	if (typeof(gbl_FSO_Cache) != "object")	
		gbl_FSO_Cache = new ActiveXObject("Scripting.FileSystemObject");
	return gbl_FSO_Cache;
}

// ОПРЕДЕЛЕНИЯ КЛАССОВ
function OSWObjectCounts()
{
	this.total = 0;
	this.active = 0;
}

function OSWObjectData()
{
	this.countDataMap = new ActiveXObject("Scripting.Dictionary");
	//
	// возвращает объект, хранящий информацию о количестве объектов по дате.
	this.GetObjectCountsByDate = function (
		aDate
	)
	{
		if ( this.countDataMap.Exists(aDate) )
			return this.countDataMap.Item(aDate);
		else
		{
			this.countDataMap.Add(aDate, new OSWObjectCounts());
			return this.GetObjectCountsByDate(aDate);
		}
	}
}

function OSWObjects()
{
	this.objectDataMap = new ActiveXObject("Scripting.Dictionary");
	//
	
	// возвращает объект, хранящий информацию о количестве объектов по датам
	this.GetObjectDataByName = function (
		aName
	)
	{
		if ( this.objectDataMap.Exists(aName) )
			return this.objectDataMap.Item(aName);
		else
		{
			this.objectDataMap.Add(aName, new OSWObjectData());
			return this.GetObjectDataByName(aName);
		}
	}
	
	this.GetObjectNames = function()	
	{
		return (new VBArray( this.objectDataMap.Keys() ).toArray());
	}
}

function OSWData()
{
	this.oswObjects = new OSWObjects();
	this.datesMap = new ActiveXObject("Scripting.Dictionary");
	
	// возвращает массив дат
	this.GetDates = function()
	{
		return (new VBArray( this.datesMap.Keys() ).toArray());
	}
	
	// вызываем это, чтобы запомнить какие даты использовались
	this.PutDate = function(
		aDate
	)
	{
		if ( !this.datesMap.Exists(aDate) )
			this.datesMap.Add(aDate, 0);
	}
	
	// заполняем объект данными из заданного файла
	this.FillFromStatFile = function(
		aFileName
	)
	{	
		// регулярные выражение для разюора строки файла
		var lineRexp = /(.*);(.*);(\d*);(\d*)/;
		var dateRexp = /(\d*)-(\d*)-(\d*)_(\d*)-(\d*)-(\d*)/;
		
		// открываем файл
		var inFile = FSO().OpenTextFile(aFileName, ForReading);
		
		// построчно его обрабатываем
		while ( !inFile.AtEndOfStream )
		{
			// разбиваем строку на дату, имя и количества
			var line = inFile.ReadLine();
			var lineRes = lineRexp.exec(line);
			if (lineRes != null)
			{
				var dateStr = lineRes[1];
				var objectName = lineRes[2];
				var total = lineRes[3];
				var active = lineRes[4];
				
				/* // парсим дату в стандартный объект
				var dateObj = null;
				dateRes = dateRexp.exec(dateStr)
				if (dateRes != null)
					dateObj = new Date(dateRes[3], dateRes[2], dateRes[1], dateRes[4], dateRes[5], dateRes[6]);
				else
					throw "Некорректный формат даты!"; */
				var dateObj = dateStr;	
				
				// добавляем полученные данные в результат
				this.PutDate(dateObj);
				oswObjectData = this.oswObjects.GetObjectDataByName(objectName);
				oswObjectCount = oswObjectData.GetObjectCountsByDate(dateObj);
				oswObjectCount.total = (new Number(total)).valueOf();
				oswObjectCount.active = (new Number(active)).valueOf();
			}
			
		}
		inFile.Close();
     
		return true;	
	}
}

function OSWParserBase()
{
	this.Parse = function(
		oswData
	)
	{		
		var oswObjects = oswData.oswObjects;
		var datesArr = oswData.GetDates();
		
		this.OnParseBegin(oswObjects, datesArr);
		
		// перебираем все объекты
		var objectNamesArr = oswObjects.GetObjectNames();	
		for (var i=0; i < objectNamesArr.length; i++)
		{		
			objectName = objectNamesArr[i];
			var oswObjectData = oswObjects.GetObjectDataByName(objectName);
			
			this.OnObjectBegin(objectName, oswObjectData);
			
			// перебираем данные для всех дат, даже для тех, для которых данных может и не быть (в этом случае 0)
			for (var j = 0; j < datesArr.length; j++)
			{
				var oswObjectCounts = oswObjectData.GetObjectCountsByDate(datesArr[j]);
				this.OnEachDate(datesArr[j], oswObjectCounts);
			}
			
			this.OnObjectEnd(objectName);
		}	
		this.OnParseEnd();
	}
	
	// вызывается при начале парсинга
	this.OnParseBegin = function(
		oswObjects,
		datesArr
	)
	{
		throw "Must be implemented!";
	}
	
	// вызывается в конце парсинга
	this.OnParseEnd = function()
	{
		throw "Must be implemented!";
	}
	
	// вызывается при начале парсинга объекта
	this.OnObjectBegin = function(
		anObjectName,
		oswObjectData
	)
	{
		throw "Must be implemented!";
	}
	
	// вызывается по окончании парсинга объекта
	this.OnObjectEnd = function(
		anObjectName
	)
	{
		throw "Must be implemented!";
	}
	
	// вызывается при каждом получении данных о количестве для конкретного объекта
	this.OnEachDate = function(
		aDate,
		oswObjectCounts
	)
	{
		throw "Must be implemented!";
	}
		
}

OSWParserToCSV.prototype = new OSWParserBase();
function OSWParserToCSV(
	baseOutFileName
)
{
	this.baseOutFileName = baseOutFileName;
	this.outFileActive;
	this.outFileTotal;
	this.outFileAll;
	//
	this.activeStr;
	this.totalStr;
	this.allStr;
	//
	this.isIncreasing;
	this.isSteadilyIncreasing;
	this.isConstant;
	this.lastValue;
	this.maxValue;	
		
	this.OnParseBegin = function(
		oswObjects,
		datesArr
	)
	{
		// открываем выходные файлы		
		this.outFileActive = FSO().OpenTextFile(this.baseOutFileName + ".active.csv", ForWriting, true);
		this.outFileTotal = FSO().OpenTextFile(this.baseOutFileName + ".total.csv", ForWriting, true);
		this.outFileAll = FSO().OpenTextFile(this.baseOutFileName + ".all.csv", ForWriting, true);
		
		// формируем заголовки		
		var activeStr = totalStr = allStr ="\"Имя класса\"";
		activeStr +=";\"Строго возрастает\";\"Возрастает\";\"Изменяется\"";
		for (var j = 0; j < datesArr.length; j++)
		{
			activeStr += ";\"Активных " + datesArr[j] + "\"";
			totalStr += ";\"Всего " + datesArr[j] + "\"";
			allStr += ";\"Всего " + datesArr[j] + "\";\"Активных " + datesArr[j] + "\"";
		}
		
		// записываем их в файлы
		this.outFileActive.WriteLine(activeStr);	
		this.outFileTotal.WriteLine(totalStr);
		this.outFileAll.WriteLine(allStr);
	}
	
	this.OnParseEnd = function()
	{
		this.outFileActive.Close();
		this.outFileTotal.Close();
		this.outFileAll.Close();
	}
	
	this.OnObjectBegin = function(
		anObjectName,
		oswObjectData
	)
	{
		this.activeStr = this.totalStr = this.allStr = ";";

		this.isIncreasing = true;
		this.isSteadilyIncreasing = true;
		this.isConstant = true;
		this.maxValue = -1;	
		this.lastValue = -1;
	}
	
	this.OnObjectEnd = function(
		anObjectName
	)
	{
		this.isIncreasing &= !this.isConstant;
		//
		var tmpStr = ";" +
			(this.isSteadilyIncreasing ? "+" : "\" \"") + ";" + 
			(this.isIncreasing ? "+" : "\" \"") +";" +
			(!this.isConstant ? "+" : "\" \"");
		//
		this.outFileActive.WriteLine(anObjectName + tmpStr + this.activeStr);
		this.outFileTotal.WriteLine(anObjectName + this.totalStr);
		this.outFileAll.WriteLine(anObjectName + this.allStr);
	}
	
	this.OnEachDate = function(
		aDate,
		oswObjectCounts
	)
	{
		this.activeStr += oswObjectCounts.active + ";";
		this.totalStr += oswObjectCounts.total + ";";
		this.allStr += oswObjectCounts.total + ";" + oswObjectCounts.active + ";";

		if (this.maxValue == -1) {
			this.maxValue = oswObjectCounts.active;
		} else {
			this.isSteadilyIncreasing &= (oswObjectCounts.active > this.maxValue);
			this.isIncreasing &= (oswObjectCounts.active >= this.maxValue);			
		}
		//
		if (this.lastValue == -1) {
			this.lastValue = oswObjectCounts.active	
		} else {
			this.isConstant &= (oswObjectCounts.active == this.lastValue);
		}
		//
		if (oswObjectCounts.active > this.maxValue)
			this.maxValue = oswObjectCounts.active;
	}	
	
}

OSWParserSimpleAnalysis.prototype = new OSWParserBase();
function OSWParserSimpleAnalysis(
	baseOutFileName
)
{
	this.baseOutFileName = baseOutFileName;
	this.outFile;	
	//
	this.isIncreasing;
	this.isSteadilyIncreasing;
	this.isConstant;
	this.lastValue;
	this.maxValue;
	this.currObjectName;
	this.increasing = new Array();
	this.steadilyIncreasing = new Array();
	//
	
	this.OnParseBegin = function(
		oswObjects,
		datesArr
	)
	{
		// открываем выходной файл			
		this.outFile = FSO().OpenTextFile(baseOutFileName + ".simple_analysis.txt", ForWriting, true);
	}
	
	this.OnParseEnd = function()
	{
		if (this.steadilyIncreasing.length > 0)
		{
			this.outFile.WriteLine("Строго возрастающие:");
			for (var i=0; i < this.steadilyIncreasing.length; i++)
				this.outFile.WriteLine("\t" + this.steadilyIncreasing[i]);
			this.outFile.WriteLine();
		}
		if (this.increasing.length > 0)
		{
			this.outFile.WriteLine("Возрастающие:");
			for (var i=0; i < this.increasing.length; i++)
				this.outFile.WriteLine("\t" + this.increasing[i]);
			this.outFile.WriteLine();
		}
		
		this.outFile.Close();
	}
	
	this.OnObjectBegin = function(
		anObjectName,
		oswObjectData
	)
	{
		this.currObjectName = anObjectName;
		this.isIncreasing = true;
		this.isSteadilyIncreasing = true;
		this.isConstant = true;
		this.maxValue = -1;	
		this.lastValue = -1;
	}
	
	this.OnObjectEnd = function()
	{
		this.isIncreasing &= !this.isConstant;
		//
		if (this.isSteadilyIncreasing)
		{
			this.steadilyIncreasing.push(this.currObjectName);			
		} else if (this.isIncreasing)
		{
			this.increasing.push(this.currObjectName);
		}					
	}
	
	this.OnEachDate = function(
		aDate,
		oswObjectCounts
	)
	{
		if (this.maxValue == -1) {
			this.maxValue = oswObjectCounts.active			
		} else {
			this.isSteadilyIncreasing &= (oswObjectCounts.active > this.maxValue);
			this.isIncreasing &= (oswObjectCounts.active >= this.maxValue);			
		}
		//
		if (this.lastValue == -1) {
			this.lastValue = oswObjectCounts.active	
		} else {
			this.isConstant &= (oswObjectCounts.active == this.lastValue);		
		}		
		//
		if (oswObjectCounts.active > this.maxValue)
			this.maxValue = oswObjectCounts.active;
	}	
	
	
	
}
