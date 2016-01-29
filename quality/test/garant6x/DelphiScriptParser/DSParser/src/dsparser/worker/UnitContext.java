package dsparser.worker;

import java.util.ArrayList;
import java.util.Collection;
import java.util.EnumSet;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;


import dsparser.worker.AllUnits.Unit;

public class UnitContext extends BaseContext {
	
	// ������, ����������� ��� ������������ � ������
	private final SymTable methods;	
	
	// ������������ (����� uses) ������
	private final Map<String, UnitContext> used_units;
	
	// ������ �� ������, ������� ����� ��� ��� ������
	private final AllUnits units;
	
	// ��� ������ (��� ��� ������������ � ����)
	private final String unit_name;	
	
	// ��� ������������ � ������ ����� ��������� ���� UnitName.Method
	private final Symbol unit_symbol; 
	
	// ��������� �������, ����������� � �������� �������. �� �� ������ ������ ��� ��� ������ ���������� � 
	// �������������� ��������������� � ��������� � ����������� ������� (����� � �� ���� �������...).
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
		
		// ���� �� ����� ������ � ������, �� ���� � uses �������
		if (ret == null)
			for (UnitContext u : used_units.values()) 
			{
				ret = u.GetLocalSymbol(name, id_type);
				if (ret != null)
					break;
			}
		
		return ret;
	}
	
	// ���������� �� ���������� ������ (����� forward).
	public void MethodDeclared(String name, Integer line, Integer pos)
	{
		if (GetLocalSymbol(name, EnumSet.of(IdType.METHOD)) != null)
		{
			Error("����� ��� ��������", new Symbol(name, line, pos) );
			return;
		}
		else CheckIfAnyDeclared(name, line, pos);		
		//
		methods.Add(name, line, pos);
	}
	
	// ���������� �� ����������� ������.
	// ���������� �������� ������, � ������� �������� ������ �� ��������������� ������ ������ (� �.� �� ��� ����������).
	public MethodContext MethodDefined(String name, Integer line, Integer pos)
	{
		if (GetLocalSymbol(name, EnumSet.of(IdType.METHOD)) == null)
			MethodDeclared(name, line, pos);
		
		MethodContext mc = new MethodContext(name, this);
		this.method_contexts.add(mc);
		return mc;		
	}
	
	// ���������� �� ������������� ������.
	public void UnitUsed(String name, Integer line, Integer pos)
	{
		Unit unit = units.Get(name);
		if (unit != null)
		{
			if (used_units.containsKey(name))
				Error("������ ��� ���������", new Symbol(name, line, pos));
			else
				used_units.put(name, unit.context);
		}			
		else
			Error("������������ ������������� ������", new Symbol(name, line, pos));
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
		result.addAll(GetMsgDataForSymTable(methods, "�����", use_threshold));
		for (MethodContext mc : this.method_contexts)
			result.addAll(mc.GetUsedSymbolsMsgData(use_threshold));
		return result;
	}
}
