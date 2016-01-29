// ����� �������
var gbl_FSO_Cache;
var ForReading = 1;
var ForWriting = 2;

function FSO()
{
	if (typeof(gbl_FSO_Cache) != "object")	
		gbl_FSO_Cache = new ActiveXObject("Scripting.FileSystemObject");
	return gbl_FSO_Cache;
}

// ����������� �������
function OSWObjectCounts()
{
	this.total = 0;
	this.active = 0;
}

function OSWObjectData()
{
	this.countDataMap = new ActiveXObject("Scripting.Dictionary");
	//
	// ���������� ������, �������� ���������� � ���������� �������� �� ����.
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
	
	// ���������� ������, �������� ���������� � ���������� �������� �� �����
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
	
	// ���������� ������ ���
	this.GetDates = function()
	{
		return (new VBArray( this.datesMap.Keys() ).toArray());
	}
	
	// �������� ���, ����� ��������� ����� ���� ��������������
	this.PutDate = function(
		aDate
	)
	{
		if ( !this.datesMap.Exists(aDate) )
			this.datesMap.Add(aDate, 0);
	}
	
	// ��������� ������ ������� �� ��������� �����
	this.FillFromStatFile = function(
		aFileName
	)
	{	
		// ���������� ��������� ��� ������� ������ �����
		var lineRexp = /(.*);(.*);(\d*);(\d*)/;
		var dateRexp = /(\d*)-(\d*)-(\d*)_(\d*)-(\d*)-(\d*)/;
		
		// ��������� ����
		var inFile = FSO().OpenTextFile(aFileName, ForReading);
		
		// ��������� ��� ������������
		while ( !inFile.AtEndOfStream )
		{
			// ��������� ������ �� ����, ��� � ����������
			var line = inFile.ReadLine();
			var lineRes = lineRexp.exec(line);
			if (lineRes != null)
			{
				var dateStr = lineRes[1];
				var objectName = lineRes[2];
				var total = lineRes[3];
				var active = lineRes[4];
				
				/* // ������ ���� � ����������� ������
				var dateObj = null;
				dateRes = dateRexp.exec(dateStr)
				if (dateRes != null)
					dateObj = new Date(dateRes[3], dateRes[2], dateRes[1], dateRes[4], dateRes[5], dateRes[6]);
				else
					throw "������������ ������ ����!"; */
				var dateObj = dateStr;	
				
				// ��������� ���������� ������ � ���������
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
		
		// ���������� ��� �������
		var objectNamesArr = oswObjects.GetObjectNames();	
		for (var i=0; i < objectNamesArr.length; i++)
		{		
			objectName = objectNamesArr[i];
			var oswObjectData = oswObjects.GetObjectDataByName(objectName);
			
			this.OnObjectBegin(objectName, oswObjectData);
			
			// ���������� ������ ��� ���� ���, ���� ��� ���, ��� ������� ������ ����� � �� ���� (� ���� ������ 0)
			for (var j = 0; j < datesArr.length; j++)
			{
				var oswObjectCounts = oswObjectData.GetObjectCountsByDate(datesArr[j]);
				this.OnEachDate(datesArr[j], oswObjectCounts);
			}
			
			this.OnObjectEnd(objectName);
		}	
		this.OnParseEnd();
	}
	
	// ���������� ��� ������ ��������
	this.OnParseBegin = function(
		oswObjects,
		datesArr
	)
	{
		throw "Must be implemented!";
	}
	
	// ���������� � ����� ��������
	this.OnParseEnd = function()
	{
		throw "Must be implemented!";
	}
	
	// ���������� ��� ������ �������� �������
	this.OnObjectBegin = function(
		anObjectName,
		oswObjectData
	)
	{
		throw "Must be implemented!";
	}
	
	// ���������� �� ��������� �������� �������
	this.OnObjectEnd = function(
		anObjectName
	)
	{
		throw "Must be implemented!";
	}
	
	// ���������� ��� ������ ��������� ������ � ���������� ��� ����������� �������
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
		// ��������� �������� �����		
		this.outFileActive = FSO().OpenTextFile(this.baseOutFileName + ".active.csv", ForWriting, true);
		this.outFileTotal = FSO().OpenTextFile(this.baseOutFileName + ".total.csv", ForWriting, true);
		this.outFileAll = FSO().OpenTextFile(this.baseOutFileName + ".all.csv", ForWriting, true);
		
		// ��������� ���������		
		var activeStr = totalStr = allStr ="\"��� ������\"";
		activeStr +=";\"������ ����������\";\"����������\";\"����������\"";
		for (var j = 0; j < datesArr.length; j++)
		{
			activeStr += ";\"�������� " + datesArr[j] + "\"";
			totalStr += ";\"����� " + datesArr[j] + "\"";
			allStr += ";\"����� " + datesArr[j] + "\";\"�������� " + datesArr[j] + "\"";
		}
		
		// ���������� �� � �����
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
		// ��������� �������� ����			
		this.outFile = FSO().OpenTextFile(baseOutFileName + ".simple_analysis.txt", ForWriting, true);
	}
	
	this.OnParseEnd = function()
	{
		if (this.steadilyIncreasing.length > 0)
		{
			this.outFile.WriteLine("������ ������������:");
			for (var i=0; i < this.steadilyIncreasing.length; i++)
				this.outFile.WriteLine("\t" + this.steadilyIncreasing[i]);
			this.outFile.WriteLine();
		}
		if (this.increasing.length > 0)
		{
			this.outFile.WriteLine("������������:");
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
