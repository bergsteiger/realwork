package dsparser.worker;

import java.util.ArrayList;
import java.util.Collection;
import java.util.EnumSet;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;


import dsparser.worker.AllUnits.Unit;

public class UnitContext extends BaseContext {
	
	// Методы, объявленные или определенные в модуле
	private final SymTable methods;	
	
	// Используемые (через uses) модули
	private final Map<String, UnitContext> used_units;
	
	// Ссылка на объект, который знает про все модули
	private final AllUnits units;
	
	// Имя модуля (как оно используется в коде)
	private final String unit_name;	
	
	// Для единообразия к первой части обращений типа UnitName.Method
	private final Symbol unit_symbol; 
	
	// Контексты методов, создаваемые в процессе анализа. Мы их держим потому что они держат информацию о 
	// неиспользуемых идентификаторах и сообщения о результатах анализа (может и не надо держать...).
	private Collection<MethodContext> method_contexts;
		
	protected UnitContext(String name, AllUnits units)
	{
		super("unit " + name);
		//
		this.units = units;		
		this.unit_name = name;
		this.unit_symbol = new Symbol(name, 0, 0);
		//
		this.methods = new SymTable();
		this.used_units = new TreeMap<String, UnitContext>(String.CASE_INSENSITIVE_ORDER);
		this.method_contexts = new ArrayList<MethodContext>();
	}
	
	@Override
	protected Symbol GetLocalSymbol(
			String name,
			EnumSet<IdType> id_type) 
	{
		if (id_type.contains(IdType.UNIT) && name.equalsIgnoreCase(this.unit_name))
			return unit_symbol;
		if (id_type.contains(IdType.METHOD) && methods.IsExists(name))
			return methods.Get(name);
		else
			return super.GetLocalSymbol(name, id_type);
	}
	
	@Override
	protected Symbol GetAvailableSymbol(String name, EnumSet<IdType> id_type) 
	{		
		Symbol ret = GetLocalSymbol(name, id_type);
		
		// если не нашли символ в модуле, то ищем в uses модулях
		if (ret == null)
			for (UnitContext u : used_units.values()) 
			{
				ret = u.GetLocalSymbol(name, id_type);
				if (ret != null)
					break;
			}
		
		return ret;
	}
	
	// Вызывается на объявлении метода (через forward).
	public void MethodDeclared(String name, Integer line, Integer pos)
	{
		if (GetLocalSymbol(name, EnumSet.of(IdType.METHOD)) != null)
		{
			Error("метод уже объявлен", new Symbol(name, line, pos) );
			return;
		}
		else CheckIfAnyDeclared(name, line, pos);		
		//
		methods.Add(name, line, pos);
	}
	
	// Вызывается на определении метода.
	// Возвращает контекст метода, с которым работает парсер на идентификаторах внутри метода (в т.ч на его параметрах).
	public MethodContext MethodDefined(String name, Integer line, Integer pos)
	{
		if (GetLocalSymbol(name, EnumSet.of(IdType.METHOD)) == null)
			MethodDeclared(name, line, pos);
		
		MethodContext mc = new MethodContext(name, this);
		this.method_contexts.add(mc);
		return mc;		
	}
	
	// Вызывается на использовании модуля.
	public void UnitUsed(String name, Integer line, Integer pos)
	{
		Unit unit = units.Get(name);
		if (unit != null)
		{
			if (used_units.containsKey(name))
				Error("модуль уже подключен", new Symbol(name, line, pos));
			else
				used_units.put(name, unit.context);
		}			
		else
			Error("используется отсутствующий модуль", new Symbol(name, line, pos));
	}
	
	@Override
	protected List<MsgData> GetAnalysisMsgData() {
		List<MsgData> result = super.GetAnalysisMsgData();
		for (MethodContext mc : this.method_contexts)
			result.addAll(mc.GetAnalysisMsgData());
		return result;
	}
	
	@Override
	protected List<MsgData> GetUsedSymbolsMsgData(int use_threshold) {
		List<MsgData> result = super.GetUsedSymbolsMsgData(use_threshold);
		result.addAll(GetMsgDataForSymTable(methods, "метод", use_threshold));
		for (MethodContext mc : this.method_contexts)
			result.addAll(mc.GetUsedSymbolsMsgData(use_threshold));
		return result;
	}
}
