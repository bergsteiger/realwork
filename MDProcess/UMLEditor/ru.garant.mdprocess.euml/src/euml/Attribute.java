/**
 * <copyright>
 * </copyright>
 *
 * $Id: Attribute.java,v 1.1 2009/02/25 06:20:00 pugin Exp $
 */
package euml;


/**
 * <!-- begin-user-doc -->
 * A representation of the model object '<em><b>Attribute</b></em>'.
 * <!-- end-user-doc -->
 *
 * <p>
 * The following features are supported:
 * <ul>
 *   <li>{@link euml.Attribute#getType <em>Type</em>}</li>
 * </ul>
 * </p>
 *
 * @see euml.EumlPackage#getAttribute()
 * @model
 * @generated
 */
public interface Attribute extends NamedElement {
	/**
	 * Returns the value of the '<em><b>Type</b></em>' reference.
	 * <!-- begin-user-doc -->
	 * <p>
	 * If the meaning of the '<em>Type</em>' reference isn't clear,
	 * there really should be more of a description here...
	 * </p>
	 * <!-- end-user-doc -->
	 * @return the value of the '<em>Type</em>' reference.
	 * @see #setType(euml.Class)
	 * @see euml.EumlPackage#getAttribute_Type()
	 * @model
	 * @generated
	 */
	euml.Class getType();

	/**
	 * Sets the value of the '{@link euml.Attribute#getType <em>Type</em>}' reference.
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @param value the new value of the '<em>Type</em>' reference.
	 * @see #getType()
	 * @generated
	 */
	void setType(euml.Class value);

} // Attribute
