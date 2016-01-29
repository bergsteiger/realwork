package euml.diagram.part;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.gef.Tool;
import org.eclipse.gef.palette.PaletteContainer;
import org.eclipse.gef.palette.PaletteDrawer;
import org.eclipse.gef.palette.PaletteRoot;
import org.eclipse.gef.palette.ToolEntry;
import org.eclipse.gmf.runtime.diagram.ui.tools.UnspecifiedTypeConnectionTool;
import org.eclipse.gmf.runtime.diagram.ui.tools.UnspecifiedTypeCreationTool;

import euml.diagram.providers.UmlElementTypes;

/**
 * @generated
 */
public class UmlPaletteFactory {

	/**
	 * @generated
	 */
	public void fillPalette(PaletteRoot paletteRoot) {
		paletteRoot.add(createElements1Group());
		paletteRoot.add(createLinks2Group());
	}

	/**
	 * Creates "Elements" palette tool group
	 * @generated
	 */
	private PaletteContainer createElements1Group() {
		PaletteDrawer paletteContainer = new PaletteDrawer(
				Messages.Elements1Group_title);
		paletteContainer.setDescription(Messages.Elements1Group_desc);
		paletteContainer.add(createClass1CreationTool());
		paletteContainer.add(createAttribute2CreationTool());
		paletteContainer.add(createOperation3CreationTool());
		paletteContainer.add(createPackage4CreationTool());
		return paletteContainer;
	}

	/**
	 * Creates "Links" palette tool group
	 * @generated
	 */
	private PaletteContainer createLinks2Group() {
		PaletteDrawer paletteContainer = new PaletteDrawer(
				Messages.Links2Group_title);
		paletteContainer.setDescription(Messages.Links2Group_desc);
		paletteContainer.add(createDependecy1CreationTool());
		paletteContainer.add(createGeneralization2CreationTool());
		paletteContainer.add(createRealization3CreationTool());
		return paletteContainer;
	}

	/**
	 * @generated
	 */
	private ToolEntry createClass1CreationTool() {
		List/*<IElementType>*/types = new ArrayList/*<IElementType>*/(1);
		types.add(UmlElementTypes.Class_2001);
		NodeToolEntry entry = new NodeToolEntry(
				Messages.Class1CreationTool_title,
				Messages.Class1CreationTool_desc, types);
		entry.setSmallIcon(UmlElementTypes
				.getImageDescriptor(UmlElementTypes.Class_2001));
		entry.setLargeIcon(entry.getSmallIcon());
		return entry;
	}

	/**
	 * @generated
	 */
	private ToolEntry createAttribute2CreationTool() {
		List/*<IElementType>*/types = new ArrayList/*<IElementType>*/(1);
		types.add(UmlElementTypes.Attribute_3001);
		NodeToolEntry entry = new NodeToolEntry(
				Messages.Attribute2CreationTool_title,
				Messages.Attribute2CreationTool_desc, types);
		entry.setSmallIcon(UmlElementTypes
				.getImageDescriptor(UmlElementTypes.Attribute_3001));
		entry.setLargeIcon(entry.getSmallIcon());
		return entry;
	}

	/**
	 * @generated
	 */
	private ToolEntry createOperation3CreationTool() {
		List/*<IElementType>*/types = new ArrayList/*<IElementType>*/(1);
		types.add(UmlElementTypes.Operation_3002);
		NodeToolEntry entry = new NodeToolEntry(
				Messages.Operation3CreationTool_title,
				Messages.Operation3CreationTool_desc, types);
		entry.setSmallIcon(UmlElementTypes
				.getImageDescriptor(UmlElementTypes.Operation_3002));
		entry.setLargeIcon(entry.getSmallIcon());
		return entry;
	}

	/**
	 * @generated
	 */
	private ToolEntry createPackage4CreationTool() {
		List/*<IElementType>*/types = new ArrayList/*<IElementType>*/(1);
		types.add(UmlElementTypes.Package_2002);
		NodeToolEntry entry = new NodeToolEntry(
				Messages.Package4CreationTool_title,
				Messages.Package4CreationTool_desc, types);
		entry.setSmallIcon(UmlElementTypes
				.getImageDescriptor(UmlElementTypes.Package_2002));
		entry.setLargeIcon(entry.getSmallIcon());
		return entry;
	}

	/**
	 * @generated
	 */
	private ToolEntry createDependecy1CreationTool() {
		List/*<IElementType>*/types = new ArrayList/*<IElementType>*/(1);
		types.add(UmlElementTypes.Dependecy_4001);
		LinkToolEntry entry = new LinkToolEntry(
				Messages.Dependecy1CreationTool_title,
				Messages.Dependecy1CreationTool_desc, types);
		entry.setSmallIcon(UmlElementTypes
				.getImageDescriptor(UmlElementTypes.Dependecy_4001));
		entry.setLargeIcon(entry.getSmallIcon());
		return entry;
	}

	/**
	 * @generated
	 */
	private ToolEntry createGeneralization2CreationTool() {
		List/*<IElementType>*/types = new ArrayList/*<IElementType>*/(1);
		types.add(UmlElementTypes.Generalization_4003);
		LinkToolEntry entry = new LinkToolEntry(
				Messages.Generalization2CreationTool_title,
				Messages.Generalization2CreationTool_desc, types);
		entry.setSmallIcon(UmlElementTypes
				.getImageDescriptor(UmlElementTypes.Generalization_4003));
		entry.setLargeIcon(entry.getSmallIcon());
		return entry;
	}

	/**
	 * @generated
	 */
	private ToolEntry createRealization3CreationTool() {
		List/*<IElementType>*/types = new ArrayList/*<IElementType>*/(1);
		types.add(UmlElementTypes.Realization_4002);
		LinkToolEntry entry = new LinkToolEntry(
				Messages.Realization3CreationTool_title,
				Messages.Realization3CreationTool_desc, types);
		entry.setSmallIcon(UmlElementTypes
				.getImageDescriptor(UmlElementTypes.Realization_4002));
		entry.setLargeIcon(entry.getSmallIcon());
		return entry;
	}

	/**
	 * @generated
	 */
	private static class NodeToolEntry extends ToolEntry {

		/**
		 * @generated
		 */
		private final List elementTypes;

		/**
		 * @generated
		 */
		private NodeToolEntry(String title, String description,
				List elementTypes) {
			super(title, description, null, null);
			this.elementTypes = elementTypes;
		}

		/**
		 * @generated
		 */
		public Tool createTool() {
			Tool tool = new UnspecifiedTypeCreationTool(elementTypes);
			tool.setProperties(getToolProperties());
			return tool;
		}
	}

	/**
	 * @generated
	 */
	private static class LinkToolEntry extends ToolEntry {

		/**
		 * @generated
		 */
		private final List relationshipTypes;

		/**
		 * @generated
		 */
		private LinkToolEntry(String title, String description,
				List relationshipTypes) {
			super(title, description, null, null);
			this.relationshipTypes = relationshipTypes;
		}

		/**
		 * @generated
		 */
		public Tool createTool() {
			Tool tool = new UnspecifiedTypeConnectionTool(relationshipTypes);
			tool.setProperties(getToolProperties());
			return tool;
		}
	}
}
